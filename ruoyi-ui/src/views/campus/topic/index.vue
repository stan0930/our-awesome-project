<template>
  <div class="app-container">
    <el-tabs v-model="queryParams.topicType" @tab-click="handleQuery">
      <el-tab-pane label="全部" name="all"></el-tab-pane>
      <el-tab-pane label="推荐" name="recommend"></el-tab-pane>
      <el-tab-pane label="问答" name="qa"></el-tab-pane>
      <el-tab-pane label="二手" name="secondhand"></el-tab-pane>
      <el-tab-pane label="恋爱交友" name="dating"></el-tab-pane>
      <el-tab-pane label="兼职信息" name="jobs"></el-tab-pane>
      <el-tab-pane label="校园八卦" name="gossip"></el-tab-pane>
    </el-tabs>

    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px" @submit.native.prevent>
      <el-form-item label="关键词" prop="content">
        <el-input
          v-model="queryParams.content"
          placeholder="帖子内容或作者昵称"
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
        >发布新话题</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <div class="topic-list" v-loading="loading">
      <div class="topic-card" v-for="topic in topicList" :key="topic.topicId">
        <div class="topic-header">
          <el-avatar :src="topic.avatar ? topic.avatar : 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c672f1epng.png'"></el-avatar>
          <div class="user-info">
            <div class="nickname">{{ topic.nickName }}</div>
            <div class="create-time">{{ parseTime(topic.createTime, '{y}-{m}-{d} {h}:{i}') }}</div>
          </div>
          <el-tag class="topic-type-tag" size="mini">{{ formatTopicType(topic.topicType) }}</el-tag>
        </div>

        <div class="topic-content">
          <p v-if="topic.content" v-html="topic.content.replace(/\n/g, '<br>')"></p>
          <div class="image-list" v-if="topic.imageUrls">
            <el-image
              v-for="(url, index) in topic.imageUrls.split(',')"
              :key="index"
              :src="url"
              :preview-src-list="topic.imageUrls.split(',')"
              class="topic-image"
              fit="cover"
            ></el-image>
          </div>
        </div>

        <div class="topic-actions">
          <span @click="handleLike(topic)" :class="{ 'liked': topic.liked }">
            <i class="el-icon-thumb"></i> {{ topic.likeCount }}
          </span>
          <span @click="handleShowComment(topic.topicId, 0, '')">
            <i class="el-icon-chat-dot-round"></i> 评论
          </span>
        </div>

        <div class="comment-section" v-if="commentList[topic.topicId] && commentList[topic.topicId].length > 0">
          <div class="comment-item" v-for="comment in commentList[topic.topicId]" :key="comment.commentId">
            <el-avatar class="comment-avatar" :src="comment.avatar ? comment.avatar : 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c672f1epng.png'"></el-avatar>
            <div class="comment-body">
              <div>
                <span class="comment-nickname">{{ comment.nickName }}</span>
                <span v-if="comment.parentId !== 0 && comment.replyToNickName">
                  <span class="reply-text"> 回复 </span>
                  <span class="comment-nickname">{{ comment.replyToNickName }}</span>
                </span>:
                <span class="comment-content">{{ comment.content }}</span>
              </div>
              <div class="comment-footer">
                <span class="comment-time">{{ parseTime(comment.createTime, '{y}-{m}-{d} {h}:{i}') }}</span>
                <span class="comment-reply-btn" @click="handleShowComment(topic.topicId, comment.commentId, comment.nickName)">回复</span>
              </div>
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
        <el-form-item label="选择分区" prop="topicType">
          <el-select v-model="form.topicType" placeholder="请选择分区">
            <el-option
              v-for="item in topicTypeOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="话题内容" prop="content">
          <el-input v-model="form.content" type="textarea" :rows="5" placeholder="分享新鲜事..." />
        </el-form-item>
        <el-form-item label="上传图片" prop="imageUrls">
          <image-upload v-model="form.imageUrls"/>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">发 布</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <el-dialog :title="commentForm.title" :visible.sync="commentOpen" width="500px" append-to-body>
      <el-form ref="commentForm" :model="commentForm" :rules="commentRules" label-width="0px">
        <el-form-item prop="content">
          <el-input v-model="commentForm.content" type="textarea" :rows="3" :placeholder="commentForm.placeholder"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitCommentForm">发 表</el-button>
        <el-button @click="cancelComment">取 消</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
import { listTopic, addTopic, getComments, toggleLike, addComment } from "@/api/campus/topic";
import ImageUpload from '@/components/ImageUpload';

export default {
  name: "Topic",
  components: { ImageUpload },
  data() {
    return {
      loading: true,
      showSearch: true,
      total: 0,
      topicList: [],
      commentList: {},
      title: "",
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        topicType: 'all',
        content: null,
      },
      form: {},
      topicTypeOptions: [
        { value: 'recommend', label: '推荐' },
        { value: 'qa', label: '问答' },
        { value: 'secondhand', label: '二手' },
        { value: 'dating', label: '恋爱交友' },
        { value: 'jobs', label: '兼职信息' },
        { value: 'gossip', label: '校园八卦' }
      ],
      rules: {
        topicType: [ { required: true, message: "请选择一个分区", trigger: "change" } ],
        content: [ { required: true, message: "话题内容不能为空", trigger: "blur" } ],
      },
      commentOpen: false,
      commentForm: {
        title: '',
        placeholder: '',
        topicId: null,
        parentId: null,
        content: ''
      },
      commentRules: {
        content: [ { required: true, message: "评论内容不能为空", trigger: "blur" } ]
      }
    };
  },

  created() {
    this.getList();
  },

  methods: {
    getList() {
      this.loading = true;
      const params = { ...this.queryParams };
      if (params.topicType === 'all') {
        params.topicType = null;
      }
      listTopic(params).then(response => {
        this.topicList = response.rows;
        this.total = response.total;
        this.loading = false;
        this.topicList.forEach(topic => {
          this.handleGetComments(topic.topicId);
        });
      });
    },

    handleGetComments(topicId) {
      getComments(topicId).then(response => {
        this.$set(this.commentList, topicId, response.data);
      });
    },

    handleLike(topic) {
      toggleLike(topic.topicId).then(response => {
        topic.liked = response.data;
        if (topic.liked) {
          topic.likeCount++;
          this.$modal.msgSuccess("点赞成功");
        } else {
          topic.likeCount--;
          this.$modal.msgSuccess("取消点赞");
        }
      });
    },

    formatTopicType(type) {
      const option = this.topicTypeOptions.find(item => item.value === type);
      return option ? option.label : '其他';
    },

    cancel() {
      this.open = false;
      this.reset();
    },

    reset() {
      this.form = { topicId: null, content: null, imageUrls: null, topicType: 'recommend' };
      this.resetForm("form");
    },

    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },

    resetQuery() {
      this.resetForm("queryForm");
      this.queryParams.topicType = 'all';
      this.handleQuery();
    },

    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "发布新话题";
    },

    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          addTopic(this.form).then(response => {
            this.$modal.msgSuccess("发布成功");
            this.open = false;
            this.getList();
          });
        }
      });
    },

    resetCommentForm() {
      this.commentForm = {
        title: '',
        placeholder: '',
        topicId: null,
        parentId: null,
        content: ''
      };
      this.resetForm("commentForm");
    },
    handleShowComment(topicId, parentId, parentNickName) {
      this.resetCommentForm();
      this.commentForm.topicId = topicId;
      this.commentForm.parentId = parentId;
      if (parentId === 0) {
        this.commentForm.title = "发表评论";
        this.commentForm.placeholder = "请输入评论内容...";
      } else {
        this.commentForm.title = "回复 " + parentNickName;
        this.commentForm.placeholder = "回复 " + parentNickName + ":";
      }
      this.commentOpen = true;
    },
    cancelComment() {
      this.commentOpen = false;
      this.resetCommentForm();
    },
    submitCommentForm() {
      this.$refs["commentForm"].validate(valid => {
        if (valid) {
          addComment(this.commentForm).then(response => {
            this.$modal.msgSuccess("发表成功");
            this.commentOpen = false;
            this.handleGetComments(this.commentForm.topicId);
          });
        }
      });
    }
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
}
.topic-header {
  display: flex;
  align-items: center;
  margin-bottom: 15px;
  position: relative;
}
.topic-type-tag {
  position: absolute;
  top: 0;
  right: 0;
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
.image-list {
  margin-top: 10px;
  display: flex;
  flex-wrap: wrap;
}
.topic-image {
  width: 100px;
  height: 100px;
  margin-right: 10px;
  margin-bottom: 10px;
  border-radius: 6px;
  cursor: pointer;
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
.topic-actions span.liked {
  color: #409EFF;
}
.topic-actions span i {
  margin-right: 5px;
}
.topic-actions span:hover {
  color: #409EFF;
}
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
  flex-shrink: 0;
  width: 32px;
  height: 32px;
}
.comment-body {
  margin-left: 10px;
  font-size: 14px;
  width: 100%;
}
.comment-nickname {
  font-weight: bold;
  color: #555;
}
.comment-content {
  color: #333;
}
.reply-text {
  font-size: 14px;
  color: #888;
  margin: 0 5px;
}
.comment-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 2px;
}
.comment-time {
  font-size: 12px;
  color: #999;
}
.comment-reply-btn {
  font-size: 12px;
  color: #888;
  cursor: pointer;
}
.comment-reply-btn:hover {
  color: #409EFF;
}
</style>
