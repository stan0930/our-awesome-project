package com.ruoyi.campus.domain;

import java.math.BigDecimal; // 确保导入这个类
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 校园二手商品对象 campus_product
 * * @author ruoyi
 * @date (你的生成日期)
 */
public class CampusProduct extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 商品ID */
    private Long productId;

    /** 卖家用户ID */
    @Excel(name = "卖家用户ID")
    private Long userId;

    /** 商品标题 */
    @Excel(name = "商品标题")
    private String title;

    /** 商品描述 */
    @Excel(name = "商品描述")
    private String description;

    /** 商品图片 */
    @Excel(name = "商品图片")
    private String imageUrls;

    /** 价格 */
    @Excel(name = "价格")
    private BigDecimal price; // 注意：价格一般用 BigDecimal

    /** 状态 (0=在售, 1=已售, 2=下架) */
    @Excel(name = "状态")
    private String status;

    /** 删除标志 */
    private String delFlag; // 【【【 1. 在这里添加 delFlag 字段 】】】

    /** 卖家昵称 (从sys_user表join) */
    private String nickName;


    // ---------------------------------
    // 下面是 Getters and Setters
    // ---------------------------------

    public void setProductId(Long productId)
    {
        this.productId = productId;
    }

    public Long getProductId()
    {
        return productId;
    }
    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Long getUserId()
    {
        return userId;
    }
    public void setTitle(String title)
    {
        this.title = title;
    }

    public String getTitle()
    {
        return title;
    }
    public void setDescription(String description)
    {
        this.description = description;
    }

    public String getDescription()
    {
        return description;
    }
    public void setImageUrls(String imageUrls)
    {
        this.imageUrls = imageUrls;
    }

    public String getImageUrls()
    {
        return imageUrls;
    }
    public void setPrice(BigDecimal price)
    {
        this.price = price;
    }

    public BigDecimal getPrice()
    {
        return price;
    }
    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getStatus()
    {
        return status;
    }
    public void setNickName(String nickName)
    {
        this.nickName = nickName;
    }

    public String getNickName()
    {
        return nickName;
    }

    // 【【【 2. 在最后添加 delFlag 的 getter/setter 】】】
    public void setDelFlag(String delFlag)
    {
        this.delFlag = delFlag;
    }

    public String getDelFlag()
    {
        return delFlag;
    }
    // 【【【 添加结束 】】】


    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
                // 调用 super.toString() 来打印父类(BaseEntity)的字段
                .appendSuper(super.toString())

                // 只打印子类(CampusProduct)自己独有的字段
                .append("productId", getProductId())
                .append("userId", getUserId())
                .append("title", getTitle())
                .append("description", getDescription())
                .append("imageUrls", getImageUrls())
                .append("price", getPrice())
                .append("status", getStatus())
                .append("delFlag", getDelFlag()) // delFlag 现在有了
                .append("nickName", getNickName())
                .toString();
    }
}
