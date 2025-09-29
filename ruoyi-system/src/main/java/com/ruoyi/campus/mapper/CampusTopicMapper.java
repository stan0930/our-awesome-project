package com.ruoyi.campus.mapper;

import java.util.List;
import com.ruoyi.campus.domain.CampusTopic;
import com.ruoyi.campus.domain.CampusTopicComment;
import com.ruoyi.campus.domain.CampusTopicLike;
import org.apache.ibatis.annotations.Param;

public interface CampusTopicMapper
{
    public CampusTopic selectCampusTopicByTopicId(Long topicId);
    public List<CampusTopic> selectCampusTopicList(CampusTopic campusTopic);
    public int insertCampusTopic(CampusTopic campusTopic);
    public int updateCampusTopic(CampusTopic campusTopic);
    public int deleteCampusTopicByTopicId(Long topicId);
    public int deleteCampusTopicByTopicIds(Long[] topicIds);
    public List<CampusTopicComment> selectCommentsByTopicId(Long topicId);
    public CampusTopicLike findLikeByTopicIdAndUserId(@Param("topicId") Long topicId, @Param("userId") Long userId);
    public int insertLike(@Param("topicId") Long topicId, @Param("userId") Long userId);
    public int deleteLike(@Param("topicId") Long topicId, @Param("userId") Long userId);
    public int insertComment(CampusTopicComment comment);
}
