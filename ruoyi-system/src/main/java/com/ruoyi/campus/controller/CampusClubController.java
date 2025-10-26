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
import com.ruoyi.campus.domain.CampusClub;
import com.ruoyi.campus.service.ICampusClubService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 社团管理Controller
 * 
 * @author ruoyi
 * @date 2025-10-26
 */
@RestController
@RequestMapping("/campus/club")
public class CampusClubController extends BaseController
{
    @Autowired
    private ICampusClubService campusClubService;

    /**
     * 查询社团管理列表
     */
    @PreAuthorize("@ss.hasPermi('campus:club:list')")
    @GetMapping("/list")
    public TableDataInfo list(CampusClub campusClub)
    {
        startPage();
        List<CampusClub> list = campusClubService.selectCampusClubList(campusClub);
        return getDataTable(list);
    }

    /**
     * 导出社团管理列表
     */
    @PreAuthorize("@ss.hasPermi('campus:club:export')")
    @Log(title = "社团管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, CampusClub campusClub)
    {
        List<CampusClub> list = campusClubService.selectCampusClubList(campusClub);
        ExcelUtil<CampusClub> util = new ExcelUtil<CampusClub>(CampusClub.class);
        util.exportExcel(response, list, "社团管理数据");
    }

    /**
     * 获取社团管理详细信息
     */
    @PreAuthorize("@ss.hasPermi('campus:club:query')")
    @GetMapping(value = "/{clubId}")
    public AjaxResult getInfo(@PathVariable("clubId") Long clubId)
    {
        return success(campusClubService.selectCampusClubByClubId(clubId));
    }

    /**
     * 新增社团管理
     */
    @PreAuthorize("@ss.hasPermi('campus:club:add')")
    @Log(title = "社团管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody CampusClub campusClub)
    {
        return toAjax(campusClubService.insertCampusClub(campusClub));
    }

    /**
     * 修改社团管理
     */
    @PreAuthorize("@ss.hasPermi('campus:club:edit')")
    @Log(title = "社团管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody CampusClub campusClub)
    {
        return toAjax(campusClubService.updateCampusClub(campusClub));
    }

    /**
     * 删除社团管理
     */
    @PreAuthorize("@ss.hasPermi('campus:club:remove')")
    @Log(title = "社团管理", businessType = BusinessType.DELETE)
	@DeleteMapping("/{clubIds}")
    public AjaxResult remove(@PathVariable Long[] clubIds)
    {
        return toAjax(campusClubService.deleteCampusClubByClubIds(clubIds));
    }
}
