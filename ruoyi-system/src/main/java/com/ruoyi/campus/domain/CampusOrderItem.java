package com.ruoyi.campus.domain;

import java.math.BigDecimal;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 订单商品关联对象 campus_order_item
 * 
 * @author ruoyi
 * @date 2025-11-11
 */
public class CampusOrderItem extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 订单项ID */
    private Long itemId;

    /** 订单ID */
    @Excel(name = "订单ID")
    private Long orderId;

    /** 商品ID */
    @Excel(name = "商品ID")
    private Long productId;

    /** 商品标题(快照) */
    @Excel(name = "商品标题(快照)")
    private String productTitle;

    /** 商品图片(快照) */
    @Excel(name = "商品图片(快照)")
    private String productImage;

    /** 成交价格 */
    @Excel(name = "成交价格")
    private BigDecimal price;

    /** 购买数量 */
    @Excel(name = "购买数量")
    private Long quantity;

    public void setItemId(Long itemId) 
    {
        this.itemId = itemId;
    }

    public Long getItemId() 
    {
        return itemId;
    }

    public void setOrderId(Long orderId) 
    {
        this.orderId = orderId;
    }

    public Long getOrderId() 
    {
        return orderId;
    }

    public void setProductId(Long productId) 
    {
        this.productId = productId;
    }

    public Long getProductId() 
    {
        return productId;
    }

    public void setProductTitle(String productTitle) 
    {
        this.productTitle = productTitle;
    }

    public String getProductTitle() 
    {
        return productTitle;
    }

    public void setProductImage(String productImage) 
    {
        this.productImage = productImage;
    }

    public String getProductImage() 
    {
        return productImage;
    }

    public void setPrice(BigDecimal price) 
    {
        this.price = price;
    }

    public BigDecimal getPrice() 
    {
        return price;
    }

    public void setQuantity(Long quantity) 
    {
        this.quantity = quantity;
    }

    public Long getQuantity() 
    {
        return quantity;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("itemId", getItemId())
            .append("orderId", getOrderId())
            .append("productId", getProductId())
            .append("productTitle", getProductTitle())
            .append("productImage", getProductImage())
            .append("price", getPrice())
            .append("quantity", getQuantity())
            .append("createTime", getCreateTime())
            .toString();
    }
}
