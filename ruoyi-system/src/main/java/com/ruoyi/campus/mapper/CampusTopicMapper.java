package com.ruoyi.campus.mapper;

import java.util.List;
import com.ruoyi.campus.domain.CampusTopic;
import com.ruoyi.campus.domain.CampusTopicComment;
import com.ruoyi.campus.domain.CampusTopicFavorite;
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

    /**
     * 查询我点赞的话题
     * @param userId 用户ID
     * @return 话题列表
     */
    public List<CampusTopic> selectMyLikedTopics(@Param("userId") Long userId);

    /**
     * 查询我评论过的话题
     * @param userId 用户ID
     * @return 话题列表
     */
    public List<CampusTopic> selectMyCommentedTopics(@Param("userId") Long userId);

    // --- 【新增】收藏相关 ---
    /**
     * 根据话题ID和用户ID查询收藏记录
     * @param topicId 话题ID
     * @param userId 用户ID
     * @return 收藏实体
     */
    CampusTopicFavorite findFavoriteByTopicIdAndUserId(@Param("topicId") Long topicId, @Param("userId") Long userId);

    /**
     * 新增收藏
     * @param topicId 话题ID
     * @param userId 用户ID
     * @return 结果
     */
    int insertFavorite(@Param("topicId") Long topicId, @Param("userId") Long userId);

    /**
     * 删除收藏
     * @param topicId 话题ID
     * @param userId 用户ID
     * @return 结果
     */
    int deleteFavorite(@Param("topicId") Long topicId, @Param("userId") Long userId);

    /**
     * 查询我收藏的话题列表
     * @param userId 用户ID
     * @return 话题列表
     */
    List<CampusTopic> selectMyFavoriteTopics(@Param("userId") Long userId);
}
