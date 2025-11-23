package com.ruoyi.campus.service;

import java.util.List;
import com.ruoyi.campus.domain.CampusTopic;
import com.ruoyi.campus.domain.CampusTopicComment;

public interface ICampusTopicService
{
    public CampusTopic selectCampusTopicByTopicId(Long topicId);
    public List<CampusTopic> selectCampusTopicList(CampusTopic campusTopic);
    public int insertCampusTopic(CampusTopic campusTopic);
    public int updateCampusTopic(CampusTopic campusTopic, Long userId);
    public int deleteCampusTopicByTopicIds(Long[] topicIds, Long userId);
    public int deleteCampusTopicByTopicId(Long topicId, Long userId);
    public List<CampusTopicComment> selectCommentsByTopicId(Long topicId);
    public boolean toggleLike(Long topicId, Long userId);
    public int insertComment(CampusTopicComment comment);

    // --- 【新增】查询“我的”相关列表的方法声明 ---
    /**
     * 查询我点赞的话题
     * @param userId 用户ID
     * @return 话题列表
     */
    public List<CampusTopic> selectMyLikedTopics(Long userId);

    /**
     * 查询我评论过的话题
     * @param userId 用户ID
     * @return 话题列表
     */
    public List<CampusTopic> selectMyCommentedTopics(Long userId);

    /**
     * 【新增】查询我发布的话题
     * @param campusTopic 查询参数，包含 userId
     * @return 话题列表
     */
    public List<CampusTopic> selectMyCampusTopicList(CampusTopic campusTopic);
    // --- 【新增结束】 ---
    // --- 【新增】收藏相关 ---
    boolean toggleFavorite(Long topicId, Long userId);
    List<CampusTopic> selectMyFavoriteTopics(Long userId);
}
