package com.ruoyi.system.service;

import com.ruoyi.system.domain.ChatMessage;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.List;

/**
 * 智能助手服务接口
 */
public interface IChatService {

    /**
     * 向Dify智能体发送消息并获取回复
     *
     * @param message 用户消息
     * @return 智能体回复
     */
    String sendMessageToDify(String message);

    /**
     * (新方法) 流式向Dify发送消息，并注入业务上下文
     *
     * @param message 用户消息
     * @param emitter SSE发射器，用于实时推送数据给前端
     */
    void streamMessage(String message, SseEmitter emitter);

    /**
     * 获取当前用户的最近聊天历史
     * * @return 消息列表
     */
    List<ChatMessage> getRecentHistory();
}