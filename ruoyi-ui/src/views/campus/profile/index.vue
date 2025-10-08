<template>
  <div class="app-container">
    <el-tabs v-model="activeTab" @tab-click="handleTabClick">
      <el-tab-pane label="我的发布" name="my-posts"></el-tab-pane>
      <el-tab-pane label="我的点赞" name="my-likes"></el-tab-pane>
      <el-tab-pane label="我的评论" name="my-comments"></el-tab-pane>
      <el-tab-pane label="我的收藏" name="my-favorites"></el-tab-pane>
    </el-tabs>

    <div class="topic-list" v-loading="loading">
      <div v-if="topicList.length === 0 && !loading" class="empty-state">
        <el-empty :description="emptyText"></el-empty>
      </div>

      <div class="topic-card" v-for="topic in topicList" :key="topic.topicId">
        <div class="topic-header">
          <el-avatar :src="topic.avatar || 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c672f1epng.png'"></el-avatar>
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
          <span v-if="topic.commentEnabled == '0'" @click="handleShowComment(topic.topicId, 0, '')">
            <i class="el-icon-chat-dot-round"></i> 评论
          </span>
          <span @click="handleFavorite(topic)" :class="{ 'favorited': topic.favorited }">
            <i class="el-icon-star-off"></i> 收藏
          </span>

          <div v-if="activeTab === 'my-posts'" class="manage-actions">
            <el-button type="text" icon="el-icon-edit" @click="handleEdit(topic)">编辑</el-button>
            <el-button type="text" icon="el-icon-delete" @click="handleDelete(topic)" class="delete-btn">删除</el-button>
          </div>
        </div>

        <div class="comment-section" v-if="topic.commentEnabled == '0' && commentList[topic.topicId] && commentList[topic.topicId].length > 0">
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
      v-show="total > 0"
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
        <el-form-item label="评论设置">
          <el-radio-group v-model="form.commentEnabled">
            <el-radio label="0">允许评论</el-radio>
            <el-radio label="1">禁止评论</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
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
import { listMyTopic, listMyLikes, listMyComments, listMyFavorites, toggleLike, getTopic, updateTopic, delTopic, getComments, addComment, toggleFavorite } from "@/api/campus/topic";
import ImageUpload from '@/components/ImageUpload';

export default {
  name: "MyProfile",
  components: { ImageUpload },
  data() {
    return {
      loading: true,
      activeTab: 'my-posts',
      topicList: [],
      commentList: {},
      total: 0,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
      },
      open: false,
      title: "",
      form: {},
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
      },
      topicTypeOptions: [
        { value: 'recommend', label: '推荐' },
        { value: 'qa', label: '问答' },
        { value: 'secondhand', label: '二手' },
        { value: 'dating', label: '恋爱交友' },
        { value: 'jobs', label: '兼职信息' },
        { value: 'gossip', label: '校园八卦' }
      ]
    };
  },
  computed: {
    emptyText() {
      switch (this.activeTab) {
        case 'my-posts': return '您还没有发布过任何话题';
        case 'my-likes': return '您还没有点赞过任何话题';
        case 'my-comments': return '您还没有评论过任何话题';
        case 'my-favorites': return '您还没有收藏过任何话题';
        default: return '暂无数据';
      }
    }
  },
  created() {
    this.getList();
  },
  methods: {
    getList() {
      this.loading = true;
      let apiCall;
      if (this.activeTab === 'my-posts') {
        apiCall = listMyTopic(this.queryParams);
      } else if (this.activeTab === 'my-likes') {
        apiCall = listMyLikes(this.queryParams);
      } else if (this.activeTab === 'my-comments') {
        apiCall = listMyComments(this.queryParams);
      } else if (this.activeTab === 'my-favorites') {
        apiCall = listMyFavorites(this.queryParams);
      }

      apiCall.then(response => {
        this.topicList = response.rows;
        this.total = response.total;
        this.loading = false;
        this.topicList.forEach(topic => {
          this.handleGetComments(topic.topicId);
        });
      });
    },
    handleTabClick() {
      this.queryParams.pageNum = 1;
      this.topicList = [];
      this.getList();
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
          if (this.activeTab === 'my-likes') {
            this.topicList = this.topicList.filter(item => item.topicId !== topic.topicId);
            if(this.topicList.length === 0){
              this.getList()
            }
          }
        }
      });
    },
    handleFavorite(topic) {
      toggleFavorite(topic.topicId).then(response => {
        topic.favorited = response.data;
        if (topic.favorited) {
          this.$modal.msgSuccess("收藏成功");
        } else {
          this.$modal.msgSuccess("取消收藏");
          if (this.activeTab === 'my-favorites') {
            this.topicList = this.topicList.filter(item => item.topicId !== topic.topicId);
            if(this.topicList.length === 0){
              this.getList()
            }
          }
        }
      });
    },
    formatTopicType(type) {
      const option = this.topicTypeOptions.find(item => item.value === type);
      return option ? option.label : '其他';
    },
    reset() {
      this.form = {
        topicId: null,
        content: null,
        imageUrls: null,
        topicType: 'recommend',
        commentEnabled: '0'
      };
      this.resetForm("form");
    },
    cancel() {
      this.open = false;
      this.reset();
    },
    handleEdit(topic) {
      this.reset();
      const topicId = topic.topicId;
      getTopic(topicId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "编辑话题";
      });
    },
    handleDelete(topic) {
      const topicIds = topic.topicId;
      this.$modal.confirm('是否确认删除该话题？').then(function() {
        return delTopic(topicIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.topicId != null) {
            updateTopic(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    handleGetComments(topicId) {
      getComments(topicId).then(response => {
        this.$set(this.commentList, topicId, response.data);
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
          }).catch(()=>{});
        }
      });
    }
  }
};
</script>

<style scoped>
.topic-list { padding: 10px; }
.topic-card { background: #ffffff; border-radius: 8px; padding: 20px; margin-bottom: 15px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); }
.topic-header { display: flex; align-items: center; margin-bottom: 15px; position: relative; }
.topic-type-tag { position: absolute; top: 0; right: 0; }
.user-info { margin-left: 10px; }
.nickname { font-weight: bold; font-size: 16px; }
.create-time { font-size: 12px; color: #999; margin-top: 2px; }
.topic-content { margin-bottom: 15px; line-height: 1.7; font-size: 15px; color: #333; }
.image-list { margin-top: 10px; display: flex; flex-wrap: wrap; }
.topic-image { width: 100px; height: 100px; margin-right: 10px; margin-bottom: 10px; border-radius: 6px; cursor: pointer; }
.topic-actions { display: flex; color: #888; font-size: 14px; align-items: center; }
.topic-actions span { display: flex; align-items: center; margin-right: 25px; cursor: pointer; }
.topic-actions span.liked { color: #409EFF; }
.topic-actions span.favorited { color: #E6A23C; }
.topic-actions span i { margin-right: 5px; }
.topic-actions span:hover { color: #409EFF; }
.empty-state { display: flex; justify-content: center; align-items: center; height: 400px; }
.manage-actions { margin-left: auto; }
.delete-btn { color: #F56C6C; }
.comment-section { margin-top: 15px; padding-top: 15px; border-top: 1px solid #f0f0f0; }
.comment-item { display: flex; margin-bottom: 10px; }
.comment-avatar { flex-shrink: 0; width: 32px; height: 32px; }
.comment-body { margin-left: 10px; font-size: 14px; width: 100%; }
.comment-nickname { font-weight: bold; color: #555; }
.comment-content { color: #333; }
.reply-text { font-size: 14px; color: #888; margin: 0 5px; }
.comment-footer { display: flex; justify-content: space-between; align-items: center; margin-top: 2px; }
.comment-time { font-size: 12px; color: #999; }
.comment-reply-btn { font-size: 12px; color: #888; cursor: pointer; }
.comment-reply-btn:hover { color: #409EFF; }
</style>
