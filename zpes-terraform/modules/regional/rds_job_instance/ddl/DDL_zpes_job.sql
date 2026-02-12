/******************************************/
/*   DatabaseName = zpes_job_dev_0   */
/*   TableName = device_job   */
/******************************************/
drop table if exists `device_job`;
CREATE TABLE `device_job` (
  `id` bigint NOT NULL COMMENT '主键',
  `workspace_id` varchar(64) DEFAULT NULL COMMENT '空间id',
  `name` varchar(64) DEFAULT NULL COMMENT '任务名',
  `job_type` int unsigned DEFAULT NULL COMMENT '任务类型，0-log；1-persistency；2-skynet',
  `cloud_status` tinyint DEFAULT NULL COMMENT '是否上云;0 不上云  1 上云',
  `auto_inc` tinyint DEFAULT NULL COMMENT '车辆是否动态新增：1 是，0 否',
  `auto_task` tinyint DEFAULT '0' COMMENT '车辆是否联网自动下发：1 是，0 否',
  `description` varchar(255) DEFAULT NULL COMMENT '任务描述',
  `device_source` int DEFAULT NULL COMMENT '来源枚举 1-按条件码搜索 2-按vin搜索 3-文件导入指定设备  4-分组',
  `device_source_config` text COMMENT '目标设备配置',
  `execute_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '设备执行规则',
  `job_file` varchar(1024) DEFAULT NULL COMMENT '下发的文件',
  `timeout` int DEFAULT '0' COMMENT '作业执行的超时时间(秒)',
  `execute_method` int DEFAULT NULL COMMENT '执行方式 1-定时 2-立即 3-周期 4-手动',
  `execute_time` datetime DEFAULT NULL COMMENT '任务期望执行时间',
  `sent_method` int DEFAULT '1' COMMENT '下发方式，1-网络 2-短信 3-短信+网络',
  `retry_method` int DEFAULT '0' COMMENT '自动重试方式，0-不重试 1-重试',
  `max_retry_count` int unsigned DEFAULT '0' COMMENT '最大重试次数',
  `last_job_instance_id` bigint DEFAULT '0' COMMENT '最近的实例id',
  `status` int unsigned DEFAULT '1' COMMENT '任务最新实例的状态 1-初始化、2-waiting 待调度、3-in_progress 执行中，4-completed 已完成，5-cancelled 已取消，6-timeout 超时',
  `identifier` varchar(32) DEFAULT NULL COMMENT '任务表示',
  `cycle_type` int DEFAULT NULL COMMENT '周期类型',
  `cycle_time` varchar(1024) DEFAULT NULL COMMENT '周期时间',
  `max_cycle_count` int DEFAULT NULL COMMENT '最大周期次数',
  `max_cycle_time` datetime DEFAULT NULL COMMENT '最大周期时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(32) DEFAULT NULL COMMENT '变更人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近更新时间',
  `del_flag` smallint NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_device_job_utime` (`update_time`) COMMENT '更新时间索引',
  KEY `idx_device_job_ctime` (`create_time`) COMMENT '创建时间索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='设备任务表'
;

/******************************************/
/*   DatabaseName = zpes_job_dev_0   */
/*   TableName = device_job_instance   */
/******************************************/
drop table if exists `device_job_instance`;
CREATE TABLE `device_job_instance` (
  `id` bigint unsigned NOT NULL COMMENT '主键',
  `workspace_id` varchar(64) DEFAULT NULL COMMENT '空间id',
  `job_id` bigint unsigned DEFAULT NULL COMMENT '任务id',
  `job_type` int unsigned DEFAULT NULL COMMENT '任务类型，0-log；1-persistency；2-skynet',
  `cloud_status` tinyint DEFAULT NULL COMMENT '是否上云;0 不上云  1 上云',
  `auto_inc` tinyint DEFAULT NULL COMMENT '车辆是否动态新增：1 是，0 否',
  `auto_task` tinyint DEFAULT '0' COMMENT '车辆是否联网自动下发：1 是，0 否',
  `task_num_total` int unsigned DEFAULT '0' COMMENT '本次任务，总作业数',
  `task_num_suc` int unsigned DEFAULT '0' COMMENT '本次任务，成功的作业数',
  `task_num_fail` int unsigned DEFAULT '0' COMMENT '本次任务，失败的作业数',
  `task_num_waiting` int unsigned DEFAULT '0' COMMENT '本次任务，等待执行的作业数',
  `task_num_inprog` int unsigned DEFAULT '0' COMMENT '本次任务，执行中的作业数',
  `status` int DEFAULT '1' COMMENT '状态 1-初始化、2-waiting 待调度、3-in_progress 执行中，4-completed 已完成，5-cancelled 已取消，6-timeout 超时',
  `status_detail` varchar(1024) DEFAULT NULL COMMENT '状态描述',
  `execute_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '设备执行规则',
  `execute_method` int DEFAULT NULL COMMENT '执行方式 1-手动、2-定时、3-立即',
  `execute_time` datetime DEFAULT NULL COMMENT '任务期望执行时间',
  `sent_method` int unsigned DEFAULT '1' COMMENT '下发方式，1-网络 2-短信 3-短信+网络',
  `start_time` datetime DEFAULT NULL COMMENT '实际任务开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '实际任务结束时间',
  `retry_method` int unsigned DEFAULT '0' COMMENT '自动重试方式，0-不重试 1-重试',
  `max_retry_count` int unsigned DEFAULT '0' COMMENT '最大重试次数',
  `timeout_time` datetime DEFAULT NULL COMMENT '任务超时时间',
  `eta` datetime DEFAULT NULL COMMENT '预计调度完成时间',
  `slot_time_conf` text COMMENT '发号明细 [{t1:500},{t2:200},{t3:100}] 周期性时间等',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近更新时间',
  `del_flag` smallint NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_device_job_instance_ctime` (`create_time`) COMMENT '创建时间索引',
  KEY `idx_device_job_instance_timeout_status` (`status`,`timeout_time`) COMMENT '任务超时索引',
  KEY `idx_device_job_instance_utime` (`update_time`) COMMENT '更新时间索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务实例表'
;

/******************************************/
/*   DatabaseName = zpes_job_dev_0   */
/*   TableName = device_job_resource   */
/******************************************/
drop table if exists `device_job_resource`;
CREATE TABLE `device_job_resource` (
  `id` bigint unsigned NOT NULL COMMENT '主键',
  `resource_type` int unsigned NOT NULL DEFAULT '1' COMMENT '资源类型 1-分钟',
  `resource_no` bigint NOT NULL COMMENT '资源时间戳(秒),e.g. 1652689043',
  `total_num` int unsigned DEFAULT '0' COMMENT ' 本次发号总资源数',
  `delivery_num` int unsigned DEFAULT '0' COMMENT ' 本次发号已使用源数',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近更新时间',
  `del_flag` smallint NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  `resource_no_timestamp` datetime DEFAULT NULL COMMENT 'resource_no格式化时间',
  PRIMARY KEY (`id`),
  KEY `idx_device_job_resource_no` (`resource_no`) COMMENT 'resource_no',
  KEY `device_job_resource_resource_type_IDX` (`resource_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='设备资源发号表'
;

/******************************************/
/*   DatabaseName = zpes_job_dev_0   */
/*   TableName = device_job_target_devices   */
/******************************************/
drop table if exists `device_job_target_devices`;
CREATE TABLE `device_job_target_devices` (
  `id` bigint NOT NULL COMMENT '主键',
  `target_type` int unsigned DEFAULT '1' COMMENT '指定的类型，1-手动指定 2-文件导入',
  `job_id` bigint unsigned DEFAULT NULL COMMENT '任务id',
  `vehicle_no` varchar(64) DEFAULT NULL COMMENT 'vin',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近更新时间',
  `del_flag` smallint NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_device_job_target_devices_utime` (`update_time`) COMMENT 'utime',
  KEY `idx_device_job_target_devices_ctime` (`create_time`) COMMENT 'ctime',
  KEY `idx_device_job_target_devices_job` (`job_id`,`target_type`) COMMENT 'job_target_type'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务已经设备圈选明细'
;

/******************************************/
/*   DatabaseName = zpes_job_dev_0   */
/*   TableName = device_task_0   */
/******************************************/
drop table if exists `device_task_0`;
CREATE TABLE `device_task_0` (
  `id` bigint unsigned NOT NULL COMMENT '主键',
  `workspace_id` varchar(64) DEFAULT NULL COMMENT '空间id',
  `vehicle_no` varchar(64) DEFAULT NULL COMMENT 'vin',
  `vehicle_brand` varchar(64) DEFAULT NULL COMMENT '车辆品牌',
  `vehicle_model` varchar(64) DEFAULT NULL COMMENT '版型',
  `car_model` varchar(64) DEFAULT NULL COMMENT '车系',
  `job_instance_id` bigint unsigned DEFAULT NULL COMMENT '任务实例id',
  `ext` varchar(100) DEFAULT NULL COMMENT '任务执行额外信息',
  `job_type` int unsigned DEFAULT NULL COMMENT '任务类型，0-log；1-persistency；2-skynet',
  `slot_time` bigint unsigned DEFAULT NULL COMMENT '任务执行时间片，秒级时间戳',
  `progress` int unsigned DEFAULT NULL COMMENT '作业进度 varchar e.g. 80',
  `start_time` datetime DEFAULT NULL COMMENT '实际任务开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '实际任务结束时间',
  `status` int unsigned DEFAULT '1' COMMENT '作业状态,1-待调度 2- 执行中 3-成功 4- 失败 5-超时 6已取消',
  `status_detail` varchar(1024) DEFAULT NULL COMMENT '设备上报的状态信息',
  `retry_method` int unsigned DEFAULT '0' COMMENT '自动重试方式，0-不重试 1-重试',
  `max_retry_count` int unsigned DEFAULT '0' COMMENT '最大重试次数',
  `retry_count` int unsigned DEFAULT '0' COMMENT '已自动重试次数',
  `manual_retry_count` int unsigned DEFAULT '0' COMMENT '已手动重试次数',
  `message` text COMMENT '任务执行的相关信息，如报错信息',
  `latest_task_log_id` bigint unsigned DEFAULT NULL COMMENT '最后一次log guid',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近更新时间',
  `del_flag` smallint NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`),
  KEY `g_idx_device_task_instance_status` (`job_instance_id`,`status`),
  KEY `idx_device_task_slot_status` (`slot_time`,`status`),
  KEY `idx_device_task_ctime` (`create_time`),
  KEY `idx_device_task_utime` (`update_time`),
  KEY `idx_device_task_vin_ctime` (`vehicle_no`,`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='设备任务详情表'
;

/******************************************/
/*   DatabaseName = zpes_job_dev_0   */
/*   TableName = device_task_1   */
/******************************************/
drop table if exists `device_task_1`;
CREATE TABLE `device_task_1` (
  `id` bigint unsigned NOT NULL COMMENT '主键',
  `workspace_id` varchar(64) DEFAULT NULL COMMENT '空间id',
  `vehicle_no` varchar(64) DEFAULT NULL COMMENT 'vin',
  `vehicle_brand` varchar(64) DEFAULT NULL COMMENT '车辆品牌',
  `vehicle_model` varchar(64) DEFAULT NULL COMMENT '版型',
  `car_model` varchar(64) DEFAULT NULL COMMENT '车系',
  `job_instance_id` bigint unsigned DEFAULT NULL COMMENT '任务实例id',
  `ext` varchar(100) DEFAULT NULL COMMENT '任务执行额外信息',
  `job_type` int unsigned DEFAULT NULL COMMENT '任务类型，0-log；1-persistency；2-skynet',
  `slot_time` bigint unsigned DEFAULT NULL COMMENT '任务执行时间片，秒级时间戳',
  `progress` int unsigned DEFAULT NULL COMMENT '作业进度 varchar e.g. 80',
  `start_time` datetime DEFAULT NULL COMMENT '实际任务开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '实际任务结束时间',
  `status` int unsigned DEFAULT '1' COMMENT '作业状态,1-待调度 2- 执行中 3-成功 4- 失败 5-超时 6已取消',
  `status_detail` varchar(1024) DEFAULT NULL COMMENT '设备上报的状态信息',
  `retry_method` int unsigned DEFAULT '0' COMMENT '自动重试方式，0-不重试 1-重试',
  `max_retry_count` int unsigned DEFAULT '0' COMMENT '最大重试次数',
  `retry_count` int unsigned DEFAULT '0' COMMENT '已自动重试次数',
  `manual_retry_count` int unsigned DEFAULT '0' COMMENT '已手动重试次数',
  `message` text COMMENT '任务执行的相关信息，如报错信息',
  `latest_task_log_id` bigint unsigned DEFAULT NULL COMMENT '最后一次log guid',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近更新时间',
  `del_flag` smallint NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`),
  KEY `g_idx_device_task_instance_status` (`job_instance_id`,`status`),
  KEY `idx_device_task_slot_status` (`slot_time`,`status`),
  KEY `idx_device_task_ctime` (`create_time`),
  KEY `idx_device_task_utime` (`update_time`),
  KEY `idx_device_task_vin_ctime` (`vehicle_no`,`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='设备任务详情表'
;

/******************************************/
/*   DatabaseName = zpes_job_dev_0   */
/*   TableName = device_task_2   */
/******************************************/
drop table if exists `device_task_2`;
CREATE TABLE `device_task_2` (
  `id` bigint unsigned NOT NULL COMMENT '主键',
  `workspace_id` varchar(64) DEFAULT NULL COMMENT '空间id',
  `vehicle_no` varchar(64) DEFAULT NULL COMMENT 'vin',
  `vehicle_brand` varchar(64) DEFAULT NULL COMMENT '车辆品牌',
  `vehicle_model` varchar(64) DEFAULT NULL COMMENT '版型',
  `car_model` varchar(64) DEFAULT NULL COMMENT '车系',
  `job_instance_id` bigint unsigned DEFAULT NULL COMMENT '任务实例id',
  `ext` varchar(100) DEFAULT NULL COMMENT '任务执行额外信息',
  `job_type` int unsigned DEFAULT NULL COMMENT '任务类型，0-log；1-persistency；2-skynet',
  `slot_time` bigint unsigned DEFAULT NULL COMMENT '任务执行时间片，秒级时间戳',
  `progress` int unsigned DEFAULT NULL COMMENT '作业进度 varchar e.g. 80',
  `start_time` datetime DEFAULT NULL COMMENT '实际任务开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '实际任务结束时间',
  `status` int unsigned DEFAULT '1' COMMENT '作业状态,1-待调度 2- 执行中 3-成功 4- 失败 5-超时 6已取消',
  `status_detail` varchar(1024) DEFAULT NULL COMMENT '设备上报的状态信息',
  `retry_method` int unsigned DEFAULT '0' COMMENT '自动重试方式，0-不重试 1-重试',
  `max_retry_count` int unsigned DEFAULT '0' COMMENT '最大重试次数',
  `retry_count` int unsigned DEFAULT '0' COMMENT '已自动重试次数',
  `manual_retry_count` int unsigned DEFAULT '0' COMMENT '已手动重试次数',
  `message` text COMMENT '任务执行的相关信息，如报错信息',
  `latest_task_log_id` bigint unsigned DEFAULT NULL COMMENT '最后一次log guid',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近更新时间',
  `del_flag` smallint NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`),
  KEY `g_idx_device_task_instance_status` (`job_instance_id`,`status`),
  KEY `idx_device_task_slot_status` (`slot_time`,`status`),
  KEY `idx_device_task_ctime` (`create_time`),
  KEY `idx_device_task_utime` (`update_time`),
  KEY `idx_device_task_vin_ctime` (`vehicle_no`,`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='设备任务详情表'
;

/******************************************/
/*   DatabaseName = zpes_job_dev_0   */
/*   TableName = device_task_3   */
/******************************************/
drop table if exists `device_task_3`;
CREATE TABLE `device_task_3` (
  `id` bigint unsigned NOT NULL COMMENT '主键',
  `workspace_id` varchar(64) DEFAULT NULL COMMENT '空间id',
  `vehicle_no` varchar(64) DEFAULT NULL COMMENT 'vin',
  `vehicle_brand` varchar(64) DEFAULT NULL COMMENT '车辆品牌',
  `vehicle_model` varchar(64) DEFAULT NULL COMMENT '版型',
  `car_model` varchar(64) DEFAULT NULL COMMENT '车系',
  `job_instance_id` bigint unsigned DEFAULT NULL COMMENT '任务实例id',
  `ext` varchar(100) DEFAULT NULL COMMENT '任务执行额外信息',
  `job_type` int unsigned DEFAULT NULL COMMENT '任务类型，0-log；1-persistency；2-skynet',
  `slot_time` bigint unsigned DEFAULT NULL COMMENT '任务执行时间片，秒级时间戳',
  `progress` int unsigned DEFAULT NULL COMMENT '作业进度 varchar e.g. 80',
  `start_time` datetime DEFAULT NULL COMMENT '实际任务开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '实际任务结束时间',
  `status` int unsigned DEFAULT '1' COMMENT '作业状态,1-待调度 2- 执行中 3-成功 4- 失败 5-超时 6已取消',
  `status_detail` varchar(1024) DEFAULT NULL COMMENT '设备上报的状态信息',
  `retry_method` int unsigned DEFAULT '0' COMMENT '自动重试方式，0-不重试 1-重试',
  `max_retry_count` int unsigned DEFAULT '0' COMMENT '最大重试次数',
  `retry_count` int unsigned DEFAULT '0' COMMENT '已自动重试次数',
  `manual_retry_count` int unsigned DEFAULT '0' COMMENT '已手动重试次数',
  `message` text COMMENT '任务执行的相关信息，如报错信息',
  `latest_task_log_id` bigint unsigned DEFAULT NULL COMMENT '最后一次log guid',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近更新时间',
  `del_flag` smallint NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`),
  KEY `g_idx_device_task_instance_status` (`job_instance_id`,`status`),
  KEY `idx_device_task_slot_status` (`slot_time`,`status`),
  KEY `idx_device_task_ctime` (`create_time`),
  KEY `idx_device_task_utime` (`update_time`),
  KEY `idx_device_task_vin_ctime` (`vehicle_no`,`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='设备任务详情表'
;

/******************************************/
/*   DatabaseName = zpes_job_dev_0   */
/*   TableName = device_task_execute_log_0   */
/******************************************/
drop table if exists `device_task_execute_log_0`;
CREATE TABLE `device_task_execute_log_0` (
  `id` bigint unsigned NOT NULL COMMENT '主键',
  `task_id` bigint unsigned DEFAULT NULL COMMENT '作业id',
  `vehicle_no` varchar(64) DEFAULT NULL COMMENT 'vin',
  `log_type` int unsigned DEFAULT '1' COMMENT '1-首次执行 2-自动重试 3-手动重试',
  `job_type` int unsigned DEFAULT NULL COMMENT '任务类型，0-log；1-persistency；2-skynet',
  `progress` int DEFAULT NULL COMMENT '作业进度 varchar e.g. 80',
  `request_id` varchar(64) DEFAULT NULL COMMENT '下发给设备的序列号',
  `request_param` text COMMENT '请求的详细参数',
  `request_result` varchar(1024) DEFAULT NULL COMMENT '请求结果',
  `response_result` text COMMENT '设备执行结果',
  `status` int unsigned DEFAULT '1' COMMENT '作业执行状态, 0-初始化 1-请求成功 2-请求失败 3-响应成功 4-响应失败 5-响应未确定',
  `status_detail` varchar(1024) DEFAULT NULL COMMENT '作业过程中，设备上报的信息',
  `start_time` datetime DEFAULT NULL COMMENT '实际任务开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '实际任务结束时间',
  `ext` varchar(512) DEFAULT NULL COMMENT '扩展信息',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近更新时间',
  `del_flag` smallint NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`),
  KEY `g_idx_device_task_execute_log_task_type` (`task_id`,`log_type`),
  KEY `idx_device_task_execute_log_ctime` (`create_time`),
  KEY `idx_device_task_execute_log_utime` (`update_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='设备作业执行log'
;

/******************************************/
/*   DatabaseName = zpes_job_dev_0   */
/*   TableName = device_task_execute_log_1   */
/******************************************/
drop table if exists `device_task_execute_log_1`;
CREATE TABLE `device_task_execute_log_1` (
  `id` bigint unsigned NOT NULL COMMENT '主键',
  `task_id` bigint unsigned DEFAULT NULL COMMENT '作业id',
  `vehicle_no` varchar(64) DEFAULT NULL COMMENT 'vin',
  `log_type` int unsigned DEFAULT '1' COMMENT '1-首次执行 2-自动重试 3-手动重试',
  `job_type` int unsigned DEFAULT NULL COMMENT '任务类型，0-log；1-persistency；2-skynet',
  `progress` int DEFAULT NULL COMMENT '作业进度 varchar e.g. 80',
  `request_id` varchar(64) DEFAULT NULL COMMENT '下发给设备的序列号',
  `request_param` text COMMENT '请求的详细参数',
  `request_result` varchar(1024) DEFAULT NULL COMMENT '请求结果',
  `response_result` text COMMENT '设备执行结果',
  `status` int unsigned DEFAULT '1' COMMENT '作业执行状态, 0-初始化 1-请求成功 2-请求失败 3-响应成功 4-响应失败 5-响应未确定',
  `status_detail` varchar(1024) DEFAULT NULL COMMENT '作业过程中，设备上报的信息',
  `start_time` datetime DEFAULT NULL COMMENT '实际任务开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '实际任务结束时间',
  `ext` varchar(512) DEFAULT NULL COMMENT '扩展信息',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近更新时间',
  `del_flag` smallint NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`),
  KEY `g_idx_device_task_execute_log_task_type` (`task_id`,`log_type`),
  KEY `idx_device_task_execute_log_ctime` (`create_time`),
  KEY `idx_device_task_execute_log_utime` (`update_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='设备作业执行log'
;

/******************************************/
/*   DatabaseName = zpes_job_dev_0   */
/*   TableName = device_task_execute_log_2   */
/******************************************/
drop table if exists `device_task_execute_log_2`;
CREATE TABLE `device_task_execute_log_2` (
  `id` bigint unsigned NOT NULL COMMENT '主键',
  `task_id` bigint unsigned DEFAULT NULL COMMENT '作业id',
  `vehicle_no` varchar(64) DEFAULT NULL COMMENT 'vin',
  `log_type` int unsigned DEFAULT '1' COMMENT '1-首次执行 2-自动重试 3-手动重试',
  `job_type` int unsigned DEFAULT NULL COMMENT '任务类型，0-log；1-persistency；2-skynet',
  `progress` int DEFAULT NULL COMMENT '作业进度 varchar e.g. 80',
  `request_id` varchar(64) DEFAULT NULL COMMENT '下发给设备的序列号',
  `request_param` text COMMENT '请求的详细参数',
  `request_result` varchar(1024) DEFAULT NULL COMMENT '请求结果',
  `response_result` text COMMENT '设备执行结果',
  `status` int unsigned DEFAULT '1' COMMENT '作业执行状态, 0-初始化 1-请求成功 2-请求失败 3-响应成功 4-响应失败 5-响应未确定',
  `status_detail` varchar(1024) DEFAULT NULL COMMENT '作业过程中，设备上报的信息',
  `start_time` datetime DEFAULT NULL COMMENT '实际任务开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '实际任务结束时间',
  `ext` varchar(512) DEFAULT NULL COMMENT '扩展信息',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近更新时间',
  `del_flag` smallint NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`),
  KEY `g_idx_device_task_execute_log_task_type` (`task_id`,`log_type`),
  KEY `idx_device_task_execute_log_ctime` (`create_time`),
  KEY `idx_device_task_execute_log_utime` (`update_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='设备作业执行log'
;

/******************************************/
/*   DatabaseName = zpes_job_dev_0   */
/*   TableName = device_task_execute_log_3   */
/******************************************/
drop table if exists `device_task_execute_log_3`;
CREATE TABLE `device_task_execute_log_3` (
  `id` bigint unsigned NOT NULL COMMENT '主键',
  `task_id` bigint unsigned DEFAULT NULL COMMENT '作业id',
  `vehicle_no` varchar(64) DEFAULT NULL COMMENT 'vin',
  `log_type` int unsigned DEFAULT '1' COMMENT '1-首次执行 2-自动重试 3-手动重试',
  `job_type` int unsigned DEFAULT NULL COMMENT '任务类型，0-log；1-persistency；2-skynet',
  `progress` int DEFAULT NULL COMMENT '作业进度 varchar e.g. 80',
  `request_id` varchar(64) DEFAULT NULL COMMENT '下发给设备的序列号',
  `request_param` text COMMENT '请求的详细参数',
  `request_result` varchar(1024) DEFAULT NULL COMMENT '请求结果',
  `response_result` text COMMENT '设备执行结果',
  `status` int unsigned DEFAULT '1' COMMENT '作业执行状态, 0-初始化 1-请求成功 2-请求失败 3-响应成功 4-响应失败 5-响应未确定',
  `status_detail` varchar(1024) DEFAULT NULL COMMENT '作业过程中，设备上报的信息',
  `start_time` datetime DEFAULT NULL COMMENT '实际任务开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '实际任务结束时间',
  `ext` varchar(512) DEFAULT NULL COMMENT '扩展信息',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近更新时间',
  `del_flag` smallint NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`),
  KEY `g_idx_device_task_execute_log_task_type` (`task_id`,`log_type`),
  KEY `idx_device_task_execute_log_ctime` (`create_time`),
  KEY `idx_device_task_execute_log_utime` (`update_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='设备作业执行log'
;
