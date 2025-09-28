package com.ruoyi.campus.domain;

import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 校园话题评论对象 campus_topic_comment
 *
 * @author ruoyi
 */
public class CampusTopicComment extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long commentId;
    private Long topicId;
    private Long userId;
    private Long parentId;
    private String content;

    // 用于接收关联查询的用户信息
    private String nickName;
    private String avatar;

    /** 被回复的用户昵称 */
    private String replyToNickName; // <-- 【新增这一行】

    // Getters and Setters
    public Long getCommentId() {
        return commentId;
    }
    public void setCommentId(Long commentId) {
        this.commentId = commentId;
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
    public Long getParentId() {
        return parentId;
    }
    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public String getNickName() {
        return nickName;
    }
    public void setNickName(String nickName) {
        this.nickName = nickName;
    }
    public String getAvatar() {
        return avatar;
    }
    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
    public String getReplyToNickName() {
        return replyToNickName;
    }
    public void setReplyToNickName(String replyToNickName) {
        this.replyToNickName = replyToNickName;
    }
}
