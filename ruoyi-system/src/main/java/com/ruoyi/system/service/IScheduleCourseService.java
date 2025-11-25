package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.ScheduleCourse;

/**
 * 课程表Service接口
 * 
 * @author ruoyi
 */
public interface IScheduleCourseService {
    /**
     * 查询课程表
     * 
     * @param id 课程表主键
     * @return 课程表
     */
    public ScheduleCourse selectScheduleCourseById(Long id);

    /**
     * 查询课程表列表
     * 
     * @param scheduleCourse 课程表
     * @return 课程表集合
     */
    public List<ScheduleCourse> selectScheduleCourseList(ScheduleCourse scheduleCourse);

    /**
     * 新增课程表
     * 
     * @param scheduleCourse 课程表
     * @return 结果
     */
    public int insertScheduleCourse(ScheduleCourse scheduleCourse);

    /**
     * 修改课程表
     * 
     * @param scheduleCourse 课程表
     * @return 结果
     */
    public int updateScheduleCourse(ScheduleCourse scheduleCourse);

    /**
     * 批量删除课程表
     * 
     * @param ids 需要删除的课程表主键集合
     * @return 结果
     */
    public int deleteScheduleCourseByIds(Long[] ids);

    /**
     * 删除课程表信息
     * 
     * @param id 课程表主键
     * @return 结果
     */
    public int deleteScheduleCourseById(Long id);

    /**
     * 批量新增课程表
     * 
     * @param scheduleCourseList 课程表列表
     * @return 结果
     */
    public int batchInsertScheduleCourse(List<ScheduleCourse> scheduleCourseList);
}
