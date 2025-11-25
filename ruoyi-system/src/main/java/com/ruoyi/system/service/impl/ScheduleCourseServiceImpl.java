package com.ruoyi.system.service.impl;

import java.util.List;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.ScheduleCourseMapper;
import com.ruoyi.system.domain.ScheduleCourse;
import com.ruoyi.system.service.IScheduleCourseService;

/**
 * 课程表Service业务层处理
 * 
 * @author ruoyi
 */
@Service
public class ScheduleCourseServiceImpl implements IScheduleCourseService {
    @Autowired
    private ScheduleCourseMapper scheduleCourseMapper;

    /**
     * 查询课程表
     * 
     * @param id 课程表主键
     * @return 课程表
     */
    @Override
    public ScheduleCourse selectScheduleCourseById(Long id) {
        return scheduleCourseMapper.selectScheduleCourseById(id);
    }

    /**
     * 查询课程表列表
     * 
     * @param scheduleCourse 课程表
     * @return 课程表
     */
    @Override
    public List<ScheduleCourse> selectScheduleCourseList(ScheduleCourse scheduleCourse) {
        return scheduleCourseMapper.selectScheduleCourseList(scheduleCourse);
    }

    /**
     * 新增课程表
     * 
     * @param scheduleCourse 课程表
     * @return 结果
     */
    @Override
    public int insertScheduleCourse(ScheduleCourse scheduleCourse) {
        scheduleCourse.setCreateTime(new Date());
        return scheduleCourseMapper.insertScheduleCourse(scheduleCourse);
    }

    /**
     * 修改课程表
     * 
     * @param scheduleCourse 课程表
     * @return 结果
     */
    @Override
    public int updateScheduleCourse(ScheduleCourse scheduleCourse) {
        scheduleCourse.setUpdateTime(new Date());
        return scheduleCourseMapper.updateScheduleCourse(scheduleCourse);
    }

    /**
     * 批量删除课程表
     * 
     * @param ids 需要删除的课程表主键
     * @return 结果
     */
    @Override
    public int deleteScheduleCourseByIds(Long[] ids) {
        return scheduleCourseMapper.deleteScheduleCourseByIds(ids);
    }

    /**
     * 删除课程表信息
     * 
     * @param id 课程表主键
     * @return 结果
     */
    @Override
    public int deleteScheduleCourseById(Long id) {
        return scheduleCourseMapper.deleteScheduleCourseById(id);
    }

    /**
     * 批量新增课程表
     * 
     * @param scheduleCourseList 课程表列表
     * @return 结果
     */
    @Override
    public int batchInsertScheduleCourse(List<ScheduleCourse> scheduleCourseList) {
        if (scheduleCourseList == null || scheduleCourseList.isEmpty()) {
            return 0;
        }

        // 获取用户ID（所有课程应该属于同一个用户）
        Long userId = scheduleCourseList.get(0).getUserId();

        // 先删除该用户的所有课程（避免重复）
        ScheduleCourse query = new ScheduleCourse();
        query.setUserId(userId);
        List<ScheduleCourse> existingCourses = scheduleCourseMapper.selectScheduleCourseList(query);
        if (!existingCourses.isEmpty()) {
            Long[] existingIds = existingCourses.stream()
                    .map(ScheduleCourse::getId)
                    .toArray(Long[]::new);
            scheduleCourseMapper.deleteScheduleCourseByIds(existingIds);
        }

        // 设置创建时间并批量插入
        Date now = new Date();
        for (ScheduleCourse course : scheduleCourseList) {
            course.setCreateTime(now);
        }
        return scheduleCourseMapper.batchInsertScheduleCourse(scheduleCourseList);
    }
}
