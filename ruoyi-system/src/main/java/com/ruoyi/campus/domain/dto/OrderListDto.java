package com.ruoyi.campus.domain.dto;

import com.ruoyi.campus.domain.CampusOrder;

/**
 * 订单列表DTO（包含商品信息）
 */
public class OrderListDto extends CampusOrder {

    /** 商品标题 */
    private String productTitle;

    /** 商品图片 */
    private String productImage;

    public String getProductTitle() {
        return productTitle;
    }

    public void setProductTitle(String productTitle) {
        this.productTitle = productTitle;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }
}
