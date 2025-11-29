package com.ruoyi.campus.domain;

import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 商品收藏对象 campus_product_favorite
 * 
 * @author ruoyi
 * @date 2025-11-28
 */
public class CampusProductFavorite extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 收藏ID */
    private Long favoriteId;

    /** 商品ID */
    private Long productId;

    /** 用户ID */
    private Long userId;

    public void setFavoriteId(Long favoriteId) {
        this.favoriteId = favoriteId;
    }

    public Long getFavoriteId() {
        return favoriteId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public Long getProductId() {
        return productId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getUserId() {
        return userId;
    }
}
