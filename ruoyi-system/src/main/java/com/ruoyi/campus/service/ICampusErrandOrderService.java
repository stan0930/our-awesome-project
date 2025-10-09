package com.ruoyi.campus.service;

import java.util.List;
import com.ruoyi.campus.domain.CampusErrandOrder;

/**
 * 跑腿订单Service接口
 * * @author ruoyi
 * @date 2025-10-09
 */
public interface ICampusErrandOrderService
{
    /**
     * 查询跑腿订单
     * * @param orderId 跑腿订单主键
     * @return 跑腿订单
     */
    public CampusErrandOrder selectCampusErrandOrderByOrderId(Long orderId);

    /**
     * 查询跑腿订单列表
     * * @param campusErrandOrder 跑腿订单
     * @return 跑腿订单集合
     */
    public List<CampusErrandOrder> selectCampusErrandOrderList(CampusErrandOrder campusErrandOrder);

    /**
     * 新增跑腿订单
     * * @param campusErrandOrder 跑腿订单
     * @return 结果
     */
    public int insertCampusErrandOrder(CampusErrandOrder campusErrandOrder);

    /**
     * 修改跑腿订单
     * * @param campusErrandOrder 跑腿订单
     * @return 结果
     */
    public int updateCampusErrandOrder(CampusErrandOrder campusErrandOrder);

    /**
     * 批量删除跑腿订单
     * * @param orderIds 需要删除的跑腿订单主键集合
     * @return 结果
     */
    public int deleteCampusErrandOrderByOrderIds(Long[] orderIds);

    /**
     * 删除跑腿订单信息
     * * @param orderId 跑腿订单主键
     * @return 结果
     */
    public int deleteCampusErrandOrderByOrderId(Long orderId);

    /**
     * 【新增】接单
     * @param orderId 订单ID
     * @param takerId 接单人ID
     * @return 结果
     */
    public int takeOrder(Long orderId, Long takerId);

    /**
     * 【新增】查询我发布的跑腿订单列表
     * @param campusErrandOrder 查询条件
     * @return 跑腿订单集合
     */
    public List<CampusErrandOrder> selectMyPublishedErrandOrderList(CampusErrandOrder campusErrandOrder);

    /**
     * 【新增】查询我接受的跑腿订单列表
     * @param campusErrandOrder 查询条件
     * @return 跑腿订单集合
     */
    public List<CampusErrandOrder> selectMyTakenErrandOrderList(CampusErrandOrder campusErrandOrder);
}
