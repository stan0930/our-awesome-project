-- 用户课程表
CREATE TABLE `schedule_course` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '课程ID',
  `user_id` BIGINT(20) NOT NULL COMMENT '用户ID',
  `day` TINYINT(4) NOT NULL COMMENT '星期几(1-7: 周一到周日)',
  `section` TINYINT(4) NOT NULL COMMENT '第几节课(1-12)',
  `name` VARCHAR(100) NOT NULL COMMENT '课程名称',
  `teacher` VARCHAR(50) DEFAULT NULL COMMENT '教师姓名',
  `location` VARCHAR(100) DEFAULT NULL COMMENT '上课地点',
  `color` VARCHAR(20) DEFAULT '#4CAF50' COMMENT '课程颜色',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_day_section` (`day`, `section`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户课程表';
