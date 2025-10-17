package com.ruoyi.system.domain;

import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 聊天消息实体类
 */
public class ChatMessage extends BaseEntity {
    private static final long serialVersionUID = 1L;

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
        return "ChatMessage{" +
                "content='" + content + '\'' +
                ", role='" + role + '\'' +
                '}';
    }
}