<template>
  <div class="app-container">
    <el-tabs v-model="activeTab" @tab-click="handleTabClick">
      <el-tab-pane label="全部" name="all"></el-tab-pane>
      <el-tab-pane label="推荐" name="recommend"></el-tab-pane>
      <el-tab-pane label="问答" name="qa"></el-tab-pane>
      <el-tab-pane label="二手" name="second-hand"></el-tab-pane>
      <el-tab-pane label="恋爱交友" name="love"></el-tab-pane>
      <el-tab-pane label="兼职信息" name="jobs"></el-tab-pane>
      <el-tab-pane label="校园八卦" name="gossip"></el-tab-pane>

      <el-button
        type="primary"
        icon="el-icon-plus"
        size="mini"
        @click="handlePublish"
        class="publish-btn"
      >
        {{ activeTab === 'second-hand' ? '上架商品' : '发布帖子' }}
      </el-button>
    </el-tabs>

    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="activeTab !== 'second-hand'">
      <el-form-item label="帖子搜索" prop="content">
        <el-input
          v-model="queryParams.content"
          placeholder="搜索帖子内容或作者"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
      </el-form-item>
    </el-form>

    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="activeTab === 'second-hand'">
      <el-form-item label="商品搜索" prop="title">
        <el-input
          v-model="queryParams.title"
          placeholder="搜索商品标题"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
      </el-form-item>
    </el-form>


    <div v-if="activeTab !== 'second-hand'" v-loading="loading">
      <div v-for="topic in topicList" :key="topic.topicId" class="topic-item">
        <div class="topic-header">
          <el-avatar :size="40" :src="topic.avatar || defaultAvatar"></el-avatar>
          <div class="user-info">
            <div class="username">{{ topic.nickName }}</div>
            <div class="time">{{ parseTime(topic.createTime) }}</div>
          </div>
        </div>
        <div class="topic-content" v-html="topic.content"></div>
        <div class="topic-footer">
          <span>
            <i class="el-icon-thumb"></i> {{ topic.likeCount }}
          </span>
        </div>
      </div>
      <el-empty v-if="!loading && topicList.length === 0" description="暂无帖子"></el-empty>
    </div>

    <div v-else v-loading="loading">
      <el-row :gutter="20">
        <el-col :span="6" v-for="product in productList" :key="product.productId">
          <el-card class="product-card">
            <img
              :src="getFirstImage(product.imageUrls)"
              class="product-image"
              alt="商品图片"
            />
            <div class="product-info">
              <div class="product-title">{{ product.title }}</div>
              <div class="product-desc">{{ product.description }}</div>
              <div class="product-price">¥ {{ product.price }}</div>
              <div class="product-seller">卖家: {{ product.nickName }}</div>

              <el-button
                type="danger"
                size="mini"
                v-if="product.status == '0' && product.userId != userId"
                @click="handleBuy(product)"
              >
                立即购买
              </el-button>
              <el-tag type="info" v-if="product.status == '0' && product.userId == userId">
                我的商品
              </el-tag>
              <el-tag type="info" v-if="product.status == '1'">已售出</el-tag>
              <el-tag type="warning" v-if="product.status == '2'">已下架</el-tag>
            </div>
          </el-card>
        </el-col>
      </el-row>
      <el-empty v-if="!loading && productList.length === 0" description="暂无商品"></el-empty>
    </div>

    <pagination
      v-show="total > 0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <el-dialog :title="titleProduct" :visible.sync="openProduct" width="600px" append-to-body>
      <el-form ref="formProduct" :model="formProduct" :rules="rulesProduct" label-width="80px">
        <el-form-item label="商品标题" prop="title">
          <el-input v-model="formProduct.title" placeholder="请输入标题" />
        </el-form-item>
        <el-form-item label="商品描述" prop="description">
          <el-input
            v-model="formProduct.description"
            type="textarea"
            rows="3"
            placeholder="请输入描述"
          />
        </el-form-item>
        <el-form-item label="商品价格" prop="price">
          <el-input-number v-model="formProduct.price" :precision="2" :step="1" :min="0.01"></el-input-number> 元
        </el-form-item>
        <el-form-item label="上传图片" prop="imageUrls">
          <image-upload v-model="formProduct.imageUrls" :limit="3"/>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitFormProduct">确 定</el-button>
        <el-button @click="cancelProduct">取 消</el-button>
      </div>
    </el-dialog>

    <el-dialog :title="titleTopic" :visible.sync="openTopic" width="700px" append-to-body>
      <el-form ref="formTopic" :model="formTopic" :rules="rulesTopic" label-width="80px">
        <el-form-item label="帖子内容" prop="content">
          <editor v-model="formTopic.content" :min-height="192"/>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitFormTopic">确 定</el-button>
        <el-button @click="cancelTopic">取 消</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
// 【 1. 导入所有需要的API 】
import { listTopic, addTopic } from "@/api/campus/topic"; // 导入 addTopic
import { listProduct, addProduct } from "@/api/campus/product";
import { createOrder } from "@/api/campus/order";
import { mapGetters } from 'vuex';
// 导入默认头像
import defaultAvatar from '@/assets/images/profile.jpg';

export default {
  name: "CampusTopicIndex",
  data() {
    return {
      loading: true,
      activeTab: "all",
      topicList: [],
      productList: [],
      total: 0,
      queryParams: {
        pageNum: 1,
        pageSize: 12,
        topicType: null,
        status: '0',
        content: null, // 【新增】给帖子搜索用
        title: null    // 【新增】给商品搜索用
      },
      defaultAvatar: defaultAvatar, // 默认头像

      // 【 2. “上架商品”的弹窗和表单 】
      openProduct: false,
      titleProduct: "",
      formProduct: {},
      rulesProduct: {
        title: [ { required: true, message: "商品标题不能为空", trigger: "blur" } ],
        price: [ { required: true, message: "商品价格不能为空", trigger: "blur" } ],
      },

      // 【 3. “发布帖子”的弹窗和表单 】
      openTopic: false,
      titleTopic: "",
      formTopic: {},
      rulesTopic: {
        content: [ { required: true, message: "帖子内容不能为空", trigger: "blur" } ]
      }
    };
  },
  computed: {
    ...mapGetters([
      'userId' // 获取当前登录的用户ID
    ]),
  },
  created() {
    this.getList();
  },
  methods: {
    /** 【 新增：搜索按钮操作 】 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },

    /** 【 覆盖：getList 方法 】 */
    getList() {
      this.loading = true;
      this.topicList = [];
      this.productList = [];

      // (A) 如果是二手，调用商品API
      if (this.activeTab === 'second-hand') {
        // 清理帖子的参数
        this.queryParams.topicType = null;
        this.queryParams.content = null; // 清空帖子搜索词
        // 设置商品的参数
        this.queryParams.status = '0'; // 只看在售

        listProduct(this.queryParams).then(response => {
          this.productList = response.rows;
          this.total = response.total;
          this.loading = false;
        });
      } else {
        // (B) 否则，调用帖子API
        // 清理商品的参数
        this.queryParams.status = null;
        this.queryParams.title = null; // 清空商品搜索词
        // 设置帖子的参数
        this.queryParams.topicType = this.activeTab === 'all' ? null : this.activeTab;

        listTopic(this.queryParams).then(response => {
          this.topicList = response.rows;
          this.total = response.total;
          this.loading = false;
        });
      }
    },

    /** 【 覆盖：handleTabClick 方法 】 */
    handleTabClick() {
      this.queryParams.pageNum = 1;

      // 【新增】切换Tab时，清空所有搜索词
      this.queryParams.content = null;
      this.queryParams.title = null;
      // 同时重置一下 queryForm (如果你有 resetQuery 方法的话)
      // this.resetQuery();

      this.getList();
    },

    /** 【 关键修改：handlePublish 方法 】 */
    handlePublish() {
      if (this.activeTab === 'second-hand') {
        // --- (A) 上架商品 ---
        this.resetProductForm();
        this.openProduct = true;
        this.titleProduct = "上架二手商品";
      } else {
        // --- (B) 发布帖子 ---
        this.resetTopicForm();
        // 自动设置帖子的类型
        this.formTopic.topicType = this.activeTab === 'all' ? 'daily' : this.activeTab;
        this.openTopic = true;
        this.titleTopic = "发布帖子 - " + this.activeTab;
      }
    },

    // --- 商品表单的方法 ---
    resetProductForm() {
      this.formProduct = { title: null, description: null, imageUrls: null, price: 0.01, status: "0" };
      if (this.$refs.formProduct) {
        this.resetForm("formProduct");
      }
    },
    cancelProduct() {
      this.openProduct = false;
      this.resetProductForm();
    },
    submitFormProduct() {
      this.$refs["formProduct"].validate(valid => {
        if (valid) {
          addProduct(this.formProduct).then(response => {
            this.$modal.msgSuccess("上架成功");
            this.openProduct = false;
            this.getList(); // 刷新列表
          });
        }
      });
    },

    // --- 【 帖子表单的方法 】 ---
    resetTopicForm() {
      this.formTopic = {
        content: null,
        // imageUrls: null, // 注：富文本编辑器会把图片URL存在content里
        topicType: 'daily' // 默认是日常
      };
      if (this.$refs.formTopic) {
        this.resetForm("formTopic");
      }
    },
    cancelTopic() {
      this.openTopic = false;
      this.resetTopicForm();
    },
    submitFormTopic() {
      this.$refs["formTopic"].validate(valid => {
        if (valid) {
          // 提交帖子
          addTopic(this.formTopic).then(response => {
            this.$modal.msgSuccess("发布成功");
            this.openTopic = false;
            // 如果当前就在这个板块，刷新
            if (this.formTopic.topicType === this.activeTab || this.activeTab === 'all') {
              this.getList();
            } else {
              // 否则，切换到那个板块
              this.activeTab = this.formTopic.topicType;
              this.getList();
            }
          });
        }
      });
    },

    // --- 购买和图片的方法 (保留) ---
    handleBuy(product) {
      this.$prompt('请输入你的收货地址 (例如：X栋X单元XXX室)', '确认购买', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        inputType: 'textarea',
        inputValidator: (value) => {
          if (!value || value.trim().length === 0) {
            return '收货地址不能为空';
          }
          return true;
        }
      }).then(({ value }) => {
        const orderData = {
          productId: product.productId,
          address: value
        };
        createOrder(orderData).then(response => {
          this.$modal.msgSuccess("购买成功！请等待卖家联系你发货");
          this.getList();
        }).catch(error => {
          // (错误处理已在后端完成)
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '取消购买'
        });
      });
    },
    getFirstImage(imageUrls) {
      if (imageUrls && imageUrls.length > 0) {
        const images = imageUrls.split(',');
        if (images[0].startsWith('/profile')) {
          return process.env.VUE_APP_BASE_API + images[0];
        }
        return images[0];
      }
      return this.defaultAvatar; // 如果没图，也用默认头像
    }
  }
};
</script>

<style scoped>
.app-container {
  padding: 20px;
}
.publish-btn {
  float: right;
  margin-top: -10px;
}

/* 帖子样式 */
.topic-item {
  border-bottom: 1px solid #e8e8e8;
  padding: 15px 0;
}
.topic-header {
  display: flex;
  align-items: center;
}
.user-info {
  margin-left: 10px;
}
.username {
  font-weight: bold;
}
.time {
  font-size: 12px;
  color: #999;
}
.topic-content {
  margin: 10px 0;
  /* 【重要】v-html 里的图片可能会超出，我们限制一下 */
  word-break: break-all;
  line-height: 1.6;
}
/* 确保 v-html 里的图片自适应宽度 */
.topic-content >>> img {
  max-width: 100%;
  height: auto;
  border-radius: 4px;
}
.topic-footer {
  color: #999;
  font-size: 14px;
}

/* 商品卡片样式 */
.product-card {
  margin-bottom: 20px;
}
.product-image {
  width: 100%;
  height: 180px; /* 固定高度 */
  object-fit: cover; /* 保证图片不变形 */
  display: block;
}
.product-info {
  padding: 14px;
}
.product-title {
  font-size: 16px;
  font-weight: bold;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
.product-desc {
  font-size: 13px;
  color: #999;
  margin: 5px 0;
  height: 40px; /* 固定2行高度 */
  overflow: hidden;
}
.product-price {
  font-size: 18px;
  color: #ff5000;
  font-weight: bold;
  margin: 10px 0;
}
.product-seller {
  font-size: 12px;
  color: #aaa;
  margin-bottom: 10px;
}
</style>
