package com.ruoyi.system.service.impl;

import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.system.service.IChatService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

/**
 * 智能助手服务实现类
 */
@Service
public class ChatServiceImpl implements IChatService {

    private final RestTemplate restTemplate = new RestTemplate();

    @Value("${dify.api.url}")
    private String difyApiUrl;

    @Value("${dify.api.key}")
    private String difyApiKey;

    @Override
    public String sendMessageToDify(String message) {
        // 构建请求头
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + difyApiKey);

        // 构建请求体，将模式改为 blocking 并添加 inputs 字段
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("query", message);
        requestBody.put("inputs", new HashMap<String, Object>()); // 添加inputs字段
        requestBody.put("response_mode", "blocking");
        requestBody.put("user", "user_123");

        HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<>(requestBody, headers);

        try {
            ResponseEntity<String> response = restTemplate.exchange(
                    difyApiUrl + "/chat-messages",
                    HttpMethod.POST,
                    requestEntity,
                    String.class);

            // 解析返回的 JSON 响应
            JSONObject jsonObject = JSONObject.parseObject(response.getBody());
            // 根据 Dify 文档，阻塞模式下回复在 answer 字段中
            return jsonObject.getString("answer");

        } catch (Exception e) {
            e.printStackTrace();
            return "抱歉，调用Dify API时发生错误。";
        }
    }
}