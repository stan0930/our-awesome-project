<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="用户ID" prop="userId">
        <el-input
          v-model="queryParams.userId"
          placeholder="请输入用户ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['campus:topic:add']"
        >新增</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <div class="topic-list">
      <div class="topic-card" v-for="topic in topicList" :key="topic.topicId">
        <div class="topic-header">
          <el-avatar :src="topic.avatar ? topic.avatar : 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c672f1epng.png'"></el-avatar>
          <div class="user-info">
            <div class="nickname">{{ topic.nickName }}</div>
            <div class="create-time">{{ parseTime(topic.createTime, '{y}-{m}-{d} {h}:{i}') }}</div>
          </div>
        </div>

        <div class="topic-content">
          <p>{{ topic.content }}</p>
        </div>

        <div class="topic-actions">
          <span><i class="el-icon-thumb"></i> 点赞</span>
          <span><i class="el-icon-chat-dot-round"></i> 评论</span>
        </div>

        <div class="comment-section" v-if="commentList[topic.topicId] && commentList[topic.topicId].length > 0">
          <div class="comment-item" v-for="comment in commentList[topic.topicId]" :key="comment.commentId">
            <el-avatar class="comment-avatar" :src="comment.avatar ? comment.avatar : 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c672f1epng.png'"></el-avatar>
            <div class="comment-body">
              <span class="comment-nickname">{{ comment.nickName }}: </span>
              <span class="comment-content">{{ comment.content }}</span>
              <div class="comment-time">{{ parseTime(comment.createTime, '{y}-{m}-{d} {h}:{i}') }}</div>
            </div>
          </div>
        </div>

      </div>
    </div>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="话题内容" prop="content">
          <el-input v-model="form.content" type="textarea" :rows="5" placeholder="请输入内容" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
// 【修改】同时导入 listTopic 和 getComments
import { listTopic, getTopic, delTopic, addTopic, updateTopic, getComments } from "@/api/campus/topic";

export default {
  name: "Topic",
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      topicList: [],
      commentList: {}, // 【新增】用于存放评论列表
      title: "",
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        content: null,
      },
      form: {},
      rules: {
        content: [
          { required: true, message: "话题内容不能为空", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询校园话题列表 */
    getList() {
      this.loading = true;
      listTopic(this.queryParams).then(response => {
        this.topicList = response.rows;
        this.total = response.total;
        this.loading = false;
        // 【新增】获取每个话题的评论
        this.topicList.forEach(topic => {
          this.handleGetComments(topic.topicId);
        });
      });
    },
    /** 【新增】获取指定话题的评论列表 */
    handleGetComments(topicId) {
      getComments(topicId).then(response => {
        // 使用 $set 来确保Vue能够响应式地更新commentList对象
        this.$set(this.commentList, topicId, response.data);
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        topicId: null,
        userId: null,
        content: null,
        imageUrls: null,
        status: "0",
        delFlag: "0",
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
        remark: null
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "发布新话题";
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.topicId != null) {
            updateTopic(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addTopic(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
  }
};
</script>

<style scoped>
.topic-list {
  padding: 10px;
}
.topic-card {
  background: #ffffff;
  border-radius: 8px;
  padding: 20px;
  margin-bottom: 15px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
}
.topic-card:hover {
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
  transform: translateY(-5px);
}
.topic-header {
  display: flex;
  align-items: center;
  margin-bottom: 15px;
}
.user-info {
  margin-left: 10px;
}
.nickname {
  font-weight: bold;
  font-size: 16px;
}
.create-time {
  font-size: 12px;
  color: #999;
  margin-top: 2px;
}
.topic-content {
  margin-bottom: 15px;
  line-height: 1.7;
  font-size: 15px;
  color: #333;
}
.topic-actions {
  display: flex;
  color: #888;
  font-size: 14px;
}
.topic-actions span {
  display: flex;
  align-items: center;
  margin-right: 25px;
  cursor: pointer;
}
.topic-actions span i {
  margin-right: 5px;
}
.topic-actions span:hover {
  color: #409EFF;
}

/* 【新增】评论区样式 */
.comment-section {
  margin-top: 15px;
  padding-top: 15px;
  border-top: 1px solid #f0f0f0;
}
.comment-item {
  display: flex;
  margin-bottom: 10px;
}
.comment-avatar {
  flex-shrink: 0; /* 防止头像被压缩 */
  width: 32px;
  height: 32px;
}
.comment-body {
  margin-left: 10px;
  font-size: 14px;
}
.comment-nickname {
  font-weight: bold;
  color: #555;
}
.comment-content {
  color: #333;
}
.comment-time {
  font-size: 12px;
  color: #999;
  margin-top: 2px;
}
</style>
