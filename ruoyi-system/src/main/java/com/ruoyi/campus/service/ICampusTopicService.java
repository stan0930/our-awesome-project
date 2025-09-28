package com.ruoyi.campus.service;

import java.util.List;
import com.ruoyi.campus.domain.CampusTopic;
import com.ruoyi.campus.domain.CampusTopicComment;

/**
 * 校园话题Service接口
 *
 * @author ruoyi
 */
public interface ICampusTopicService
{
    /**
     * 查询校园话题
     */
    public CampusTopic selectCampusTopicByTopicId(Long topicId);

    /**
     * 查询校园话题列表
     */
    public List<CampusTopic> selectCampusTopicList(CampusTopic campusTopic);

    /**
     * 新增校园话题
     */
    public int insertCampusTopic(CampusTopic campusTopic);

    /**
     * 修改校园话题
     */
    public int updateCampusTopic(CampusTopic campusTopic);

    /**
     * 批量删除校园话题
     */
    public int deleteCampusTopicByTopicIds(Long[] topicIds);

    /**
     * 删除校园话题信息
     */
    public int deleteCampusTopicByTopicId(Long topicId);

    /**
     * 查询评论列表
     */
    public List<CampusTopicComment> selectCommentsByTopicId(Long topicId);

    /**
     * 处理点赞/取消点赞的业务
     */
    public boolean toggleLike(Long topicId, Long userId);
    // ...
    /** 【新增】新增评论 */
    public int insertComment(CampusTopicComment comment);
}
