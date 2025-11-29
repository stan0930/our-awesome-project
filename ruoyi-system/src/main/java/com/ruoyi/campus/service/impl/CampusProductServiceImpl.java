package com.ruoyi.campus.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.campus.mapper.CampusProductMapper;
import com.ruoyi.campus.domain.CampusProduct;
import com.ruoyi.campus.service.ICampusProductService;

/**
 * 校园二手商品Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-11-11
 */
@Service
public class CampusProductServiceImpl implements ICampusProductService {
    @Autowired
    private CampusProductMapper campusProductMapper;

    /**
     * 查询校园二手商品
     * 
     * @param productId 校园二手商品主键
     * @return 校园二手商品
     */
    @Override
    public CampusProduct selectCampusProductByProductId(Long productId) {
        return campusProductMapper.selectCampusProductByProductId(productId);
    }

    /**
     * 查询校园二手商品列表
     * 
     * @param campusProduct 校园二手商品
     * @return 校园二手商品
     */
    @Override
    public List<CampusProduct> selectCampusProductList(CampusProduct campusProduct) {
        return campusProductMapper.selectCampusProductList(campusProduct);
    }

    /**
     * 新增校园二手商品
     * 
     * @param campusProduct 校园二手商品
     * @return 结果
     */
    @Override
    public int insertCampusProduct(CampusProduct campusProduct) {
        campusProduct.setCreateTime(DateUtils.getNowDate());
        return campusProductMapper.insertCampusProduct(campusProduct);
    }

    /**
     * 修改校园二手商品
     * 
     * @param campusProduct 校园二手商品
     * @return 结果
     */
    @Override
    public int updateCampusProduct(CampusProduct campusProduct) {
        campusProduct.setUpdateTime(DateUtils.getNowDate());
        return campusProductMapper.updateCampusProduct(campusProduct);
    }

    /**
     * 批量删除校园二手商品
     * 
     * @param productIds 需要删除的校园二手商品主键
     * @return 结果
     */
    @Override
    public int deleteCampusProductByProductIds(Long[] productIds) {
        return campusProductMapper.deleteCampusProductByProductIds(productIds);
    }

    /**
     * 删除校园二手商品信息
     * 
     * @param productId 校园二手商品主键
     * @return 结果
     */
    @Override
    public int deleteCampusProductByProductId(Long productId) {
        return campusProductMapper.deleteCampusProductByProductId(productId);
    }

    /**
     * 【新增】切换收藏状态
     */
    @Override
    public boolean toggleFavorite(Long productId, Long userId) {
        int count = campusProductMapper.checkProductFavorite(productId, userId);
        if (count > 0) {
            // 已收藏，取消收藏
            campusProductMapper.deleteProductFavorite(productId, userId);
            return false;
        } else {
            // 未收藏，添加收藏
            campusProductMapper.insertProductFavorite(productId, userId);
            return true;
        }
    }

    /**
     * 【新增】查询我的商品列表
     */
    @Override
    public List<CampusProduct> selectMyProducts(CampusProduct campusProduct) {
        return campusProductMapper.selectMyProducts(campusProduct);
    }

    /**
     * 【新增】查询我的收藏列表
     */
    @Override
    public List<CampusProduct> selectMyFavoriteProducts(Long userId) {
        return campusProductMapper.selectMyFavoriteProducts(userId);
    }

    /**
     * 【新增】更新商品状态
     */
    @Override
    public int updateProductStatus(Long productId, String status, Long userId) {
        // 验证商品是否属于当前用户
        CampusProduct product = campusProductMapper.selectCampusProductByProductId(productId);
        if (product == null || !product.getUserId().equals(userId)) {
            throw new RuntimeException("无权操作此商品");
        }
        return campusProductMapper.updateCampusProductStatus(productId, status);
    }

    /**
     * 【新增】查询商品详情(并增加浏览次数)
     */
    @Override
    public CampusProduct selectProductDetail(Long productId, Long userId) {
        // 先增加浏览次数
        campusProductMapper.incrementViewCount(productId);
        // 查询商品详情
        CampusProduct product = campusProductMapper.selectCampusProductByProductId(productId);
        if (product != null && userId != null) {
            // 判断是否已收藏
            int count = campusProductMapper.checkProductFavorite(productId, userId);
            product.setFavorited(count > 0);
        }
        return product;
    }
}
