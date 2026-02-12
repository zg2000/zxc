-- MySQL dump 10.13  Distrib 8.3.0, for macos14.2 (arm64)
--
-- Host: aws-zpes-eu-data-uat-mysql.c9is4w0i0q2l.eu-central-1.rds.amazonaws.com    Database: zpes
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `t_alert_notice_record`
--

DROP TABLE IF EXISTS `t_alert_notice_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_alert_notice_record` (
  `id` bigint NOT NULL COMMENT '主键',
  `channel` varchar(255) DEFAULT NULL COMMENT '通知方式',
  `recipient` varchar(255) NOT NULL COMMENT '通知人',
  `contact` varchar(255) DEFAULT NULL COMMENT '联系信息',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='告警通知记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_alert_record`
--

DROP TABLE IF EXISTS `t_alert_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_alert_record` (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(255) DEFAULT NULL COMMENT '配置名称',
  `monitor_attribute` varchar(255) DEFAULT NULL COMMENT '告警属性',
  `business_area_id` varchar(500) DEFAULT NULL COMMENT '业务域',
  `vehicle_model` varchar(255) DEFAULT NULL COMMENT '车型',
  `vehicle_no` varchar(255) DEFAULT NULL COMMENT 'vin 码',
  `vehicle_brand` varchar(255) DEFAULT NULL COMMENT '品牌',
  `recipient_type` int DEFAULT NULL COMMENT '相应team',
  `recipient` varchar(100) DEFAULT NULL,
  `recipient_content` text,
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `record_time` datetime DEFAULT NULL,
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `business_area_name` varchar(500) DEFAULT NULL,
  `config_id` varchar(100) DEFAULT NULL COMMENT '告警配置id',
  `severity` int DEFAULT NULL COMMENT '告警严重程度',
  `severity_name` varchar(20) DEFAULT NULL,
  `channel` int DEFAULT NULL,
  `channel_name` varchar(20) DEFAULT NULL,
  `is_notice` int DEFAULT NULL,
  `is_public` int DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL COMMENT '告警类型',
  `version_id` varchar(100) DEFAULT NULL,
  `workspacE` int DEFAULT NULL,
  `workspace_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `t_alert_record_channel_index` (`channel`),
  KEY `t_alert_record_create_time_IDX` (`create_time`),
  KEY `t_alert_record_id_index` (`id`),
  KEY `t_alert_record_severity_index` (`severity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='告警记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_algo_algorithm`
--

DROP TABLE IF EXISTS `t_algo_algorithm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_algo_algorithm` (
  `id` bigint NOT NULL COMMENT '主键',
  `workspace_id` bigint DEFAULT NULL COMMENT '空间ID',
  `name` varchar(128) DEFAULT NULL COMMENT '名称',
  `description` longtext COMMENT '描述',
  `cells` longtext COMMENT '算法数据',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态',
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '删除标志',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `sdb_version` varchar(50) DEFAULT NULL COMMENT 'sdb版本',
  `model_id` varchar(50) DEFAULT NULL COMMENT '车型ID',
  `model_name` varchar(50) DEFAULT NULL COMMENT '车型名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='算法';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_algo_algorithm_reference`
--

DROP TABLE IF EXISTS `t_algo_algorithm_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_algo_algorithm_reference` (
  `id` bigint NOT NULL COMMENT '主键',
  `workspace_id` bigint DEFAULT NULL COMMENT '空间ID',
  `algorithm_id` bigint DEFAULT NULL COMMENT '算法ID',
  `object_type` tinyint(1) DEFAULT NULL COMMENT '对象类型',
  `object_id` bigint DEFAULT NULL COMMENT '对象ID',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态',
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '删除标志',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='算法';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_algo_seed`
--

DROP TABLE IF EXISTS `t_algo_seed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_algo_seed` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '算子id',
  `exd_id` varchar(50) DEFAULT NULL COMMENT 'exd原始的ID',
  `name` varchar(64) DEFAULT NULL COMMENT '名称',
  `display_name` varchar(64) DEFAULT NULL COMMENT '显示名称',
  `type` varchar(64) DEFAULT NULL COMMENT '类型',
  `category` varchar(64) DEFAULT NULL COMMENT '类别',
  `subcategory` varchar(64) DEFAULT NULL COMMENT '子类别',
  `icon` varchar(255) DEFAULT NULL COMMENT '图标',
  `server` varchar(64) DEFAULT NULL COMMENT '服务',
  `tag` varchar(64) DEFAULT NULL COMMENT '标签',
  `is_deployable` char(1) DEFAULT '0' COMMENT '是否可部署，1-是，0-否',
  `attributes` longtext COMMENT '属性',
  `data_type` varchar(255) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '删除标志',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='算子表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_algo_vcompute_data`
--

DROP TABLE IF EXISTS `t_algo_vcompute_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_algo_vcompute_data` (
  `id` bigint NOT NULL,
  `workspace_id` bigint DEFAULT NULL COMMENT '工作空间ID',
  `source_data` longtext,
  `transform_data` longtext,
  `status` tinyint(1) DEFAULT '0',
  `create_by` varchar(32) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(32) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_dashboard`
--

DROP TABLE IF EXISTS `t_dashboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dashboard` (
  `id` bigint NOT NULL COMMENT '主键',
  `workspace_id` bigint DEFAULT NULL COMMENT '工作空间id',
  `draft_name` varchar(64) DEFAULT NULL COMMENT '草稿id  已更新未发布',
  `dashboard_name` varchar(64) DEFAULT NULL COMMENT '仪表板名称',
  `dashboard_type` int DEFAULT NULL COMMENT '仪表板类型',
  `status` int DEFAULT NULL COMMENT '状态',
  `owner_id` bigint DEFAULT NULL COMMENT '所有者id',
  `owner_account` varchar(64) DEFAULT NULL,
  `creator` varchar(32) DEFAULT NULL COMMENT '所有者名',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标识;0：正常  1：删除',
  PRIMARY KEY (`id`),
  KEY `workspace_owner_id` (`workspace_id`,`owner_id`,`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='仪表板主表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_dashboard_version`
--

DROP TABLE IF EXISTS `t_dashboard_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_dashboard_version` (
  `id` bigint NOT NULL COMMENT '主键',
  `dashboard_id` bigint DEFAULT NULL COMMENT '主表id',
  `dashboard_name` varchar(32) DEFAULT NULL COMMENT '仪表板名称',
  `dashboard_type` int DEFAULT NULL COMMENT '仪表板类型',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人名',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标识;0：正常  1：删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='仪表板表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_data_calculate_field_function`
--

DROP TABLE IF EXISTS `t_data_calculate_field_function`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_data_calculate_field_function` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `ds_type` varchar(32) DEFAULT NULL COMMENT '数据源类型',
  `name` varchar(32) DEFAULT NULL COMMENT '函数名称',
  `method` varchar(255) DEFAULT NULL COMMENT '函数',
  `description` varchar(500) DEFAULT NULL COMMENT '描述',
  `example` varchar(255) DEFAULT NULL COMMENT '示例',
  `category` varchar(32) DEFAULT NULL COMMENT '分类',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='计算字段函数表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_data_collect_config`
--

DROP TABLE IF EXISTS `t_data_collect_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_data_collect_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `latest_version_id` bigint DEFAULT NULL COMMENT '最新配置版本id',
  `workspace_id` bigint DEFAULT NULL COMMENT '空间id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据采集配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_data_collect_config_signal`
--

DROP TABLE IF EXISTS `t_data_collect_config_signal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_data_collect_config_signal` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `collect_scope_id` bigint DEFAULT NULL COMMENT '采集范围表 t_data_collect_scope 主键',
  `signal_en_name` varchar(100) DEFAULT NULL COMMENT '信号英文名称',
  `signal_name` varchar(100) DEFAULT NULL COMMENT '信号名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据采集配置数据范围信号表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_data_collect_config_vehicle`
--

DROP TABLE IF EXISTS `t_data_collect_config_vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_data_collect_config_vehicle` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `model_name` varchar(17) DEFAULT NULL COMMENT '车型name 例：DC1E',
  `attributes` int DEFAULT NULL COMMENT '属性 0：测试；1：市场',
  `add_mode` int DEFAULT NULL COMMENT '添加方式 0：特定车辆；1：动态新增',
  `vehicle_range` int DEFAULT NULL COMMENT '车辆范围 0：全部；1：按vin码添加',
  `vehicle_count` int DEFAULT NULL COMMENT '车辆数量',
  `vehicle_import_flag` int DEFAULT '0' COMMENT '导入标识;0：非导入  1：导入',
  `vehicle_file_url` varchar(500) DEFAULT NULL COMMENT '导入的文件url',
  `vehicle_file_name` varchar(500) DEFAULT NULL COMMENT '导入的文件原名',
  `config_version_id` bigint DEFAULT NULL COMMENT '配置版本表 t_data_collect_config_version 主键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据采集配置车辆信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_data_collect_config_vehicle_vin`
--

DROP TABLE IF EXISTS `t_data_collect_config_vehicle_vin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_data_collect_config_vehicle_vin` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `config_vehicle_id` bigint DEFAULT NULL COMMENT '配置车辆信息表t_data_collect_config_vehicle_vin 主键',
  `vehicle_no` varchar(17) DEFAULT NULL COMMENT 'vin码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据采集配置车辆vin码信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_data_collect_config_version`
--

DROP TABLE IF EXISTS `t_data_collect_config_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_data_collect_config_version` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_name` varchar(64) DEFAULT NULL COMMENT '创建者人名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_name` varchar(64) DEFAULT NULL COMMENT '更新者人名',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `config_id` bigint DEFAULT NULL COMMENT '配置表 t_signal_collect_config ID',
  `config_name` varchar(64) DEFAULT NULL COMMENT '配置名称',
  `config_type` int DEFAULT NULL COMMENT '配置类型 0：事件采集；1：周期采集；2：历史数据采集；3：采集开关',
  `version` int DEFAULT NULL COMMENT '版本号',
  `back_to_version` int DEFAULT NULL COMMENT '回退至版本',
  `operation_type` int DEFAULT NULL COMMENT '配置操作类型 0：终止；1：回退；2：新建；3：复制；4：编辑；',
  `test_report_url` varchar(500) DEFAULT NULL COMMENT '测试报告url',
  `test_report_name` varchar(500) DEFAULT NULL COMMENT '测试报告文件原名',
  `status` int DEFAULT NULL COMMENT '配置状态 -1：已失效；0：已终止；1：已创建；2：审批中；3：运行中；4：发布失败；',
  `release_time` datetime DEFAULT NULL COMMENT '发布时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `job_id` bigint DEFAULT NULL COMMENT '任务jobId',
  `enable_data_collect` int DEFAULT '0' COMMENT '采集开关 0：关闭，不采集 1：打开，采集',
  `latest_version` int DEFAULT NULL COMMENT '是否为最新版本 0:不是 1:是',
  `workspace_id` bigint DEFAULT NULL COMMENT '工作空间id',
  `sdb_version` varchar(32) DEFAULT NULL COMMENT 'sdb版本',
  `model_name` varchar(32) DEFAULT NULL COMMENT '车型name 例：DC1E',
  PRIMARY KEY (`id`),
  KEY `t_data_collect_config_version_config_id_version_uindex` (`config_id`,`version`),
  KEY `t_data_collect_config_version_config_name_config_id_index` (`config_name`,`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据采集配置版本表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_data_collect_scope`
--

DROP TABLE IF EXISTS `t_data_collect_scope`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_data_collect_scope` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `sdb_version` varchar(32) DEFAULT NULL COMMENT 'SDB版本',
  `upload_cycle` int DEFAULT NULL COMMENT '上传周期/秒（周期采集）',
  `trigger_type` int DEFAULT NULL COMMENT '触发方式（事件采集） 0：条件触发；1：事件算法触发',
  `seconds_before_trigger` int DEFAULT NULL COMMENT '触发前n秒（事件采集 采集时长）',
  `seconds_after_trigger` int DEFAULT NULL COMMENT '触发后n秒（事件采集 采集时长）',
  `collect_time_start` datetime DEFAULT NULL COMMENT '采集时间-开始时间（历史数据采集）',
  `collect_time_end` datetime DEFAULT NULL COMMENT '采集时间-结束时间（历史数据采集）',
  `duration` int DEFAULT NULL COMMENT '时长/s（历史数据采集）',
  `signal_range` int DEFAULT NULL COMMENT '信号范围 0：全部；1：指定信号',
  `signal_count` int DEFAULT NULL COMMENT '信号数量',
  `signal_import_flag` int DEFAULT '0' COMMENT '导入标识;0：非导入  1：导入',
  `signal_file_url` varchar(500) DEFAULT NULL COMMENT '导入的文件url',
  `signal_file_name` varchar(500) DEFAULT NULL COMMENT '导入的文件原名',
  `config_version_id` bigint DEFAULT NULL COMMENT '配置版本表 t_data_collect_config_version 主键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据采集配置数据范围表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_data_collect_trigger_condition`
--

DROP TABLE IF EXISTS `t_data_collect_trigger_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_data_collect_trigger_condition` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `collect_scope_id` bigint DEFAULT NULL COMMENT '采集范围表 t_data_collect_scope 主键',
  `signal_en_name` varchar(100) DEFAULT NULL COMMENT '信号英文名称',
  `signal_name` varchar(100) DEFAULT NULL COMMENT '信号名称',
  `operator` varchar(4) DEFAULT NULL COMMENT '操作符支持＝，≠，>，≥，<，≤',
  `value` varchar(32) DEFAULT NULL COMMENT '值',
  `algorithm_id` varchar(20) DEFAULT NULL COMMENT '算法ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据采集配置触发条件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_data_flag`
--

DROP TABLE IF EXISTS `t_data_flag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_data_flag` (
  `id` bigint NOT NULL COMMENT '主键',
  `data_type_id` bigint DEFAULT NULL COMMENT '数据类型id',
  `cn_name` varchar(32) DEFAULT NULL COMMENT '标识名称',
  `en_name` varchar(32) DEFAULT NULL COMMENT '物理名称',
  `domain_id` int DEFAULT NULL COMMENT 'domain_id',
  `service_id` varchar(64) DEFAULT NULL COMMENT 'serviceId',
  `memo` varchar(200) DEFAULT NULL COMMENT '描述',
  `business_area_id` varchar(255) DEFAULT NULL COMMENT '业务域ID',
  `business_area_name` varchar(255) DEFAULT NULL COMMENT '业务域名称',
  `car_type_json` json DEFAULT NULL COMMENT '车型',
  `car_type_name` varchar(255) DEFAULT NULL COMMENT '车型名',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标识;0：正常  1：删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cnName` (`cn_name`,`del_flag`),
  UNIQUE KEY `three_filter` (`en_name`,`domain_id`,`service_id`,`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_data_requirement_task`
--

DROP TABLE IF EXISTS `t_data_requirement_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_data_requirement_task` (
  `id` varchar(64) NOT NULL COMMENT '主键',
  `requirement_version_id` varchar(64) NOT NULL COMMENT '配置id',
  `vehicle_no` varchar(64) DEFAULT NULL COMMENT 'vin码',
  `service_id` varchar(64) DEFAULT NULL COMMENT 'appId',
  `vehicle_brand` varchar(64) DEFAULT NULL COMMENT '车辆品牌',
  `vehicle_model` varchar(64) DEFAULT NULL COMMENT '车型',
  `domain_id` int DEFAULT NULL COMMENT 'domainId',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间（周期任务）',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间（周期任务）',
  `data_flag_name` varchar(64) DEFAULT NULL COMMENT '数据标识名（en_name）',
  `status` int DEFAULT NULL COMMENT '任务状态;0 未开始  1.开启任务-下发开始，2.开启任务-下发成功，3.开启任务-下发失败,4.结束任务-下发开始，5.结束任务-下发成功，6.结束任务-下发失败',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT '0',
  `remark` varchar(200) DEFAULT NULL,
  `oss_url` varchar(255) DEFAULT NULL COMMENT '上传地址',
  `is_running` tinyint DEFAULT NULL COMMENT '任务是否在运行 1 运行，0未运行',
  `exec_time` datetime DEFAULT NULL COMMENT '任务下发执行时间',
  PRIMARY KEY (`id`),
  KEY `vehicle_filter_id` (`vehicle_no`,`domain_id`,`service_id`),
  KEY `version_id` (`requirement_version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='persistency 单车数据task表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_data_scope`
--

DROP TABLE IF EXISTS `t_data_scope`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_data_scope` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `business_type` varchar(64) DEFAULT NULL COMMENT '业务类型 log、persistency...',
  `field` varchar(64) DEFAULT NULL COMMENT '数据范围字段名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据范围表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_data_type`
--

DROP TABLE IF EXISTS `t_data_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_data_type` (
  `id` bigint NOT NULL COMMENT '主键',
  `cn_name` varchar(32) DEFAULT NULL COMMENT '数据名称',
  `en_name` varchar(32) DEFAULT NULL COMMENT '物理名称',
  `type` varchar(32) DEFAULT NULL COMMENT '数据类型',
  `json_schema` json DEFAULT NULL COMMENT 'json语法',
  `unit` varchar(32) DEFAULT NULL COMMENT '单位',
  `memo` varchar(200) DEFAULT NULL COMMENT '描述',
  `business_area_id` varchar(64) DEFAULT NULL COMMENT '业务域ID',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标识;0：正常  1：删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cn_name` (`cn_name`,`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_area_field`
--

DROP TABLE IF EXISTS `t_log_area_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_area_field` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `business_area_id` varchar(32) DEFAULT NULL COMMENT '业务域id',
  `field_id` bigint DEFAULT NULL COMMENT 't_log_field表id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='业务域-私有日志字段关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_custom_export`
--

DROP TABLE IF EXISTS `t_log_custom_export`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_custom_export` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `filename` varchar(255) DEFAULT NULL COMMENT '文件名',
  `extension` varchar(10) DEFAULT NULL COMMENT '文件格式',
  `record_time_start` datetime DEFAULT NULL COMMENT '日志起始时间',
  `record_time_end` datetime DEFAULT NULL COMMENT '日志结束时间',
  `order_by` varchar(32) DEFAULT NULL COMMENT '排序字段',
  `order_direction` varchar(4) DEFAULT NULL COMMENT '排序方式',
  `count` int DEFAULT NULL COMMENT '日志数量',
  `bucket_name` varchar(255) DEFAULT NULL COMMENT '存储空间',
  `object_name` varchar(255) DEFAULT NULL COMMENT '文件对象名',
  `export_status` int DEFAULT NULL COMMENT '文件状态 0：文件生成失败 1：文件生成中 2：文件已生成',
  `workspace_id` varchar(64) DEFAULT NULL COMMENT '工作空间id(导出用户的工作空间id)',
  `module_type` varchar(16) DEFAULT NULL COMMENT '所属模块 log、persistency',
  `params` json DEFAULT NULL COMMENT '导出参数',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='自定义日志导出记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_data_dashboard_component`
--

DROP TABLE IF EXISTS `t_log_data_dashboard_component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_data_dashboard_component` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `guid` varchar(64) DEFAULT NULL COMMENT '组件id',
  `component_name` varchar(255) DEFAULT NULL COMMENT '组件名称',
  `component_type` varchar(32) DEFAULT NULL COMMENT '组件类型（多种图表、查询控件、图表内筛选）',
  `chart_type` int DEFAULT NULL COMMENT '图表类型 0:聚合；1:明细',
  `order_number` int DEFAULT NULL COMMENT '排序',
  `component_content` json DEFAULT NULL COMMENT '组件信息（布局、属性、筛选条件（查询控件、图表内筛选））',
  `query_input` json DEFAULT NULL COMMENT '图表字段（维度、度量、过滤器、api地址）',
  `parent_id` bigint DEFAULT NULL COMMENT '父组件id（图表内筛选）',
  `data_set_id` bigint DEFAULT NULL COMMENT '数据源id',
  `dashboard_version_id` bigint DEFAULT NULL COMMENT '仪表板版本id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='仪表板组件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_data_field`
--

DROP TABLE IF EXISTS `t_log_data_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_data_field` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `field` varchar(32) DEFAULT NULL COMMENT '日志字段',
  `field_name` varchar(50) DEFAULT NULL COMMENT '字段名称',
  `es_type` varchar(8) DEFAULT NULL COMMENT '字段在es索引中的类型',
  `field_type` varchar(8) DEFAULT NULL COMMENT '字段类型 string、number、date...',
  `operator` varchar(64) DEFAULT NULL COMMENT '运算符表id',
  `business_type` varchar(16) DEFAULT NULL COMMENT '业务类型 log、zpes-alert',
  `common` int DEFAULT '0' COMMENT '列展示是否为公共字段；0：不是 1：是',
  `filter_field` int DEFAULT '0' COMMENT '添加过滤是否可添加为过滤字段；0：否 1：是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日志和数据字段表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_data_search_record`
--

DROP TABLE IF EXISTS `t_log_data_search_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_data_search_record` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `keyword` varchar(64) DEFAULT NULL COMMENT '关键字',
  `module_type` varchar(16) DEFAULT NULL COMMENT '模块',
  `field` varchar(16) DEFAULT NULL COMMENT '记录所属字段',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='搜索记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_data_set`
--

DROP TABLE IF EXISTS `t_log_data_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_data_set` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `data_set_name` varchar(64) DEFAULT NULL COMMENT '数据集名称',
  `tables` json DEFAULT NULL COMMENT '数据集表',
  `links` json DEFAULT NULL COMMENT '数据集表关联关系',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据集表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_data_set_field`
--

DROP TABLE IF EXISTS `t_log_data_set_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_data_set_field` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `data_set_id` bigint DEFAULT NULL COMMENT '字段所属数据集集id',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `unique_id` varchar(64) DEFAULT NULL,
  `table_unique_id` varchar(64) DEFAULT NULL COMMENT '表唯一id（uniqueId）',
  `type` varchar(16) DEFAULT NULL COMMENT '字段维度类型 维度dimension、度量measure',
  `origin_field` varchar(64) DEFAULT NULL COMMENT '物理字段名',
  `origin_data_type` varchar(32) DEFAULT NULL COMMENT '物理数据类型',
  `origin_comment` text COMMENT '物理字段描述',
  `new_flag` tinyint(1) DEFAULT NULL COMMENT '是否为新增字段;true：新增',
  `caption` varchar(64) DEFAULT NULL COMMENT '字段原名（可修改）',
  `second_data_type` varchar(16) DEFAULT NULL COMMENT '数据类型(可修改)',
  `comment` text COMMENT '字段描述',
  `aggregator` varchar(16) DEFAULT NULL COMMENT '聚合方式（求和：sum、计数：count、计数(去重)：distinctCount、最大值：max、最小值：min、平均值：avg）',
  `format` varchar(16) DEFAULT NULL COMMENT '数值展示格式（自动：null、整数：#,##0、保留1位小数：#,##0.0、保留2位小数：#,##0.00、百分比：#,##0%、百分比1位小数：#,##0.0%、百分比2位小数：#,##0.00%）',
  `date_format` varchar(25) DEFAULT NULL COMMENT '日期格式',
  `date_trunc` varchar(25) DEFAULT NULL COMMENT '日期格式 year、month...',
  `geo` varchar(32) DEFAULT NULL COMMENT '地理',
  `parent_id` bigint DEFAULT NULL COMMENT '父级id 日期格式字段会拆分为多个字段',
  `hidden` tinyint(1) DEFAULT '0' COMMENT '是否隐藏 隐藏：true',
  `field_from` int DEFAULT NULL COMMENT '字段来源：0：数据源；1：复制；2：计算字段',
  `expression` text COMMENT '计算字段表达式',
  `support_aggregation` tinyint(1) DEFAULT '0' COMMENT '计算字段是否支持聚合（度量且计算字段不包含聚合函数为true）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  PRIMARY KEY (`id`),
  KEY `t_log_data_set_field_data_set_id_index` (`data_set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据集字段表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_data_source_table`
--

DROP TABLE IF EXISTS `t_log_data_source_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_data_source_table` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `table_name` varchar(64) DEFAULT NULL COMMENT '表名',
  `db_type` varchar(64) DEFAULT NULL COMMENT '数据库类型',
  `comment` varchar(64) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据源对应的数据库table表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_data_source_table_field`
--

DROP TABLE IF EXISTS `t_log_data_source_table_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_data_source_table_field` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `field` varchar(64) DEFAULT NULL COMMENT '字段',
  `field_type` varchar(32) DEFAULT NULL COMMENT '字段类型',
  `field_name` varchar(64) DEFAULT NULL COMMENT '字段名称',
  `comment` text COMMENT '字段描述',
  `table_id` bigint DEFAULT NULL COMMENT '所属表id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据源table字段表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_file_download_record`
--

DROP TABLE IF EXISTS `t_log_file_download_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_file_download_record` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `file_id` text COMMENT 'OSS文件id',
  `status` int DEFAULT NULL COMMENT '下载状态;0:失败 1:成功',
  `remark` varchar(255) DEFAULT NULL COMMENT '其他信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日志文件下载记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_file_parse_flow`
--

DROP TABLE IF EXISTS `t_log_file_parse_flow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_file_parse_flow` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `file_id` bigint DEFAULT NULL COMMENT 'OSS文件id',
  `parse_status` int DEFAULT NULL COMMENT '解析状态 1：created 2：parsed 3：partParsed 4：failed',
  `parse_failed_message` text COMMENT '解析失败原因',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日志文件解析过程表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_file_requirement_version`
--

DROP TABLE IF EXISTS `t_log_file_requirement_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_file_requirement_version` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `file_id` bigint DEFAULT NULL COMMENT 'oss文件id',
  `requirement_version_id` bigint DEFAULT NULL COMMENT '需求版本id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日志文件需求配置版本关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_filter`
--

DROP TABLE IF EXISTS `t_log_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_filter` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `filter_name` varchar(255) DEFAULT NULL COMMENT '过滤器名称',
  `default_flag` int DEFAULT '0' COMMENT '默认 0 非默认；1默认',
  `filters` json DEFAULT NULL COMMENT '过滤条件',
  `business_type` varchar(16) DEFAULT NULL COMMENT '业务类型 log、persistency、zpes-alert',
  `workspace_id` varchar(64) DEFAULT NULL COMMENT '所属工作空间id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日志检索过滤器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_level_config`
--

DROP TABLE IF EXISTS `t_log_level_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_level_config` (
  `id` bigint NOT NULL COMMENT '主键',
  `log_level` int DEFAULT NULL COMMENT '日志级别',
  `log_type` varchar(16) DEFAULT NULL COMMENT '日志类型',
  `vehicle_model` varchar(32) DEFAULT NULL COMMENT '车型',
  `vehicle_env` varchar(32) DEFAULT NULL COMMENT '所适用的车辆环境',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标志',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日志级别默认配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_requirement`
--

DROP TABLE IF EXISTS `t_log_requirement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_requirement` (
  `id` bigint NOT NULL COMMENT '主键',
  `requirement_version_id` bigint DEFAULT NULL COMMENT '最新版本id;指向最新正式生效的版本id',
  `revision` varchar(32) DEFAULT NULL,
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标志',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日志需求配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_requirement_cloud_record`
--

DROP TABLE IF EXISTS `t_log_requirement_cloud_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_requirement_cloud_record` (
  `id` bigint NOT NULL COMMENT '主键',
  `requirement_version_id` bigint DEFAULT NULL COMMENT '版本配置表id',
  `requirement_task_id` bigint DEFAULT NULL COMMENT '日志需求配置任务id',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标志',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日志需求配置需求上云状态的记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_requirement_filter`
--

DROP TABLE IF EXISTS `t_log_requirement_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_requirement_filter` (
  `id` varchar(255) NOT NULL COMMENT '主键',
  `filter_type` int DEFAULT NULL COMMENT '来源类型;0 静态配置  1 动态配置',
  `physical_id` varchar(64) DEFAULT NULL COMMENT 'PhysicalId',
  `ecu_id` varchar(64) DEFAULT NULL COMMENT 'ecuId',
  `app_id` varchar(64) DEFAULT NULL COMMENT 'appId',
  `ctx_id` varchar(64) DEFAULT NULL COMMENT 'ctxId',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标志',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日志配置四元组表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_requirement_filter_loginfo`
--

DROP TABLE IF EXISTS `t_log_requirement_filter_loginfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_requirement_filter_loginfo` (
  `id` bigint NOT NULL COMMENT '主键',
  `filter_id` varchar(255) DEFAULT NULL COMMENT '四元组id',
  `requirement_version_id` bigint DEFAULT NULL COMMENT '配置id',
  `soft_version` varchar(64) DEFAULT NULL COMMENT '软件版本',
  `log_type` varchar(32) DEFAULT NULL COMMENT '日志类型',
  `log_level` int DEFAULT NULL COMMENT '日志级别',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标志',
  PRIMARY KEY (`id`),
  KEY `version_filter` (`requirement_version_id`,`filter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日志配置需求日志配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_requirement_task`
--

DROP TABLE IF EXISTS `t_log_requirement_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_requirement_task` (
  `id` varchar(64) NOT NULL COMMENT '主键',
  `requirement_version_id` varchar(64) DEFAULT NULL COMMENT '日志需求配置版本',
  `cloud_status` int DEFAULT NULL,
  `task_opt_id` varchar(64) DEFAULT NULL COMMENT '任务操作id',
  `vehicle_brand` varchar(64) DEFAULT NULL COMMENT '车辆品牌',
  `vehicle_model` varchar(64) DEFAULT NULL COMMENT '车型',
  `vehicle_no` varchar(64) DEFAULT NULL COMMENT 'vin码',
  `physical_id` varchar(64) DEFAULT NULL COMMENT 'PhysicalId',
  `ecu_id` varchar(64) DEFAULT NULL COMMENT 'ecuId',
  `app_id` varchar(64) DEFAULT NULL COMMENT 'appId',
  `ctx_id` varchar(64) DEFAULT NULL COMMENT 'ctxId',
  `task_type` int DEFAULT NULL COMMENT '任务类型;1 开始任务  2 关闭任务',
  `log_level` int DEFAULT NULL COMMENT '日志级别',
  `log_type` varchar(255) DEFAULT NULL COMMENT '日志类型',
  `start_time` datetime DEFAULT NULL COMMENT '任务开始时间',
  `end_time` datetime DEFAULT NULL,
  `status` int DEFAULT NULL COMMENT '任务状态;0 未开始  1.开启任务-下发开始，2.开启任务-下发成功，3.开启任务-下发失败,4.结束任务-下发开始，5.结束任务-下发成功，6.结束任务-下发失败',
  `oss_uri` varchar(255) DEFAULT NULL COMMENT '文件的oss_uri',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT '0',
  `memo` varchar(200) DEFAULT NULL,
  `exec_time` datetime DEFAULT NULL COMMENT '任务下发执行时间',
  PRIMARY KEY (`id`),
  KEY `vehicle_filter_id` (`vehicle_no`,`physical_id`,`ecu_id`,`app_id`,`ctx_id`),
  KEY `version_id` (`requirement_version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日志需求配置任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_requirement_task_do`
--

DROP TABLE IF EXISTS `t_log_requirement_task_do`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_requirement_task_do` (
  `id` varchar(64) NOT NULL COMMENT '主键',
  `cloud_status` int DEFAULT NULL COMMENT '上云状态',
  `vehicle_no` varchar(64) DEFAULT NULL COMMENT 'vin码',
  `physical_id` varchar(64) DEFAULT NULL COMMENT 'PhysicalId',
  `ecu_id` varchar(64) DEFAULT NULL COMMENT 'ecuId',
  `app_id` varchar(64) DEFAULT NULL COMMENT 'appId',
  `ctx_id` varchar(64) DEFAULT NULL COMMENT 'ctxId',
  `task_type` int DEFAULT NULL COMMENT '任务类型;1 开始任务  2 关闭任务',
  `log_level` int DEFAULT NULL COMMENT '日志级别',
  `log_type` varchar(255) DEFAULT NULL COMMENT '日志类型',
  `oss_url` varchar(255) DEFAULT NULL COMMENT '文件url',
  `start_time` datetime DEFAULT NULL COMMENT '任务开始时间',
  `end_time` datetime DEFAULT NULL,
  `status` int DEFAULT NULL COMMENT '任务状态;0 未开始  1.开启任务-下发开始，2.开启任务-下发成功，3.开启任务-下发失败,4.结束任务-下发开始，5.结束任务-下发成功，6.结束任务-下发失败',
  `is_running` tinyint DEFAULT NULL COMMENT '任务是否在运行 1 运行，0未运行',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` int DEFAULT '0',
  `merge` tinyint(1) DEFAULT '0' COMMENT '是否合并',
  `exec_time` datetime DEFAULT NULL COMMENT '任务下发执行时间',
  PRIMARY KEY (`id`),
  KEY `vehicle_no` (`vehicle_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日志需求配置任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_requirement_task_record`
--

DROP TABLE IF EXISTS `t_log_requirement_task_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_requirement_task_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `requirement_id` bigint DEFAULT NULL COMMENT '需求配置id',
  `requirement_version_id` bigint DEFAULT NULL COMMENT '配置版本id',
  `request_id` varchar(128) DEFAULT NULL COMMENT '请求ID',
  `vehicle_brand` varchar(64) DEFAULT NULL COMMENT '车辆品牌',
  `vehicle_model` varchar(64) DEFAULT NULL COMMENT '车型',
  `vehicle_no` varchar(64) DEFAULT NULL COMMENT 'vin码',
  `physical_id` varchar(64) DEFAULT NULL COMMENT 'PhysicalId',
  `ecu_id` varchar(64) DEFAULT NULL COMMENT 'ecuId',
  `app_id` varchar(64) DEFAULT NULL COMMENT 'appId',
  `ctx_id` varchar(64) DEFAULT NULL COMMENT 'ctxId',
  `status` int DEFAULT NULL COMMENT '状态',
  `cause` varchar(32) DEFAULT NULL COMMENT '结果描述',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标志',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日志需求配置任务下发记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_requirement_task_relation`
--

DROP TABLE IF EXISTS `t_log_requirement_task_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_requirement_task_relation` (
  `id` bigint NOT NULL COMMENT '主键',
  `requirement_task_id` bigint DEFAULT NULL COMMENT '日志需求配置任务id',
  `requirement_version_id` bigint DEFAULT NULL COMMENT '版本配置表id',
  `requirement_cloud_status` int DEFAULT NULL,
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标志',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日志需求配置任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_requirement_task_request`
--

DROP TABLE IF EXISTS `t_log_requirement_task_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_requirement_task_request` (
  `id` varchar(64) NOT NULL COMMENT '主键',
  `requirement_task_id` varchar(64) DEFAULT NULL COMMENT '日志需求配置任务id',
  `request_id` varchar(255) DEFAULT NULL COMMENT '调用zxc接口返回的 request',
  `request_type` int DEFAULT NULL COMMENT '请求类型：AddOrUpdateFilters(0), EnableFilters(1), EnableLogReport(2), DisableLogReport(3), DisableFilters(4), RemoveLogFilters(5)',
  `vehicle_no` varchar(100) DEFAULT NULL COMMENT 'vin码',
  `log_level` int DEFAULT NULL,
  `cloud_status` int DEFAULT NULL,
  `service_name` varchar(100) DEFAULT NULL COMMENT '服务名称',
  `function_name` varchar(100) DEFAULT NULL COMMENT '方法名称',
  `request_param` json DEFAULT NULL COMMENT '请求参数',
  `status` int DEFAULT NULL COMMENT '状态',
  `response_result` json DEFAULT NULL COMMENT 'ZXC请求结果',
  `request_result` json DEFAULT NULL COMMENT 'ZXC响应结果',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标志',
  `memo` varchar(100) DEFAULT NULL,
  `stage` tinyint DEFAULT NULL COMMENT '指令所属阶段，开始或者结束等',
  `first` tinyint(1) DEFAULT NULL COMMENT '是否是该阶段的第一个指令',
  `last` tinyint(1) DEFAULT NULL COMMENT '是否是该阶段的最后一个指令',
  `task_type` tinyint DEFAULT NULL COMMENT '任务类型, 0: LogManager, 1: Persistency,2:skynet',
  PRIMARY KEY (`id`),
  KEY `idx_t_log_requirement_task_request_vehicle_no` (`vehicle_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务指令请求信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_requirement_task_snapshot`
--

DROP TABLE IF EXISTS `t_log_requirement_task_snapshot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_requirement_task_snapshot` (
  `id` bigint NOT NULL COMMENT '主键',
  `requirement_task_id` bigint DEFAULT NULL COMMENT '快照任务id',
  `cloud_status` int DEFAULT NULL COMMENT '快照上云状态',
  `task_type` int DEFAULT NULL COMMENT '任务类型;1 开始任务  2 关闭任务',
  `vehicle_no` varchar(64) DEFAULT NULL COMMENT 'vin码',
  `physical_id` varchar(64) DEFAULT NULL COMMENT 'PhysicalId',
  `ecu_id` varchar(64) DEFAULT NULL COMMENT 'ecuId',
  `app_id` varchar(64) DEFAULT NULL COMMENT 'appId',
  `ctx_id` varchar(64) DEFAULT NULL COMMENT 'ctxId',
  `log_level` int DEFAULT NULL COMMENT '日志级别',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标志',
  PRIMARY KEY (`id`),
  UNIQUE KEY `vehicle_filter_id` (`vehicle_no`,`physical_id`,`ecu_id`,`app_id`,`ctx_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='车端日志任务快照';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_requirement_task_statistic`
--

DROP TABLE IF EXISTS `t_log_requirement_task_statistic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_requirement_task_statistic` (
  `id` bigint NOT NULL COMMENT '主键',
  `requirement_version_id` bigint DEFAULT NULL COMMENT '配置版本id',
  `total_count` int DEFAULT NULL COMMENT '总数',
  `done_count` int DEFAULT NULL COMMENT '已下发数',
  `fail_count` int DEFAULT NULL COMMENT '失败数',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标志',
  PRIMARY KEY (`id`),
  KEY `t_log_requirement_task_statistic_requirement_version_id_IDX` (`requirement_version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日志需求配置任务下发统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_requirement_vehicle_version_relation`
--

DROP TABLE IF EXISTS `t_log_requirement_vehicle_version_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_requirement_vehicle_version_relation` (
  `id` bigint NOT NULL COMMENT '主键',
  `requirement_version_id` bigint DEFAULT NULL COMMENT '最新版本id;指向最新正式生效的版本id',
  `vehicle_no` varchar(255) DEFAULT NULL COMMENT '车辆vin码',
  `vehicle_count` int DEFAULT NULL,
  `filter_log_info_id` varchar(64) DEFAULT NULL COMMENT '日志配置id',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标志',
  PRIMARY KEY (`id`),
  KEY `vehicleNo` (`vehicle_no`,`requirement_version_id`),
  KEY `versionId` (`requirement_version_id`,`vehicle_no`,`vehicle_count`),
  KEY `version_vehicle` (`requirement_version_id`,`vehicle_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日志需求版本车辆四元组表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_requirement_version`
--

DROP TABLE IF EXISTS `t_log_requirement_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_requirement_version` (
  `id` bigint NOT NULL COMMENT '主键',
  `requirement_id` bigint DEFAULT NULL COMMENT '配置表ID',
  `config_name` varchar(64) DEFAULT NULL COMMENT '配置名称',
  `workspace_id` bigint DEFAULT NULL,
  `vehicle_brand` varchar(64) DEFAULT NULL COMMENT '车辆品牌',
  `vehicle_brand_id` varchar(64) DEFAULT NULL,
  `vehicle_model` varchar(64) DEFAULT NULL COMMENT '车型',
  `vehicle_model_id` varchar(64) DEFAULT NULL,
  `vehicle_no` varchar(64) DEFAULT NULL COMMENT 'vin码',
  `job_id` bigint DEFAULT NULL,
  `business_area_id` varchar(64) DEFAULT NULL COMMENT '业务域ID',
  `business_area_name` varchar(64) DEFAULT NULL COMMENT '业务域名称',
  `is_public` int DEFAULT NULL COMMENT '0 不公开 1 公开',
  `start_time` datetime DEFAULT NULL COMMENT '配置开始日期',
  `end_time` datetime DEFAULT NULL COMMENT '配置结束时间',
  `duration` varchar(64) DEFAULT NULL,
  `cloud_status` int DEFAULT NULL COMMENT '是否上云;0 不上云  1 上云',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` int DEFAULT NULL COMMENT '配置状态',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标志',
  `module_type` tinyint NOT NULL DEFAULT '0' COMMENT '0 log,1 persistency',
  `revision` varchar(32) DEFAULT NULL,
  `chose_type` int DEFAULT NULL,
  `range_type` int DEFAULT NULL,
  `vehicle_count` int DEFAULT NULL,
  `md5_character` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `t_log_requirement_version_requirement_id_IDX` (`requirement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日志需求配版本置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_log_task_do_link`
--

DROP TABLE IF EXISTS `t_log_task_do_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log_task_do_link` (
  `id` varchar(64) NOT NULL,
  `task_id` varchar(64) NOT NULL COMMENT 'task主键id',
  `task_do_id` varchar(64) NOT NULL COMMENT 'task_do 主键id',
  `requirement_version_id` varchar(64) NOT NULL COMMENT '日志需求配置版本',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `requirement_version_id` (`requirement_version_id`),
  KEY `task_do_index` (`task_do_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_message_notify`
--

DROP TABLE IF EXISTS `t_message_notify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_message_notify` (
  `id` bigint NOT NULL COMMENT '主键',
  `workspace_id` varchar(64) DEFAULT NULL COMMENT '空间id',
  `ref_id` bigint DEFAULT NULL COMMENT '消息源id',
  `message_type` varchar(64) DEFAULT NULL COMMENT '消息类型',
  `message_title` varchar(64) DEFAULT NULL COMMENT '消息头',
  `message_body` varchar(200) DEFAULT NULL COMMENT '消息内容',
  `status` int DEFAULT NULL COMMENT '消息状态',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标识;0：正常  1：删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='消息通知中心';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_metric_application`
--

DROP TABLE IF EXISTS `t_metric_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_metric_application` (
  `id` varchar(64) NOT NULL COMMENT '主键',
  `name` varchar(50) DEFAULT '' COMMENT '应用名称',
  `business_code` varchar(50) DEFAULT '0' COMMENT '业务编码, 如：zpes',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `kafka_properties` varchar(1000) DEFAULT NULL,
  `topic` varchar(100) DEFAULT NULL,
  `env` varchar(20) DEFAULT NULL COMMENT '环境',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='埋点应用信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_metric_audit_log`
--

DROP TABLE IF EXISTS `t_metric_audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_metric_audit_log` (
  `id` varchar(64) NOT NULL COMMENT '主键',
  `title` varchar(50) DEFAULT '' COMMENT '标题',
  `request_url` varchar(2000) DEFAULT NULL COMMENT '请求地址',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime(3) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime(3) DEFAULT NULL COMMENT '修改时间',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `request_body` text,
  `response_body` text,
  `ip_address` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `business_code` varchar(50) DEFAULT NULL COMMENT '业务编码, 如：zpes',
  `application_name` varchar(50) DEFAULT NULL COMMENT '应用名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='审计日志信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_monitor_config`
--

DROP TABLE IF EXISTS `t_monitor_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_monitor_config` (
  `id` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '配置名称',
  `business_area_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '业务域id',
  `business_area_name` text COLLATE utf8mb4_estonian_ci,
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识',
  `status` int NOT NULL DEFAULT '0' COMMENT '草稿状态',
  `enable` int NOT NULL DEFAULT '0' COMMENT '启用状态',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `creator` varchar(64) COLLATE utf8mb4_estonian_ci DEFAULT NULL,
  `is_public` int DEFAULT NULL,
  `type` varchar(50) COLLATE utf8mb4_estonian_ci DEFAULT NULL,
  `version_id` varchar(50) COLLATE utf8mb4_estonian_ci DEFAULT NULL,
  `version` varchar(50) COLLATE utf8mb4_estonian_ci DEFAULT NULL,
  `workspace_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_estonian_ci COMMENT='告警配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_monitor_config_version`
--

DROP TABLE IF EXISTS `t_monitor_config_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_monitor_config_version` (
  `id` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL COMMENT ' 主键',
  `config_id` varchar(100) COLLATE utf8mb4_estonian_ci NOT NULL COMMENT ' 配置id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '配置名称',
  `vehicle_no` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT ' vin码',
  `vehicle_json` text COLLATE utf8mb4_estonian_ci,
  `business_area_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT ' 业务域id',
  `business_area_name` text COLLATE utf8mb4_estonian_ci,
  `severity` int DEFAULT NULL COMMENT ' 告警严重程度',
  `channel` int DEFAULT NULL COMMENT ' 告警方式',
  `notice_interval` int DEFAULT NULL,
  `workspace_id` varchar(100) COLLATE utf8mb4_estonian_ci DEFAULT NULL,
  `recipient_type` int DEFAULT NULL COMMENT ' 响应team',
  `recipient` varchar(100) COLLATE utf8mb4_estonian_ci DEFAULT NULL COMMENT ' team信息',
  `recipient_content` text COLLATE utf8mb4_estonian_ci,
  `email` text COLLATE utf8mb4_estonian_ci,
  `emp_no` text COLLATE utf8mb4_estonian_ci,
  `start_time` datetime DEFAULT NULL COMMENT ' 告警开始时间',
  `end_time` datetime DEFAULT NULL COMMENT ' 告警结束时间',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT ' 删除标识',
  `status` int NOT NULL DEFAULT '0' COMMENT ' 草稿状态',
  `alert_logic` varchar(10) COLLATE utf8mb4_estonian_ci DEFAULT NULL COMMENT ' 告警条件逻辑',
  `condition_json` text COLLATE utf8mb4_estonian_ci COMMENT ' 告警条件集合',
  `alert_condition_json` text COLLATE utf8mb4_estonian_ci COMMENT ' 告警触发条件集合',
  `monitor_attribute` text COLLATE utf8mb4_estonian_ci COMMENT ' 告警属性文本',
  `enable` int NOT NULL DEFAULT '0' COMMENT '启用状态',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT ' 创建人',
  `create_time` datetime DEFAULT NULL COMMENT ' 创建时间',
  `update_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT ' 更新人',
  `update_time` datetime DEFAULT NULL COMMENT ' 更新时间',
  `creator` varchar(64) COLLATE utf8mb4_estonian_ci DEFAULT NULL,
  `is_public` int DEFAULT NULL,
  `type` varchar(50) COLLATE utf8mb4_estonian_ci DEFAULT NULL,
  `version` varchar(50) COLLATE utf8mb4_estonian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_estonian_ci COMMENT='告警配置版本表        ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_monitor_task`
--

DROP TABLE IF EXISTS `t_monitor_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_monitor_task` (
  `id` varchar(100) NOT NULL,
  `config_id` varchar(100) DEFAULT NULL COMMENT '配置表id',
  `name` varchar(255) DEFAULT NULL COMMENT '配置名称',
  `monitor_attribute` text,
  `status` int DEFAULT NULL COMMENT '同步kap状态',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `version_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `t_monitor_task_config_id_index` (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='下发kap记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_oss_file`
--

DROP TABLE IF EXISTS `t_oss_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_oss_file` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `bucket_name` varchar(255) DEFAULT NULL COMMENT '存储空间名',
  `object_name` varchar(255) DEFAULT NULL COMMENT '对象名',
  `file_oss_url` varchar(500) DEFAULT NULL COMMENT '文件oss地址',
  `etag` varchar(50) DEFAULT NULL COMMENT '标识一个Object的内容',
  `size` bigint DEFAULT NULL COMMENT '文件大小',
  `mime_type` varchar(32) DEFAULT NULL COMMENT '资源类型',
  `vehicle_brand` varchar(64) DEFAULT NULL COMMENT '车辆品牌',
  `car_model` varchar(64) DEFAULT NULL COMMENT '车系',
  `vehicle_model` varchar(64) DEFAULT NULL COMMENT '版型',
  `vehicle_no` varchar(64) DEFAULT NULL COMMENT 'vin码',
  `workspace_id` text COMMENT '工作空间id',
  `physical_id` text COMMENT 'physicalId',
  `ecu_id` text COMMENT 'ECU ID',
  `app_id` text COMMENT '应用ID',
  `ctx_id` text COMMENT '上下文ID',
  `sampling_id` text COMMENT 'samplingIdList',
  `service_id` text COMMENT 'persistency 三元组 serviceId',
  `domain_id` text COMMENT 'persistency 三元组 domainId',
  `data_key` text COMMENT 'persistency 三元组 key',
  `filename` varchar(255) DEFAULT NULL COMMENT '文件名',
  `file_time` datetime DEFAULT NULL COMMENT '日志文件产生的时间',
  `file_type` varchar(16) DEFAULT NULL COMMENT '日志类型 dlt、core、dump、tomstore、logcat、syslog',
  `business_type` varchar(64) DEFAULT NULL COMMENT '业务类型 log、persistency',
  `static_config` int DEFAULT NULL COMMENT '是否为静态配置 0：静态配置 1：非静态配置',
  `parse_status` int DEFAULT NULL COMMENT '解析状态 1：created 2：parsed 3：partParsed 4：failed',
  `parse_failed_message` text COMMENT '解析失败原因',
  `data_scope` json DEFAULT NULL COMMENT '数据范围',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='OSS文件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_permission`
--

DROP TABLE IF EXISTS `t_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_permission` (
  `id` bigint NOT NULL COMMENT '主键',
  `permission_code` varchar(255) NOT NULL COMMENT '权限编号',
  `permission_name` varchar(255) NOT NULL COMMENT '权限名称',
  `permission_type` int NOT NULL COMMENT '权限类型 1.菜单资源;2.操作资源(按钮资源);3.数据行资源;4.接口资源',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工作空间功能权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_requirement_data_link`
--

DROP TABLE IF EXISTS `t_requirement_data_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_requirement_data_link` (
  `id` bigint NOT NULL,
  `data_flag_id` varchar(64) NOT NULL COMMENT 'data_falg_id',
  `data_requirement_id` varchar(64) DEFAULT NULL COMMENT 'data_requirement_id',
  `version_id` varchar(64) NOT NULL COMMENT '配置version',
  `vehicle_no` varchar(64) DEFAULT NULL COMMENT '车辆vin',
  `cn_name` varchar(64) DEFAULT NULL,
  `domain_id` int DEFAULT NULL,
  `service_id` varchar(64) DEFAULT NULL,
  `group_tag` varchar(64) DEFAULT NULL COMMENT '分类tag',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标志',
  PRIMARY KEY (`id`),
  KEY `data_requirement_id` (`data_requirement_id`),
  KEY `version_id` (`version_id`,`data_flag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据配置 关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_requirement_origin`
--

DROP TABLE IF EXISTS `t_requirement_origin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_requirement_origin` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `requirement_id` varchar(32) DEFAULT NULL COMMENT '配置id',
  `requirement_version_id` varchar(32) DEFAULT NULL COMMENT '配置版本id',
  `config_name` varchar(32) DEFAULT NULL COMMENT '配置名称',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `cloud_status` tinyint DEFAULT NULL COMMENT '是否上云',
  `status` int DEFAULT NULL COMMENT '配置状态 0 默认，1,暂停，2.重启，3,结束（已有新版本，老版本结束）',
  `requirement_type` tinyint DEFAULT NULL COMMENT '配置类型:0-log,1-persistency,2-netSky',
  `vehicle_type` tinyint DEFAULT NULL COMMENT '0,批量选择，1,具体vin列表 ',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` tinyint(1) DEFAULT NULL COMMENT '是否删除',
  `ext_info` text COMMENT '配置信息 保存三元组，四元组信息 json',
  `ext_param` text COMMENT '批量选择车辆条件json',
  `auto_inc` tinyint(1) DEFAULT '0' COMMENT '车辆是否动态新增：1 是，0 否',
  PRIMARY KEY (`id`),
  UNIQUE KEY `versionId` (`requirement_version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='task服务数据配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_requirement_push_seg_log`
--

DROP TABLE IF EXISTS `t_requirement_push_seg_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_requirement_push_seg_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `requirement_version_id` varchar(64) DEFAULT NULL COMMENT '配置versionId',
  `seg_index` int DEFAULT NULL COMMENT '分片页码',
  `size` int DEFAULT NULL COMMENT '分片大小',
  `total` int DEFAULT NULL COMMENT '分片总数',
  `send_status` tinyint(1) DEFAULT '0' COMMENT '发送结果',
  `seg_id` varchar(64) DEFAULT NULL COMMENT '分片uuId',
  `receive_status` tinyint(1) DEFAULT '0' COMMENT '接收结果',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务分片发送日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_requirement_vehicle`
--

DROP TABLE IF EXISTS `t_requirement_vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_requirement_vehicle` (
  `id` bigint DEFAULT NULL COMMENT '主键',
  `vehicle_no` varchar(32) DEFAULT NULL COMMENT 'vin码 车辆vin码',
  `requirment_version_id` varchar(32) DEFAULT NULL COMMENT '配置version_id',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '是否删除'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务配置关联车辆';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_resolver`
--

DROP TABLE IF EXISTS `t_resolver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_resolver` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `desc` varchar(512) DEFAULT NULL COMMENT '描述',
  `workspace_id` varchar(255) DEFAULT NULL COMMENT '空间id',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='消息流转-订阅';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_rtos_requirement_ext`
--

DROP TABLE IF EXISTS `t_rtos_requirement_ext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_rtos_requirement_ext` (
  `id` bigint NOT NULL COMMENT '主键',
  `requirement_version_id` bigint DEFAULT NULL COMMENT '配置id',
  `ecu_id` varchar(64) DEFAULT NULL COMMENT 'ecu_id',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标识;0：正常  1：删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='天网配置数据范围信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_signal_car_model`
--

DROP TABLE IF EXISTS `t_signal_car_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_signal_car_model` (
  `id` bigint NOT NULL,
  `sdb_version` varchar(50) DEFAULT NULL COMMENT 'sdb版本',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `oss_path` varchar(255) DEFAULT NULL COMMENT '文件路径',
  `sdb_version_id` bigint DEFAULT NULL COMMENT '版本id',
  `car_model` varchar(50) DEFAULT NULL COMMENT '车型',
  `content` json DEFAULT NULL COMMENT '文件解析内容',
  `operate_id` varchar(100) DEFAULT NULL COMMENT '操作id',
  `del_flag` int DEFAULT NULL COMMENT '删除状态',
  `check_status` int DEFAULT NULL COMMENT '校验状态',
  `check_message` varchar(250) DEFAULT NULL COMMENT '校验信息',
  PRIMARY KEY (`id`),
  KEY `t_signal_car_model_operate_id_index` (`operate_id`),
  KEY `t_signal_car_model_operate_id_oss_path_index` (`operate_id`,`oss_path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='sdb版本车型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_signal_info`
--

DROP TABLE IF EXISTS `t_signal_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_signal_info` (
  `id` bigint NOT NULL,
  `sdb_version` varchar(50) DEFAULT NULL COMMENT '版本',
  `sdb_version_id` bigint DEFAULT NULL COMMENT '版本id',
  `pdu_name` varchar(100) DEFAULT NULL COMMENT '报文名称',
  `signal_name` varchar(255) DEFAULT NULL COMMENT '信号中文名称',
  `signal_english_name` varchar(100) NOT NULL COMMENT '信号英文名称',
  `cycle_time` int DEFAULT NULL COMMENT '发送频率',
  `bit_length` int DEFAULT NULL COMMENT '信号长度',
  `min` varchar(50) DEFAULT NULL COMMENT '最小值',
  `unit` varchar(50) DEFAULT NULL COMMENT '单位',
  `max` varchar(50) DEFAULT NULL COMMENT '最大值',
  `factor` decimal(10,0) DEFAULT NULL COMMENT 'factor',
  `offset` decimal(10,0) DEFAULT NULL COMMENT '偏移量',
  `text_table` text COMMENT 'textTable',
  `car_model` varchar(100) DEFAULT NULL COMMENT '车型',
  `signal_car_model_id` bigint DEFAULT NULL COMMENT '所属车型文件id',
  `tag` varchar(50) DEFAULT NULL COMMENT '标签',
  `signal_type` varchar(50) DEFAULT NULL COMMENT '类型',
  `description` text COMMENT '描述',
  `cloud_status` int DEFAULT NULL COMMENT '上云状态',
  `workspace_id` bigint DEFAULT NULL COMMENT '工作空间',
  `del_flag` int DEFAULT NULL COMMENT '删除状态',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `collect_frequency` int DEFAULT NULL COMMENT '降频系数',
  `demand_cycle` int DEFAULT NULL COMMENT '需求周期',
  `collect_cycle` int DEFAULT '0' COMMENT '采集周期',
  `pdu_id` int DEFAULT NULL COMMENT 'pduId',
  `frame_name` varchar(250) DEFAULT NULL COMMENT '报文名称',
  `gdpr_signals` int DEFAULT NULL COMMENT 'gdpr信号',
  PRIMARY KEY (`id`),
  KEY `signal_english_index` (`signal_english_name`),
  KEY `t_sdb_version_index` (`sdb_version`),
  KEY `t_signal_info_cloud_status_index` (`cloud_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='信号详情';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_signal_version`
--

DROP TABLE IF EXISTS `t_signal_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_signal_version` (
  `id` bigint NOT NULL,
  `sdb_version` varchar(50) NOT NULL COMMENT '文件版本',
  `create_by` varchar(255) DEFAULT NULL COMMENT '用户ID',
  `update_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `workspace_id` bigint DEFAULT NULL COMMENT '空间id',
  `del_flag` int DEFAULT NULL COMMENT '删除状态',
  `car_model` varchar(255) DEFAULT NULL COMMENT '车型',
  `operate_id` varchar(50) DEFAULT NULL COMMENT '操作id',
  `cloud_file_path` varchar(100) DEFAULT NULL COMMENT '上云文件路径',
  `status` int DEFAULT NULL COMMENT '版本状态',
  `signal_count` int DEFAULT '0' COMMENT '上云信号数量',
  PRIMARY KEY (`id`),
  UNIQUE KEY `t_signal_version_sdb_version_uindex` (`sdb_version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='信号版本表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_skynet_ext`
--

DROP TABLE IF EXISTS `t_skynet_ext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_skynet_ext` (
  `id` bigint NOT NULL COMMENT '主键',
  `type` int DEFAULT NULL COMMENT '类型 1 ecu 2 simpling',
  `cn_name` varchar(64) DEFAULT NULL COMMENT 'ECU或simpling中文名称',
  `en_name` varchar(64) DEFAULT NULL COMMENT 'ECU或simpling英文名称',
  `serial_no` int DEFAULT NULL COMMENT '序号',
  `memo` varchar(32) DEFAULT NULL COMMENT '资源描述',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标识;0：正常  1：删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='天网配置数据范围信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_skynet_requirement_ext`
--

DROP TABLE IF EXISTS `t_skynet_requirement_ext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_skynet_requirement_ext` (
  `id` bigint NOT NULL COMMENT '主键',
  `requirement_version_id` bigint DEFAULT NULL COMMENT '配置版本id',
  `skynet_ext_id` varchar(64) DEFAULT NULL COMMENT 'ECU或simpling主键',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标识;0：正常  1：删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='需求配置的天网配置信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_skynet_requirement_task`
--

DROP TABLE IF EXISTS `t_skynet_requirement_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_skynet_requirement_task` (
  `id` varchar(64) NOT NULL COMMENT '主键',
  `requirement_version_id` varchar(64) NOT NULL COMMENT '配置id',
  `vehicle_no` varchar(64) DEFAULT NULL COMMENT 'vin码',
  `service_id` varchar(64) DEFAULT NULL COMMENT 'appId',
  `vehicle_brand` varchar(64) DEFAULT NULL COMMENT '车辆品牌',
  `vehicle_model` varchar(64) DEFAULT NULL COMMENT '车型',
  `domain_id` int DEFAULT NULL COMMENT 'domainId',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间（周期任务）',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间（周期任务）',
  `status` int DEFAULT NULL COMMENT '任务状态;0 未开始  1.下发开始，2.下发成功，3.下发失败',
  `remark` varchar(200) DEFAULT NULL,
  `sampling_ids` varchar(255) DEFAULT NULL COMMENT 'sampling列表',
  `oss_url` varchar(255) DEFAULT NULL COMMENT '上传地址',
  `is_running` tinyint DEFAULT NULL COMMENT '任务是否在运行 1 运行，0未运行',
  `exec_time` datetime DEFAULT NULL COMMENT '任务下发执行时间',
  `ecu_ids` varchar(255) DEFAULT NULL COMMENT 'ecuid 列表',
  `del_flag` int DEFAULT '0',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `vehicle_filter_id` (`vehicle_no`,`domain_id`,`service_id`),
  KEY `version_id` (`requirement_version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='skynet单车数据task表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_source`
--

DROP TABLE IF EXISTS `t_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_source` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `resolver_id` bigint NOT NULL COMMENT 't_resolver.pk 归属的resolver',
  `type` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '订阅类型 1-车辆,2-消息类型',
  `config` json NOT NULL COMMENT '来源扩展参数',
  `desc` varchar(512) DEFAULT NULL COMMENT '描述',
  `workspace_id` varchar(255) DEFAULT NULL COMMENT '空间id',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='消息流转-数据源';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_stat_data_by_mock`
--

DROP TABLE IF EXISTS `t_stat_data_by_mock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_stat_data_by_mock` (
  `id` bigint NOT NULL COMMENT '主键',
  `metric_name` varchar(255) DEFAULT NULL COMMENT '指标名称',
  `stat_type` varchar(32) DEFAULT NULL COMMENT '统计类型',
  `num_value` varchar(1024) DEFAULT NULL COMMENT '统计值',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  KEY `t_stat_data_by_mock_metric_name_stat_type_create_time_index` (`metric_name`,`stat_type`,`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='图表统计mock表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_stat_data_by_week`
--

DROP TABLE IF EXISTS `t_stat_data_by_week`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_stat_data_by_week` (
  `id` bigint NOT NULL COMMENT '主键',
  `metric_name` varchar(255) DEFAULT NULL COMMENT '指标名称',
  `stat_dt` date DEFAULT NULL COMMENT '日期',
  `num` bigint DEFAULT NULL COMMENT '数量',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `STAT_WEEK_DEL_INDEX` (`del_flag`),
  KEY `STAT_WEEK_DT_INDEX` (`stat_dt`),
  KEY `STAT_WEEK_METRIC_INDEX` (`metric_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='周粒度统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_stat_dim_by_date`
--

DROP TABLE IF EXISTS `t_stat_dim_by_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_stat_dim_by_date` (
  `id` bigint NOT NULL COMMENT '主键',
  `metric_name` varchar(255) DEFAULT NULL COMMENT '指标名称',
  `stat_dt` date DEFAULT NULL COMMENT '日期',
  `dim_flg` varchar(255) DEFAULT NULL COMMENT '维度标识',
  `num` bigint DEFAULT NULL COMMENT '数量',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `STAT_DATE_DEL_INDEX` (`del_flag`),
  KEY `STAT_DATE_DIM_INDEX` (`dim_flg`),
  KEY `STAT_DATE_DT_INDEX` (`stat_dt`),
  KEY `STAT_DATE_METRIC_INDEX` (`metric_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日粒度统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_stat_mock_detail`
--

DROP TABLE IF EXISTS `t_stat_mock_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_stat_mock_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `chart_type` varchar(128) DEFAULT NULL,
  `item_type` varchar(32) DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `value` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_sys_dict`
--

DROP TABLE IF EXISTS `t_sys_dict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_sys_dict` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `model_type` varchar(64) DEFAULT NULL COMMENT '功能模块代码',
  `dict_name` varchar(64) DEFAULT NULL COMMENT '字典名',
  `dict_value` varchar(255) DEFAULT NULL COMMENT '字典值',
  `sort` int DEFAULT NULL COMMENT '排序',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标识;0：正常  1：删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_sys_operate_log`
--

DROP TABLE IF EXISTS `t_sys_operate_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_sys_operate_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) DEFAULT NULL COMMENT '操作名称',
  `moduleName` varchar(50) DEFAULT NULL COMMENT '模块名称',
  `operate_type` varchar(10) DEFAULT '0' COMMENT '业务类型,OTHER:其他,INSERT:新增,DELETE:删除,UPDATE:更新,SELECT:查询',
  `method` varchar(100) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `request_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `request_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
  `operator` varchar(1000) DEFAULT NULL COMMENT '操作人员信息,json格式: {"id":"123", "name":"Liang.Xue1"}',
  `operator_ip` varchar(128) DEFAULT '' COMMENT '操作人IP地址',
  `response_body` text COMMENT '返回参数',
  `cost_millisecond` int DEFAULT '0' COMMENT '耗时,单位: 毫秒',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者(系统字段)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间(系统字段)',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者(系统字段)',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间(系统字段)',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识(系统字段), 0:正常, 1:删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='操作日志记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_target`
--

DROP TABLE IF EXISTS `t_target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_target` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `resolver_id` bigint NOT NULL COMMENT 't_resolver.pk 归属的resolver',
  `type` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '目的地类型，1-kafka topic, 2-http url',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `config` json NOT NULL COMMENT '目的地扩展参数',
  `desc` varchar(512) DEFAULT NULL COMMENT '描述',
  `workspace_id` varchar(255) DEFAULT NULL COMMENT '空间id',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int NOT NULL DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='消息流转-目的地';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_user_collection`
--

DROP TABLE IF EXISTS `t_user_collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_user_collection` (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` varchar(64) DEFAULT NULL COMMENT '成员id',
  `resource_id` bigint DEFAULT NULL COMMENT '收藏资源id',
  `collection_type` int DEFAULT NULL COMMENT '收藏类型',
  `default_set` int DEFAULT NULL COMMENT '默认设置',
  `status` int DEFAULT NULL COMMENT '状态',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标识;0：正常  1：删除',
  PRIMARY KEY (`id`),
  KEY `userid` (`user_id`,`default_set`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户收藏表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_user_dashboard`
--

DROP TABLE IF EXISTS `t_user_dashboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_user_dashboard` (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` varchar(64) DEFAULT NULL COMMENT '成员id',
  `dashboard_id` bigint DEFAULT NULL COMMENT '仪表板id',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标识;0：正常  1：删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_dashboard` (`user_id`,`dashboard_id`,`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户仪表板';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_vehicle_meta`
--

DROP TABLE IF EXISTS `t_vehicle_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_vehicle_meta` (
  `id` bigint NOT NULL COMMENT '唯一主键',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` int DEFAULT '0' COMMENT '删除标识;0：正常  1：删除',
  `request_id` varchar(64) DEFAULT NULL COMMENT 'requestId',
  `vin` varchar(64) DEFAULT NULL COMMENT 'vin码',
  `creation_epoch` datetime DEFAULT NULL COMMENT '车端消息上报时间',
  `sdb_Version` varchar(64) DEFAULT NULL COMMENT 'sdb版本',
  `v_data_version` varchar(64) DEFAULT NULL COMMENT 'vData版本 0122新增',
  `v_dc_version` varchar(64) DEFAULT NULL COMMENT 'dc版本 0122新增',
  `v_compute_version` varchar(64) DEFAULT NULL COMMENT 'vCompute版本 0122新增',
  `ota_master_version` varchar(64) DEFAULT NULL COMMENT 'OTA版本，非必填，0122新增',
  `algo_version` varchar(64) DEFAULT NULL COMMENT '算子库版本，必填，0222新增',
  `enable_data_collect` int DEFAULT NULL COMMENT '全局数据采集功能开关状态，上报当前工作状态非持久化值 0：关 1：开',
  PRIMARY KEY (`id`),
  KEY `t_vehicle_meta_create_time_index` (`create_time`),
  KEY `t_vehicle_meta_vin_index` (`vin`),
  KEY `t_vehicle_meta_vin_del_flag_creation_epoch_index` (`vin`,`del_flag`,`creation_epoch`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='车辆运行态元数据';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_vehicledb_vehicle`
--

DROP TABLE IF EXISTS `t_vehicledb_vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_vehicledb_vehicle` (
  `id` bigint NOT NULL COMMENT '车辆表 主键自增',
  `vin` varchar(17) DEFAULT NULL COMMENT '车辆Vin',
  `model_id` bigint DEFAULT NULL COMMENT '车型表t_model 主键',
  `brand_id` bigint DEFAULT NULL COMMENT '品牌表t_brand主键',
  `iccid` varchar(100) DEFAULT NULL COMMENT 'iccid - 5 码信息',
  `imsi` varchar(100) DEFAULT NULL COMMENT 'imsi - 5 码信息',
  `imei` varchar(100) DEFAULT NULL COMMENT 'imei - 5码信息',
  `sim_phone` varchar(100) DEFAULT NULL COMMENT 'msisdn 手机号- 5 码信息',
  `tbox_sn` varchar(100) DEFAULT NULL COMMENT 'TU_ID - 5 码信息',
  `dhu_sn` varchar(100) DEFAULT NULL COMMENT 'IHU_ID - 6 码信息',
  `factory_code` varchar(100) DEFAULT NULL COMMENT '工厂编码',
  `product_time` datetime DEFAULT NULL COMMENT '生产日期',
  `downline_date` datetime DEFAULT NULL COMMENT '下线日期',
  `out_factory_time` datetime DEFAULT NULL COMMENT '出厂日期',
  `publish_date` datetime DEFAULT NULL COMMENT '上市日期',
  `attributes` int DEFAULT NULL COMMENT '车辆属性(0:测试 1:市场)',
  `sales_status` int DEFAULT NULL COMMENT '销售状态(0:售前  1:售后)',
  `created_user_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_user_id` bigint DEFAULT NULL COMMENT '更新人ID',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `model_name` varchar(500) DEFAULT NULL COMMENT '车型名称',
  `model_code` varchar(500) DEFAULT NULL COMMENT '车型编码',
  `model_type` varchar(500) DEFAULT NULL COMMENT '车辆类型',
  `brand_code` varchar(45) DEFAULT NULL COMMENT '品牌编码',
  `brand_name` varchar(45) DEFAULT NULL COMMENT '品牌名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_vehicle_vin` (`vin`),
  KEY `idx_vehicle_id` (`id`),
  KEY `idx_vin_model_code` (`vin`,`model_code`,`brand_name`),
  KEY `team_index` (`model_name`,`attributes`,`sales_status`,`vin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='车辆信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_vsa_vehicle_bus`
--

DROP TABLE IF EXISTS `t_vsa_vehicle_bus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_vsa_vehicle_bus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL COMMENT '总线名称',
  `ecu_id` int DEFAULT NULL COMMENT '关联ecuid',
  `categories` varchar(64) DEFAULT NULL COMMENT '总线类型',
  `description` text COMMENT '总线描述',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ck_name_ecu` (`name`,`ecu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='整车总线表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_vsa_vehicle_cx1e_800v`
--

DROP TABLE IF EXISTS `t_vsa_vehicle_cx1e_800v`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_vsa_vehicle_cx1e_800v` (
  `tx_ecu` text,
  `tx_com_ecu` text,
  `tx_type` text,
  `rx_ecu` text,
  `rx_com_ecu` text,
  `rx_type` text,
  `frame` text,
  `frame_id` text,
  `frame_len` bigint DEFAULT NULL,
  `frame_rate` text,
  `bus` text,
  `signal_group` text,
  `sig` text,
  `len` bigint DEFAULT NULL,
  `start` text,
  `group_ub` text,
  `signal_ub` text,
  `base_type` text,
  `min` text,
  `max` text,
  `factor` text,
  `offset` text,
  `unit` text,
  `text_table` text,
  `description` text,
  `life_cycle` text,
  `id` bigint DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_vsa_vehicle_ecu`
--

DROP TABLE IF EXISTS `t_vsa_vehicle_ecu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_vsa_vehicle_ecu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL COMMENT 'ecu 名称',
  `level` int DEFAULT '1' COMMENT 'ecu 级别',
  `hatchback_id` int DEFAULT '1' COMMENT '车型id',
  `description` text COMMENT 'ecu 描述',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ck_name_hatchback` (`name`,`hatchback_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='整车ECU表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_vsa_vehicle_hatchback`
--

DROP TABLE IF EXISTS `t_vsa_vehicle_hatchback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_vsa_vehicle_hatchback` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL COMMENT '车型名称',
  `description` text COMMENT '车型 描述',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='车型类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_vsa_vehicle_superset`
--

DROP TABLE IF EXISTS `t_vsa_vehicle_superset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_vsa_vehicle_superset` (
  `tx_ecu` text,
  `tx_com_ecu` text,
  `tx_type` text,
  `rx_ecu` text,
  `rx_com_ecu` text,
  `rx_type` text,
  `frame` text,
  `frame_id` text,
  `frame_len` bigint DEFAULT NULL,
  `frame_rate` text,
  `bus` text,
  `signal_group` text,
  `sig` text,
  `len` bigint DEFAULT NULL,
  `start` text,
  `group_ub` text,
  `signal_ub` text,
  `base_type` text,
  `min` text,
  `max` text,
  `factor` text,
  `offset` text,
  `unit` text,
  `text_table` text,
  `description` text,
  `life_cycle` text,
  `id` bigint DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_vsw_analysis_file_download`
--

DROP TABLE IF EXISTS `t_vsw_analysis_file_download`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_vsw_analysis_file_download` (
  `id` bigint NOT NULL COMMENT '主键',
  `paths` text NOT NULL COMMENT '下载文件路径集合',
  `type` varchar(32) NOT NULL COMMENT '文件类型',
  `upload_path` varchar(255) DEFAULT NULL COMMENT '上传文件路径',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `status` int NOT NULL COMMENT '状态 0:初始值 1:成功 2：失败',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='vsw解析下载表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_work_space`
--

DROP TABLE IF EXISTS `t_work_space`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_work_space` (
  `id` bigint NOT NULL COMMENT '主键',
  `workspace_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '工作空间名称',
  `space_type` int DEFAULT NULL COMMENT '空间类型',
  `remark` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '工作空间说明',
  `owner_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '所有者id',
  `owner_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `owner_account` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '所有者账号',
  `member_count` int DEFAULT NULL COMMENT '成员数',
  `md5_character` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `function_permission` int DEFAULT NULL COMMENT '功能权限',
  `preference` int DEFAULT NULL COMMENT '偏好设置',
  `sync_set` int DEFAULT NULL COMMENT '同步设置',
  `sys_type` int DEFAULT '0' COMMENT '系统默认标识  0 不是  1 是',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人名',
  `create_account` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标识;0：正常  1：删除',
  `status` tinyint DEFAULT NULL COMMENT '0 正常  -1 未审批',
  `revision` int DEFAULT NULL COMMENT '乐观锁号',
  PRIMARY KEY (`id`),
  KEY `owner_type_del` (`owner_id`,`space_type`,`del_flag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='工作空间';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_work_space_apply`
--

DROP TABLE IF EXISTS `t_work_space_apply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_work_space_apply` (
  `id` bigint NOT NULL COMMENT '主键',
  `workspace_id` bigint DEFAULT NULL COMMENT '工作空间id',
  `apply_type` tinyint DEFAULT NULL COMMENT '申请类型;0 成员加入 1 空间功能申请 2 数据采集配置创建申请',
  `user_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '申请人id',
  `user_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户名',
  `user_account` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户账号',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '申请备注',
  `revision` int DEFAULT NULL,
  `status` tinyint DEFAULT NULL COMMENT '申请状态',
  `permission` tinyint DEFAULT NULL COMMENT '权限',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标识;0：正常  1：删除',
  `process_request_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '流程请求id',
  PRIMARY KEY (`id`),
  KEY `t_work_space_apply_process_request_id_index` (`process_request_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='工作空间申请表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_work_space_apply_approval`
--

DROP TABLE IF EXISTS `t_work_space_apply_approval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_work_space_apply_approval` (
  `id` bigint NOT NULL COMMENT '主键',
  `apply_id` bigint DEFAULT NULL COMMENT '申请id',
  `process_node_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '流程节点名称',
  `approval_user_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审批人id',
  `approval_user_account` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `approval_user_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审批人名',
  `approval_desc` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审批意见',
  `approval_time` datetime DEFAULT NULL COMMENT '审批时间',
  `status` tinyint DEFAULT NULL COMMENT '审批状态',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标识;0：正常  1：删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='工作空间申请审批表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_work_space_apply_content`
--

DROP TABLE IF EXISTS `t_work_space_apply_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_work_space_apply_content` (
  `id` bigint NOT NULL COMMENT '主键',
  `apply_id` bigint DEFAULT NULL COMMENT '申请id',
  `content_type` tinyint DEFAULT NULL COMMENT '内容类型',
  `content_json` json DEFAULT NULL COMMENT '内容json',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标识;0：正常  1：删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='工作空间申请内容表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_work_space_function`
--

DROP TABLE IF EXISTS `t_work_space_function`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_work_space_function` (
  `id` bigint NOT NULL COMMENT '主键',
  `function_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '编号',
  `function_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `type` int NOT NULL COMMENT '0：功能 1：资源',
  `resource_id` int NOT NULL COMMENT '资源id',
  `permission` set('1','2','3','4') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '1.菜单资源;2.操作资源(按钮资源);3.数据行资源;4.接口资源',
  `permission_type` int DEFAULT NULL COMMENT '对应moduleServiceType',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='工作空间功能/资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_work_space_function_permission`
--

DROP TABLE IF EXISTS `t_work_space_function_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_work_space_function_permission` (
  `id` bigint NOT NULL COMMENT '主键',
  `function_id` bigint NOT NULL COMMENT '功能/资源id',
  `permission_id` bigint NOT NULL COMMENT '权限id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='工作空间功能权限关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_work_space_function_relation`
--

DROP TABLE IF EXISTS `t_work_space_function_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_work_space_function_relation` (
  `id` bigint NOT NULL COMMENT '主键',
  `workspace_id` bigint DEFAULT NULL COMMENT '工作空间id',
  `function_id` bigint DEFAULT NULL COMMENT '功能/资源id',
  `relation_type` tinyint(1) DEFAULT NULL COMMENT '关联类型',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标识;0：正常  1：删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='工作空间与功能关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_work_space_member`
--

DROP TABLE IF EXISTS `t_work_space_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_work_space_member` (
  `id` bigint NOT NULL COMMENT '主键',
  `workspace_id` bigint DEFAULT NULL COMMENT '工作空间id',
  `role_type` tinyint DEFAULT NULL COMMENT '1 普通用户 0 空间管理员',
  `user_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '成员id',
  `user_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户名',
  `user_account` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户账号',
  `status` int DEFAULT NULL,
  `seq` int DEFAULT NULL COMMENT '用户工作空间排序标志',
  `permission` int DEFAULT NULL COMMENT '权限',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT NULL COMMENT '删除标识;0：正常  1：删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `workspace_user_id` (`workspace_id`,`user_id`) USING BTREE,
  KEY `userid_seq` (`user_id`,`seq`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='工作空间成员';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_work_space_vehicle_resource`
--

DROP TABLE IF EXISTS `t_work_space_vehicle_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_work_space_vehicle_resource` (
  `id` bigint NOT NULL COMMENT '主键',
  `workspace_id` varchar(255) NOT NULL COMMENT '空间id',
  `vehicle` varchar(255) NOT NULL COMMENT 'vin码或者版型',
  `chose_type` int NOT NULL COMMENT '0：按分类  1：按VIN码',
  `status` int NOT NULL COMMENT '0：审批通过  1：初始状态',
  `total` int DEFAULT NULL COMMENT '车辆数量',
  `operate` varchar(255) DEFAULT NULL COMMENT 'insert/edit',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `range_type` int DEFAULT NULL COMMENT '0：当前车辆 1：动态新增',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工作空间车辆资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_zxc_vehicle_request_record`
--

DROP TABLE IF EXISTS `t_zxc_vehicle_request_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_zxc_vehicle_request_record` (
  `id` varchar(100) NOT NULL COMMENT '主键',
  `request_param` json DEFAULT NULL COMMENT 'ZXC下发时的请求参数',
  `request_id` varchar(128) DEFAULT NULL COMMENT '请求ID',
  `vehicle_no` varchar(64) DEFAULT NULL COMMENT 'vin码',
  `status` int DEFAULT NULL COMMENT '状态',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` int DEFAULT '0' COMMENT '删除标志',
  `response_result` json DEFAULT NULL,
  `request_result` json DEFAULT NULL COMMENT 'ZXC请求响应',
  PRIMARY KEY (`id`),
  UNIQUE KEY `t_zxc_vehicle_request_record_un` (`request_id`),
  KEY `t_zxc_vehicle_request_record_create_time_IDX` (`create_time`),
  KEY `t_zxc_vehicle_request_record_update_time_IDX` (`update_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='ZXC车云调用请求记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'zpes'
--
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-24 15:03:01
