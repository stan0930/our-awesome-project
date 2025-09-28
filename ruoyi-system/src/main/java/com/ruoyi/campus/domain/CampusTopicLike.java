package com.ruoyi.campus.domain;

import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 话题点赞记录对象 campus_topic_like
 *
 * @author ruoyi
 */
public class CampusTopicLike extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long likeId;

    private Long topicId;

    private Long userId;

    public Long getLikeId() {
        return likeId;
    }

    public void setLikeId(Long likeId) {
        this.likeId = likeId;
    }

    public Long getTopicId() {
        return topicId;
    }

    public void setTopicId(Long topicId) {
        this.topicId = topicId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }
}
