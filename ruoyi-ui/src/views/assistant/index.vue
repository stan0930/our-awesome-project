<template>
  <div class="app-container chat-container">
    <div class="chat-header">
      <span class="title">校园智能助手 (Agent)</span>
      <el-tag size="mini" type="success" effect="dark">Online</el-tag>
    </div>

    <div class="chat-box" ref="scrollRef">
      <div v-for="(msg, index) in messageList" :key="index" class="message-item" :class="msg.role">

        <div class="avatar" :class="msg.role">
          <img v-if="msg.role === 'user'" src="@/assets/images/profile.jpg" />
          <img v-else src="@/assets/logo/logo.png" />
        </div>

        <div class="content-wrapper">
          <div class="name">{{ msg.role === 'user' ? '我' : 'AI 校园助手' }}</div>

          <div class="bubble">
            <div v-if="msg.thought && msg.thought.length > 0" class="agent-thought">
              <el-collapse>
                <el-collapse-item name="1">
                  <template slot="title">
                    <i class="el-icon-cpu"></i>
                    <span class="thought-title">{{ msg.thinking ? '正在深度思考...' : '思考过程已完成' }}</span>
                    <i v-if="msg.thinking" class="el-icon-loading"></i>
                  </template>
                  <div class="thought-content">
                    <div v-for="(t, tIndex) in msg.thought" :key="tIndex" class="thought-step">
                      <span class="step-label">[推理]</span> {{ t }}
                    </div>
                  </div>
                </el-collapse-item>
              </el-collapse>
            </div>

            <div v-if="msg.content" class="markdown-body" v-html="renderMarkdown(msg.content)"></div>
            <div v-else-if="!msg.thought || msg.thought.length === 0" class="typing-indicator">
              <span></span><span></span><span></span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="input-area">
      <el-input
        type="textarea"
        :rows="3"
        placeholder="请输入您的问题，例如：查询我的期末成绩..."
        v-model="inputMessage"
        @keyup.enter.native="handleSend"
        :disabled="loading"
      ></el-input>
      <div class="btn-group">
        <el-button type="primary" icon="el-icon-s-promotion" @click="handleSend" :loading="loading">发送</el-button>
      </div>
    </div>
  </div>
</template>

<script>
import { getToken } from '@/utils/auth'
import MarkdownIt from 'markdown-it' // 如果没安装，请把这行和下面的 md 变量初始化注释掉

export default {
  name: "AssistantChat",
  data() {
    return {
      inputMessage: "",
      loading: false,
      messageList: [
        {
          role: "assistant",
          content: "你好！我是你的校园智能助手。我可以帮你查询成绩、课表，或者解答校园生活问题。",
          thought: []
        }
      ],
      // 初始化 Markdown 解析器
      md: new MarkdownIt({
        html: true,
        linkify: true,
        typographer: true
      })
    };
  },
  methods: {
    // 渲染 Markdown，如果没有安装库则直接显示文本
    renderMarkdown(text) {
      if (this.md) {
        return this.md.render(text);
      }
      return text.replace(/\n/g, '<br>');
    },

    async handleSend() {
      if (!this.inputMessage.trim()) return;

      const userMsg = this.inputMessage;
      this.inputMessage = ""; // 清空输入框
      this.loading = true;

      // 1. 添加用户消息
      this.messageList.push({
        role: "user",
        content: userMsg,
        thought: []
      });

      // 2. 添加 AI 占位消息 (用于流式更新)
      const aiMsgIndex = this.messageList.push({
        role: "assistant",
        content: "",
        thought: [],
        thinking: true // 标记正在思考
      }) - 1;

      this.scrollToBottom();

      // 3. 发起原生 Fetch 流式请求 (绕过 axios 拦截器)
      try {
        const response = await fetch(process.env.VUE_APP_BASE_API + "/chat/send-stream", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer " + getToken() // 携带 RuoYi Token
          },
          body: JSON.stringify({ message: userMsg })
        });

        if (!response.ok) {
          throw new Error("Network response was not ok");
        }

        const reader = response.body.getReader();
        const decoder = new TextDecoder("utf-8");
        let buffer = "";

        // 4. 循环读取流
        while (true) {
          const { done, value } = await reader.read();
          if (done) break;

          buffer += decoder.decode(value, { stream: true });

          // 处理 SSE 格式数据 (event: name \n data: content \n\n)
          const lines = buffer.split("\n\n");
          buffer = lines.pop(); // 保留最后一个可能不完整的包

          for (const line of lines) {
            this.parseSSELine(line, this.messageList[aiMsgIndex]);
          }
          this.scrollToBottom();
        }

        // 结束状态
        this.messageList[aiMsgIndex].thinking = false;
        this.loading = false;

      } catch (error) {
        this.messageList[aiMsgIndex].content += "\n[连接中断，请重试]";
        this.messageList[aiMsgIndex].thinking = false;
        this.loading = false;
      }
    },

    // 解析 SSE 数据行
    parseSSELine(line, currentMsg) {
      if (!line.trim()) return;

      // 简单解析 event 和 data
      const eventMatch = line.match(/event:(.*?)\n/);
      const dataMatch = line.match(/data:(.*)/s); // s flag allow dot to match newline if needed

      if (eventMatch && dataMatch) {
        const event = eventMatch[1].trim();
        const data = dataMatch[1].trim();

        if (event === "message") {
          // 累加回复内容
          currentMsg.content += data;
        } else if (event === "thought") {
          // 解析思考过程 JSON
          try {
            const thoughtObj = JSON.parse(data);
            // Dify 返回的 thought 通常在 thought 字段或 observation 字段
            const thoughtText = thoughtObj.thought || thoughtObj.observation || thoughtObj.tool_input || "Processing...";
            if(thoughtText && thoughtText !== 'null') {
              currentMsg.thought.push(thoughtText);
            }
          } catch (e) {
            // ignore json error
          }
        } else if (event === "error") {
          currentMsg.content += ` [错误: ${data}]`;
        }
      }
    },

    scrollToBottom() {
      this.$nextTick(() => {
        const box = this.$refs.scrollRef;
        box.scrollTop = box.scrollHeight;
      });
    }
  }
};
</script>

<style scoped lang="scss">
.chat-container {
  display: flex;
  flex-direction: column;
  height: calc(100vh - 84px); // 减去 navbar 高度
  background-color: #f0f2f5;
  padding: 0 !important;
}

.chat-header {
  background: #fff;
  padding: 15px 20px;
  border-bottom: 1px solid #e6e6e6;
  display: flex;
  align-items: center;
  justify-content: space-between;
  box-shadow: 0 1px 4px rgba(0,0,0,0.05);

  .title {
    font-size: 16px;
    font-weight: 600;
    color: #333;
  }
}

.chat-box {
  flex: 1;
  overflow-y: auto;
  padding: 20px;

  .message-item {
    display: flex;
    margin-bottom: 20px;

    &.user {
      flex-direction: row-reverse;
      .content-wrapper {
        align-items: flex-end;
        .bubble {
          background-color: #1890ff; // RuoYi 蓝色主题
          color: #fff;
          border-top-right-radius: 2px;
        }
      }
      .avatar {
        margin-left: 10px;
        margin-right: 0;
      }
    }

    &.assistant {
      .content-wrapper {
        align-items: flex-start;
        .bubble {
          background-color: #fff;
          color: #333;
          border-top-left-radius: 2px;
          border: 1px solid #e6e6e6;
        }
      }
    }
  }

  .avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    overflow: hidden;
    margin-right: 10px;
    flex-shrink: 0;
    background: #fff;
    img {
      width: 100%;
      height: 100%;
    }
  }

  .content-wrapper {
    display: flex;
    flex-direction: column;
    max-width: 80%;

    .name {
      font-size: 12px;
      color: #999;
      margin-bottom: 4px;
    }

    .bubble {
      padding: 10px 15px;
      border-radius: 8px;
      font-size: 14px;
      line-height: 1.6;
      position: relative;
      min-height: 40px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      word-break: break-word;

      /* Markdown 样式调整 */
      ::v-deep p {
        margin: 5px 0;
      }
      ::v-deep pre {
        background: #f4f4f5;
        padding: 10px;
        border-radius: 4px;
        overflow-x: auto;
      }
      ::v-deep code {
        font-family: Consolas, Monaco, 'Andale Mono', 'Ubuntu Mono', monospace;
      }
    }
  }
}

/* 思维链样式 */
.agent-thought {
  margin-bottom: 10px;
  border-bottom: 1px solid #eee;
  padding-bottom: 5px;

  ::v-deep .el-collapse {
    border: none;
  }
  ::v-deep .el-collapse-item__header {
    height: 30px;
    line-height: 30px;
    background: #f9f9f9;
    border-radius: 4px;
    padding: 0 10px;
    font-size: 12px;
    color: #909399;
    border: none;
  }
  ::v-deep .el-collapse-item__content {
    padding: 10px;
    background: #fcfcfc;
    font-size: 12px;
    color: #666;
  }

  .thought-title {
    margin-left: 5px;
    margin-right: 5px;
  }

  .thought-step {
    margin-bottom: 5px;
    font-family: monospace;
    .step-label {
      color: #e6a23c; // 橙色
      font-weight: bold;
    }
  }
}

/* 打字机光标动画 */
.typing-indicator {
  display: inline-block;
  span {
    display: inline-block;
    width: 6px;
    height: 6px;
    background-color: #ccc;
    border-radius: 50%;
    margin: 0 2px;
    animation: typing 1.4s infinite ease-in-out both;
    &:nth-child(1) { animation-delay: -0.32s; }
    &:nth-child(2) { animation-delay: -0.16s; }
  }
}

@keyframes typing {
  0%, 80%, 100% { transform: scale(0); }
  40% { transform: scale(1); }
}

.input-area {
  background: #fff;
  padding: 15px 20px;
  border-top: 1px solid #e6e6e6;
  display: flex;
  flex-direction: column;

  .btn-group {
    margin-top: 10px;
    text-align: right;
  }
}
</style>
