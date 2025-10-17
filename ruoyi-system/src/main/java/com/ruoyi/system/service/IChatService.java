package com.ruoyi.system.service;

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
}