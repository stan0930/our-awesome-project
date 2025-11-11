package com.ruoyi.campus.service;

import java.util.List;
import com.ruoyi.campus.domain.CampusOrder;

/**
 * 校园订单Service接口
 * 
 * @author ruoyi
 * @date 2025-11-11
 */
public interface ICampusOrderService 
{
    /**
     * 查询校园订单
     * 
     * @param orderId 校园订单主键
     * @return 校园订单
     */
    public CampusOrder selectCampusOrderByOrderId(Long orderId);

    /**
     * 查询校园订单列表
     * 
     * @param campusOrder 校园订单
     * @return 校园订单集合
     */
    public List<CampusOrder> selectCampusOrderList(CampusOrder campusOrder);

    /**
     * 新增校园订单
     * 
     * @param campusOrder 校园订单
     * @return 结果
     */
    public int insertCampusOrder(CampusOrder campusOrder);

    /**
     * 修改校园订单
     * 
     * @param campusOrder 校园订单
     * @return 结果
     */
    public int updateCampusOrder(CampusOrder campusOrder);

    /**
     * 批量删除校园订单
     * 
     * @param orderIds 需要删除的校园订单主键集合
     * @return 结果
     */
    public int deleteCampusOrderByOrderIds(Long[] orderIds);

    /**
     * 删除校园订单信息
     * 
     * @param orderId 校园订单主键
     * @return 结果
     */
    public int deleteCampusOrderByOrderId(Long orderId);
}
