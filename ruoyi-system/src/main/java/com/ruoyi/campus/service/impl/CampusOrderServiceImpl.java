package com.ruoyi.campus.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.campus.mapper.CampusOrderMapper;
import com.ruoyi.campus.domain.CampusOrder;
import com.ruoyi.campus.service.ICampusOrderService;

/**
 * 校园订单Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-11-11
 */
@Service
public class CampusOrderServiceImpl implements ICampusOrderService 
{
    @Autowired
    private CampusOrderMapper campusOrderMapper;

    /**
     * 查询校园订单
     * 
     * @param orderId 校园订单主键
     * @return 校园订单
     */
    @Override
    public CampusOrder selectCampusOrderByOrderId(Long orderId)
    {
        return campusOrderMapper.selectCampusOrderByOrderId(orderId);
    }

    /**
     * 查询校园订单列表
     * 
     * @param campusOrder 校园订单
     * @return 校园订单
     */
    @Override
    public List<CampusOrder> selectCampusOrderList(CampusOrder campusOrder)
    {
        return campusOrderMapper.selectCampusOrderList(campusOrder);
    }

    /**
     * 新增校园订单
     * 
     * @param campusOrder 校园订单
     * @return 结果
     */
    @Override
    public int insertCampusOrder(CampusOrder campusOrder)
    {
        campusOrder.setCreateTime(DateUtils.getNowDate());
        return campusOrderMapper.insertCampusOrder(campusOrder);
    }

    /**
     * 修改校园订单
     * 
     * @param campusOrder 校园订单
     * @return 结果
     */
    @Override
    public int updateCampusOrder(CampusOrder campusOrder)
    {
        campusOrder.setUpdateTime(DateUtils.getNowDate());
        return campusOrderMapper.updateCampusOrder(campusOrder);
    }

    /**
     * 批量删除校园订单
     * 
     * @param orderIds 需要删除的校园订单主键
     * @return 结果
     */
    @Override
    public int deleteCampusOrderByOrderIds(Long[] orderIds)
    {
        return campusOrderMapper.deleteCampusOrderByOrderIds(orderIds);
    }

    /**
     * 删除校园订单信息
     * 
     * @param orderId 校园订单主键
     * @return 结果
     */
    @Override
    public int deleteCampusOrderByOrderId(Long orderId)
    {
        return campusOrderMapper.deleteCampusOrderByOrderId(orderId);
    }
}
