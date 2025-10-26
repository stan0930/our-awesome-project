package com.ruoyi.campus.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
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
import com.ruoyi.campus.domain.CampusActivity;
import com.ruoyi.campus.service.ICampusActivityService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 社团活动Controller
 * 
 * @author ruoyi
 * @date 2025-10-26
 */
@RestController
@RequestMapping("/campus/activity")
public class CampusActivityController extends BaseController
{
    @Autowired
    private ICampusActivityService campusActivityService;

    /**
     * 查询社团活动列表
     */
    @PreAuthorize("@ss.hasPermi('campus:activity:list')")
    @GetMapping("/list")
    public TableDataInfo list(CampusActivity campusActivity)
    {
        startPage();
        List<CampusActivity> list = campusActivityService.selectCampusActivityList(campusActivity);
        return getDataTable(list);
    }

    /**
     * 导出社团活动列表
     */
    @PreAuthorize("@ss.hasPermi('campus:activity:export')")
    @Log(title = "社团活动", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, CampusActivity campusActivity)
    {
        List<CampusActivity> list = campusActivityService.selectCampusActivityList(campusActivity);
        ExcelUtil<CampusActivity> util = new ExcelUtil<CampusActivity>(CampusActivity.class);
        util.exportExcel(response, list, "社团活动数据");
    }

    /**
     * 获取社团活动详细信息
     */
    @PreAuthorize("@ss.hasPermi('campus:activity:query')")
    @GetMapping(value = "/{activityId}")
    public AjaxResult getInfo(@PathVariable("activityId") Long activityId)
    {
        return success(campusActivityService.selectCampusActivityByActivityId(activityId));
    }

    /**
     * 新增社团活动
     */
    @PreAuthorize("@ss.hasPermi('campus:activity:add')")
    @Log(title = "社团活动", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody CampusActivity campusActivity)
    {
        return toAjax(campusActivityService.insertCampusActivity(campusActivity));
    }

    /**
     * 修改社团活动
     */
    @PreAuthorize("@ss.hasPermi('campus:activity:edit')")
    @Log(title = "社团活动", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody CampusActivity campusActivity)
    {
        return toAjax(campusActivityService.updateCampusActivity(campusActivity));
    }

    /**
     * 删除社团活动
     */
    @PreAuthorize("@ss.hasPermi('campus:activity:remove')")
    @Log(title = "社团活动", businessType = BusinessType.DELETE)
	@DeleteMapping("/{activityIds}")
    public AjaxResult remove(@PathVariable Long[] activityIds)
    {
        return toAjax(campusActivityService.deleteCampusActivityByActivityIds(activityIds));
    }
}
