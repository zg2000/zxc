# EMQX Deployment Documentation

## Prepare

3 * 8C16G   system disk 50GB  SSD 100GB  EC2   for emqx node

3 * 4C8G  system disk 50GB  EC2 for haproxy 

1 * nlb

## SSD 

``` bash
sudo mkdir /opt/emqx
sudo gdisk /dev/news_ssd_disk

sudo mkfs.xfs /dev/news_ssd_disk
sudo blkid /dev/news_ssd_disk

# copy uuid 
sudo vim /etc/fstab

uuid="xxxx"  /opt/emqx xfs defaults 0 0
```

## EC2 Tuning

``` bash
cat <<_EOF_ >/etc/security/limits.conf
* soft nofile 1048576
* hard nofile 1048576
* soft nproc unlimited
* hard nproc unlimited
* soft core unlimited
* hard core unlimited
* soft memlock unlimited
* hard memlock unlimited
_EOF_

cat <<_EOF_ >/etc/sysctl.conf
fs.aio-max-nr = 1048576
fs.file-max = 3145728
fs.nr_open = 2097152
# TCP
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr
net.ipv4.ip_local_port_range  =  1025 65000
net.core.somaxconn = 32768
net.ipv4.tcp_max_syn_backlog = 16384
net.core.netdev_max_backlog = 16384
net.core.rmem_default = 262144
net.core.wmem_default = 262144
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.core.optmem_max = 16777216
net.ipv4.tcp_rmem = 1024 4096 16777216
net.ipv4.tcp_wmem = 1024 4096 16777216
net.ipv4.tcp_max_tw_buckets = 1048576
net.ipv4.tcp_fin_timeout = 15
net.ipv4.tcp_keepalive_time = 180
net.ipv4.tcp_keepalive_intvl = 60
net.ipv4.tcp_keepalive_probes = 3
# vm
vm.dirty_background_bytes = 409600000
vm.dirty_expire_centisecs = 3000
vm.dirty_writeback_centisecs = 100
vm.dirty_ratio = 85
vm.mmap_min_addr = 65536
vm.swappiness = 1
vm.zone_reclaim_mode = 0
_EOF_

sysctl -p

sed -i 's/#DefaultLimitNOFILE=/DefaultLimitNOFILE=1048576/g' /etc/systemd/system.conf
```

## EMQX  NODE

``` bash
## Downloads emqx install packages
cd /root
wget https://www.emqx.com/en/downloads/enterprise/4.4.24/emqx-ee-4.4.24-otp24.3.4.2-4-amzn2-amd64.zip
cd /opt
unzip /root/emqx-ee-4.4.24-otp24.3.4.2-4-amzn2-amd64.zip

LOCALIP=$(hostname -I | cut -d' ' -f1)
sed -i "s/node\.name = emqx@127\.0\.0\.1/node.name = emqx@$LOCALIP/g" /opt/emqx/etc/emqx.conf
CLUSTER=dhucluster
CLUSTER=tcamcluster
sed -i "s/cluster\.name = emqxcl/cluster.name = $CLUSTER/g" /opt/emqx/etc/cluster.conf

sed -i 's/log\.rotation\.size = 10MB/log.rotation.size = 200MB/g; s/log\.rotation\.count = 5/log.rotation.count = 20/g' /opt/emqx/etc/logger.conf

cat <<_EOF_ >/etc/systemd/system/emqx.service
[Unit]
Description=emqx daemon
After=network.target
[Service]
Type=forking
Environment=HOME=/opt/emqx
# Must use a 'bash' wrap for some OS
# errno=13 'Permission denied'
# Cannot create FIFO ... for writing
ExecStart=/opt/emqx/bin/emqx start
LimitNOFILE=1048576
ExecStop=/opt/emqx/bin/emqx stop
Restart=on-failure
# When clustered, give the peers enough time to get this node's 'DOWN' event
RestartSec=60s
[Install]
WantedBy=multi-user.target
_EOF_

systemctl daemon-reload
systemctl start emqx
systemctl enable emqx

## choose one node ip 
## Execute the following command on other nodes
/opt/emqx/bin/emqx_ctl cluster join emqx@<node_ip>
```

## Haproxy

``` bash
sudo yum -y install haproxy
```

upload ca.pem and server.pem

``` bash
mv ca.pem  /etc/haproxy/certs/
mv server.pem  /etc/haproxy/certs/
```

haproxy.cfg

``` bash
global
    log         127.0.0.1 local2

    chroot      /var/lib/haproxy
    pidfile     /var/run/haproxy.pid
    user        haproxy
    group       haproxy
    maxconn 1024000
    daemon

    # turn on stats unix socket
    stats socket /var/lib/haproxy/stats
#---------------------------------------------------------------------
# common defaults that all the 'listen' and 'backend' sections will
# use if not designated in their block
#---------------------------------------------------------------------
defaults
    mode                    tcp
    log                     global
    option                  tcplog
    timeout client          240s
    timeout server          240s
    maxconn                 30000

#---------------------------------------------------------------------
# main frontend which proxys to the backends
#---------------------------------------------------------------------
frontend emqx_ws
    bind *:8083
    option tcplog
    mode tcp 
    default_backend emqx_ws_back

frontend emqx_dashboard 
    bind *:18084 ssl crt /etc/haproxy/certs/server.pem no-sslv3
    bind *:18083
    option tcplog
    mode tcp 
    default_backend emqx_dashboard_back

frontend emqx_api 
    bind *:8081
    option tcplog
    mode tcp 
    default_backend emqx_api_back

frontend emqx_ssl
    bind *:8883  ssl ca-file /etc/haproxy/certs/ca.pem crt /etc/haproxy/certs/server.pem verify required
    bind *:1883
    option tcplog
    mode tcp
    default_backend emqx_ssl_back

frontend emqx_wss
    bind *:8084 ssl crt /etc/haproxy/certs/server.pem no-sslv3
    option tcplog
    mode tcp 
    default_backend emqx_wss_back

backend emqx_ws_back 
   balance roundrobin
   server emqx_node_1 node_ip:8083 check inter 10s fall 2 rise 5
   server emqx_node_2 node_ip:8083 check inter 10s fall 2 rise 5
   server emqx_node_3 node_ip:8083 check inter 10s fall 2 rise 5

backend emqx_dashboard_back
   balance roundrobin
   server emqx_node_1 node_ip:18083 check inter 10s fall 2 rise 5
   server emqx_node_2 node_ip:18083 check inter 10s fall 2 rise 5
   server emqx_node_3 node_ip:18083 check inter 10s fall 2 rise 5

backend emqx_api_back
   balance roundrobin
   server emqx_node_1 node_ip:8081 check inter 10s fall 2 rise 5
   server emqx_node_2 node_ip:8081 check inter 10s fall 2 rise 5
   server emqx_node_3 node_ip:8081 check inter 10s fall 2 rise 5

backend emqx_wss_back
   balance roundrobin
   mode tcp 
   server emqx_node_1 node_ip:8083 check inter 10s fall 2 rise 5
   server emqx_node_2 node_ip:8083 check inter 10s fall 2 rise 5
   server emqx_node_3 node_ip:8083 check inter 10s fall 2 rise 5

backend emqx_ssl_back
   balance roundrobin
   mode tcp
   server emqx_node_1 node_ip:1883  check-send-proxy send-proxy-v2 check inter 10s fall 2 rise 5
   server emqx_node_2 node_ip:1883  check-send-proxy send-proxy-v2 check inter 10s fall 2 rise 5
   server emqx_node_3 node_ip:1883  check-send-proxy send-proxy-v2 check inter 10s fall 2 rise 5
   
```

``` bash
sudo service haproxy reload
sudo systemctl restart haproxy.service
sudo systemctl status haproxy.service
```

