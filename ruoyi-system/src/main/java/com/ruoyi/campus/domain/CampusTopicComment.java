package com.ruoyi.campus.domain;

import com.ruoyi.common.core.domain.BaseEntity;

public class CampusTopicComment extends BaseEntity
{
    private static final long serialVersionUID = 1L;
    private Long commentId;
    private Long topicId;
    private Long userId;
    private Long parentId;
    private String content;
    private String nickName;
    private String avatar;
    private String replyToNickName;

    // Getters and Setters ... (此处省略，请确保已添加所有字段的getter/setter)
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
