package com.ruoyi.campus.service;

import java.util.List;
import com.ruoyi.campus.domain.CampusProduct;

/**
 * 校园二手商品Service接口
 * 
 * @author ruoyi
 * @date 2025-11-11
 */
public interface ICampusProductService {
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
     * 批量删除校园二手商品
     * 
     * @param productIds 需要删除的校园二手商品主键集合
     * @return 结果
     */
    public int deleteCampusProductByProductIds(Long[] productIds);

    /**
     * 删除校园二手商品信息
     * 
     * @param productId 校园二手商品主键
     * @return 结果
     */
    public int deleteCampusProductByProductId(Long productId);

    /**
     * 【新增】切换收藏状态
     * 
     * @param productId 商品ID
     * @param userId    用户ID
     * @return 是否已收藏
     */
    public boolean toggleFavorite(Long productId, Long userId);

    /**
     * 【新增】查询我的商品列表
     * 
     * @param campusProduct 商品
     * @return 商品列表
     */
    public List<CampusProduct> selectMyProducts(CampusProduct campusProduct);

    /**
     * 【新增】查询我的收藏列表
     * 
     * @param userId 用户ID
     * @return 商品列表
     */
    public List<CampusProduct> selectMyFavoriteProducts(Long userId);

    /**
     * 【新增】更新商品状态
     * 
     * @param productId 商品ID
     * @param status    状态
     * @param userId    当前用户ID(用于权限验证)
     * @return 结果
     */
    public int updateProductStatus(Long productId, String status, Long userId);

    /**
     * 【新增】查询商品详情(并增加浏览次数)
     * 
     * @param productId 商品ID
     * @param userId    当前用户ID(用于判断收藏状态)
     * @return 商品详情
     */
    public CampusProduct selectProductDetail(Long productId, Long userId);
}
