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
    @Override
    public boolean toggleLike(Long topicId, Long userId) {
        CampusTopicLike like = campusTopicMapper.findLikeByTopicIdAndUserId(topicId, userId);
        if (like == null) {
            campusTopicMapper.insertLike(topicId, userId);
            return true;
        } else {
            campusTopicMapper.deleteLike(topicId, userId);
            return false;
        }
    }
    @Override
    public int insertComment(CampusTopicComment comment) {
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
    @Override
    public boolean toggleFavorite(Long topicId, Long userId) {
        CampusTopicFavorite favorite = campusTopicMapper.findFavoriteByTopicIdAndUserId(topicId, userId);
        if (favorite == null) {
            campusTopicMapper.insertFavorite(topicId, userId);
            return true; // 返回true表示已收藏
        } else {
            campusTopicMapper.deleteFavorite(topicId, userId);
            return false; // 返回false表示未收藏
        }
    }

    @Override
    public List<CampusTopic> selectMyFavoriteTopics(Long userId) {
        return campusTopicMapper.selectMyFavoriteTopics(userId);
    }
}
