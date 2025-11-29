package com.ruoyi.campus.domain;

import java.math.BigDecimal;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 校园二手商品对象 campus_product
 * 
 * @author ruoyi
 * @date 2025-11-11
 */
public class CampusProduct extends BaseEntity {
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
    private BigDecimal price;

    /** 状态 (0=在售, 1=已售, 2=下架) */
    @Excel(name = "状态 (0=在售, 1=已售, 2=下架)")
    private String status;

    /** 删除标志 (0存在 2删除) */
    private String delFlag;

    /** 商品分类 (digital=数码, book=图书, daily=生活用品, clothing=服饰, other=其他) */
    @Excel(name = "商品分类")
    private String category;

    /** 联系方式 (手机/微信等) */
    @Excel(name = "联系方式")
    private String contactInfo;

    /** 浏览次数 */
    @Excel(name = "浏览次数")
    private Integer viewCount;

    // --- 关联查询字段(不映射到数据库) ---

    /** 卖家昵称 */
    private String nickName;

    /** 卖家头像 */
    private String avatar;

    /** 当前登录用户是否已收藏 */
    private boolean favorited;

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

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTitle() {
        return title;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setImageUrls(String imageUrls) {
        this.imageUrls = imageUrls;
    }

    public String getImageUrls() {
        return imageUrls;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag;
    }

    public String getDelFlag() {
        return delFlag;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getCategory() {
        return category;
    }

    public void setContactInfo(String contactInfo) {
        this.contactInfo = contactInfo;
    }

    public String getContactInfo() {
        return contactInfo;
    }

    public void setViewCount(Integer viewCount) {
        this.viewCount = viewCount;
    }

    public Integer getViewCount() {
        return viewCount;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public boolean isFavorited() {
        return favorited;
    }

    public void setFavorited(boolean favorited) {
        this.favorited = favorited;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("productId", getProductId())
                .append("userId", getUserId())
                .append("title", getTitle())
                .append("description", getDescription())
                .append("category", getCategory())
                .append("imageUrls", getImageUrls())
                .append("price", getPrice())
                .append("contactInfo", getContactInfo())
                .append("viewCount", getViewCount())
                .append("status", getStatus())
                .append("delFlag", getDelFlag())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .append("remark", getRemark())
                .toString();
    }
}
