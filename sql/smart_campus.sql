/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80041 (8.0.41)
 Source Host           : localhost:3306
 Source Schema         : smart_campus

 Target Server Type    : MySQL
 Target Server Version : 80041 (8.0.41)
 File Encoding         : 65001

 Date: 10/10/2025 18:02:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for campus_comment
-- ----------------------------
DROP TABLE IF EXISTS `campus_comment`;
CREATE TABLE `campus_comment`  (
                                   `comment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '评论ID (主键)',
                                   `topic_id` bigint NOT NULL COMMENT '话题ID (外键)',
                                   `user_id` bigint NOT NULL COMMENT '评论用户ID (外键)',
                                   `content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '评论内容',
                                   `parent_comment_id` bigint NULL DEFAULT NULL COMMENT '父评论ID (用于二级评论)',
                                   `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                   PRIMARY KEY (`comment_id`) USING BTREE,
                                   INDEX `topic_id`(`topic_id` ASC) USING BTREE,
                                   INDEX `user_id`(`user_id` ASC) USING BTREE,
                                   CONSTRAINT `campus_comment_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `campus_topic` (`topic_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                   CONSTRAINT `campus_comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '12. 帖子评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of campus_comment
-- ----------------------------

-- ----------------------------
-- Table structure for campus_errand_order
-- ----------------------------
DROP TABLE IF EXISTS `campus_errand_order`;
CREATE TABLE `campus_errand_order`  (
                                        `order_id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单ID (主键)',
                                        `publisher_id` bigint NOT NULL COMMENT '发布人ID (外键, 关联sys_user)',
                                        `taker_id` bigint NULL DEFAULT NULL COMMENT '接单人ID (外键, 关联sys_user)',
                                        `order_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单类型 (如: 快递代取, 外卖代拿, 校园跑腿)',
                                        `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单标题',
                                        `detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '订单详情',
                                        `reward` decimal(10, 2) NOT NULL COMMENT '悬赏金额',
                                        `delivery_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '送达地址',
                                        `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '订单状态 (0=待接单, 1=进行中, 2=已完成, 3=已取消)',
                                        `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                        `take_time` datetime NULL DEFAULT NULL COMMENT '接单时间',
                                        `finish_time` datetime NULL DEFAULT NULL COMMENT '完成时间',
                                        `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
                                        `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
                                        PRIMARY KEY (`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '跑腿代办订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of campus_errand_order
-- ----------------------------
INSERT INTO `campus_errand_order` VALUES (1, 1, 2, '快递代取', 'test', '777', 5.00, 'test', '1', '2025-10-09 10:55:13', '2025-10-09 13:35:49', NULL, '', '');
INSERT INTO `campus_errand_order` VALUES (2, 2, NULL, '快递代取', 'test', '11', 5.00, '11', '0', '2025-10-09 13:36:04', NULL, NULL, 'ry', '');
INSERT INTO `campus_errand_order` VALUES (3, 1, NULL, '外卖代拿', 's', 's', 5.00, 's', '0', '2025-10-10 17:51:11', NULL, NULL, 'admin', '');

-- ----------------------------
-- Table structure for campus_topic
-- ----------------------------
DROP TABLE IF EXISTS `campus_topic`;
CREATE TABLE `campus_topic`  (
                                 `topic_id` bigint NOT NULL AUTO_INCREMENT COMMENT '话题ID',
                                 `user_id` bigint NOT NULL COMMENT '用户ID',
                                 `content` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '话题内容',
                                 `image_urls` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '图片链接(多张用逗号分隔)',
                                 `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '状态(0=正常, 1=停用)',
                                 `del_flag` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '删除标志(0=代表存在, 2=代表删除)',
                                 `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
                                 `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                 `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
                                 `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                 `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
                                 `topic_type` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'recommend',
                                 `comment_enabled` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '是否允许评论 (0=允许, 1=禁止)',
                                 PRIMARY KEY (`topic_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 117 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '校园话题表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of campus_topic
-- ----------------------------
INSERT INTO `campus_topic` VALUES (100, 1, '<p>test001哈哈哈666</p>', NULL, '0', '0', '', '2025-09-21 21:22:17', 'admin', '2025-09-29 20:10:18', NULL, 'recommend', '0');
INSERT INTO `campus_topic` VALUES (102, 1, '<p><img src=\"/dev-api/profile/upload/2025/09/21/微信图片_20230823145137_20250921215308A002.jpg\"></p>', NULL, '0', '0', '', '2025-09-21 21:53:12', '', NULL, NULL, 'recommend', '0');
INSERT INTO `campus_topic` VALUES (104, 1, '<p>1</p>', NULL, '0', '0', '', '2025-09-21 23:27:30', '', NULL, NULL, 'recommend', '0');
INSERT INTO `campus_topic` VALUES (105, 1, '1', NULL, '0', '0', '', '2025-09-21 23:52:34', '', NULL, NULL, 'recommend', '0');
INSERT INTO `campus_topic` VALUES (106, 2, '666', NULL, '0', '0', '', '2025-09-22 14:37:38', '', NULL, NULL, 'recommend', '0');
INSERT INTO `campus_topic` VALUES (107, 2, 'hh', '/profile/upload/2025/09/22/微信图片_20230823145137_20250922144305A001.jpg', '0', '0', '', '2025-09-22 14:43:10', '', NULL, NULL, 'recommend', '0');
INSERT INTO `campus_topic` VALUES (108, 2, '1', '/profile/upload/2025/09/22/微信图片_20230823145137_20250922145220A002.jpg', '0', '0', '', '2025-09-22 14:52:24', '', NULL, NULL, 'recommend', '0');
INSERT INTO `campus_topic` VALUES (109, 1, '？', '/profile/upload/2025/09/22/Screenshot 2025-08-29 190218_20250922155349A002.png', '0', '0', '', '2025-09-22 15:53:51', '', NULL, NULL, 'recommend', '0');
INSERT INTO `campus_topic` VALUES (110, 1, '有没有二手货', '/profile/upload/2025/09/29/Grounded_2025.09.22-19.53.20_20250929123454A001.png', '0', '0', 'admin', '2025-09-29 12:34:55', '', NULL, NULL, 'secondhand', '0');
INSERT INTO `campus_topic` VALUES (111, 1, '什么东西？', '/profile/upload/2025/09/29/Screenshot 2025-09-25 131510_20250929123742A002.png', '0', '0', 'admin', '2025-09-29 12:37:54', '', NULL, NULL, 'qa', '0');
INSERT INTO `campus_topic` VALUES (112, 1, '666', NULL, '0', '0', 'admin', '2025-09-29 14:42:40', '', NULL, NULL, 'recommend', '0');
INSERT INTO `campus_topic` VALUES (113, 1, 's', NULL, '0', '0', 'admin', '2025-09-29 14:53:26', '', NULL, NULL, 'recommend', '0');
INSERT INTO `campus_topic` VALUES (114, 1, '谭墨我爱你', NULL, '0', '0', 'admin', '2025-09-29 14:57:53', '', NULL, NULL, 'dating', '0');
INSERT INTO `campus_topic` VALUES (115, 1, 'bot', '/profile/upload/2025/09/29/Screenshot 2025-09-07 151720_20250929210155A001.png,/profile/upload/2025/09/29/Screenshot 2025-08-29 190218_20250929210217A002.png', '0', '0', 'admin', '2025-09-29 21:02:21', '', NULL, NULL, 'qa', '0');
INSERT INTO `campus_topic` VALUES (116, 1, '禁止评论', NULL, '0', '0', 'admin', '2025-10-08 16:12:04', '', NULL, NULL, 'recommend', '1');

-- ----------------------------
-- Table structure for campus_topic_comment
-- ----------------------------
DROP TABLE IF EXISTS `campus_topic_comment`;
CREATE TABLE `campus_topic_comment`  (
                                         `comment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '评论ID',
                                         `topic_id` bigint NOT NULL COMMENT '话题ID',
                                         `user_id` bigint NOT NULL COMMENT '评论用户ID',
                                         `parent_id` bigint NULL DEFAULT 0 COMMENT '父评论ID(回复某条评论)',
                                         `content` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '评论内容',
                                         `create_time` datetime NULL DEFAULT NULL COMMENT '评论时间',
                                         PRIMARY KEY (`comment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '话题评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of campus_topic_comment
-- ----------------------------
INSERT INTO `campus_topic_comment` VALUES (1, 100, 2, 0, '这是来自用户ry的第一条评论！', '2025-09-28 23:45:01');
INSERT INTO `campus_topic_comment` VALUES (2, 100, 1, 1, '这是admin回复ry的内容。', '2025-09-28 23:45:01');
INSERT INTO `campus_topic_comment` VALUES (3, 101, 1, 0, '。。\n\n', '2025-09-29 12:35:12');
INSERT INTO `campus_topic_comment` VALUES (4, 111, 1, 0, 'good\n', '2025-09-29 12:38:03');
INSERT INTO `campus_topic_comment` VALUES (5, 100, 1, 1, '666', '2025-09-29 19:19:34');
INSERT INTO `campus_topic_comment` VALUES (6, 114, 1, 0, 's\n', '2025-09-29 20:28:45');
INSERT INTO `campus_topic_comment` VALUES (7, 106, 1, 0, '6', '2025-09-29 20:29:25');

-- ----------------------------
-- Table structure for campus_topic_favorite
-- ----------------------------
DROP TABLE IF EXISTS `campus_topic_favorite`;
CREATE TABLE `campus_topic_favorite`  (
                                          `favorite_id` bigint NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
                                          `topic_id` bigint NOT NULL COMMENT '话题ID',
                                          `user_id` bigint NOT NULL COMMENT '用户ID',
                                          `create_time` datetime NULL DEFAULT NULL COMMENT '收藏时间',
                                          PRIMARY KEY (`favorite_id`) USING BTREE,
                                          UNIQUE INDEX `uk_user_topic`(`user_id` ASC, `topic_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '话题收藏表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of campus_topic_favorite
-- ----------------------------
INSERT INTO `campus_topic_favorite` VALUES (1, 115, 1, '2025-09-29 23:09:37');
INSERT INTO `campus_topic_favorite` VALUES (2, 107, 1, '2025-09-29 23:36:07');

-- ----------------------------
-- Table structure for campus_topic_like
-- ----------------------------
DROP TABLE IF EXISTS `campus_topic_like`;
CREATE TABLE `campus_topic_like`  (
                                      `like_id` bigint NOT NULL AUTO_INCREMENT COMMENT '点赞ID',
                                      `topic_id` bigint NOT NULL COMMENT '话题ID',
                                      `user_id` bigint NOT NULL COMMENT '点赞用户ID',
                                      `create_time` datetime NULL DEFAULT NULL COMMENT '点赞时间',
                                      PRIMARY KEY (`like_id`) USING BTREE,
                                      UNIQUE INDEX `uk_topic_user`(`topic_id` ASC, `user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '话题点赞记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of campus_topic_like
-- ----------------------------
INSERT INTO `campus_topic_like` VALUES (1, 100, 1, '2025-09-22 16:03:39');
INSERT INTO `campus_topic_like` VALUES (2, 101, 1, '2025-09-22 16:03:42');
INSERT INTO `campus_topic_like` VALUES (3, 102, 1, '2025-09-22 16:03:44');
INSERT INTO `campus_topic_like` VALUES (4, 103, 1, '2025-09-22 16:03:45');
INSERT INTO `campus_topic_like` VALUES (5, 104, 1, '2025-09-22 16:03:46');
INSERT INTO `campus_topic_like` VALUES (6, 109, 1, '2025-09-22 18:26:47');
INSERT INTO `campus_topic_like` VALUES (7, 108, 1, '2025-09-22 18:26:48');
INSERT INTO `campus_topic_like` VALUES (8, 111, 1, '2025-09-29 12:37:58');
INSERT INTO `campus_topic_like` VALUES (9, 114, 1, '2025-09-29 14:59:47');
INSERT INTO `campus_topic_like` VALUES (10, 105, 1, '2025-09-29 20:10:02');
INSERT INTO `campus_topic_like` VALUES (11, 110, 1, '2025-09-29 23:52:37');
INSERT INTO `campus_topic_like` VALUES (12, 116, 1, '2025-10-08 16:12:06');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
                              `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
                              `table_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '表名称',
                              `table_comment` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '表描述',
                              `sub_table_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
                              `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
                              `class_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '实体类名称',
                              `tpl_category` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
                              `tpl_web_type` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
                              `package_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
                              `module_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
                              `business_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
                              `function_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
                              `function_author` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
                              `gen_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
                              `gen_path` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
                              `options` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
                              `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
                              `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                              `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
                              `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                              `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
                              PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'campus_topic', '校园话题表', NULL, NULL, 'CampusTopic', 'crud', 'element-ui', 'com.ruoyi.campus', 'campus', 'topic', '校园话题', 'stan', '0', '/', '{\"parentMenuId\":0}', 'admin', '2025-09-21 20:28:05', '', '2025-09-21 20:40:36', NULL);
INSERT INTO `gen_table` VALUES (2, 'campus_errand_order', '跑腿代办订单表', NULL, NULL, 'CampusErrandOrder', 'crud', 'element-ui', 'com.ruoyi.campus', 'campus', 'errand', '跑腿代办', 'stan', '0', '/', '{\"parentMenuId\":0}', 'admin', '2025-10-08 17:10:34', '', '2025-10-08 18:17:53', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
                                     `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
                                     `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
                                     `column_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '列名称',
                                     `column_comment` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '列描述',
                                     `column_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '列类型',
                                     `java_type` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
                                     `java_field` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
                                     `is_pk` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
                                     `is_increment` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
                                     `is_required` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
                                     `is_insert` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
                                     `is_edit` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
                                     `is_list` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
                                     `is_query` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
                                     `query_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
                                     `html_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
                                     `dict_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典类型',
                                     `sort` int NULL DEFAULT NULL COMMENT '排序',
                                     `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
                                     `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                     `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
                                     `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                     PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, 1, 'topic_id', '话题ID', 'bigint', 'Long', 'topicId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-09-21 20:28:05', '', '2025-09-21 20:40:36');
INSERT INTO `gen_table_column` VALUES (2, 1, 'user_id', '用户ID', 'bigint', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-09-21 20:28:05', '', '2025-09-21 20:40:36');
INSERT INTO `gen_table_column` VALUES (3, 1, 'content', '话题内容', 'varchar(500)', 'String', 'content', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'editor', '', 3, 'admin', '2025-09-21 20:28:05', '', '2025-09-21 20:40:36');
INSERT INTO `gen_table_column` VALUES (4, 1, 'image_urls', '图片链接(多张用逗号分隔)', 'varchar(1000)', 'String', 'imageUrls', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 'admin', '2025-09-21 20:28:05', '', '2025-09-21 20:40:36');
INSERT INTO `gen_table_column` VALUES (5, 1, 'status', '状态(0=正常, 1=停用)', 'char(1)', 'String', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 5, 'admin', '2025-09-21 20:28:05', '', '2025-09-21 20:40:36');
INSERT INTO `gen_table_column` VALUES (6, 1, 'del_flag', '删除标志(0=代表存在, 2=代表删除)', 'char(1)', 'String', 'delFlag', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 6, 'admin', '2025-09-21 20:28:05', '', '2025-09-21 20:40:36');
INSERT INTO `gen_table_column` VALUES (7, 1, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 7, 'admin', '2025-09-21 20:28:05', '', '2025-09-21 20:40:36');
INSERT INTO `gen_table_column` VALUES (8, 1, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2025-09-21 20:28:05', '', '2025-09-21 20:40:36');
INSERT INTO `gen_table_column` VALUES (9, 1, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2025-09-21 20:28:05', '', '2025-09-21 20:40:36');
INSERT INTO `gen_table_column` VALUES (10, 1, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2025-09-21 20:28:05', '', '2025-09-21 20:40:36');
INSERT INTO `gen_table_column` VALUES (11, 1, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'textarea', '', 11, 'admin', '2025-09-21 20:28:05', '', '2025-09-21 20:40:36');
INSERT INTO `gen_table_column` VALUES (12, 2, 'order_id', '订单ID (主键)', 'bigint', 'Long', 'orderId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-10-08 17:10:34', '', '2025-10-08 18:17:53');
INSERT INTO `gen_table_column` VALUES (13, 2, 'publisher_id', '发布人ID (外键, 关联sys_user)', 'bigint', 'Long', 'publisherId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-10-08 17:10:34', '', '2025-10-08 18:17:53');
INSERT INTO `gen_table_column` VALUES (14, 2, 'taker_id', '接单人ID (外键, 关联sys_user)', 'bigint', 'Long', 'takerId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-10-08 17:10:34', '', '2025-10-08 18:17:53');
INSERT INTO `gen_table_column` VALUES (15, 2, 'order_type', '订单类型 (如: 快递代取, 外卖代拿, 校园跑腿)', 'varchar(50)', 'String', 'orderType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 4, 'admin', '2025-10-08 17:10:34', '', '2025-10-08 18:17:53');
INSERT INTO `gen_table_column` VALUES (16, 2, 'title', '订单标题', 'varchar(255)', 'String', 'title', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-10-08 17:10:34', '', '2025-10-08 18:17:53');
INSERT INTO `gen_table_column` VALUES (17, 2, 'detail', '订单详情', 'text', 'String', 'detail', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 6, 'admin', '2025-10-08 17:10:34', '', '2025-10-08 18:17:53');
INSERT INTO `gen_table_column` VALUES (18, 2, 'reward', '悬赏金额', 'decimal(10,2)', 'BigDecimal', 'reward', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2025-10-08 17:10:34', '', '2025-10-08 18:17:53');
INSERT INTO `gen_table_column` VALUES (19, 2, 'delivery_address', '送达地址', 'varchar(255)', 'String', 'deliveryAddress', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2025-10-08 17:10:34', '', '2025-10-08 18:17:53');
INSERT INTO `gen_table_column` VALUES (20, 2, 'status', '订单状态 (0=待接单, 1=进行中, 2=已完成, 3=已取消)', 'char(1)', 'String', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 9, 'admin', '2025-10-08 17:10:34', '', '2025-10-08 18:17:53');
INSERT INTO `gen_table_column` VALUES (21, 2, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2025-10-08 17:10:34', '', '2025-10-08 18:17:53');
INSERT INTO `gen_table_column` VALUES (22, 2, 'take_time', '接单时间', 'datetime', 'Date', 'takeTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 11, 'admin', '2025-10-08 17:10:34', '', '2025-10-08 18:17:53');
INSERT INTO `gen_table_column` VALUES (23, 2, 'finish_time', '完成时间', 'datetime', 'Date', 'finishTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 12, 'admin', '2025-10-08 17:10:34', '', '2025-10-08 18:17:53');

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
                                       `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
                                       `trigger_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
                                       `trigger_group` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
                                       `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
                                       PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
                                       CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
                                   `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
                                   `calendar_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '日历名称',
                                   `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
                                   PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
                                       `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
                                       `trigger_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
                                       `trigger_group` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
                                       `cron_expression` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'cron表达式',
                                       `time_zone_id` varchar(80) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '时区',
                                       PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
                                       CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
                                        `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
                                        `entry_id` varchar(95) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度器实例id',
                                        `trigger_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
                                        `trigger_group` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
                                        `instance_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度器实例名',
                                        `fired_time` bigint NOT NULL COMMENT '触发的时间',
                                        `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
                                        `priority` int NOT NULL COMMENT '优先级',
                                        `state` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '状态',
                                        `job_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '任务名称',
                                        `job_group` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '任务组名',
                                        `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否并发',
                                        `requests_recovery` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
                                        PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
                                     `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
                                     `job_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '任务名称',
                                     `job_group` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '任务组名',
                                     `description` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
                                     `job_class_name` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '执行任务类名称',
                                     `is_durable` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '是否持久化',
                                     `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '是否并发',
                                     `is_update_data` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '是否更新数据',
                                     `requests_recovery` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '是否接受恢复执行',
                                     `job_data` blob NULL COMMENT '存放持久化job对象',
                                     PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
                               `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
                               `lock_name` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '悲观锁名称',
                               PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
                                             `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
                                             `trigger_group` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
                                             PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
                                         `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
                                         `instance_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '实例名称',
                                         `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
                                         `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
                                         PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
                                         `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
                                         `trigger_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
                                         `trigger_group` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
                                         `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
                                         `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
                                         `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
                                         PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
                                         CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
                                          `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
                                          `trigger_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
                                          `trigger_group` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
                                          `str_prop_1` varchar(512) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
                                          `str_prop_2` varchar(512) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
                                          `str_prop_3` varchar(512) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
                                          `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
                                          `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
                                          `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
                                          `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
                                          `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
                                          `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
                                          `bool_prop_1` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
                                          `bool_prop_2` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
                                          PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
                                          CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
                                  `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
                                  `trigger_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '触发器的名字',
                                  `trigger_group` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '触发器所属组的名字',
                                  `job_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
                                  `job_group` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
                                  `description` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
                                  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
                                  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
                                  `priority` int NULL DEFAULT NULL COMMENT '优先级',
                                  `trigger_state` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '触发器状态',
                                  `trigger_type` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '触发器的类型',
                                  `start_time` bigint NOT NULL COMMENT '开始时间',
                                  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
                                  `calendar_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '日程表名称',
                                  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
                                  `job_data` blob NULL COMMENT '存放持久化job对象',
                                  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
                                  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
                                  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
                               `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
                               `config_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '参数名称',
                               `config_key` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '参数键名',
                               `config_value` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '参数键值',
                               `config_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
                               `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
                               `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                               `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
                               `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                               `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
                               PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-09-21 20:04:51', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-09-21 20:04:51', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-09-21 20:04:51', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2025-09-21 20:04:51', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2025-09-21 20:04:51', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-09-21 20:04:51', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2025-09-21 20:04:51', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2025-09-21 20:04:51', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
                             `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
                             `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
                             `ancestors` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '祖级列表',
                             `dept_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '部门名称',
                             `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
                             `leader` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '负责人',
                             `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '联系电话',
                             `email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '邮箱',
                             `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
                             `del_flag` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                             `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
                             `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                             `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
                             `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                             PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-21 20:04:51', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-21 20:04:51', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-21 20:04:51', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-21 20:04:51', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-21 20:04:51', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-21 20:04:51', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-21 20:04:51', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-21 20:04:51', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-21 20:04:51', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-21 20:04:51', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
                                  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
                                  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
                                  `dict_label` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典标签',
                                  `dict_value` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典键值',
                                  `dict_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典类型',
                                  `css_class` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
                                  `list_class` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
                                  `is_default` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
                                  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
                                  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
                                  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
                                  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
                                  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
                                  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
                                  `dict_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典名称',
                                  `dict_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典类型',
                                  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
                                  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
                                  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
                                  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
                                  PRIMARY KEY (`dict_id`) USING BTREE,
                                  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
                            `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
                            `job_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
                            `job_group` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
                            `invoke_target` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调用目标字符串',
                            `cron_expression` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
                            `misfire_policy` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
                            `concurrent` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
                            `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
                            `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
                            `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                            `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
                            `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                            `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '备注信息',
                            PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-09-21 20:04:51', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
                                `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
                                `job_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '任务名称',
                                `job_group` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '任务组名',
                                `invoke_target` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调用目标字符串',
                                `job_message` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '日志信息',
                                `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
                                `exception_info` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '异常信息',
                                `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
                                   `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
                                   `user_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '用户账号',
                                   `ipaddr` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
                                   `login_location` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '登录地点',
                                   `browser` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
                                   `os` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '操作系统',
                                   `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
                                   `msg` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '提示消息',
                                   `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
                                   PRIMARY KEY (`info_id`) USING BTREE,
                                   INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
                                   INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 192 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-21 20:17:48');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-21 21:30:09');
INSERT INTO `sys_logininfor` VALUES (102, 'stany', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-21 21:30:18');
INSERT INTO `sys_logininfor` VALUES (103, 'stany', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-21 21:32:32');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-21 21:32:38');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-21 21:33:14');
INSERT INTO `sys_logininfor` VALUES (106, 'stany', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-21 21:33:26');
INSERT INTO `sys_logininfor` VALUES (107, 'stany', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-21 21:33:39');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-21 21:33:47');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-21 21:34:18');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-21 21:34:24');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-21 21:53:28');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-21 21:53:32');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-21 22:19:04');
INSERT INTO `sys_logininfor` VALUES (114, 'stany', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-21 22:19:17');
INSERT INTO `sys_logininfor` VALUES (115, 'stany', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-21 22:22:07');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-21 22:22:11');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-21 22:54:28');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-09-21 23:25:22');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-09-21 23:25:24');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-21 23:25:27');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '192.168.1.25', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-21 23:49:17');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-22 00:02:37');
INSERT INTO `sys_logininfor` VALUES (123, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-22 00:02:42');
INSERT INTO `sys_logininfor` VALUES (124, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-22 00:06:01');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-22 00:06:05');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-22 00:06:49');
INSERT INTO `sys_logininfor` VALUES (127, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-22 00:06:56');
INSERT INTO `sys_logininfor` VALUES (128, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-22 00:07:06');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-09-22 00:10:34');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-22 00:10:37');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-22 00:17:23');
INSERT INTO `sys_logininfor` VALUES (132, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-22 00:17:31');
INSERT INTO `sys_logininfor` VALUES (133, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-22 00:17:40');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-22 00:17:46');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-22 14:29:56');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-22 14:31:39');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-22 14:37:23');
INSERT INTO `sys_logininfor` VALUES (138, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-22 14:37:30');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '10.67.61.65', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-22 14:48:00');
INSERT INTO `sys_logininfor` VALUES (140, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-22 15:25:33');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-22 15:25:37');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-22 18:07:24');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '10.67.61.65', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-22 18:27:42');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-22 18:45:31');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-28 23:16:06');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-29 11:18:09');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-29 13:58:40');
INSERT INTO `sys_logininfor` VALUES (148, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-29 14:37:25');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-29 16:39:37');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-29 19:02:06');
INSERT INTO `sys_logininfor` VALUES (151, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-29 20:58:10');
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-29 21:36:11');
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-29 23:02:17');
INSERT INTO `sys_logininfor` VALUES (154, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-29 23:35:30');
INSERT INTO `sys_logininfor` VALUES (155, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-09-30 09:12:10');
INSERT INTO `sys_logininfor` VALUES (156, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-30 09:12:15');
INSERT INTO `sys_logininfor` VALUES (157, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-04 16:38:22');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-08 15:36:29');
INSERT INTO `sys_logininfor` VALUES (159, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-08 17:09:56');
INSERT INTO `sys_logininfor` VALUES (160, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-08 18:17:22');
INSERT INTO `sys_logininfor` VALUES (161, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-08 19:41:51');
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-09 10:54:48');
INSERT INTO `sys_logininfor` VALUES (163, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-09 13:11:36');
INSERT INTO `sys_logininfor` VALUES (164, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-09 13:28:07');
INSERT INTO `sys_logininfor` VALUES (165, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-09 13:28:16');
INSERT INTO `sys_logininfor` VALUES (166, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-09 13:28:30');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-09 13:28:35');
INSERT INTO `sys_logininfor` VALUES (168, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-09 13:29:22');
INSERT INTO `sys_logininfor` VALUES (169, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-09 13:29:28');
INSERT INTO `sys_logininfor` VALUES (170, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-09 13:29:42');
INSERT INTO `sys_logininfor` VALUES (171, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-09 13:29:48');
INSERT INTO `sys_logininfor` VALUES (172, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-09 13:32:35');
INSERT INTO `sys_logininfor` VALUES (173, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-09 13:32:42');
INSERT INTO `sys_logininfor` VALUES (174, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-09 13:34:37');
INSERT INTO `sys_logininfor` VALUES (175, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-09 13:34:40');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-09 13:35:28');
INSERT INTO `sys_logininfor` VALUES (177, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-09 13:35:38');
INSERT INTO `sys_logininfor` VALUES (178, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-09 13:36:08');
INSERT INTO `sys_logininfor` VALUES (179, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-09 13:36:11');
INSERT INTO `sys_logininfor` VALUES (180, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-09 15:09:35');
INSERT INTO `sys_logininfor` VALUES (181, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-09 15:42:37');
INSERT INTO `sys_logininfor` VALUES (182, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-10 16:19:57');
INSERT INTO `sys_logininfor` VALUES (183, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-10 16:32:41');
INSERT INTO `sys_logininfor` VALUES (184, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-10 16:32:47');
INSERT INTO `sys_logininfor` VALUES (185, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-10 16:33:02');
INSERT INTO `sys_logininfor` VALUES (186, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-10 16:33:06');
INSERT INTO `sys_logininfor` VALUES (187, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-10 16:33:32');
INSERT INTO `sys_logininfor` VALUES (188, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-10 16:34:29');
INSERT INTO `sys_logininfor` VALUES (189, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-10 16:35:08');
INSERT INTO `sys_logininfor` VALUES (190, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-10 16:35:13');
INSERT INTO `sys_logininfor` VALUES (191, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-10 17:47:29');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
                             `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
                             `menu_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '菜单名称',
                             `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
                             `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
                             `path` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '路由地址',
                             `component` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '组件路径',
                             `query` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '路由参数',
                             `route_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '路由名称',
                             `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
                             `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
                             `menu_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
                             `visible` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
                             `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
                             `perms` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '权限标识',
                             `icon` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
                             `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
                             `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                             `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
                             `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                             `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '备注',
                             PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2011 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 4, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-09-21 20:04:51', 'admin', '2025-10-09 15:56:33', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 5, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-09-21 20:04:51', 'admin', '2025-10-09 15:56:43', '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 6, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-09-21 20:04:51', 'admin', '2025-10-09 15:57:32', '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 7, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2025-09-21 20:04:51', 'admin', '2025-10-09 15:58:06', '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-09-21 20:04:51', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-09-21 20:04:51', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-09-21 20:04:51', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-09-21 20:04:51', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-09-21 20:04:51', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-09-21 20:04:51', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-09-21 20:04:51', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-09-21 20:04:51', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-09-21 20:04:51', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-09-21 20:04:51', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2025-09-21 20:04:51', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2025-09-21 20:04:51', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-09-21 20:04:51', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2025-09-21 20:04:51', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2025-09-21 20:04:51', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-09-21 20:04:51', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-09-21 20:04:51', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-09-21 20:04:51', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-09-21 20:04:51', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-09-21 20:04:51', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '校园圈子', 0, 0, 'topic', 'campus/topic/index', NULL, '', 1, 0, 'C', '0', '0', 'campus:topic:list', 'international', 'admin', '2025-09-21 20:55:34', 'admin', '2025-09-21 21:55:03', '');
INSERT INTO `sys_menu` VALUES (2001, '话题新增', 2000, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'campus:topic:add', '#', 'admin', '2025-09-22 14:36:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2002, '跑腿代办（后台）', 1, 0, 'errand', 'campus/admin/errand/index', NULL, '', 1, 0, 'C', '0', '0', 'campus:errand:list', 'shopping', 'admin', '2025-10-08 18:30:57', 'admin', '2025-10-08 19:14:24', '跑腿代办菜单');
INSERT INTO `sys_menu` VALUES (2003, '跑腿代办查询', 2002, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'campus:errand:query', '#', 'admin', '2025-10-08 18:30:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2004, '跑腿代办新增', 2002, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'campus:errand:add', '#', 'admin', '2025-10-08 18:30:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '跑腿代办修改', 2002, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'campus:errand:edit', '#', 'admin', '2025-10-08 18:30:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '跑腿代办删除', 2002, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'campus:errand:remove', '#', 'admin', '2025-10-08 18:30:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2007, '跑腿代办导出', 2002, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'campus:errand:export', '#', 'admin', '2025-10-08 18:30:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2008, '跑腿大厅', 0, 2, 'errand', 'campus/errand/index', NULL, '', 1, 0, 'C', '0', '0', '', 'shopping', 'admin', '2025-10-08 19:47:31', 'admin', '2025-10-09 15:55:18', '');
INSERT INTO `sys_menu` VALUES (2009, '我的跑腿', 0, 3, 'my-errands', 'campus/profile/my-errands', NULL, '', 1, 0, 'C', '0', '0', '', 'shopping', 'admin', '2025-10-09 15:11:07', 'admin', '2025-10-09 15:56:12', '');
INSERT INTO `sys_menu` VALUES (2010, '我的圈子', 0, 1, 'my-circle', 'campus/profile/index', NULL, '', 1, 0, 'C', '0', '0', '', 'international', 'admin', '2025-10-09 15:54:14', 'admin', '2025-10-09 15:55:04', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
                               `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
                               `notice_title` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '公告标题',
                               `notice_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
                               `notice_content` longblob NULL COMMENT '公告内容',
                               `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
                               `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
                               `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                               `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
                               `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                               `remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
                               PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2025-09-21 20:04:51', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2025-09-21 20:04:51', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
                                 `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
                                 `title` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '模块标题',
                                 `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
                                 `method` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '方法名称',
                                 `request_method` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '请求方式',
                                 `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
                                 `oper_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '操作人员',
                                 `dept_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '部门名称',
                                 `oper_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '请求URL',
                                 `oper_ip` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '主机地址',
                                 `oper_location` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '操作地点',
                                 `oper_param` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '请求参数',
                                 `json_result` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '返回参数',
                                 `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
                                 `error_msg` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '错误消息',
                                 `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
                                 `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
                                 PRIMARY KEY (`oper_id`) USING BTREE,
                                 INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
                                 INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
                                 INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 214 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"campus_topic\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-21 20:28:05', 61);
INSERT INTO `sys_oper_log` VALUES (101, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"topic\",\"className\":\"CampusTopic\",\"columns\":[{\"capJavaField\":\"TopicId\",\"columnComment\":\"话题ID\",\"columnId\":1,\"columnName\":\"topic_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-21 20:28:05\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"topicId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户ID\",\"columnId\":2,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-21 20:28:05\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Content\",\"columnComment\":\"话题内容\",\"columnId\":3,\"columnName\":\"content\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-21 20:28:05\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"editor\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"content\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ImageUrls\",\"columnComment\":\"图片链接(多张用逗号分隔)\",\"columnId\":4,\"columnName\":\"image_urls\",\"columnType\":\"varchar(1000)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-21 20:28:05\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-21 20:31:25', 127);
INSERT INTO `sys_oper_log` VALUES (102, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"campus_topic\"}', NULL, 0, NULL, '2025-09-21 20:31:33', 128);
INSERT INTO `sys_oper_log` VALUES (103, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"topic\",\"className\":\"CampusTopic\",\"columns\":[{\"capJavaField\":\"TopicId\",\"columnComment\":\"话题ID\",\"columnId\":1,\"columnName\":\"topic_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-21 20:28:05\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"topicId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-09-21 20:31:25\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户ID\",\"columnId\":2,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-21 20:28:05\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-09-21 20:31:25\",\"usableColumn\":false},{\"capJavaField\":\"Content\",\"columnComment\":\"话题内容\",\"columnId\":3,\"columnName\":\"content\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-21 20:28:05\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"editor\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"content\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-09-21 20:31:25\",\"usableColumn\":false},{\"capJavaField\":\"ImageUrls\",\"columnComment\":\"图片链接(多张用逗号分隔)\",\"columnId\":4,\"columnName\":\"image_urls\",\"columnType\":\"varchar(1000)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-21 20:28:05\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"ins', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-21 20:40:36', 116);
INSERT INTO `sys_oper_log` VALUES (104, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"campus_topic\"}', NULL, 0, NULL, '2025-09-21 20:40:40', 28);
INSERT INTO `sys_oper_log` VALUES (105, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/topic/index\",\"createBy\":\"admin\",\"icon\":\"international\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"校园圈子\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"topic\",\"perms\":\"campus:topic:list\",\"routeName\":\"\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-21 20:55:34', 177);
INSERT INTO `sys_oper_log` VALUES (106, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'admin', '研发部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"content\":\"<p>test001哈哈哈</p>\",\"createTime\":\"2025-09-21 21:22:17\",\"params\":{},\"topicId\":100,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-21 21:22:17', 132);
INSERT INTO `sys_oper_log` VALUES (107, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2025/09/21/1fa8aafb3c354b968b86254fe28e8847.jpg\",\"code\":200}', 0, NULL, '2025-09-21 21:28:05', 165);
INSERT INTO `sys_oper_log` VALUES (108, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"trzrzzh@icloud.com\",\"nickName\":\"stan\",\"params\":{},\"phonenumber\":\"15257942123\",\"sex\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-21 21:28:23', 16);
INSERT INTO `sys_oper_log` VALUES (109, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptId\":100,\"email\":\"trzrzzh@icloud.com\",\"nickName\":\"stany\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"roleIds\":[2],\"sex\":\"0\",\"status\":\"0\",\"userName\":\"stany\"}', '{\"msg\":\"新增用户\'stany\'失败，邮箱账号已存在\",\"code\":500}', 0, NULL, '2025-09-21 21:29:44', 12);
INSERT INTO `sys_oper_log` VALUES (110, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":100,\"email\":\"3403368487@qq.com\",\"nickName\":\"stany\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"roleIds\":[2],\"sex\":\"0\",\"status\":\"0\",\"userId\":100,\"userName\":\"stany\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-21 21:29:53', 104);
INSERT INTO `sys_oper_log` VALUES (111, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'stany', '若依科技', '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2025/09/21/0b6194a629154a9aad6c1687e253f53a.JPG\",\"code\":200}', 0, NULL, '2025-09-21 21:30:41', 10);
INSERT INTO `sys_oper_log` VALUES (112, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-21 20:04:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-21 21:33:10', 22);
INSERT INTO `sys_oper_log` VALUES (113, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-21 20:04:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-21 21:34:15', 13);
INSERT INTO `sys_oper_log` VALUES (114, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"trzrzzh@icloud.com\",\"nickName\":\"stan\",\"params\":{},\"phonenumber\":\"15257942123\",\"sex\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-21 21:36:34', 15);
INSERT INTO `sys_oper_log` VALUES (115, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'admin', '研发部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"content\":\"<p>test002哈哈哈<img src=\\\"/dev-api/profile/upload/2025/09/21/微信图片_20230823145137_20250921214858A001.jpg\\\"></p>\",\"createTime\":\"2025-09-21 21:48:59\",\"params\":{},\"topicId\":101,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-21 21:48:59', 138);
INSERT INTO `sys_oper_log` VALUES (116, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'admin', '研发部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"content\":\"<p><img src=\\\"/dev-api/profile/upload/2025/09/21/微信图片_20230823145137_20250921215308A002.jpg\\\"></p>\",\"createTime\":\"2025-09-21 21:53:12\",\"params\":{},\"topicId\":102,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-21 21:53:12', 9);
INSERT INTO `sys_oper_log` VALUES (117, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/topic/index\",\"createTime\":\"2025-09-21 20:55:34\",\"icon\":\"international\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"校园圈子\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"topic\",\"perms\":\"campus:topic:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-21 21:55:03', 126);
INSERT INTO `sys_oper_log` VALUES (118, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2025/09/21/9bcc8038281847dc897b22a99214f89e.png\",\"code\":200}', 0, NULL, '2025-09-21 22:17:26', 16);
INSERT INTO `sys_oper_log` VALUES (119, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"trzrzzh@icloud.com\",\"nickName\":\"stan\",\"params\":{},\"phonenumber\":\"15257942123\",\"sex\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-21 22:17:28', 22);
INSERT INTO `sys_oper_log` VALUES (120, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2025/09/21/25057a6499e74c67acf2cfa5663bc0b2.jpg\",\"code\":200}', 0, NULL, '2025-09-21 22:17:59', 10);
INSERT INTO `sys_oper_log` VALUES (121, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'admin', '研发部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"content\":\"<p><img src=\\\"/dev-api/profile/upload/2025/09/21/微信图片_20250701131615_20250921221823A003.jpg\\\"></p>\",\"createTime\":\"2025-09-21 22:18:25\",\"params\":{},\"topicId\":103,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-21 22:18:25', 7);
INSERT INTO `sys_oper_log` VALUES (122, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2025/09/21/f5748c03e0e4452887ac214017fe6a7d.jpg\",\"code\":200}', 0, NULL, '2025-09-21 22:22:25', 9);
INSERT INTO `sys_oper_log` VALUES (123, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'admin', '研发部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"content\":\"<p>1</p>\",\"createTime\":\"2025-09-21 23:27:29\",\"params\":{},\"topicId\":104,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-21 23:27:29', 80);
INSERT INTO `sys_oper_log` VALUES (124, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'admin', '研发部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"content\":\"1\",\"createTime\":\"2025-09-21 23:52:33\",\"delFlag\":\"0\",\"params\":{},\"status\":\"0\",\"topicId\":105,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-21 23:52:33', 16);
INSERT INTO `sys_oper_log` VALUES (125, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-09-21 20:04:51\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"测试部门\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":105,\"email\":\"ry@qq.com\",\"loginDate\":\"2025-09-21 20:04:51\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[2],\"pwdUpdateDate\":\"2025-09-21 20:04:51\",\"remark\":\"测试员\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":2,\"userName\":\"ry\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-22 00:02:27', 28);
INSERT INTO `sys_oper_log` VALUES (126, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'ry', '测试部门', '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2025/09/22/2cd6efbe672645258a4eac4cea69e045.JPG\",\"code\":200}', 0, NULL, '2025-09-22 00:03:04', 70);
INSERT INTO `sys_oper_log` VALUES (127, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'ry', '测试部门', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"ry@qq.com\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15666666666\",\"sex\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-22 00:03:06', 11);
INSERT INTO `sys_oper_log` VALUES (128, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-21 20:04:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-22 00:06:46', 18);
INSERT INTO `sys_oper_log` VALUES (129, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-21 20:04:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"admin\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\"}', '{\"msg\":\"修改角色\'普通角色\'失败，角色权限已存在\",\"code\":500}', 0, NULL, '2025-09-22 00:11:15', 4);
INSERT INTO `sys_oper_log` VALUES (130, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-21 20:04:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"admin\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\"}', '{\"msg\":\"修改角色\'普通角色\'失败，角色权限已存在\",\"code\":500}', 0, NULL, '2025-09-22 00:11:22', 4);
INSERT INTO `sys_oper_log` VALUES (131, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-21 20:04:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"admin\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\"}', '{\"msg\":\"修改角色\'普通角色\'失败，角色权限已存在\",\"code\":500}', 0, NULL, '2025-09-22 00:11:24', 4);
INSERT INTO `sys_oper_log` VALUES (132, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-21 20:04:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"admin\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\"}', '{\"msg\":\"修改角色\'普通角色\'失败，角色权限已存在\",\"code\":500}', 0, NULL, '2025-09-22 00:11:26', 4);
INSERT INTO `sys_oper_log` VALUES (133, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-21 20:04:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"admin\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\"}', '{\"msg\":\"修改角色\'普通角色\'失败，角色权限已存在\",\"code\":500}', 0, NULL, '2025-09-22 00:11:51', 2);
INSERT INTO `sys_oper_log` VALUES (134, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-21 20:04:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"admin\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\"}', '{\"msg\":\"修改角色\'普通角色\'失败，角色权限已存在\",\"code\":500}', 0, NULL, '2025-09-22 00:11:53', 4);
INSERT INTO `sys_oper_log` VALUES (135, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-21 20:04:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"admin\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\"}', '{\"msg\":\"修改角色\'普通角色\'失败，角色权限已存在\",\"code\":500}', 0, NULL, '2025-09-22 00:11:56', 4);
INSERT INTO `sys_oper_log` VALUES (136, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000],\"params\":{},\"roleKey\":\"admin\",\"roleName\":\"游客\",\"roleSort\":3,\"status\":\"0\"}', '{\"msg\":\"新增角色\'游客\'失败，角色权限已存在\",\"code\":500}', 0, NULL, '2025-09-22 00:15:11', 4);
INSERT INTO `sys_oper_log` VALUES (137, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000],\"params\":{},\"roleKey\":\"admin\",\"roleName\":\"游客\",\"roleSort\":3,\"status\":\"0\"}', '{\"msg\":\"新增角色\'游客\'失败，角色权限已存在\",\"code\":500}', 0, NULL, '2025-09-22 00:15:14', 3);
INSERT INTO `sys_oper_log` VALUES (138, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000],\"params\":{},\"roleKey\":\"admin\",\"roleName\":\"游客\",\"roleSort\":3,\"status\":\"0\"}', '{\"msg\":\"新增角色\'游客\'失败，角色权限已存在\",\"code\":500}', 0, NULL, '2025-09-22 00:15:14', 3);
INSERT INTO `sys_oper_log` VALUES (139, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.changeStatus()', 'PUT', 1, 'admin', '研发部门', '/system/role/changeStatus', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"status\":\"1\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-22 00:16:48', 67);
INSERT INTO `sys_oper_log` VALUES (140, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', '研发部门', '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-21 20:04:51\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":false,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-22 00:17:08', 10);
INSERT INTO `sys_oper_log` VALUES (141, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.changeStatus()', 'PUT', 1, 'admin', '研发部门', '/system/role/changeStatus', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-22 00:17:11', 4);
INSERT INTO `sys_oper_log` VALUES (142, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', '研发部门', '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-21 20:04:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[100],\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-22 00:18:17', 12);
INSERT INTO `sys_oper_log` VALUES (143, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-21 20:04:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-22 14:35:55', 41);
INSERT INTO `sys_oper_log` VALUES (144, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"话题新增\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"perms\":\"campus:topic:add\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-22 14:36:49', 14);
INSERT INTO `sys_oper_log` VALUES (145, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-21 20:04:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-22 14:37:19', 17);
INSERT INTO `sys_oper_log` VALUES (146, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'ry', '测试部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"content\":\"666\",\"createTime\":\"2025-09-22 14:37:37\",\"delFlag\":\"0\",\"params\":{},\"status\":\"0\",\"topicId\":106,\"userId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-22 14:37:37', 11);
INSERT INTO `sys_oper_log` VALUES (147, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'ry', '测试部门', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"ry@qq.com\",\"nickName\":\"ry\",\"params\":{},\"phonenumber\":\"15666666666\",\"sex\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-22 14:39:54', 10);
INSERT INTO `sys_oper_log` VALUES (148, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'ry', '测试部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"content\":\"hh\",\"createTime\":\"2025-09-22 14:43:09\",\"imageUrls\":\"/profile/upload/2025/09/22/微信图片_20230823145137_20250922144305A001.jpg\",\"params\":{},\"topicId\":107,\"userId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-22 14:43:09', 8);
INSERT INTO `sys_oper_log` VALUES (149, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'ry', '测试部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"content\":\"1\",\"createTime\":\"2025-09-22 14:52:24\",\"imageUrls\":\"/profile/upload/2025/09/22/微信图片_20230823145137_20250922145220A002.jpg\",\"params\":{},\"topicId\":108,\"userId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-22 14:52:24', 5);
INSERT INTO `sys_oper_log` VALUES (150, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'admin', '研发部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"content\":\"？\",\"createTime\":\"2025-09-22 15:53:50\",\"imageUrls\":\"/profile/upload/2025/09/22/Screenshot 2025-08-29 190218_20250922155349A002.png\",\"params\":{},\"topicId\":109,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-22 15:53:50', 75);
INSERT INTO `sys_oper_log` VALUES (151, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'admin', '研发部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"content\":\"s\",\"createBy\":\"admin\",\"createTime\":\"2025-09-28 23:46:27\",\"imageUrls\":\"/profile/upload/2025/09/28/Grounded_2025.09.22-19.53.20_20250928234624A001.png\",\"liked\":false,\"params\":{},\"topicType\":\"qa\",\"userId\":1}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'delFlag\' in \'class com.ruoyi.campus.domain.CampusTopic\'', '2025-09-28 23:46:27', 32);
INSERT INTO `sys_oper_log` VALUES (152, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'admin', '研发部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"content\":\"有没有二手货\",\"createBy\":\"admin\",\"createTime\":\"2025-09-29 12:34:55\",\"imageUrls\":\"/profile/upload/2025/09/29/Grounded_2025.09.22-19.53.20_20250929123454A001.png\",\"liked\":false,\"params\":{},\"topicId\":110,\"topicType\":\"secondhand\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-29 12:34:55', 145);
INSERT INTO `sys_oper_log` VALUES (153, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'admin', '研发部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"content\":\"什么东西？\",\"createBy\":\"admin\",\"createTime\":\"2025-09-29 12:37:54\",\"imageUrls\":\"/profile/upload/2025/09/29/Screenshot 2025-09-25 131510_20250929123742A002.png\",\"liked\":false,\"params\":{},\"topicId\":111,\"topicType\":\"qa\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-29 12:37:54', 8);
INSERT INTO `sys_oper_log` VALUES (154, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'admin', '研发部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"content\":\"666\",\"createBy\":\"admin\",\"createTime\":\"2025-09-29 14:42:39\",\"liked\":false,\"params\":{},\"topicId\":112,\"topicType\":\"recommend\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-29 14:42:39', 26);
INSERT INTO `sys_oper_log` VALUES (155, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'admin', '研发部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"content\":\"s\",\"createBy\":\"admin\",\"createTime\":\"2025-09-29 14:53:25\",\"liked\":false,\"params\":{},\"topicId\":113,\"topicType\":\"recommend\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-29 14:53:25', 6);
INSERT INTO `sys_oper_log` VALUES (156, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'admin', '研发部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"content\":\"谭墨我爱你\",\"createBy\":\"admin\",\"createTime\":\"2025-09-29 14:57:52\",\"liked\":false,\"params\":{},\"topicId\":114,\"topicType\":\"dating\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-29 14:57:52', 5);
INSERT INTO `sys_oper_log` VALUES (157, '校园话题', 2, 'com.ruoyi.campus.controller.CampusTopicController.edit()', 'PUT', 1, 'admin', '研发部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"content\":\"<p>test001哈哈哈666</p>\",\"createBy\":\"\",\"createTime\":\"2025-09-21 21:22:17\",\"delFlag\":\"0\",\"liked\":false,\"params\":{},\"status\":\"0\",\"topicId\":100,\"topicType\":\"recommend\",\"updateBy\":\"admin\",\"updateTime\":\"2025-09-29 20:10:18\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-29 20:10:18', 35);
INSERT INTO `sys_oper_log` VALUES (158, '校园话题', 3, 'com.ruoyi.campus.controller.CampusTopicController.remove()', 'DELETE', 1, 'admin', '研发部门', '/campus/topic/101', '127.0.0.1', '内网IP', '[101]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-29 20:10:22', 11);
INSERT INTO `sys_oper_log` VALUES (159, '校园话题', 3, 'com.ruoyi.campus.controller.CampusTopicController.remove()', 'DELETE', 1, 'admin', '研发部门', '/campus/topic/103', '127.0.0.1', '内网IP', '[103]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-29 20:10:26', 7);
INSERT INTO `sys_oper_log` VALUES (160, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'admin', '研发部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"content\":\"bot\",\"createBy\":\"admin\",\"createTime\":\"2025-09-29 21:02:21\",\"imageUrls\":\"/profile/upload/2025/09/29/Screenshot 2025-09-07 151720_20250929210155A001.png,/profile/upload/2025/09/29/Screenshot 2025-08-29 190218_20250929210217A002.png\",\"liked\":false,\"params\":{},\"topicId\":115,\"topicType\":\"qa\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-29 21:02:21', 20);
INSERT INTO `sys_oper_log` VALUES (161, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'admin', '研发部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"commentEnabled\":\"1\",\"content\":\"禁止评论\\n\",\"createBy\":\"admin\",\"createTime\":\"2025-10-08 16:07:44\",\"favorited\":false,\"liked\":false,\"params\":{},\"topicType\":\"recommend\",\"userId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Column \'create_time\' specified twice\r\n### The error may exist in file [C:\\Users\\stan0930\\Desktop\\our-awesome-project\\ruoyi-system\\target\\classes\\mapper\\campus\\CampusTopicMapper.xml]\r\n### The error may involve com.ruoyi.campus.mapper.CampusTopicMapper.insertCampusTopic-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into campus_topic          ( user_id,             content,                          topic_type,                          create_by,             create_time,                          create_time,             comment_enabled )           values ( ?,             ?,                          ?,                          ?,             ?,                          ?,             ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Column \'create_time\' specified twice\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Column \'create_time\' specified twice', '2025-10-08 16:07:44', 81);
INSERT INTO `sys_oper_log` VALUES (162, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'admin', '研发部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"commentEnabled\":\"1\",\"content\":\"禁止评论\\n\",\"createBy\":\"admin\",\"createTime\":\"2025-10-08 16:07:46\",\"favorited\":false,\"liked\":false,\"params\":{},\"topicType\":\"recommend\",\"userId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Column \'create_time\' specified twice\r\n### The error may exist in file [C:\\Users\\stan0930\\Desktop\\our-awesome-project\\ruoyi-system\\target\\classes\\mapper\\campus\\CampusTopicMapper.xml]\r\n### The error may involve com.ruoyi.campus.mapper.CampusTopicMapper.insertCampusTopic-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into campus_topic          ( user_id,             content,                          topic_type,                          create_by,             create_time,                          create_time,             comment_enabled )           values ( ?,             ?,                          ?,                          ?,             ?,                          ?,             ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Column \'create_time\' specified twice\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Column \'create_time\' specified twice', '2025-10-08 16:07:46', 4);
INSERT INTO `sys_oper_log` VALUES (163, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'admin', '研发部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"commentEnabled\":\"1\",\"content\":\"禁止评论\\n\",\"createBy\":\"admin\",\"createTime\":\"2025-10-08 16:07:50\",\"favorited\":false,\"liked\":false,\"params\":{},\"topicType\":\"recommend\",\"userId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Column \'create_time\' specified twice\r\n### The error may exist in file [C:\\Users\\stan0930\\Desktop\\our-awesome-project\\ruoyi-system\\target\\classes\\mapper\\campus\\CampusTopicMapper.xml]\r\n### The error may involve com.ruoyi.campus.mapper.CampusTopicMapper.insertCampusTopic-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into campus_topic          ( user_id,             content,                          topic_type,                          create_by,             create_time,                          create_time,             comment_enabled )           values ( ?,             ?,                          ?,                          ?,             ?,                          ?,             ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Column \'create_time\' specified twice\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Column \'create_time\' specified twice', '2025-10-08 16:07:50', 3);
INSERT INTO `sys_oper_log` VALUES (164, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'admin', '研发部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"commentEnabled\":\"1\",\"content\":\"禁止评论\\n\",\"createBy\":\"admin\",\"createTime\":\"2025-10-08 16:08:39\",\"favorited\":false,\"liked\":false,\"params\":{},\"topicType\":\"recommend\",\"userId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Column \'create_time\' specified twice\r\n### The error may exist in file [C:\\Users\\stan0930\\Desktop\\our-awesome-project\\ruoyi-system\\target\\classes\\mapper\\campus\\CampusTopicMapper.xml]\r\n### The error may involve com.ruoyi.campus.mapper.CampusTopicMapper.insertCampusTopic-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into campus_topic          ( user_id,             content,                          topic_type,                          create_by,             create_time,                          create_time,             comment_enabled )           values ( ?,             ?,                          ?,                          ?,             ?,                          ?,             ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Column \'create_time\' specified twice\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Column \'create_time\' specified twice', '2025-10-08 16:08:39', 2);
INSERT INTO `sys_oper_log` VALUES (165, '校园话题', 1, 'com.ruoyi.campus.controller.CampusTopicController.add()', 'POST', 1, 'admin', '研发部门', '/campus/topic', '127.0.0.1', '内网IP', '{\"commentEnabled\":\"1\",\"content\":\"禁止评论\",\"createBy\":\"admin\",\"createTime\":\"2025-10-08 16:12:04\",\"favorited\":false,\"liked\":false,\"params\":{},\"topicId\":116,\"topicType\":\"recommend\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-08 16:12:04', 77);
INSERT INTO `sys_oper_log` VALUES (166, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"campus_errand_order\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-08 17:10:34', 70);
INSERT INTO `sys_oper_log` VALUES (167, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"errand\",\"className\":\"CampusErrandOrder\",\"columns\":[{\"capJavaField\":\"OrderId\",\"columnComment\":\"订单ID (主键)\",\"columnId\":12,\"columnName\":\"order_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-08 17:10:34\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"orderId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"PublisherId\",\"columnComment\":\"发布人ID (外键, 关联sys_user)\",\"columnId\":13,\"columnName\":\"publisher_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-08 17:10:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"publisherId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"TakerId\",\"columnComment\":\"接单人ID (外键, 关联sys_user)\",\"columnId\":14,\"columnName\":\"taker_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-08 17:10:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"takerId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"OrderType\",\"columnComment\":\"订单类型 (如: 快递代取, 外卖代拿, 校园跑腿)\",\"columnId\":15,\"columnName\":\"order_type\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-08 17:10:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-08 17:13:12', 128);
INSERT INTO `sys_oper_log` VALUES (168, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"campus_errand_order\"}', NULL, 0, NULL, '2025-10-08 17:13:16', 129);
INSERT INTO `sys_oper_log` VALUES (169, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"errand\",\"className\":\"CampusErrandOrder\",\"columns\":[{\"capJavaField\":\"OrderId\",\"columnComment\":\"订单ID (主键)\",\"columnId\":12,\"columnName\":\"order_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-08 17:10:34\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"orderId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-10-08 17:13:12\",\"usableColumn\":false},{\"capJavaField\":\"PublisherId\",\"columnComment\":\"发布人ID (外键, 关联sys_user)\",\"columnId\":13,\"columnName\":\"publisher_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-08 17:10:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"publisherId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-10-08 17:13:12\",\"usableColumn\":false},{\"capJavaField\":\"TakerId\",\"columnComment\":\"接单人ID (外键, 关联sys_user)\",\"columnId\":14,\"columnName\":\"taker_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-08 17:10:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"takerId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-10-08 17:13:12\",\"usableColumn\":false},{\"capJavaField\":\"OrderType\",\"columnComment\":\"订单类型 (如: 快递代取, 外卖代拿, 校园跑腿)\",\"columnId\":15,\"columnName\":\"order_type\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-08 17:10:34\",', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-08 18:17:54', 48);
INSERT INTO `sys_oper_log` VALUES (170, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"campus_errand_order\"}', NULL, 0, NULL, '2025-10-08 18:17:59', 61);
INSERT INTO `sys_oper_log` VALUES (171, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/errand/index\",\"createTime\":\"2025-10-08 18:30:57\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"跑腿代办\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"errand\",\"perms\":\"campus:errand:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-08 18:33:43', 21);
INSERT INTO `sys_oper_log` VALUES (172, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/errand/index\",\"createTime\":\"2025-10-08 18:30:57\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"跑腿代办\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"errand\",\"perms\":\"campus:errand:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-08 18:34:10', 8);
INSERT INTO `sys_oper_log` VALUES (173, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/errand/index\",\"createTime\":\"2025-10-08 18:30:57\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"跑腿代办\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"errand\",\"perms\":\"campus:errand:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-08 18:34:42', 8);
INSERT INTO `sys_oper_log` VALUES (174, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/errand/index\",\"createTime\":\"2025-10-08 18:30:57\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"跑腿代办\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"errand\",\"perms\":\"campus:errand:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-08 18:34:58', 10);
INSERT INTO `sys_oper_log` VALUES (175, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/errand/index\",\"createTime\":\"2025-10-08 18:30:57\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"跑腿代办（后台）\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"errand\",\"perms\":\"campus:errand:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-08 18:37:27', 8);
INSERT INTO `sys_oper_log` VALUES (176, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/errand/index\",\"createTime\":\"2025-10-08 18:30:57\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"跑腿代办（后台）\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":1,\"path\":\"errand\",\"perms\":\"campus:errand:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-08 18:38:00', 9);
INSERT INTO `sys_oper_log` VALUES (177, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/admin/errand/index\",\"createTime\":\"2025-10-08 18:30:57\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"跑腿代办（后台）\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":1,\"path\":\"errand\",\"perms\":\"campus:errand:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-08 18:59:29', 104);
INSERT INTO `sys_oper_log` VALUES (178, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/errand/index\",\"createTime\":\"2025-10-08 18:30:57\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"跑腿代办（后台）\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":1,\"path\":\"errand\",\"perms\":\"campus:errand:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-08 19:12:05', 12);
INSERT INTO `sys_oper_log` VALUES (179, '跑腿代办', 1, 'com.ruoyi.campus.controller.CampusErrandOrderController.add()', 'POST', 1, 'admin', '研发部门', '/campus/errand', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-10-08 19:13:21\",\"deliveryAddress\":\"666\",\"detail\":\"取件码111\",\"orderType\":\"外卖代拿\",\"params\":{},\"reward\":6,\"title\":\"拿个快递\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'publisher_id\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\stan0930\\Desktop\\our-awesome-project\\ruoyi-system\\target\\classes\\mapper\\campus\\CampusErrandOrderMapper.xml]\r\n### The error may involve com.ruoyi.campus.mapper.CampusErrandOrderMapper.insertCampusErrandOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into campus_errand_order          ( order_type,             title,             detail,             reward,             delivery_address,                          create_time )           values ( ?,             ?,             ?,             ?,             ?,                          ? )\r\n### Cause: java.sql.SQLException: Field \'publisher_id\' doesn\'t have a default value\n; Field \'publisher_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'publisher_id\' doesn\'t have a default value', '2025-10-08 19:13:21', 88);
INSERT INTO `sys_oper_log` VALUES (180, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/admin/errand/index\",\"createTime\":\"2025-10-08 18:30:57\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"跑腿代办（后台）\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":1,\"path\":\"errand\",\"perms\":\"campus:errand:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-08 19:14:24', 7);
INSERT INTO `sys_oper_log` VALUES (181, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/portal/errand\",\"createBy\":\"admin\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"跑腿大厅\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"errand\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-08 19:47:31', 11);
INSERT INTO `sys_oper_log` VALUES (182, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/portal/errand\",\"createTime\":\"2025-10-08 19:47:31\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2008,\"menuName\":\"跑腿大厅\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"errand\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-08 19:48:01', 10);
INSERT INTO `sys_oper_log` VALUES (183, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/portal/errand\",\"createTime\":\"2025-10-08 19:47:31\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2008,\"menuName\":\"跑腿大厅\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"errand\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-08 19:49:20', 106);
INSERT INTO `sys_oper_log` VALUES (184, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/portal/errand\",\"createTime\":\"2025-10-08 19:47:31\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2008,\"menuName\":\"跑腿大厅\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"errand\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-08 19:49:42', 9);
INSERT INTO `sys_oper_log` VALUES (185, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/errand\",\"createTime\":\"2025-10-08 19:47:31\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2008,\"menuName\":\"跑腿大厅\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"errand\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-08 20:14:51', 116);
INSERT INTO `sys_oper_log` VALUES (186, '跑腿代办', 1, 'com.ruoyi.campus.controller.CampusErrandOrderController.add()', 'POST', 1, 'admin', '研发部门', '/campus/errand', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-10-08 20:15:45\",\"deliveryAddress\":\"408\",\"detail\":\"取件码加我微信给你\",\"orderType\":\"快递代取\",\"params\":{},\"reward\":10,\"title\":\"test\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'publisher_id\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\stan0930\\Desktop\\our-awesome-project\\ruoyi-system\\target\\classes\\mapper\\campus\\CampusErrandOrderMapper.xml]\r\n### The error may involve com.ruoyi.campus.mapper.CampusErrandOrderMapper.insertCampusErrandOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into campus_errand_order          ( order_type,             title,             detail,             reward,             delivery_address,                          create_time )           values ( ?,             ?,             ?,             ?,             ?,                          ? )\r\n### Cause: java.sql.SQLException: Field \'publisher_id\' doesn\'t have a default value\n; Field \'publisher_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'publisher_id\' doesn\'t have a default value', '2025-10-08 20:15:45', 4);
INSERT INTO `sys_oper_log` VALUES (187, '跑腿订单', 1, 'com.ruoyi.campus.controller.CampusErrandOrderController.add()', 'POST', 1, 'admin', '研发部门', '/campus/errand', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-10-09 10:55:12\",\"deliveryAddress\":\"test\",\"detail\":\"777\",\"orderId\":1,\"orderType\":\"快递代取\",\"params\":{},\"publisherId\":1,\"reward\":5,\"title\":\"test\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-09 10:55:12', 16);
INSERT INTO `sys_oper_log` VALUES (188, '跑腿订单', 2, 'com.ruoyi.campus.controller.CampusErrandOrderController.takeOrder()', 'PUT', 1, 'admin', '研发部门', '/campus/errand/take/1', '127.0.0.1', '内网IP', '1', NULL, 1, '不能接自己发布的任务哦', '2025-10-09 13:28:00', 12);
INSERT INTO `sys_oper_log` VALUES (189, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-21 20:04:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,2000,2001,2008,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-09 13:29:18', 30);
INSERT INTO `sys_oper_log` VALUES (190, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/09/22/2cd6efbe672645258a4eac4cea69e045.JPG\",\"createBy\":\"admin\",\"createTime\":\"2025-09-21 20:04:51\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"测试部门\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":105,\"email\":\"ry@qq.com\",\"loginDate\":\"2025-10-09 13:29:29\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"ry\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[2],\"pwdUpdateDate\":\"2025-09-21 20:04:51\",\"remark\":\"测试员\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":2,\"userName\":\"ry\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-09 13:30:19', 17);
INSERT INTO `sys_oper_log` VALUES (191, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-21 20:04:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,2000,2001,2008,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-09 13:30:47', 14);
INSERT INTO `sys_oper_log` VALUES (192, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-21 20:04:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,2000,2001,2008,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-09 13:30:57', 11);
INSERT INTO `sys_oper_log` VALUES (193, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/errand/index\",\"createTime\":\"2025-10-08 19:47:31\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2008,\"menuName\":\"跑腿大厅\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"errand\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-09 13:32:19', 12);
INSERT INTO `sys_oper_log` VALUES (194, '跑腿订单', 2, 'com.ruoyi.campus.controller.CampusErrandOrderController.takeOrder()', 'PUT', 1, 'admin', '研发部门', '/campus/errand/take/1', '127.0.0.1', '内网IP', '1', NULL, 1, '不能接自己发布的任务哦', '2025-10-09 13:32:24', 1);
INSERT INTO `sys_oper_log` VALUES (195, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-21 20:04:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,2008,1,2002,2003,2004,2005,2006,2007,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-09 13:35:25', 13);
INSERT INTO `sys_oper_log` VALUES (196, '跑腿订单', 2, 'com.ruoyi.campus.controller.CampusErrandOrderController.takeOrder()', 'PUT', 1, 'ry', '测试部门', '/campus/errand/take/1', '127.0.0.1', '内网IP', '1', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-09 13:35:49', 10);
INSERT INTO `sys_oper_log` VALUES (197, '跑腿订单', 1, 'com.ruoyi.campus.controller.CampusErrandOrderController.add()', 'POST', 1, 'ry', '测试部门', '/campus/errand', '127.0.0.1', '内网IP', '{\"createBy\":\"ry\",\"createTime\":\"2025-10-09 13:36:03\",\"deliveryAddress\":\"11\",\"detail\":\"11\",\"orderId\":2,\"orderType\":\"快递代取\",\"params\":{},\"publisherId\":2,\"reward\":5,\"title\":\"test\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-09 13:36:03', 11);
INSERT INTO `sys_oper_log` VALUES (198, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/profile/my-errands\",\"createBy\":\"admin\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"我的跑腿\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"my-errands\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-09 15:11:07', 25);
INSERT INTO `sys_oper_log` VALUES (199, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/profile/my-errands\",\"createTime\":\"2025-10-09 15:11:07\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2009,\"menuName\":\"我的跑腿\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"my-errands\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-09 15:13:15', 15);
INSERT INTO `sys_oper_log` VALUES (200, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/profile/index\",\"createBy\":\"admin\",\"icon\":\"international\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"我的圈子\",\"menuType\":\"C\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"my-circle\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-09 15:54:14', 108);
INSERT INTO `sys_oper_log` VALUES (201, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/profile/index\",\"createTime\":\"2025-10-09 15:54:14\",\"icon\":\"international\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2010,\"menuName\":\"我的圈子\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"my-circle\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-09 15:55:04', 16);
INSERT INTO `sys_oper_log` VALUES (202, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/errand/index\",\"createTime\":\"2025-10-08 19:47:31\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2008,\"menuName\":\"跑腿大厅\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"errand\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-09 15:55:18', 8);
INSERT INTO `sys_oper_log` VALUES (203, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/profile/my-errands\",\"createTime\":\"2025-10-09 15:11:07\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2009,\"menuName\":\"我的跑腿\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"my-errands\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-09 15:55:40', 22);
INSERT INTO `sys_oper_log` VALUES (204, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"campus/profile/my-errands\",\"createTime\":\"2025-10-09 15:11:07\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2009,\"menuName\":\"我的跑腿\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"my-errands\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-09 15:56:12', 13);
INSERT INTO `sys_oper_log` VALUES (205, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-09-21 20:04:51\",\"icon\":\"system\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1,\"menuName\":\"系统管理\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-09 15:56:33', 13);
INSERT INTO `sys_oper_log` VALUES (206, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-09-21 20:04:51\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"系统监控\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"monitor\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-09 15:56:43', 17);
INSERT INTO `sys_oper_log` VALUES (207, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-09-21 20:04:51\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-09 15:57:32', 6);
INSERT INTO `sys_oper_log` VALUES (208, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '127.0.0.1', '内网IP', '4', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2025-10-09 15:57:55', 10);
INSERT INTO `sys_oper_log` VALUES (209, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-09-21 20:04:51\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":7,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-09 15:58:06', 7);
INSERT INTO `sys_oper_log` VALUES (210, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-21 20:04:51\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2000,2001,2010,2008,2009,1,2002,2003,2004,2005,2006,2007,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-10 16:33:28', 37);
INSERT INTO `sys_oper_log` VALUES (211, '跑腿订单', 1, 'com.ruoyi.campus.controller.CampusErrandOrderController.add()', 'POST', 1, 'admin', '研发部门', '/campus/errand', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-10-10 17:48:37\",\"detail\":\"s\",\"orderType\":\"校园跑腿\",\"params\":{},\"publisherId\":1,\"reward\":10,\"title\":\"s\"}', NULL, 1, 'Invalid bound statement (not found): com.ruoyi.campus.mapper.CampusErrandOrderMapper.insertCampusErrandOrder', '2025-10-10 17:48:37', 9);
INSERT INTO `sys_oper_log` VALUES (212, '跑腿订单', 1, 'com.ruoyi.campus.controller.CampusErrandOrderController.add()', 'POST', 1, 'admin', '研发部门', '/campus/errand', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-10-10 17:48:40\",\"detail\":\"s\",\"orderType\":\"校园跑腿\",\"params\":{},\"publisherId\":1,\"reward\":10,\"title\":\"s\"}', NULL, 1, 'Invalid bound statement (not found): com.ruoyi.campus.mapper.CampusErrandOrderMapper.insertCampusErrandOrder', '2025-10-10 17:48:40', 1);
INSERT INTO `sys_oper_log` VALUES (213, '跑腿订单', 1, 'com.ruoyi.campus.controller.CampusErrandOrderController.add()', 'POST', 1, 'admin', '研发部门', '/campus/errand', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-10-10 17:51:10\",\"deliveryAddress\":\"s\",\"detail\":\"s\",\"orderId\":3,\"orderType\":\"外卖代拿\",\"params\":{},\"publisherId\":1,\"reward\":5,\"title\":\"s\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-10 17:51:10', 18);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
                             `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
                             `post_code` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '岗位编码',
                             `post_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '岗位名称',
                             `post_sort` int NOT NULL COMMENT '显示顺序',
                             `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
                             `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
                             `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                             `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
                             `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                             `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
                             PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2025-09-21 20:04:51', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2025-09-21 20:04:51', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
                             `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
                             `role_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色名称',
                             `role_key` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色权限字符串',
                             `role_sort` int NOT NULL COMMENT '显示顺序',
                             `data_scope` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
                             `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
                             `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
                             `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
                             `del_flag` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                             `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
                             `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                             `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
                             `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                             `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
                             PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-09-21 20:04:51', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2025-09-21 20:04:51', 'admin', '2025-10-10 16:33:28', '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
                                  `role_id` bigint NOT NULL COMMENT '角色ID',
                                  `dept_id` bigint NOT NULL COMMENT '部门ID',
                                  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
                                  `role_id` bigint NOT NULL COMMENT '角色ID',
                                  `menu_id` bigint NOT NULL COMMENT '菜单ID',
                                  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);
INSERT INTO `sys_role_menu` VALUES (2, 2000);
INSERT INTO `sys_role_menu` VALUES (2, 2001);
INSERT INTO `sys_role_menu` VALUES (2, 2002);
INSERT INTO `sys_role_menu` VALUES (2, 2003);
INSERT INTO `sys_role_menu` VALUES (2, 2004);
INSERT INTO `sys_role_menu` VALUES (2, 2005);
INSERT INTO `sys_role_menu` VALUES (2, 2006);
INSERT INTO `sys_role_menu` VALUES (2, 2007);
INSERT INTO `sys_role_menu` VALUES (2, 2008);
INSERT INTO `sys_role_menu` VALUES (2, 2009);
INSERT INTO `sys_role_menu` VALUES (2, 2010);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
                             `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
                             `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
                             `user_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户账号',
                             `nick_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户昵称',
                             `user_type` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
                             `email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
                             `phonenumber` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '手机号码',
                             `sex` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
                             `avatar` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '头像地址',
                             `password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '密码',
                             `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
                             `del_flag` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                             `login_ip` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
                             `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
                             `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
                             `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
                             `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                             `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
                             `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                             `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
                             PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', 'stan', '00', 'trzrzzh@icloud.com', '15257942123', '0', '/profile/avatar/2025/09/21/f5748c03e0e4452887ac214017fe6a7d.jpg', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-10-10 17:47:30', '2025-09-21 20:04:51', 'admin', '2025-09-21 20:04:51', '', '2025-09-21 22:22:25', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', 'ry', '00', 'ry@qq.com', '15666666666', '1', '/profile/avatar/2025/09/22/2cd6efbe672645258a4eac4cea69e045.JPG', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-10-10 16:34:29', '2025-09-21 20:04:51', 'admin', '2025-09-21 20:04:51', 'admin', '2025-10-09 13:30:19', '测试员');
INSERT INTO `sys_user` VALUES (100, 100, 'stany', 'stany', '00', '3403368487@qq.com', '', '0', '/profile/avatar/2025/09/21/0b6194a629154a9aad6c1687e253f53a.JPG', '$2a$10$oed/BoxvGYRe69eCf0zZKOZGgY4iKtev2ODIHu3RoZESOPTvOfJxe', '0', '0', '127.0.0.1', '2025-09-21 22:19:17', NULL, 'admin', '2025-09-21 21:29:53', '', '2025-09-21 21:30:41', NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
                                  `user_id` bigint NOT NULL COMMENT '用户ID',
                                  `post_id` bigint NOT NULL COMMENT '岗位ID',
                                  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
                                  `user_id` bigint NOT NULL COMMENT '用户ID',
                                  `role_id` bigint NOT NULL COMMENT '角色ID',
                                  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (100, 2);

SET FOREIGN_KEY_CHECKS = 1;
