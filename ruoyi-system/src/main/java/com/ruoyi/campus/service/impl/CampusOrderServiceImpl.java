package com.ruoyi.campus.service.impl;

import java.util.List;

// 【新增】导入所有需要的类
import com.ruoyi.campus.domain.CampusProduct;
import com.ruoyi.campus.domain.CampusOrderItem;
import com.ruoyi.campus.domain.dto.CreateOrderDto;
import com.ruoyi.campus.mapper.CampusProductMapper;
import com.ruoyi.campus.mapper.CampusOrderItemMapper;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.transaction.annotation.Transactional; // 【新增】导入事务
// ---

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.campus.mapper.CampusOrderMapper;
import com.ruoyi.campus.domain.CampusOrder;
import com.ruoyi.campus.service.ICampusOrderService;

/**
 * 校园订单Service业务层处理
 * * @author ruoyi
 * 
 * @date (你的生成日期)
 */
@Service
public class CampusOrderServiceImpl implements ICampusOrderService {
    @Autowired
    private CampusOrderMapper campusOrderMapper;

    // 【新增】注入另外两个Mapper
    @Autowired
    private CampusOrderItemMapper campusOrderItemMapper;

    @Autowired
    private CampusProductMapper campusProductMapper;

    /**
     * 查询校园订单
     */
    @Override
    public CampusOrder selectCampusOrderByOrderId(Long orderId) {
        return campusOrderMapper.selectCampusOrderByOrderId(orderId);
    }

    /**
     * 查询校园订单列表
     */
    @Override
    public List<CampusOrder> selectCampusOrderList(CampusOrder campusOrder) {
        return campusOrderMapper.selectCampusOrderList(campusOrder);
    }

    /**
     * 新增校园订单 (这是后台管理用的)
     */
    @Override
    public int insertCampusOrder(CampusOrder campusOrder) {
        campusOrder.setCreateTime(DateUtils.getNowDate());
        return campusOrderMapper.insertCampusOrder(campusOrder);
    }

    /**
     * 修改校园订单
     */
    @Override
    public int updateCampusOrder(CampusOrder campusOrder) {
        campusOrder.setUpdateTime(DateUtils.getNowDate());
        return campusOrderMapper.updateCampusOrder(campusOrder);
    }

    /**
     * 批量删除校园订单
     */
    @Override
    public int deleteCampusOrderByOrderIds(Long[] orderIds) {
        return campusOrderMapper.deleteCampusOrderByOrderIds(orderIds);
    }

    /**
     * 删除校园订单信息
     */
    @Override
    public int deleteCampusOrderByOrderId(Long orderId) {
        return campusOrderMapper.deleteCampusOrderByOrderId(orderId);
    }

    /**
     * 【新增】创建订单 (核心业务)
     * ！！！ 必须加事务，保证数据一致性 ！！！
     */
    @Override
    @Transactional
    public Long createOrder(CreateOrderDto createOrderDto) {
        // 获取当前登录的用户ID，即买家ID
        Long buyerId = SecurityUtils.getUserId();
        Long productId = createOrderDto.getProductId();

        // 1. 【核心】锁定商品：查询商品并使用悲观锁，防止多人同时购买
        // 这个方法是我们在 CampusProductMapper.xml 里新增的
        CampusProduct product = campusProductMapper.selectCampusProductByProductIdForUpdate(productId);

        // 2. 检查商品状态
        if (product == null) {
            throw new ServiceException("商品不存在");
        }
        if (!"0".equals(product.getStatus())) { // '0' 是我们在字典里配置的 "在售"
            throw new ServiceException("商品已售出或已下架");
        }
        if (product.getUserId().equals(buyerId)) {
            throw new ServiceException("不能购买自己的商品");
        }

        // 3. 更新商品状态为“已售” (状态 1)
        // 这个方法是我们在 CampusProductMapper.xml 里新增的
        // 它会检查 status = '0'，作为乐观锁
        int rows = campusProductMapper.updateCampusProductStatus(productId, "1"); // '1' 是 "已售"
        if (rows == 0) {
            // 如果更新失败 (rows=0)，说明在第1步查完后，商品状态被改了 (被别人买走了)
            throw new ServiceException("手慢了，商品刚被别人买走");
        }

        // 4. 创建订单 (CampusOrder)
        CampusOrder order = new CampusOrder();
        // 简单生成订单号，生产环境建议用雪花算法或Redis
        order.setOrderSn("SN" + System.currentTimeMillis() + buyerId);
        order.setBuyerId(buyerId);
        order.setSellerId(product.getUserId());
        order.setTotalAmount(product.getPrice());

        // 状态: '0'=待支付, '1'=待发货
        // 二手平台我们跳过支付环节，直接设置为 "待发货"，等待卖家处理
        order.setStatus("1");

        order.setAddress(createOrderDto.getAddress()); // 设置收货地址
        order.setCreateBy(SecurityUtils.getUsername());
        order.setCreateTime(DateUtils.getNowDate());

        // 插入订单
        campusOrderMapper.insertCampusOrder(order); // 插入后，orderId会被MyBatis回填到 order 对象里

        // 5. 创建订单项 (CampusOrderItem)
        CampusOrderItem item = new CampusOrderItem();
        item.setOrderId(order.getOrderId()); // 使用回填的订单ID
        item.setProductId(product.getProductId());
        // 记录成交时的商品快照，防止卖家后续修改商品信息
        item.setProductTitle(product.getTitle());
        item.setProductImage(product.getImageUrls());
        item.setPrice(product.getPrice());
        item.setQuantity(1L); // 1 后面加个 L
        item.setCreateTime(DateUtils.getNowDate());

        // 插入订单项
        campusOrderItemMapper.insertCampusOrderItem(item);

        // 6. 返回订单ID
        return order.getOrderId();
    }

    /**
     * 【新增】取消订单
     */
    @Override
    public void cancelOrder(Long orderId, Long userId) {
        // 1. 查询订单
        CampusOrder order = campusOrderMapper.selectCampusOrderByOrderId(orderId);
        if (order == null) {
            throw new ServiceException("订单不存在");
        }

        // 2. 权限校验：只有买家可以取消
        if (!order.getBuyerId().equals(userId)) {
            throw new ServiceException("无权操作此订单");
        }

        // 3. 状态校验：只有待发货状态可以取消
        if (!"1".equals(order.getStatus())) {
            throw new ServiceException("当前订单状态不允许取消");
        }

        // 4. 更新订单状态为已取消
        order.setStatus("4");
        order.setUpdateTime(DateUtils.getNowDate());
        campusOrderMapper.updateCampusOrder(order);

        // 5. 恢复商品状态为在售
        Long productId = getProductIdFromOrder(orderId);
        if (productId != null) {
            campusProductMapper.updateCampusProductStatus(productId, "0");
        }
    }

    /**
     * 【新增】确认收货
     */
    @Override
    public void confirmReceipt(Long orderId, Long userId) {
        // 1. 查询订单
        CampusOrder order = campusOrderMapper.selectCampusOrderByOrderId(orderId);
        if (order == null) {
            throw new ServiceException("订单不存在");
        }

        // 2. 权限校验：只有买家可以确认收货
        if (!order.getBuyerId().equals(userId)) {
            throw new ServiceException("无权操作此订单");
        }

        // 3. 状态校验：只有待收货状态可以确认
        if (!"2".equals(order.getStatus())) {
            throw new ServiceException("当前订单状态不允许确认收货");
        }

        // 4. 更新订单状态为已完成
        order.setStatus("3");
        order.setUpdateTime(DateUtils.getNowDate());
        campusOrderMapper.updateCampusOrder(order);
    }

    /**
     * 辅助方法：从订单中获取商品ID
     */
    private Long getProductIdFromOrder(Long orderId) {
        // 通过订单项表查询商品ID
        CampusOrderItem item = campusOrderItemMapper.selectByOrderId(orderId);
        return item != null ? item.getProductId() : null;
    }
}
