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

    <div v-if="activeTab !== 'second-hand'" v-loading="loading">
      <div v-for="topic in topicList" :key="topic.topicId" class="topic-item">
        <div class="topic-header">
          <el-avatar :size="40" :src="topic.avatar"></el-avatar>
          <div class="user-info">
            <div class="username">{{ topic.nickName }}</div>
            <div class="time">{{ parseTime(topic.createTime) }}</div>
          </div>
        </div>
        <div class="topic-content">
          <p>{{ topic.content }}</p>
        </div>
        <div class="topic-footer">
          <span>
            <i class="el-icon-thumb"></i> {{ topic.likeCount }}
          </span>
        </div>
      </div>
      <el-empty v-if="topicList.length === 0" description="暂无帖子"></el-empty>
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
      <el-empty v-if="productList.length === 0" description="暂无商品"></el-empty>
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
        <el-form-item label="商品标题" prop="title">
          <el-input v-model="form.title" placeholder="请输入标题" />
        </el-form-item>
        <el-form-item label="商品描述" prop="description">
          <el-input
            v-model="form.description"
            type="textarea"
            rows="3"
            placeholder="请输入描述"
          />
        </el-form-item>
        <el-form-item label="商品价格" prop="price">
          <el-input-number v-model="form.price" :precision="2" :step="1" :min="0.01"></el-input-number> 元
        </el-form-item>
        <el-form-item label="上传图片" prop="imageUrls">
          <image-upload v-model="form.imageUrls" :limit="3"/>
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
// 【【【 1. 导入所有需要的API 】】】
import { listTopic } from "@/api/campus/topic";
import { listProduct, addProduct } from "@/api/campus/product";
import { createOrder } from "@/api/campus/order";
import { mapGetters } from 'vuex';

export default {
  name: "CampusTopicIndex", // 你的组件名
  data() {
    return {
      loading: true,
      // 激活的标签页
      activeTab: "all",
      // 帖子列表
      topicList: [],
      // 【新增】商品列表
      productList: [],
      // 总条数
      total: 0,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 12,
        topicType: null, // 用于查询帖子
        status: '0',     // 【新增】默认只查询"在售"的商品
      },

      // 【【【【【【 以下是新加的 】】】】】】
      // 弹窗开关
      open: false,
      // 弹窗标题
      title: "",
      // 商品表单
      form: {},
      // 【【【【【【 新增结束 】】】】】】
      // 【【【 新增表单校验 】】】
      rules: {
        title: [
          { required: true, message: "商品标题不能为空", trigger: "blur" }
        ],
        price: [
          { required: true, message: "商品价格不能为空", trigger: "blur" }
        ],
      }
    };
  },
  computed: {
    ...mapGetters([
      'userId' // 获取当前登录的用户ID，用于判断是否是自己的商品
    ]),
  },
  created() {
    this.getList();
  },
  methods: {
    /** 【【【 2. 大改 getList 方法 】】】 */
    getList() {
      this.loading = true;
      this.topicList = [];
      this.productList = [];

      // 判断当前是否在“二手”标签页
      if (this.activeTab === 'second-hand') {
        // ** (A) 如果是二手，调用商品API **
        // 我们只看在售('0')的商品
        this.queryParams.status = '0';
        // topicType 参数对商品无效，清空
        this.queryParams.topicType = null;

        listProduct(this.queryParams).then(response => {
          this.productList = response.rows;
          this.total = response.total;
          this.loading = false;
        });
      } else {
        // ** (B) 否则，调用帖子API **
        // status 参数对帖子无效，清空
        this.queryParams.status = null;
        // 设置帖子类型
        this.queryParams.topicType = this.activeTab === 'all' ? null : this.activeTab;

        listTopic(this.queryParams).then(response => {
          this.topicList = response.rows;
          this.total = response.total;
          this.loading = false;
        });
      }
    },
    // 切换Tab
    handleTabClick() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 【【【 修改：发布按钮逻辑 】】】 */
    handlePublish() {
      if (this.activeTab === 'second-hand') {
        // --- (A) 上架商品 ---
        this.reset(); // 重置表单
        this.open = true; // 打开弹窗
        this.title = "上架二手商品";
      } else {
        // --- (B) 发布帖子 ---
        // TODO: (这里放你原来的发布帖子逻辑)
        this.$modal.msgWarning("“发布帖子”功能待开发");
      }
    },

    /** 【【【 新增：重置表单 】】】 */
    reset() {
      this.form = {
        title: null,
        description: null,
        imageUrls: null, // 对应 ImageUpload
        price: 0.01,
        status: "0" // 默认上架
      };
      this.resetForm("form"); // ruoyi.js 提供的表单重置
    },

    /** 【【【 新增：关闭弹窗 】】】 */
    cancel() {
      this.open = false;
      this.reset();
    },

    /** 【【【 新增：提交表单 】】】 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          // 调用我们之前在 product.js 里定义的 addProduct
          addProduct(this.form).then(response => {
            this.$modal.msgSuccess("上架成功");
            this.open = false;
            this.getList(); // 刷新列表，就能看到新商品了
          });
        }
      });
    },
    /** 【【【 3. 新增 handleBuy 购买方法 】】】 */
    handleBuy(product) {
      // 弹出一个输入框，让用户输入地址
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
        // 用户点击了“确定”
        const orderData = {
          productId: product.productId,
          address: value
        };

        // 调用我们第3步创建的后端接口
        createOrder(orderData).then(response => {
          this.$modal.msgSuccess("购买成功！请等待卖家联系你发货");
          // 刷新列表，这个商品会变成“已售出”
          this.getList();
        }).catch(error => {
          // API 可能会返回错误，例如 "商品已售出"
          // this.$modal.msgError(error.message);
        });

      }).catch(() => {
        // 用户点击了“取消”
        this.$message({
          type: 'info',
          message: '取消购买'
        });
      });
    },
    /** 【【【 4. 新增 getFirstImage 辅助方法 】】】 */
    getFirstImage(imageUrls) {
      if (imageUrls && imageUrls.length > 0) {
        // 数据库存的是逗号分隔的字符串，我们取第一个
        const images = imageUrls.split(',');
        // 确保返回的是完整的 URL
        // (如果图片路径不是 /profile/ 开头，你可能需要修改这里)
        if (images[0].startsWith('/profile')) {
          return process.env.VUE_APP_BASE_API + images[0];
        }
        return images[0];
      }
      // 返回一个默认图片
      return "/path/to/your/default-image.png";
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

/* 帖子样式 (你原来的样式) */
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
}
.topic-footer {
  color: #999;
  font-size: 14px;
}

/* 【【【 新增：商品卡片样式 】】】 */
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
