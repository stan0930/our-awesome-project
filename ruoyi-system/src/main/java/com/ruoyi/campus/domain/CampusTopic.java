package com.ruoyi.campus.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 校园话题对象 campus_topic
 *
 * @author stan
 * @date 2025-09-21
 */
public class CampusTopic extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 话题ID */
    private Long topicId;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** 话题内容 */
    @Excel(name = "话题内容")
    private String content;

    /** 图片链接(多张用逗号分隔) */
    @Excel(name = "图片链接(多张用逗号分隔)")
    private String imageUrls;

    /** 状态(0=正常, 1=停用) */
    @Excel(name = "状态(0=正常, 1=停用)")
    private String status;

    /** 删除标志(0=代表存在, 2=代表删除) */
    private String delFlag;

    public void setTopicId(Long topicId)
    {
        this.topicId = topicId;
    }

    public Long getTopicId()
    {
        return topicId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Long getUserId()
    {
        return userId;
    }

    public void setContent(String content)
    {
        this.content = content;
    }

    public String getContent()
    {
        return content;
    }

    public void setImageUrls(String imageUrls)
    {
        this.imageUrls = imageUrls;
    }

    public String getImageUrls()
    {
        return imageUrls;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getStatus()
    {
        return status;
    }

    public void setDelFlag(String delFlag)
    {
        this.delFlag = delFlag;
    }

    public String getDelFlag()
    {
        return delFlag;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("topicId", getTopicId())
            .append("userId", getUserId())
            .append("content", getContent())
            .append("imageUrls", getImageUrls())
            .append("status", getStatus())
            .append("delFlag", getDelFlag())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
    /** 用户昵称 */
    private String nickName;

    /** 用户头像 */
    private String avatar;

    // --- 在这里添加getter和setter ---
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
}
