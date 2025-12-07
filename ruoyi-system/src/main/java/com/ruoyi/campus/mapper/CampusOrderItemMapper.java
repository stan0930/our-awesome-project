package com.ruoyi.campus.mapper;

import java.util.List;
import com.ruoyi.campus.domain.CampusOrderItem;

/**
 * 订单商品关联Mapper接口
 * 
 * @author ruoyi
 * @date 2025-11-11
 */
public interface CampusOrderItemMapper {
    /**
     * 查询订单商品关联
     * 
     * @param itemId 订单商品关联主键
     * @return 订单商品关联
     */
    public CampusOrderItem selectCampusOrderItemByItemId(Long itemId);

    /**
     * 查询订单商品关联列表
     * 
     * @param campusOrderItem 订单商品关联
     * @return 订单商品关联集合
     */
    public List<CampusOrderItem> selectCampusOrderItemList(CampusOrderItem campusOrderItem);

    /**
     * 新增订单商品关联
     * 
     * @param campusOrderItem 订单商品关联
     * @return 结果
     */
    public int insertCampusOrderItem(CampusOrderItem campusOrderItem);

    /**
     * 修改订单商品关联
     * 
     * @param campusOrderItem 订单商品关联
     * @return 结果
     */
    public int updateCampusOrderItem(CampusOrderItem campusOrderItem);

    /**
     * 删除订单商品关联
     * 
     * @param itemId 订单商品关联主键
     * @return 结果
     */
    public int deleteCampusOrderItemByItemId(Long itemId);

    /**
     * 批量删除订单商品关联
     * 
     * @param itemIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCampusOrderItemByItemIds(Long[] itemIds);

    /**
     * 【新增】根据订单ID查询订单项
     * 
     * @param orderId 订单ID
     * @return 订单项
     */
    public CampusOrderItem selectByOrderId(Long orderId);
}
