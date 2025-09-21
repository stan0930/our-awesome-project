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
import com.ruoyi.campus.domain.CampusTopic;
import com.ruoyi.campus.service.ICampusTopicService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 校园话题Controller
 * 
 * @author stan
 * @date 2025-09-21
 */
@RestController
@RequestMapping("/campus/topic")
public class CampusTopicController extends BaseController
{
    @Autowired
    private ICampusTopicService campusTopicService;

    /**
     * 查询校园话题列表
     */
    @PreAuthorize("@ss.hasPermi('campus:topic:list')")
    @GetMapping("/list")
    public TableDataInfo list(CampusTopic campusTopic)
    {
        startPage();
        List<CampusTopic> list = campusTopicService.selectCampusTopicList(campusTopic);
        return getDataTable(list);
    }

    /**
     * 导出校园话题列表
     */
    @PreAuthorize("@ss.hasPermi('campus:topic:export')")
    @Log(title = "校园话题", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, CampusTopic campusTopic)
    {
        List<CampusTopic> list = campusTopicService.selectCampusTopicList(campusTopic);
        ExcelUtil<CampusTopic> util = new ExcelUtil<CampusTopic>(CampusTopic.class);
        util.exportExcel(response, list, "校园话题数据");
    }

    /**
     * 获取校园话题详细信息
     */
    @PreAuthorize("@ss.hasPermi('campus:topic:query')")
    @GetMapping(value = "/{topicId}")
    public AjaxResult getInfo(@PathVariable("topicId") Long topicId)
    {
        return success(campusTopicService.selectCampusTopicByTopicId(topicId));
    }

    /**
     * 新增校园话题
     */
    @PreAuthorize("@ss.hasPermi('campus:topic:add')")
    @Log(title = "校园话题", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody CampusTopic campusTopic)
    {
        return toAjax(campusTopicService.insertCampusTopic(campusTopic));
    }

    /**
     * 修改校园话题
     */
    @PreAuthorize("@ss.hasPermi('campus:topic:edit')")
    @Log(title = "校园话题", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody CampusTopic campusTopic)
    {
        return toAjax(campusTopicService.updateCampusTopic(campusTopic));
    }

    /**
     * 删除校园话题
     */
    @PreAuthorize("@ss.hasPermi('campus:topic:remove')")
    @Log(title = "校园话题", businessType = BusinessType.DELETE)
	@DeleteMapping("/{topicIds}")
    public AjaxResult remove(@PathVariable Long[] topicIds)
    {
        return toAjax(campusTopicService.deleteCampusTopicByTopicIds(topicIds));
    }
}
