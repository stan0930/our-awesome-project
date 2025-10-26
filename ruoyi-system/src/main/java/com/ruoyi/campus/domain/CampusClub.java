package com.ruoyi.campus.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 社团管理对象 campus_club
 * 
 * @author ruoyi
 * @date 2025-10-26
 */
public class CampusClub extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 社团id */
    @Excel(name = "社团id")
    private Long clubId;

    /** 社团名称 */
    @Excel(name = "社团名称")
    private String clubName;

    /** 社团logo */
    @Excel(name = "社团logo")
    private String logo;

    /** 社团简介 */
    @Excel(name = "社团简介")
    private String description;

    /** 社长（关联sys_user表） */
    private Long presidentUserId;

    /** 社长姓名 */
    @Excel(name = "社长姓名")
    private String presidentName;

    /** 状态（0正常 1停用） */
    @Excel(name = "状态", readConverterExp = "0=正常,1=停用")
    private String status;

    public void setClubId(Long clubId) 
    {
        this.clubId = clubId;
    }

    public Long getClubId() 
    {
        return clubId;
    }

    public void setClubName(String clubName) 
    {
        this.clubName = clubName;
    }

    public String getClubName() 
    {
        return clubName;
    }

    public void setLogo(String logo) 
    {
        this.logo = logo;
    }

    public String getLogo() 
    {
        return logo;
    }

    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
    }

    public void setPresidentUserId(Long presidentUserId) 
    {
        this.presidentUserId = presidentUserId;
    }

    public Long getPresidentUserId() 
    {
        return presidentUserId;
    }

    public void setPresidentName(String presidentName) 
    {
        this.presidentName = presidentName;
    }

    public String getPresidentName() 
    {
        return presidentName;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("clubId", getClubId())
            .append("clubName", getClubName())
            .append("logo", getLogo())
            .append("description", getDescription())
            .append("presidentUserId", getPresidentUserId())
            .append("presidentName", getPresidentName())
            .append("status", getStatus())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
