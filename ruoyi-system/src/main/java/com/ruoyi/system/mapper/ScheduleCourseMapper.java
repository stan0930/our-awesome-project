package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.ScheduleCourse;

/**
 * 课程表Mapper接口
 * 
 * @author ruoyi
 */
public interface ScheduleCourseMapper {
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
     * 删除课程表
     * 
     * @param id 课程表主键
     * @return 结果
     */
    public int deleteScheduleCourseById(Long id);

    /**
     * 批量删除课程表
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteScheduleCourseByIds(Long[] ids);

    /**
     * 批量新增课程表
     * 
     * @param scheduleCourseList 课程表列表
     * @return 结果
     */
    public int batchInsertScheduleCourse(List<ScheduleCourse> scheduleCourseList);
}
