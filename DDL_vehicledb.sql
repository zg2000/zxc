-- Create a new database
CREATE DATABASE IF NOT EXISTS vehicledb;

-- Use the newly created database
USE vehicledb;

/******************************************/
/*   DatabaseName = vehicledb   */
/*   TableName = t_brand   */
/******************************************/
CREATE TABLE `t_brand` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Primary key auto increment',
  `brand_code` varchar(45) DEFAULT NULL COMMENT 'Brand code',
  `brand_name` varchar(45) DEFAULT NULL COMMENT 'Brand name',
  `del_flag` int DEFAULT '0' COMMENT 'Deletion flag; 0: not deleted 1: deleted Default 0',
  `created_user_id` bigint DEFAULT NULL COMMENT 'Creator ID',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
  `updated_user_id` bigint DEFAULT NULL COMMENT 'Updater ID',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Modification time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Brand table'
;

/******************************************/
/*   DatabaseName = vehicledb   */
/*   TableName = t_function   */
/******************************************/
CREATE TABLE `t_function` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Function table primary key',
  `vin` varchar(17) DEFAULT NULL COMMENT 'Vehicle Vin',
  `function_code` varchar(500) DEFAULT NULL COMMENT 'Vehicle function code\n',
  `function_name` varchar(500) DEFAULT NULL COMMENT 'Vehicle function name\n',
  `software_version` varchar(500) DEFAULT NULL COMMENT 'Software version\n',
  `created_user_id` bigint DEFAULT NULL COMMENT 'Creator ID',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
  `updated_user_id` bigint DEFAULT NULL COMMENT 'Updater ID',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Modification time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Function table'
;

/******************************************/
/*   DatabaseName = vehicledb   */
/*   TableName = t_model   */
/******************************************/
CREATE TABLE `t_model` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Model table primary key',
  `model_code` varchar(100) DEFAULT NULL COMMENT 'Model code',
  `model_name` varchar(100) DEFAULT NULL COMMENT 'Model name',
  `brand_id` bigint DEFAULT NULL COMMENT 'Brand table t_brand primary key',
  `del_flag` int DEFAULT '0' COMMENT 'Deletion flag; 0: not deleted 1: deleted Default 0',
  `created_user_id` bigint DEFAULT NULL COMMENT 'Creator ID',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
  `updated_user_id` bigint DEFAULT NULL COMMENT 'Updater ID',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Modification time',
  `model_type` varchar(100) DEFAULT NULL COMMENT 'Vehicle type',
  PRIMARY KEY (`id`),
  UNIQUE KEY `un_model_type` (`model_type`,`model_code`,`model_name`),
  KEY `idx_model_code` (`model_code`),
  KEY `idx_model_name` (`model_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Model table'
;

/******************************************/
/*   DatabaseName = vehicledb   */
/*   TableName = t_vehicle   */
/******************************************/
CREATE TABLE `t_vehicle` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Vehicle table Primary key auto increment',
  `vin` varchar(17) DEFAULT NULL COMMENT 'Vehicle Vin',
  `model_id` bigint DEFAULT NULL COMMENT 'Model table t_model Primary key',
  `brand_id` bigint DEFAULT NULL COMMENT 'Brand table t_brand primary key',
  `iccid` varchar(100) DEFAULT NULL COMMENT 'iccid - 5 code information',
  `imsi` varchar(100) DEFAULT NULL COMMENT 'imsi - 5 code information',
  `imei` varchar(100) DEFAULT NULL COMMENT 'imei - 5 code information',
  `sim_phone` varchar(100) DEFAULT NULL COMMENT 'msisdn phone number- 5 code information',
  `tbox_sn` varchar(100) DEFAULT NULL COMMENT 'TU_ID - 5 code information',
  `dhu_sn` varchar(100) DEFAULT NULL COMMENT 'IHU_ID - 6 code information',
  `factory_code` varchar(100) DEFAULT NULL COMMENT 'Factory code',
  `product_time` datetime DEFAULT NULL COMMENT 'Production date',
  `downline_date` datetime DEFAULT NULL COMMENT 'Offline date',
  `out_factory_time` datetime DEFAULT NULL COMMENT 'Out factory date',
  `publish_date` datetime DEFAULT NULL COMMENT 'Launch date',
  `attributes` int DEFAULT NULL COMMENT 'Vehicle attributes(0: test 1: market)',
  `sales_status` int DEFAULT NULL COMMENT 'Sales status(0: pre-sale 1: after-sale)',
  `created_user_id` bigint DEFAULT NULL COMMENT 'Creator ID',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
  `updated_user_id` bigint DEFAULT NULL COMMENT 'Updater ID',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Modification time',
  `model_name` varchar(500) DEFAULT NULL COMMENT 'Model name',
  `model_code` varchar(500) DEFAULT NULL COMMENT 'Model code',
  `model_type` varchar(500) DEFAULT NULL COMMENT 'Vehicle type',
  `brand_code` varchar(45) DEFAULT NULL COMMENT 'Brand code',
  `brand_name` varchar(45) DEFAULT NULL COMMENT 'Brand name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_vehicle_vin` (`vin`) USING BTREE,
  KEY `idx_vehicle_id` (`id`) USING BTREE,
  KEY `idx_vin_model_code` (`model_name`,`vin`,`attributes`,`sales_status`) USING BTREE,
  KEY `team_index` (`model_name`,`attributes`) USING BTREE,
  KEY `team_name_attributes` (`attributes`,`model_name`),
  KEY `team_attributes_vin` (`attributes`,`model_name`,`vin`),
  KEY `team_code_name` (`model_code`,`brand_name`)
) ENGINE=InnoDB AUTO_INCREMENT=868818 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Vehicle information table'
;
