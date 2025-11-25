package com.ruoyi.web.controller.app;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.ScheduleCourse;
import com.ruoyi.system.service.IScheduleCourseService;
import com.ruoyi.common.utils.SecurityUtils;

/**
 * 课程表Controller
 * 
 * @author ruoyi
 */
@RestController
@RequestMapping("/app/schedule")
public class ScheduleController extends BaseController {
    @Autowired
    private IScheduleCourseService scheduleCourseService;

    /**
     * 查询课程表列表（App端）
     */
    @GetMapping("/list")
    public AjaxResult list() {
        // 获取当前登录用户ID
        Long userId = SecurityUtils.getUserId();

        ScheduleCourse scheduleCourse = new ScheduleCourse();
        scheduleCourse.setUserId(userId);

        List<ScheduleCourse> list = scheduleCourseService.selectScheduleCourseList(scheduleCourse);
        return success(list);
    }

    /**
     * 获取课程表详细信息
     */
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return success(scheduleCourseService.selectScheduleCourseById(id));
    }

    /**
     * 新增课程表
     */
    @Log(title = "课程表", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ScheduleCourse scheduleCourse) {
        // 设置当前登录用户ID
        scheduleCourse.setUserId(SecurityUtils.getUserId());
        int result = scheduleCourseService.insertScheduleCourse(scheduleCourse);
        if (result > 0) {
            // 返回插入后的完整对象（包含自动生成的ID）
            return success(scheduleCourse);
        }
        return error("添加课程失败");
    }

    /**
     * 修改课程表
     */
    @Log(title = "课程表", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ScheduleCourse scheduleCourse) {
        return toAjax(scheduleCourseService.updateScheduleCourse(scheduleCourse));
    }

    /**
     * 删除课程表
     */
    @Log(title = "课程表", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(scheduleCourseService.deleteScheduleCourseByIds(ids));
    }

    /**
     * 批量保存课程表（用于本地数据同步到云端）
     */
    @Log(title = "课程表批量保存", businessType = BusinessType.INSERT)
    @PostMapping("/batch")
    public AjaxResult batchSave(@RequestBody List<ScheduleCourse> scheduleCourseList) {
        // 获取当前登录用户ID
        Long userId = SecurityUtils.getUserId();

        // 设置用户ID
        for (ScheduleCourse course : scheduleCourseList) {
            course.setUserId(userId);
        }

        return toAjax(scheduleCourseService.batchInsertScheduleCourse(scheduleCourseList));
    }
}
