package com.ruoyi.campus.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 跑腿代办对象 campus_errand_order
 *
 * @author stan
 * @date 2025-10-08
 */
public class CampusErrandOrder extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 【新增】发布人头像 */
    private String publisherAvatar;

    /** 【新增】接单人头像 */
    private String takerAvatar;

    public String getPublisherAvatar() {
        return publisherAvatar;
    }

    public void setPublisherAvatar(String publisherAvatar) {
        this.publisherAvatar = publisherAvatar;
    }

    public String getTakerAvatar() {
        return takerAvatar;
    }

    public void setTakerAvatar(String takerAvatar) {
        this.takerAvatar = takerAvatar;
    }

    /** 订单ID (主键) */
    private Long orderId;

    /** 发布人ID (外键, 关联sys_user) */
    @Excel(name = "发布人ID (外键, 关联sys_user)")
    private Long publisherId;

    /** 接单人ID (外键, 关联sys_user) */
    @Excel(name = "接单人ID (外键, 关联sys_user)")
    private Long takerId;

    /** 订单类型 (如: 快递代取, 外卖代拿, 校园跑腿) */
    @Excel(name = "订单类型 (如: 快递代取, 外卖代拿, 校园跑腿)")
    private String orderType;

    /** 订单标题 */
    @Excel(name = "订单标题")
    private String title;

    /** 订单详情 */
    @Excel(name = "订单详情")
    private String detail;

    /** 悬赏金额 */
    @Excel(name = "悬赏金额")
    private BigDecimal reward;

    /** 送达地址 */
    @Excel(name = "送达地址")
    private String deliveryAddress;

    /** 订单状态 (0=待接单, 1=进行中, 2=已完成, 3=已取消) */
    @Excel(name = "订单状态 (0=待接单, 1=进行中, 2=已完成, 3=已取消)")
    private String status;

    /** 接单时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "接单时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date takeTime;

    /** 完成时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "完成时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date finishTime;

    /** 【新增】发布人昵称 (用于列表展示) */
    private String publisherNickName;

    /** 【新增】接单人昵称 (用于详情展示) */
    private String takerNickName;

    public void setOrderId(Long orderId)
    {
        this.orderId = orderId;
    }

    public Long getOrderId()
    {
        return orderId;
    }

    public void setPublisherId(Long publisherId)
    {
        this.publisherId = publisherId;
    }

    public Long getPublisherId()
    {
        return publisherId;
    }

    public void setTakerId(Long takerId)
    {
        this.takerId = takerId;
    }

    public Long getTakerId()
    {
        return takerId;
    }

    public void setOrderType(String orderType)
    {
        this.orderType = orderType;
    }

    public String getOrderType()
    {
        return orderType;
    }

    public void setTitle(String title)
    {
        this.title = title;
    }

    public String getTitle()
    {
        return title;
    }

    public void setDetail(String detail)
    {
        this.detail = detail;
    }

    public String getDetail()
    {
        return detail;
    }

    public void setReward(BigDecimal reward)
    {
        this.reward = reward;
    }

    public BigDecimal getReward()
    {
        return reward;
    }

    public void setDeliveryAddress(String deliveryAddress)
    {
        this.deliveryAddress = deliveryAddress;
    }

    public String getDeliveryAddress()
    {
        return deliveryAddress;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getStatus()
    {
        return status;
    }

    public void setTakeTime(Date takeTime)
    {
        this.takeTime = takeTime;
    }

    public Date getTakeTime()
    {
        return takeTime;
    }

    public void setFinishTime(Date finishTime)
    {
        this.finishTime = finishTime;
    }

    public Date getFinishTime()
    {
        return finishTime;
    }

    public String getPublisherNickName() {
        return publisherNickName;
    }

    public void setPublisherNickName(String publisherNickName) {
        this.publisherNickName = publisherNickName;
    }

    public String getTakerNickName() {
        return takerNickName;
    }

    public void setTakerNickName(String takerNickName) {
        this.takerNickName = takerNickName;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("orderId", getOrderId())
            .append("publisherId", getPublisherId())
            .append("takerId", getTakerId())
            .append("orderType", getOrderType())
            .append("title", getTitle())
            .append("detail", getDetail())
            .append("reward", getReward())
            .append("deliveryAddress", getDeliveryAddress())
            .append("status", getStatus())
            .append("createTime", getCreateTime())
            .append("takeTime", getTakeTime())
            .append("finishTime", getFinishTime())
            .toString();
    }
}
