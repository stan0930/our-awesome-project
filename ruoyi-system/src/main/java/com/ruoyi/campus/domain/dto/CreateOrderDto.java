package com.ruoyi.campus.domain.dto;

/**
 * 创建订单 DTO
 * 专门用于接收前端创建订单时传来的数据
 */
public class CreateOrderDto {

    private Long productId;

    private String address;

    // 你也可以在这里添加一个 remark 字段给用户留言

    // --- Getters and Setters ---

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
