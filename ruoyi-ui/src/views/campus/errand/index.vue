<template>
  <div class="app-container">
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handlePublish"
        >发布新任务</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <div class="errand-list" v-loading="loading">
      <div v-if="orderList.length === 0 && !loading" class="empty-state">
        <el-empty description="当前没有待接单的任务"></el-empty>
      </div>
      <div class="errand-card" v-for="order in orderList" :key="order.orderId">
        <div class="card-header">
          <el-tag size="small">{{ order.orderType }}</el-tag>
          <span class="reward">￥{{ order.reward }}</span>
        </div>
        <div class="card-body">
          <h4 class="title">{{ order.title }}</h4>
          <p class="detail">{{ order.detail }}</p>
          <div class="address">
            <i class="el-icon-location-outline"></i>
            <span>送达地址：{{ order.deliveryAddress }}</span>
          </div>
        </div>
        <div class="card-footer">
          <span class="publisher-info">
            <el-avatar size="small" src="https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c672f1epng.png"></el-avatar>
            <span class="nickname">{{ order.publisherNickName }}</span>
          </span>
          <el-button type="primary" size="mini" round @click="handleTakeOrder(order)">立即接单</el-button>
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
        <el-form-item label="任务类型" prop="orderType">
          <el-select v-model="form.orderType" placeholder="请选择任务类型">
            <el-option label="快递代取" value="快递代取"></el-option>
            <el-option label="外卖代拿" value="外卖代拿"></el-option>
            <el-option label="校园跑腿" value="校园跑腿"></el-option>
            <el-option label="其他" value="其他"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="任务标题" prop="title">
          <el-input v-model="form.title" placeholder="一句话描述你的需求" />
        </el-form-item>
        <el-form-item label="详细描述" prop="detail">
          <el-input v-model="form.detail" type="textarea" :rows="3" placeholder="例如取件码、具体商品、期望送达时间等" />
        </el-form-item>
        <el-form-item label="送达地址" prop="deliveryAddress">
          <el-input v-model="form.deliveryAddress" placeholder="请输入宿舍楼、教室等" />
        </el-form-item>
        <el-form-item label="悬赏金额" prop="reward">
          <el-input-number v-model="form.reward" :precision="2" :step="1" :min="0"></el-input-number> 元
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">发 布</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
// 【修改】导入 takeErrandOrder 接口
import { listErrand, addErrand, takeErrandOrder } from "@/api/campus/errand";

export default {
  name: "ErrandHall",
  data() {
    return {
      loading: true,
      showSearch: true,
      total: 0,
      orderList: [],
      title: "",
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        status: '0'
      },
      form: {},
      rules: {
        orderType: [
          { required: true, message: "任务类型不能为空", trigger: "change" }
        ],
        title: [
          { required: true, message: "订单标题不能为空", trigger: "blur" }
        ],
        reward: [
          { required: true, message: "悬赏金额不能为空", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    getList() {
      this.loading = true;
      listErrand(this.queryParams).then(response => {
        this.orderList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    cancel() {
      this.open = false;
      this.reset();
    },
    reset() {
      this.form = {
        orderId: null,
        orderType: "快递代取",
        title: null,
        detail: null,
        reward: 5,
        deliveryAddress: null,
      };
      this.resetForm("form");
    },
    handlePublish() {
      this.reset();
      this.open = true;
      this.title = "发布跑腿任务";
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          addErrand(this.form).then(response => {
            this.$modal.msgSuccess("发布成功");
            this.open = false;
            this.getList();
          });
        }
      });
    },
    /** 【修改】实现接单逻辑 */
    handleTakeOrder(row) {
      this.$modal.confirm('是否确认接收这个跑腿任务？').then(() => {
        return takeErrandOrder(row.orderId);
      }).then(() => {
        this.$modal.msgSuccess("接单成功！");
        // 刷新列表，这样被接单的任务就会消失
        this.getList();
      }).catch(() => {});
    }
  }
};
</script>

<style scoped>
/* 样式部分无需修改 */
.errand-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
}
.errand-card {
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.08);
  padding: 15px 20px;
  display: flex;
  flex-direction: column;
  transition: all 0.3s ease;
}
.errand-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 20px rgba(0,0,0,0.12);
}
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}
.reward {
  color: #ff4949;
  font-size: 20px;
  font-weight: bold;
}
.card-body .title {
  font-size: 16px;
  margin-bottom: 8px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  font-weight: 600;
}
.card-body .detail {
  font-size: 14px;
  color: #666;
  margin-bottom: 15px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  min-height: 42px; /* 保持两行的高度 */
}
.card-body .address {
  font-size: 13px;
  color: #999;
}
.card-body .address i {
  margin-right: 5px;
}
.card-footer {
  margin-top: auto;
  padding-top: 15px;
  border-top: 1px solid #f0f0f0;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.publisher-info {
  display: flex;
  align-items: center;
  font-size: 13px;
  color: #888;
}
.publisher-info .nickname {
  margin-left: 8px;
}
.empty-state {
  grid-column: 1 / -1;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 400px;
}
</style>
