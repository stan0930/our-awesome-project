package com.ruoyi.campus.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.exception.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.campus.mapper.CampusErrandOrderMapper;
import com.ruoyi.campus.domain.CampusErrandOrder;
import com.ruoyi.campus.service.ICampusErrandOrderService;

/**
 * 跑腿订单Service业务层处理
 * * @author ruoyi
 * @date 2025-10-09
 */
@Service
public class CampusErrandOrderServiceImpl implements ICampusErrandOrderService
{
    @Autowired
    private CampusErrandOrderMapper campusErrandOrderMapper;

    /**
     * 查询跑腿订单
     * * @param orderId 跑腿订单主键
     * @return 跑腿订单
     */
    @Override
    public CampusErrandOrder selectCampusErrandOrderByOrderId(Long orderId)
    {
        return campusErrandOrderMapper.selectCampusErrandOrderByOrderId(orderId);
    }

    /**
     * 查询跑腿订单列表
     * * @param campusErrandOrder 跑腿订单
     * @return 跑腿订单
     */
    @Override
    public List<CampusErrandOrder> selectCampusErrandOrderList(CampusErrandOrder campusErrandOrder)
    {
        return campusErrandOrderMapper.selectCampusErrandOrderList(campusErrandOrder);
    }

    /**
     * 新增跑腿订单
     * * @param campusErrandOrder 跑腿订单
     * @return 结果
     */
    @Override
    public int insertCampusErrandOrder(CampusErrandOrder campusErrandOrder)
    {
        campusErrandOrder.setCreateTime(DateUtils.getNowDate());
        return campusErrandOrderMapper.insertCampusErrandOrder(campusErrandOrder);
    }

    /**
     * 修改跑腿订单
     * * @param campusErrandOrder 跑腿订单
     * @return 结果
     */
    @Override
    public int updateCampusErrandOrder(CampusErrandOrder campusErrandOrder)
    {
        return campusErrandOrderMapper.updateCampusErrandOrder(campusErrandOrder);
    }

    /**
     * 批量删除跑腿订单
     * * @param orderIds 需要删除的跑腿订单主键
     * @return 结果
     */
    @Override
    public int deleteCampusErrandOrderByOrderIds(Long[] orderIds)
    {
        return campusErrandOrderMapper.deleteCampusErrandOrderByOrderIds(orderIds);
    }

    /**
     * 删除跑腿订单信息
     * * @param orderId 跑腿订单主键
     * @return 结果
     */
    @Override
    public int deleteCampusErrandOrderByOrderId(Long orderId)
    {
        return campusErrandOrderMapper.deleteCampusErrandOrderByOrderId(orderId);
    }

    /**
     * 接单逻辑
     */
    @Override
    public int takeOrder(Long orderId, Long takerId) {
        CampusErrandOrder order = campusErrandOrderMapper.selectCampusErrandOrderByOrderId(orderId);
        // 校验1：订单是否存在
        if (order == null) {
            throw new ServiceException("订单不存在");
        }
        // 校验2：订单状态是否为“待接单”
        if (!"0".equals(order.getStatus())) {
            throw new ServiceException("订单已被他人捷足先登啦");
        }
        // 校验3：不能接自己发布的订单
        if (order.getPublisherId().equals(takerId)) {
            throw new ServiceException("不能接自己发布的任务哦");
        }

        // 更新订单信息
        order.setTakerId(takerId);
        order.setStatus("1"); // 状态更新为“进行中”
        order.setTakeTime(DateUtils.getNowDate()); // 记录接单时间

        return campusErrandOrderMapper.updateCampusErrandOrder(order);
    }

    /**
     * 查询我发布的跑腿订单
     */
    @Override
    public List<CampusErrandOrder> selectMyPublishedErrandOrderList(CampusErrandOrder campusErrandOrder) {
        return campusErrandOrderMapper.selectCampusErrandOrderList(campusErrandOrder);
    }

    /**
     * 查询我接受的跑腿订单
     */
    @Override
    public List<CampusErrandOrder> selectMyTakenErrandOrderList(CampusErrandOrder campusErrandOrder) {
        return campusErrandOrderMapper.selectCampusErrandOrderList(campusErrandOrder);
    }
}
