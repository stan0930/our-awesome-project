package com.ruoyi.campus.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.campus.mapper.CampusOrderItemMapper;
import com.ruoyi.campus.domain.CampusOrderItem;
import com.ruoyi.campus.service.ICampusOrderItemService;

/**
 * 订单商品关联Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-11-11
 */
@Service
public class CampusOrderItemServiceImpl implements ICampusOrderItemService 
{
    @Autowired
    private CampusOrderItemMapper campusOrderItemMapper;

    /**
     * 查询订单商品关联
     * 
     * @param itemId 订单商品关联主键
     * @return 订单商品关联
     */
    @Override
    public CampusOrderItem selectCampusOrderItemByItemId(Long itemId)
    {
        return campusOrderItemMapper.selectCampusOrderItemByItemId(itemId);
    }

    /**
     * 查询订单商品关联列表
     * 
     * @param campusOrderItem 订单商品关联
     * @return 订单商品关联
     */
    @Override
    public List<CampusOrderItem> selectCampusOrderItemList(CampusOrderItem campusOrderItem)
    {
        return campusOrderItemMapper.selectCampusOrderItemList(campusOrderItem);
    }

    /**
     * 新增订单商品关联
     * 
     * @param campusOrderItem 订单商品关联
     * @return 结果
     */
    @Override
    public int insertCampusOrderItem(CampusOrderItem campusOrderItem)
    {
        campusOrderItem.setCreateTime(DateUtils.getNowDate());
        return campusOrderItemMapper.insertCampusOrderItem(campusOrderItem);
    }

    /**
     * 修改订单商品关联
     * 
     * @param campusOrderItem 订单商品关联
     * @return 结果
     */
    @Override
    public int updateCampusOrderItem(CampusOrderItem campusOrderItem)
    {
        return campusOrderItemMapper.updateCampusOrderItem(campusOrderItem);
    }

    /**
     * 批量删除订单商品关联
     * 
     * @param itemIds 需要删除的订单商品关联主键
     * @return 结果
     */
    @Override
    public int deleteCampusOrderItemByItemIds(Long[] itemIds)
    {
        return campusOrderItemMapper.deleteCampusOrderItemByItemIds(itemIds);
    }

    /**
     * 删除订单商品关联信息
     * 
     * @param itemId 订单商品关联主键
     * @return 结果
     */
    @Override
    public int deleteCampusOrderItemByItemId(Long itemId)
    {
        return campusOrderItemMapper.deleteCampusOrderItemByItemId(itemId);
    }
}
