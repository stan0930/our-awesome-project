<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="发布人ID (外键, 关联sys_user)" prop="publisherId">
        <el-input
          v-model="queryParams.publisherId"
          placeholder="请输入发布人ID (外键, 关联sys_user)"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="接单人ID (外键, 关联sys_user)" prop="takerId">
        <el-input
          v-model="queryParams.takerId"
          placeholder="请输入接单人ID (外键, 关联sys_user)"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="订单标题" prop="title">
        <el-input
          v-model="queryParams.title"
          placeholder="请输入订单标题"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="悬赏金额" prop="reward">
        <el-input
          v-model="queryParams.reward"
          placeholder="请输入悬赏金额"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="送达地址" prop="deliveryAddress">
        <el-input
          v-model="queryParams.deliveryAddress"
          placeholder="请输入送达地址"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="接单时间" prop="takeTime">
        <el-date-picker clearable
          v-model="queryParams.takeTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择接单时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="完成时间" prop="finishTime">
        <el-date-picker clearable
          v-model="queryParams.finishTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择完成时间">
        </el-date-picker>
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
          v-hasPermi="['campus:errand:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['campus:errand:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['campus:errand:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['campus:errand:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="errandList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="订单ID (主键)" align="center" prop="orderId" />
      <el-table-column label="发布人ID (外键, 关联sys_user)" align="center" prop="publisherId" />
      <el-table-column label="接单人ID (外键, 关联sys_user)" align="center" prop="takerId" />
      <el-table-column label="订单类型 (如: 快递代取, 外卖代拿, 校园跑腿)" align="center" prop="orderType" />
      <el-table-column label="订单标题" align="center" prop="title" />
      <el-table-column label="订单详情" align="center" prop="detail" />
      <el-table-column label="悬赏金额" align="center" prop="reward" />
      <el-table-column label="送达地址" align="center" prop="deliveryAddress" />
      <el-table-column label="订单状态 (0=待接单, 1=进行中, 2=已完成, 3=已取消)" align="center" prop="status" />
      <el-table-column label="接单时间" align="center" prop="takeTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.takeTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="完成时间" align="center" prop="finishTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.finishTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['campus:errand:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['campus:errand:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改跑腿代办对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="发布人ID (外键, 关联sys_user)" prop="publisherId">
          <el-input v-model="form.publisherId" placeholder="请输入发布人ID (外键, 关联sys_user)" />
        </el-form-item>
        <el-form-item label="接单人ID (外键, 关联sys_user)" prop="takerId">
          <el-input v-model="form.takerId" placeholder="请输入接单人ID (外键, 关联sys_user)" />
        </el-form-item>
        <el-form-item label="订单标题" prop="title">
          <el-input v-model="form.title" placeholder="请输入订单标题" />
        </el-form-item>
        <el-form-item label="订单详情" prop="detail">
          <el-input v-model="form.detail" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="悬赏金额" prop="reward">
          <el-input v-model="form.reward" placeholder="请输入悬赏金额" />
        </el-form-item>
        <el-form-item label="送达地址" prop="deliveryAddress">
          <el-input v-model="form.deliveryAddress" placeholder="请输入送达地址" />
        </el-form-item>
        <el-form-item label="接单时间" prop="takeTime">
          <el-date-picker clearable
            v-model="form.takeTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择接单时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="完成时间" prop="finishTime">
          <el-date-picker clearable
            v-model="form.finishTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择完成时间">
          </el-date-picker>
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
import { listErrand, getErrand, delErrand, addErrand, updateErrand } from "@/api/campus/errand"

export default {
  name: "Errand",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 跑腿代办表格数据
      errandList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        publisherId: null,
        takerId: null,
        orderType: null,
        title: null,
        detail: null,
        reward: null,
        deliveryAddress: null,
        status: null,
        takeTime: null,
        finishTime: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        publisherId: [
          { required: true, message: "发布人ID (外键, 关联sys_user)不能为空", trigger: "blur" }
        ],
        orderType: [
          { required: true, message: "订单类型 (如: 快递代取, 外卖代拿, 校园跑腿)不能为空", trigger: "change" }
        ],
        title: [
          { required: true, message: "订单标题不能为空", trigger: "blur" }
        ],
        reward: [
          { required: true, message: "悬赏金额不能为空", trigger: "blur" }
        ],
        status: [
          { required: true, message: "订单状态 (0=待接单, 1=进行中, 2=已完成, 3=已取消)不能为空", trigger: "change" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询跑腿代办列表 */
    getList() {
      this.loading = true
      listErrand(this.queryParams).then(response => {
        this.errandList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        orderId: null,
        publisherId: null,
        takerId: null,
        orderType: null,
        title: null,
        detail: null,
        reward: null,
        deliveryAddress: null,
        status: null,
        createTime: null,
        takeTime: null,
        finishTime: null
      }
      this.resetForm("form")
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.orderId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加跑腿代办"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const orderId = row.orderId || this.ids
      getErrand(orderId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改跑腿代办"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.orderId != null) {
            updateErrand(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addErrand(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const orderIds = row.orderId || this.ids
      this.$modal.confirm('是否确认删除跑腿代办编号为"' + orderIds + '"的数据项？').then(function() {
        return delErrand(orderIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('campus/errand/export', {
        ...this.queryParams
      }, `errand_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
