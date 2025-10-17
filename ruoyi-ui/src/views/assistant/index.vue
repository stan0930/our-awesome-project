<template>
  <div class="chat-container">
    <div class="message-list">
      <div v-for="(message, index) in messages" :key="index" :class="message.role">
        <p>{{ message.content }}</p>
      </div>
    </div>
    <div class="input-area">
      <el-input v-model="inputMessage" @keyup.enter.native="sendMessage" placeholder="请输入消息..."></el-input>
      <el-button @click="sendMessage">发送</el-button>
    </div>
  </div>
</template>

<script>
import { sendMessageToDify } from "@/api/assistant/chat";

export default {
  data() {
    return {
      inputMessage: '',
      messages: []
    };
  },
  methods: {
    async sendMessage() {
      if (this.inputMessage.trim() === '') return;

      const userMessage = { role: 'user', content: this.inputMessage };
      this.messages.push(userMessage);

      try {
        const response = await sendMessageToDify(this.inputMessage);
        this.messages.push({ role: 'assistant', content: response.msg }); // 若依的AjaxResult返回格式为{code, msg, data}
      } catch (error) {
        this.messages.push({ role: 'assistant', content: '抱歉，服务出现问题。' });
        console.error("Error sending message:", error);
      }

      this.inputMessage = '';
    }
  }
};
</script>

<style scoped>
.chat-container {
  display: flex;
  flex-direction: column;
  height: 100%;
  border: 1px solid #ddd;
  border-radius: 8px;
  overflow: hidden;
}

.message-list {
  flex: 1;
  padding: 20px;
  overflow-y: auto;
}

.message-list .user {
  text-align: right;
  margin-bottom: 10px;
}

.message-list .user p {
  background-color: #e1ffc7;
  display: inline-block;
  padding: 8px 12px;
  border-radius: 12px;
  max-width: 70%;
}

.message-list .assistant {
  text-align: left;
  margin-bottom: 10px;
}

.message-list .assistant p {
  background-color: #f0f0f0;
  display: inline-block;
  padding: 8px 12px;
  border-radius: 12px;
  max-width: 70%;
}

.input-area {
  display: flex;
  padding: 10px;
  border-top: 1px solid #eee;
}

.input-area .el-input {
  flex: 1;
  margin-right: 10px;
}
</style>
