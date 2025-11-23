package com.ruoyi.web.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.system.domain.ChatMessage;
import com.ruoyi.system.service.IChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 智能助手接口
 */
@RestController
@RequestMapping("/chat")
public class ChatController extends BaseController {

    @Autowired
    private IChatService chatService;

    /**
     * 发送消息给智能助手
     *
     * @param message 用户消息
     * @return 智能助手回复
     */
    @PostMapping("/send")
    public AjaxResult sendMessage(@RequestBody String message) {
        String response = chatService.sendMessageToDify(message);
        return AjaxResult.success(response);
    }

    @GetMapping("/history")
    public AjaxResult getHistory() {
        List<ChatMessage> list = chatService.getRecentHistory();
        return AjaxResult.success(list);
    }
}