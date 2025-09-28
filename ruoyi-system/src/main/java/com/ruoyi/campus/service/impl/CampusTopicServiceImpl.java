package com.ruoyi.campus.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.campus.mapper.CampusTopicMapper;
import com.ruoyi.campus.domain.CampusTopic;
import com.ruoyi.campus.domain.CampusTopicComment;
import com.ruoyi.campus.domain.CampusTopicLike;
import com.ruoyi.campus.service.ICampusTopicService;

/**
 * 校园话题Service业务层处理
 *
 * @author ruoyi
 */
@Service
public class CampusTopicServiceImpl implements ICampusTopicService
{
    @Autowired
    private CampusTopicMapper campusTopicMapper;

    @Override
    public CampusTopic selectCampusTopicByTopicId(Long topicId)
    {
        return campusTopicMapper.selectCampusTopicByTopicId(topicId);
    }

    @Override
    public List<CampusTopic> selectCampusTopicList(CampusTopic campusTopic)
    {
        return campusTopicMapper.selectCampusTopicList(campusTopic);
    }

    @Override
    public int insertCampusTopic(CampusTopic campusTopic)
    {
        campusTopic.setCreateTime(DateUtils.getNowDate());
        return campusTopicMapper.insertCampusTopic(campusTopic);
    }

    @Override
    public int updateCampusTopic(CampusTopic campusTopic)
    {
        campusTopic.setUpdateTime(DateUtils.getNowDate());
        return campusTopicMapper.updateCampusTopic(campusTopic);
    }

    @Override
    public int deleteCampusTopicByTopicIds(Long[] topicIds)
    {
        return campusTopicMapper.deleteCampusTopicByTopicIds(topicIds);
    }

    @Override
    public int deleteCampusTopicByTopicId(Long topicId)
    {
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
            // 如果没点过赞，就新增一条记录
            campusTopicMapper.insertLike(topicId, userId);
            return true; // 返回true代表操作后是“已点赞”状态
        } else {
            // 如果点过赞，就删除记录
            campusTopicMapper.deleteLike(topicId, userId);
            return false; // 返回false代表操作后是“未点赞”状态
        }
    }

    @Override
    public int insertComment(CampusTopicComment comment) {
        comment.setCreateTime(DateUtils.getNowDate());
        // 如果 parentId 为 null，则设置为 0，表示是主评论
        if (comment.getParentId() == null) {
            comment.setParentId(0L);
        }
        return campusTopicMapper.insertComment(comment);
    }
}
