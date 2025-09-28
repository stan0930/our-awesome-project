package com.ruoyi.campus.mapper;

import java.util.List;
import com.ruoyi.campus.domain.CampusTopic;
import com.ruoyi.campus.domain.CampusTopicComment;
import com.ruoyi.campus.domain.CampusTopicLike;
import org.apache.ibatis.annotations.Param;

/**
 * 校园话题Mapper接口
 *
 * @author ruoyi
 */
public interface CampusTopicMapper
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
     * 删除校园话题
     */
    public int deleteCampusTopicByTopicId(Long topicId);

    /**
     * 批量删除校园话题
     */
    public int deleteCampusTopicByTopicIds(Long[] topicIds);

    /**
     * 根据话题ID查询评论列表
     */
    public List<CampusTopicComment> selectCommentsByTopicId(Long topicId);

    /**
     * 查询用户是否已点赞
     */
    public CampusTopicLike findLikeByTopicIdAndUserId(@Param("topicId") Long topicId, @Param("userId") Long userId);

    /**
     * 插入一条点赞记录
     */
    public int insertLike(@Param("topicId") Long topicId, @Param("userId") Long userId);

    /**
     * 删除一条点赞记录
     */
    public int deleteLike(@Param("topicId") Long topicId, @Param("userId") Long userId);
}
