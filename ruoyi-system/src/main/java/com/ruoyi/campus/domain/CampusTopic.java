package com.ruoyi.campus.domain;

import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 校园话题对象 campus_topic
 *
 * @author ruoyi
 */
public class CampusTopic extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long topicId;

    private Long userId;

    private String content;

    private String imageUrls;

    private String topicType;

    private String status;

    // --- 【关键新增】 我们在这里为 CampusTopic 添加自己的 delFlag ---
    /** 删除标志（0代表存在 2代表删除） */
    private String delFlag;

    // --- 以下是关联查询出的字段 ---

    /** 用户昵称 */
    private String nickName;

    /** 用户头像 */
    private String avatar;

    /** 点赞数 */
    private Integer likeCount;

    /** 当前登录用户是否已点赞 */
    private boolean liked;

    /** 【新增】当前登录用户是否已收藏 */
    private boolean favorited;

    // --- Getters and Setters ---

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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImageUrls() {
        return imageUrls;
    }

    public void setImageUrls(String imageUrls) {
        this.imageUrls = imageUrls;
    }

    public String getTopicType() {
        return topicType;
    }

    public void setTopicType(String topicType) {
        this.topicType = topicType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // --- 【关键新增】 delFlag 的 getter 和 setter ---
    public String getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag;
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

    public Integer getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(Integer likeCount) {
        this.likeCount = likeCount;
    }

    public boolean isLiked() {
        return liked;
    }

    public void setLiked(boolean liked) {
        this.liked = liked;
    }
    public boolean isFavorited() {
        return favorited;
    }

    public void setFavorited(boolean favorited) {
        this.favorited = favorited;
    }
}
