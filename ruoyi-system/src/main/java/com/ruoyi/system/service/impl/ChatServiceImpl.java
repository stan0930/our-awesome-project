package com.ruoyi.system.service.impl;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.ChatMessage;
import com.ruoyi.system.mapper.ChatMessageMapper;
import com.ruoyi.system.service.IChatService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;

/**
 * 智能助手服务实现类 (Java 8 兼容 / 修复Final变量问题版)
 */
@Service
public class ChatServiceImpl implements IChatService {

    private static final Logger log = LoggerFactory.getLogger(ChatServiceImpl.class);

    @Autowired
    private ChatMessageMapper chatMessageMapper;

    @Value("${dify.api.url}")
    private String difyApiUrl;

    @Value("${dify.api.key}")
    private String difyApiKey;

    /**
     * 流式发送消息实现
     */
    @Override
    public void streamMessage(String message, SseEmitter emitter) {
        // 1. 获取上下文信息 (局部变量初始化)
        String tempUsername = "anonymous";
        Long tempUserId = 0L;
        String tempNickName = "访客";
        String tempDeptName = "无";

        try {
            LoginUser loginUser = SecurityUtils.getLoginUser();
            if (loginUser != null) {
                tempUsername = loginUser.getUsername();
                tempUserId = loginUser.getUserId();
                SysUser user = loginUser.getUser();
                if (user != null) {
                    tempNickName = user.getNickName();
                    if (user.getDept() != null) {
                        tempDeptName = user.getDept().getDeptName();
                    }
                }
            }
        } catch (Exception e) {
            // 忽略未登录异常
        }

        // 关键修复点：定义 Final 变量供 Lambda 使用
        // 这些变量被赋值后不会再改变，符合 effectively final 原则
        final String finalUsername = tempUsername;
        final Long finalUserId = tempUserId;
        final String finalNickName = tempNickName;
        final String finalDeptName = tempDeptName;

        // 2. 持久化用户发送的消息
        ChatMessage userMsg = new ChatMessage();
        userMsg.setContent(message);
        userMsg.setRole("user");
        userMsg.setCreateBy(finalUsername);
        userMsg.setCreateTime(DateUtils.getNowDate());
        chatMessageMapper.insertChatMessage(userMsg);

        // 3. 异步执行 Dify 请求
        CompletableFuture.runAsync(() -> {
            StringBuilder fullAnswer = new StringBuilder();
            HttpURLConnection connection = null;

            try {
                // 构建请求体 (使用上面定义的 final 变量)
                Map<String, Object> inputs = new HashMap<>();
                inputs.put("user_name", finalNickName);
                inputs.put("dept_name", finalDeptName);

                Map<String, Object> requestBody = new HashMap<>();
                requestBody.put("query", message);
                requestBody.put("inputs", inputs);
                requestBody.put("response_mode", "streaming");
                requestBody.put("user", String.valueOf(finalUserId));

                String jsonBody = JSON.toJSONString(requestBody);

                // 建立连接
                URL url = new URL(difyApiUrl + "/chat-messages");
                connection = (HttpURLConnection) url.openConnection();
                connection.setRequestMethod("POST");
                connection.setRequestProperty("Authorization", "Bearer " + difyApiKey);
                connection.setRequestProperty("Content-Type", "application/json");
                connection.setRequestProperty("Accept", "text/event-stream");
                connection.setDoOutput(true);
                connection.setConnectTimeout(30000);
                connection.setReadTimeout(180000);

                // 发送数据
                try (OutputStream os = connection.getOutputStream()) {
                    byte[] input = jsonBody.getBytes(StandardCharsets.UTF_8);
                    os.write(input, 0, input.length);
                }

                // 读取流式响应
                int status = connection.getResponseCode();
                if (status == 200) {
                    try (BufferedReader reader = new BufferedReader(
                            new InputStreamReader(connection.getInputStream(), StandardCharsets.UTF_8))) {
                        String line;
                        while ((line = reader.readLine()) != null) {
                            if (line.startsWith("data: ")) {
                                String jsonStr = line.substring(6);
                                if ("[DONE]".equals(jsonStr.trim())) {
                                    break;
                                }

                                try {
                                    JSONObject json = JSON.parseObject(jsonStr);
                                    String event = json.getString("event");

                                    if ("message".equals(event) || "agent_message".equals(event)) {
                                        String answerChunk = json.getString("answer");
                                        fullAnswer.append(answerChunk);
                                        emitter.send(SseEmitter.event().name("message").data(answerChunk));
                                    } else if ("agent_thought".equals(event)) {
                                        emitter.send(SseEmitter.event().name("thought").data(json.toString()));
                                    } else if ("error".equals(event)) {
                                        emitter.send(SseEmitter.event().name("error").data(json.getString("message")));
                                    }
                                } catch (Exception ignored) {
                                }
                            }
                        }
                    }
                } else {
                    emitter.send(SseEmitter.event().name("error").data("Dify API Error: " + status));
                }

                // 4. 结束后持久化 AI 的完整回复
                if (fullAnswer.length() > 0) {
                    ChatMessage aiMsg = new ChatMessage();
                    aiMsg.setContent(fullAnswer.toString());
                    aiMsg.setRole("assistant");
                    aiMsg.setCreateBy(finalUsername);
                    aiMsg.setCreateTime(DateUtils.getNowDate());
                    chatMessageMapper.insertChatMessage(aiMsg);
                }

                emitter.complete();

            } catch (Exception e) {
                log.error("Dify流式请求异常", e);
                try {
                    emitter.send(SseEmitter.event().name("error").data("连接超时或中断"));
                    emitter.completeWithError(e);
                } catch (Exception ex) {
                    // ignore
                }
            } finally {
                if (connection != null) {
                    connection.disconnect();
                }
            }
        });
    }

    /**
     * 旧接口兼容
     */
    @Override
    public String sendMessageToDify(String message) {
        return "请使用流式接口 /chat/send-stream";
    }

    @Override
    public List<ChatMessage> getRecentHistory() {
        String username = "anonymous";
        try {
            username = SecurityUtils.getUsername();
        } catch (Exception e) {
        }
        return chatMessageMapper.selectRecentChatMessages(username, 20);
    }
}