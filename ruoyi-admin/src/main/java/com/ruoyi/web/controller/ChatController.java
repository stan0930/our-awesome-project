package com.ruoyi.web.controller;

import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.system.domain.ChatMessage;
import com.ruoyi.system.service.IChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.List;

/**
 * 智能助手接口 (Agent版)
 */
@RestController
@RequestMapping("/chat")
public class ChatController extends BaseController {

    @Autowired
    private IChatService chatService;

    /**
     * 发送消息给智能助手 (流式响应)
     * 前端使用 EventSource 或 fetch 处理流
     *
     * @param body 包含 message 的 JSON
     * @return SSE 流
     */
    @PostMapping(value = "/send-stream", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public SseEmitter sendStream(@RequestBody String body) {
        // 解析前端传来的JSON，获取 message 字段
        // 兼容前端可能直接传字符串或传JSON对象的情况
        String message;
        try {
            JSONObject json = JSONObject.parseObject(body);
            message = json.getString("message"); // 假设前端传 { "message": "你好" }
            if (message == null) {
                message = body; // 降级处理
            }
        } catch (Exception e) {
            message = body;
        }

        // 设置超时时间为 3分钟 (Dify 推理可能较慢)
        SseEmitter emitter = new SseEmitter(180000L);

        // 注册回调防止内存泄漏
        emitter.onCompletion(() -> {
            // log.info("SSE连接结束");
        });
        emitter.onTimeout(() -> {
            emitter.complete();
            // log.info("SSE连接超时");
        });

        // 调用服务层
        chatService.streamMessage(message, emitter);

        return emitter;
    }

    /**
     * 获取历史记录
     */
    @GetMapping("/history")
    public AjaxResult getHistory() {
        List<ChatMessage> list = chatService.getRecentHistory();
        return AjaxResult.success(list);
    }
}