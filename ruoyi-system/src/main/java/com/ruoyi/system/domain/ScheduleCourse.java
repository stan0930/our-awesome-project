package com.ruoyi.system.domain;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 课程表对象 schedule_course
 * 
 * @author ruoyi
 */
public class ScheduleCourse extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 课程ID */
    private Long id;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** 星期几(1-7) */
    @Excel(name = "星期几")
    private Integer day;

    /** 第几节课(1-12) */
    @Excel(name = "第几节课")
    private Integer section;

    /** 课程名称 */
    @Excel(name = "课程名称")
    private String name;

    /** 教师姓名 */
    @Excel(name = "教师姓名")
    private String teacher;

    /** 上课地点 */
    @Excel(name = "上课地点")
    private String location;

    /** 课程颜色 */
    @Excel(name = "课程颜色")
    private String color;

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setDay(Integer day) {
        this.day = day;
    }

    public Integer getDay() {
        return day;
    }

    public void setSection(Integer section) {
        this.section = section;
    }

    public Integer getSection() {
        return section;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setTeacher(String teacher) {
        this.teacher = teacher;
    }

    public String getTeacher() {
        return teacher;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getLocation() {
        return location;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getColor() {
        return color;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("id", getId())
                .append("userId", getUserId())
                .append("day", getDay())
                .append("section", getSection())
                .append("name", getName())
                .append("teacher", getTeacher())
                .append("location", getLocation())
                .append("color", getColor())
                .append("createTime", getCreateTime())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
