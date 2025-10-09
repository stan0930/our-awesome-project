<template>
  <div class="app-container">
    <el-tabs v-model="activeTab" @tab-click="handleTabClick">
      <el-tab-pane label="我发布的" name="published"></el-tab-pane>
      <el-tab-pane label="我接受的" name="taken"></el-tab-pane>
    </el-tabs>

    <div class="my-errand-list" v-loading="loading">
      <div v-if="orderList.length === 0 && !loading" class="empty-state">
        <el-empty :description="emptyText"></el-empty>
      </div>

      <div class="errand-card" v-for="order in orderList" :key="order.orderId" :class="statusClass(order.status)">
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
          <span class="status-tag">
            <el-tag :type="statusType(order.status)" size="mini">{{ formatStatus(order.status) }}</el-tag>
          </span>
          <div class="actions">
            <el-button v-if="activeTab === 'published' && order.status === '1'" type="success" size="mini" round @click="handleComplete(order)">确认送达</el-button>
            <el-button v-if="activeTab === 'published' && order.status === '0'" type="danger" size="mini" round @click="handleCancel(order)">取消订单</el-button>
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
  </div>
</template>

<script>
import { listMyPublished, listMyTaken, updateErrand } from "@/api/campus/errand";

export default {
  name: "MyErrands",
  data() {
    return {
      loading: true,
      activeTab: 'published',
      orderList: [],
      total: 0,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
      },
    };
  },
  computed: {
    emptyText() {
      return this.activeTab === 'published' ? '您还没有发布过任何任务' : '您还没有接受过任何任务';
    }
  },
  created() {
    this.getList();
  },
  methods: {
    getList() {
      this.loading = true;
      let apiCall = this.activeTab === 'published' ? listMyPublished(this.queryParams) : listMyTaken(this.queryParams);
      apiCall.then(response => {
        this.orderList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    handleTabClick() {
      this.queryParams.pageNum = 1;
      this.orderList = [];
      this.getList();
    },
    formatStatus(status) {
      if (status === '0') return '待接单';
      if (status === '1') return '进行中';
      if (status === '2') return '已完成';
      if (status === '3') return '已取消';
      return '未知';
    },
    statusType(status) {
      if (status === '0') return 'info';
      if (status === '1') return '';
      if (status === '2') return 'success';
      if (status === '3') return 'warning';
      return 'danger';
    },
    statusClass(status) {
      if (status === '2' || status === '3') return 'is-completed';
      return '';
    },
    handleComplete(order) {
      this.$modal.confirm('是否确认任务已送达？').then(() => {
        const updatedOrder = { orderId: order.orderId, status: '2' };
        return updateErrand(updatedOrder);
      }).then(() => {
        this.$modal.msgSuccess("操作成功！订单已完成。");
        this.getList();
      }).catch(() => {});
    },
    handleCancel(order) {
      this.$modal.confirm('是否确认取消这个跑腿任务？').then(() => {
        const updatedOrder = { orderId: order.orderId, status: '3' };
        return updateErrand(updatedOrder);
      }).then(() => {
        this.$modal.msgSuccess("订单已取消");
        this.getList();
      }).catch(() => {});
    }
  }
};
</script>

<style scoped>
/* 复用跑腿大厅的卡片样式，并做微调 */
.my-errand-list {
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
  border-left: 5px solid #409EFF; /* 默认蓝色边框，代表进行中 */
}
.errand-card.is-completed {
  border-left-color: #C0C4CC; /* 完成或取消的订单，灰色边框 */
  opacity: 0.8;
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
  min-height: 42px;
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
.empty-state {
  grid-column: 1 / -1;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 400px;
}
</style>
