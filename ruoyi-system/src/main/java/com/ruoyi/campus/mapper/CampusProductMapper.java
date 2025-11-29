package com.ruoyi.campus.mapper;

import java.util.List;
import com.ruoyi.campus.domain.CampusProduct;
import org.apache.ibatis.annotations.Param; // 【新增】导入 Param

/**
 * 校园二手商品Mapper接口
 * * @author ruoyi
 * 
 * @date (你的生成日期)
 */
public interface CampusProductMapper {
    /**
     * 查询校园二手商品
     * * @param productId 校园二手商品主键
     * 
     * @return 校园二手商品
     */
    public CampusProduct selectCampusProductByProductId(Long productId);

    /**
     * 查询校园二手商品列表
     * * @param campusProduct 校园二手商品
     * 
     * @return 校园二手商品集合
     */
    public List<CampusProduct> selectCampusProductList(CampusProduct campusProduct);

    /**
     * 新增校园二手商品
     * * @param campusProduct 校园二手商品
     * 
     * @return 结果
     */
    public int insertCampusProduct(CampusProduct campusProduct);

    /**
     * 修改校园二手商品
     * * @param campusProduct 校园二手商品
     * 
     * @return 结果
     */
    public int updateCampusProduct(CampusProduct campusProduct);

    /**
     * 删除校园二手商品
     * * @param productId 校园二手商品主键
     * 
     * @return 结果
     */
    public int deleteCampusProductByProductId(Long productId);

    /**
     * 批量删除校园二手商品
     * * @param productIds 需要删除的数据主键集合
     * 
     * @return 结果
     */
    public int deleteCampusProductByProductIds(Long[] productIds);

    /**
     * 【新增】查询商品并锁定
     * 
     * @param productId 商品ID
     * @return 商品
     */
    public CampusProduct selectCampusProductByProductIdForUpdate(@Param("productId") Long productId);

    /**
     * 【新增】更新商品状态
     * 
     * @param productId 商品ID
     * @param status    状态
     * @return 结果
     */
    public int updateCampusProductStatus(@Param("productId") Long productId, @Param("status") String status);

    /**
     * 【新增】增加浏览次数
     * 
     * @param productId 商品ID
     * @return 结果
     */
    public int incrementViewCount(@Param("productId") Long productId);

    /**
     * 【新增】添加收藏
     * 
     * @param productId 商品ID
     * @param userId    用户ID
     * @return 结果
     */
    public int insertProductFavorite(@Param("productId") Long productId, @Param("userId") Long userId);

    /**
     * 【新增】取消收藏
     * 
     * @param productId 商品ID
     * @param userId    用户ID
     * @return 结果
     */
    public int deleteProductFavorite(@Param("productId") Long productId, @Param("userId") Long userId);

    /**
     * 【新增】判断是否已收藏
     * 
     * @param productId 商品ID
     * @param userId    用户ID
     * @return 是否已收藏
     */
    public int checkProductFavorite(@Param("productId") Long productId, @Param("userId") Long userId);

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
    public List<CampusProduct> selectMyFavoriteProducts(@Param("userId") Long userId);
}
