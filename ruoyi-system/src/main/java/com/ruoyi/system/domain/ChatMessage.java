package com.ruoyi.system.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 聊天消息实体类
 */
public class ChatMessage extends BaseEntity {
    private static final long serialVersionUID = 1L;

    //消息ID
    private Long messageId;
    /**
     * 消息内容
     */
    private String content;

    /**
     * 角色：user 或 assistant
     */
    private String role;

    public ChatMessage() {
    }

    public ChatMessage(String content, String role) {
        this.content = content;
        this.role = role;
    }

    public Long getMessageId() {
        return messageId;
    }
    public void setMessageId(Long messageId) {
        this.messageId = messageId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("messageId", getMessageId())
                .append("content", getContent())
                .append("role", getRole())
                .append("createTime", getCreateTime())
                .toString();
    }
}