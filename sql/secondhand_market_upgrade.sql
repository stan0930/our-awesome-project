-- ========================================
-- 二手市场功能数据库升级脚本
-- 执行日期: 2025-11-28
-- ========================================

USE smart_campus;

-- ========================================
-- 1. 修改 campus_product 表，添加新字段
-- ========================================

-- 添加商品分类字段
ALTER TABLE `campus_product` 
ADD COLUMN `category` varchar(50) DEFAULT 'other' COMMENT '商品分类(digital=数码,book=图书,daily=生活用品,clothing=服饰,other=其他)' AFTER `description`;

-- 添加联系方式字段
ALTER TABLE `campus_product` 
ADD COLUMN `contact_info` varchar(200) DEFAULT '' COMMENT '联系方式(手机/微信等)' AFTER `price`;

-- 添加浏览次数字段
ALTER TABLE `campus_product` 
ADD COLUMN `view_count` int DEFAULT 0 COMMENT '浏览次数' AFTER `contact_info`;

-- ========================================
-- 2. 创建商品收藏表
-- ========================================

DROP TABLE IF EXISTS `campus_product_favorite`;
CREATE TABLE `campus_product_favorite` (
  `favorite_id` bigint NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `product_id` bigint NOT NULL COMMENT '商品ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `create_time` datetime DEFAULT NULL COMMENT '收藏时间',
  PRIMARY KEY (`favorite_id`),
  UNIQUE KEY `uk_user_product` (`user_id`,`product_id`),
  KEY `idx_product_id` (`product_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='商品收藏表';

-- ========================================
-- 3. 更新现有数据(如果有的话)
-- ========================================

-- 为现有商品设置默认分类为 'other'
UPDATE `campus_product` SET `category` = 'other' WHERE `category` IS NULL;

-- 为现有商品设置默认浏览次数为 0
UPDATE `campus_product` SET `view_count` = 0 WHERE `view_count` IS NULL;

-- ========================================
-- 执行完成
-- ========================================
