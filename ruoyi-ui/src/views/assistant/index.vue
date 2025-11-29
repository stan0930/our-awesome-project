<template>
  <div class="chat-container">
    <div class="message-list" ref="messageList">
      <div v-for="(message, index) in messages" :key="index" :class="['message-item', message.role]">
        <div class="content-wrapper">
          <div class="bubble">
            <p>{{ message.content }}</p>
          </div>
          <span class="time" v-if="message.createTime">{{ message.createTime }}</span>
        </div>
      </div>
    </div>

    <div class="input-area">
      <el-input
        v-model="inputMessage"
        @keyup.enter.native="sendMessage"
        placeholder="请输入消息..."
        :disabled="loading"
      ></el-input>
      <el-button type="primary" @click="sendMessage" :loading="loading">发送</el-button>
    </div>
  </div>
</template>

<script>
import { sendMessageToDify, getChatHistory } from "@/api/assistant/chat";
import { parseTime } from "@/utils/ruoyi"; // 引入若依自带的时间格式化工具

export default {
  name: "Chat",
  data() {
    return {
      inputMessage: '',
      messages: [],
      loading: false
    };
  },
  created() {
    this.loadHistory();
  },
  methods: {
    // 加载历史记录
    async loadHistory() {
      try {
        const response = await getChatHistory();
        if (response.data) {
          this.messages = response.data;
          this.scrollToBottom();
        }
      } catch (error) {
        console.error("加载历史记录失败:", error);
      }
    },

    // 发送消息
    async sendMessage() {
      const content = this.inputMessage.trim();
      if (!content) return;

      // 1. 立即将用户的消息显示在界面上
      const userMessage = {
        role: 'user',
        content: content,
        createTime: parseTime(new Date()) // 获取当前时间并格式化
      };
      this.messages.push(userMessage);
      this.inputMessage = '';
      this.scrollToBottom();
      this.loading = true;

      try {
        // 2. 发送请求
        const response = await sendMessageToDify(content);

        // 3. 接收回复
        // 注意：根据后端 ChatController，response.msg 存放的是回复内容
        const aiMessage = {
          role: 'assistant',
          content: response.msg,
          createTime: parseTime(new Date())
        };
        this.messages.push(aiMessage);
      } catch (error) {
        this.messages.push({
          role: 'assistant',
          content: '抱歉，服务出现问题，请稍后再试。',
          createTime: parseTime(new Date())
        });
      } finally {
        this.loading = false;
        this.scrollToBottom();
      }
    },

    // 滚动到底部
    scrollToBottom() {
      this.$nextTick(() => {
        const container = this.$refs.messageList;
        if (container) {
          container.scrollTop = container.scrollHeight;
        }
      });
    }
  }
};
</script>

<style scoped lang="scss">
.chat-container {
  display: flex;
  flex-direction: column;
  height: calc(100vh - 84px); // 减去若依顶栏高度，根据实际情况调整
  border: 1px solid #e6ebf5;
  border-radius: 4px;
  background-color: #fff;
  margin: 10px;
}

.message-list {
  flex: 1;
  padding: 20px;
  overflow-y: auto;
  background-color: #f9f9f9;

  .message-item {
    display: flex;
    margin-bottom: 20px;

    .content-wrapper {
      display: flex;
      flex-direction: column;
      max-width: 70%;
    }

    .bubble {
      padding: 10px 15px;
      border-radius: 8px;
      line-height: 1.5;
      word-wrap: break-word;
      font-size: 14px;
      box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    }

    .time {
      font-size: 12px;
      color: #999;
      margin-top: 5px;
    }

    // 用户样式（靠右）
    &.user {
      justify-content: flex-end;

      .content-wrapper {
        align-items: flex-end;
      }

      .bubble {
        background-color: #95ec69; // 微信风格绿色
        color: #000;
        border-top-right-radius: 2px;
      }
    }

    // 助手样式（靠左）
    &.assistant {
      justify-content: flex-start;

      .content-wrapper {
        align-items: flex-start;
      }

      .bubble {
        background-color: #ffffff;
        color: #333;
        border-top-left-radius: 2px;
      }
    }
  }
}

.input-area {
  display: flex;
  padding: 15px;
  border-top: 1px solid #eee;
  background-color: #fff;

  .el-input {
    margin-right: 10px;
  }
}
</style>
