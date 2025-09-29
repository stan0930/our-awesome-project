<template>
  <div class="app-container">
    <el-tabs v-model="activeTab" @tab-click="handleTabClick">
      <el-tab-pane label="我的发布" name="my-posts"></el-tab-pane>
      <el-tab-pane label="我的点赞" name="my-likes"></el-tab-pane>
      <el-tab-pane label="我的评论" name="my-comments"></el-tab-pane>
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
          <p v-html="topic.content.replace(/\n/g, '<br>')"></p>
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
          <span>
            <i class="el-icon-chat-dot-round"></i> 查看评论
          </span>
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
  </div>
</template>

<script>
// 导入我们新增的API，以及之前用过的toggleLike
import { listMyTopic, listMyLikes, listMyComments, toggleLike } from "@/api/campus/topic";

export default {
  name: "MyProfile",
  data() {
    return {
      loading: true,
      activeTab: 'my-posts', // 默认选中的Tab
      topicList: [],
      total: 0,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
      },
      // 分区类型定义，用于格式化标签显示
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
    // 根据当前Tab显示不同的空状态提示
    emptyText() {
      switch (this.activeTab) {
        case 'my-posts': return '您还没有发布过任何话题';
        case 'my-likes': return '您还没有点赞过任何话题';
        case 'my-comments': return '您还没有评论过任何话题';
        default: return '暂无数据';
      }
    }
  },
  created() {
    this.getList();
  },
  methods: {
    // 统一的数据获取入口
    getList() {
      this.loading = true;
      let apiCall;
      // 根据当前激活的Tab，选择调用哪个API
      if (this.activeTab === 'my-posts') {
        apiCall = listMyTopic(this.queryParams);
      } else if (this.activeTab === 'my-likes') {
        apiCall = listMyLikes(this.queryParams);
      } else if (this.activeTab === 'my-comments') {
        apiCall = listMyComments(this.queryParams);
      }

      apiCall.then(response => {
        this.topicList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // Tab切换时的处理
    handleTabClick() {
      this.queryParams.pageNum = 1; // 重置页码
      this.topicList = []; // 清空列表，避免闪烁
      this.getList();
    },
    // 点赞/取消点赞
    handleLike(topic) {
      toggleLike(topic.topicId).then(response => {
        topic.liked = response.data;
        if (topic.liked) {
          topic.likeCount++;
          this.$modal.msgSuccess("点赞成功");
        } else {
          topic.likeCount--;
          this.$modal.msgSuccess("取消点赞");
          // 如果是在“我的点赞”页面取消点赞，则从列表中移除
          if (this.activeTab === 'my-likes') {
            this.topicList = this.topicList.filter(item => item.topicId !== topic.topicId);
            if(this.topicList.length === 0){
              this.getList()
            }
          }
        }
      });
    },
    // 格式化分区显示
    formatTopicType(type) {
      const option = this.topicTypeOptions.find(item => item.value === type);
      return option ? option.label : '其他';
    },
  }
};
</script>

<style scoped>
/* 直接复用 campus/topic/index.vue 的样式 */
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
.topic-actions { display: flex; color: #888; font-size: 14px; }
.topic-actions span { display: flex; align-items: center; margin-right: 25px; cursor: pointer; }
.topic-actions span.liked { color: #409EFF; }
.topic-actions span i { margin-right: 5px; }
.topic-actions span:hover { color: #409EFF; }
.empty-state {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 400px;
}
</style>
