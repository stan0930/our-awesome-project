package com.ruoyi.campus.service.impl;

import java.util.List;

import com.ruoyi.campus.domain.CampusTopicFavorite;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.campus.mapper.CampusTopicMapper;
import com.ruoyi.campus.domain.CampusTopic;
import com.ruoyi.campus.domain.CampusTopicComment;
import com.ruoyi.campus.domain.CampusTopicLike;
import com.ruoyi.campus.service.ICampusTopicService;
import com.ruoyi.common.exception.ServiceException;
import org.springframework.dao.DuplicateKeyException; // 【修改】增加了这个 import

@Service
public class CampusTopicServiceImpl implements ICampusTopicService
{
    @Autowired
    private CampusTopicMapper campusTopicMapper;

    @Override
    public CampusTopic selectCampusTopicByTopicId(Long topicId) {
        return campusTopicMapper.selectCampusTopicByTopicId(topicId);
    }
    @Override
    public List<CampusTopic> selectCampusTopicList(CampusTopic campusTopic) {
        return campusTopicMapper.selectCampusTopicList(campusTopic);
    }
    @Override
    public int insertCampusTopic(CampusTopic campusTopic) {
        campusTopic.setCreateTime(DateUtils.getNowDate());
        return campusTopicMapper.insertCampusTopic(campusTopic);
    }
    @Override
    public int updateCampusTopic(CampusTopic campusTopic) {
        campusTopic.setUpdateTime(DateUtils.getNowDate());
        return campusTopicMapper.updateCampusTopic(campusTopic);
    }
    @Override
    public int deleteCampusTopicByTopicIds(Long[] topicIds) {
        return campusTopicMapper.deleteCampusTopicByTopicIds(topicIds);
    }
    @Override
    public int deleteCampusTopicByTopicId(Long topicId) {
        return campusTopicMapper.deleteCampusTopicByTopicId(topicId);
    }
    @Override
    public List<CampusTopicComment> selectCommentsByTopicId(Long topicId) {
        return campusTopicMapper.selectCommentsByTopicId(topicId);
    }

    /**
     * 【修改】切换点赞状态 - 修复并发问题
     *
     * @param topicId 话题ID
     * @param userId  用户ID
     * @return boolean true表示操作后为“已点赞”，false表示操作后为“未点赞”
     */
    @Override
    public boolean toggleLike(Long topicId, Long userId) {
        try {
            // 1. 尝试插入（点赞）
            campusTopicMapper.insertLike(topicId, userId);
            // 插入成功，说明之前未点赞，现在状态是“已点赞”
            return true;
        } catch (Exception e) {
            // 2. 检查是否为唯一键冲突
            //    (MyBatis或Spring会将底层的 SQLIntegrityConstraintViolationException 包装为 DuplicateKeyException)
            //    我们同时检查两种异常情况确保万无一失
            if (e instanceof DuplicateKeyException || e.getMessage().contains("Duplicate entry")) {
                // 3. 确实是冲突了，说明已经点赞了，现在执行删除（取消点赞）
                campusTopicMapper.deleteLike(topicId, userId);
                // 删除成功，现在状态是“未点赞”
                return false;
            } else {
                // 4. 如果是其他异常，则抛出
                throw new ServiceException("点赞操作失败: " + e.getMessage());
            }
        }
    }

    @Override
    public int insertComment(CampusTopicComment comment) {
        // 【修改】先查询主贴信息
        CampusTopic topic = campusTopicMapper.selectCampusTopicByTopicId(comment.getTopicId());
        if (topic == null) {
            throw new ServiceException("评论的话题不存在");
        }
        // 【修改】判断帖子是否禁止评论
        if ("1".equals(topic.getCommentEnabled())) {
            throw new ServiceException("该话题作者已关闭评论");
        }

        comment.setCreateTime(DateUtils.getNowDate());
        if (comment.getParentId() == null) {
            comment.setParentId(0L);
        }
        return campusTopicMapper.insertComment(comment);
    }

    // --- 【新增】查询“我的”相关列表的方法实现 ---
    @Override
    public List<CampusTopic> selectMyLikedTopics(Long userId) {
        return campusTopicMapper.selectMyLikedTopics(userId);
    }

    @Override
    public List<CampusTopic> selectMyCommentedTopics(Long userId) {
        return campusTopicMapper.selectMyCommentedTopics(userId);
    }
    // --- 【新增结束】 ---
    // ... 在文件末尾 } 之前 ...

    // --- 【新增】收藏相关 ---

    /**
     * 【修改】切换收藏状态 - 修复并发问题
     *
     * @param topicId 话题ID
     * @param userId  用户ID
     * @return boolean true表示操作后为“已收藏”，false表示操作后为“未收藏”
     */
    @Override
    public boolean toggleFavorite(Long topicId, Long userId) {
        try {
            // 1. 尝试插入（收藏）
            campusTopicMapper.insertFavorite(topicId, userId);
            // 插入成功，说明之前未收藏，现在状态是“已收藏”
            return true;
        } catch (Exception e) {
            // 2. 检查是否为唯一键冲突
            if (e instanceof DuplicateKeyException || e.getMessage().contains("Duplicate entry")) {
                // 3. 确实是冲突了，说明已经收藏了，现在执行删除（取消收藏）
                campusTopicMapper.deleteFavorite(topicId, userId);
                // 删除成功，现在状态是“未收藏”
                return false;
            } else {
                // 4. 如果是其他异常，则抛出
                throw new ServiceException("收藏操作失败: " + e.getMessage());
            }
        }
    }

    @Override
    public List<CampusTopic> selectMyFavoriteTopics(Long userId) {
        return campusTopicMapper.selectMyFavoriteTopics(userId);
    }
}
