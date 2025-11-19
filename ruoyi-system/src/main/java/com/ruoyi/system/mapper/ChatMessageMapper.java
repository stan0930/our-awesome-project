package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.ChatMessage;
import java.util.List;

/**
 * 聊天消息 Mapper 接口
 */
public interface ChatMessageMapper {
    /**
     * 新增聊天消息
     * * @param chatMessage 消息信息
     * @return 结果
     */
    public int insertChatMessage(ChatMessage chatMessage);

    /**
     * 查询最近的聊天记录
     * * @param createBy 创建者（用户）
     * @param limit 条数限制
     * @return 聊天消息集合
     */
    public List<ChatMessage> selectRecentChatMessages(String createBy, int limit);
}