package com.ruoyi.campus.service;

import java.util.List;
import com.ruoyi.campus.domain.CampusTopic;
import com.ruoyi.campus.domain.CampusTopicComment;

public interface ICampusTopicService
{
    public CampusTopic selectCampusTopicByTopicId(Long topicId);
    public List<CampusTopic> selectCampusTopicList(CampusTopic campusTopic);
    public int insertCampusTopic(CampusTopic campusTopic);
    public int updateCampusTopic(CampusTopic campusTopic);
    public int deleteCampusTopicByTopicIds(Long[] topicIds);
    public int deleteCampusTopicByTopicId(Long topicId);
    public List<CampusTopicComment> selectCommentsByTopicId(Long topicId);
    public boolean toggleLike(Long topicId, Long userId);
    public int insertComment(CampusTopicComment comment);
}
