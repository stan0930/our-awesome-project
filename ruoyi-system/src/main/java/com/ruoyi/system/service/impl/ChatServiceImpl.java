package com.ruoyi.system.service.impl;

import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.ChatMessage;
import com.ruoyi.system.mapper.ChatMessageMapper;
import com.ruoyi.system.service.IChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 智能助手服务实现类
 */
@Service
public class ChatServiceImpl implements IChatService {

    @Autowired
    private ChatMessageMapper chatMessageMapper;

    private final RestTemplate restTemplate = new RestTemplate();

    @Value("${dify.api.url}")
    private String difyApiUrl;

    @Value("${dify.api.key}")
    private String difyApiKey;

    @Override
    public String sendMessageToDify(String message) {
        // 获取当前登录用户名，如果没有登录则使用默认值
        String username = "anonymous";
        try {
            username = SecurityUtils.getUsername();
        } catch (Exception e) {
            // 忽略未登录异常
        }

        // 1. 持久化用户发送的消息
        ChatMessage userMsg = new ChatMessage();
        userMsg.setContent(message);
        userMsg.setRole("user");
        userMsg.setCreateBy(username);
        userMsg.setCreateTime(DateUtils.getNowDate());
        chatMessageMapper.insertChatMessage(userMsg);

        // 构建API请求
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + difyApiKey);

        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("query", message);
        requestBody.put("inputs", new HashMap<String, Object>());
        requestBody.put("response_mode", "blocking");
        requestBody.put("user", username);

        HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<>(requestBody, headers);

        try {
            ResponseEntity<String> response = restTemplate.exchange(
                    difyApiUrl + "/chat-messages",
                    HttpMethod.POST,
                    requestEntity,
                    String.class);

            JSONObject jsonObject = JSONObject.parseObject(response.getBody());
            String answer = jsonObject.getString("answer");

            // 2. 持久化 AI 回复的消息
            ChatMessage aiMsg = new ChatMessage();
            aiMsg.setContent(answer);
            aiMsg.setRole("assistant");
            aiMsg.setCreateBy(username);
            aiMsg.setCreateTime(DateUtils.getNowDate());
            chatMessageMapper.insertChatMessage(aiMsg);

            return answer;

        } catch (Exception e) {
            e.printStackTrace();
            return "抱歉，调用Dify API时发生错误。";
        }
    }

    @Override
    public List<ChatMessage> getRecentHistory() {
        String username = "anonymous";
        try {
            username = SecurityUtils.getUsername();
        } catch (Exception e) {
        }
        // 获取最近的10条记录
        return chatMessageMapper.selectRecentChatMessages(username, 10);
    }
}