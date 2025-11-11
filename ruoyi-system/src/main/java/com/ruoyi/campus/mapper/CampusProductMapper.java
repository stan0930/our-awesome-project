package com.ruoyi.campus.mapper;

import java.util.List;
import com.ruoyi.campus.domain.CampusProduct;

/**
 * 校园二手商品Mapper接口
 * 
 * @author ruoyi
 * @date 2025-11-11
 */
public interface CampusProductMapper 
{
    /**
     * 查询校园二手商品
     * 
     * @param productId 校园二手商品主键
     * @return 校园二手商品
     */
    public CampusProduct selectCampusProductByProductId(Long productId);

    /**
     * 查询校园二手商品列表
     * 
     * @param campusProduct 校园二手商品
     * @return 校园二手商品集合
     */
    public List<CampusProduct> selectCampusProductList(CampusProduct campusProduct);

    /**
     * 新增校园二手商品
     * 
     * @param campusProduct 校园二手商品
     * @return 结果
     */
    public int insertCampusProduct(CampusProduct campusProduct);

    /**
     * 修改校园二手商品
     * 
     * @param campusProduct 校园二手商品
     * @return 结果
     */
    public int updateCampusProduct(CampusProduct campusProduct);

    /**
     * 删除校园二手商品
     * 
     * @param productId 校园二手商品主键
     * @return 结果
     */
    public int deleteCampusProductByProductId(Long productId);

    /**
     * 批量删除校园二手商品
     * 
     * @param productIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCampusProductByProductIds(Long[] productIds);
}
