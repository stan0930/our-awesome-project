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
import com.ruoyi.campus.domain.CampusOrderItem;
import com.ruoyi.campus.service.ICampusOrderItemService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 订单商品关联Controller
 * 
 * @author ruoyi
 * @date 2025-11-11
 */
@RestController
@RequestMapping("/campus/item")
public class CampusOrderItemController extends BaseController
{
    @Autowired
    private ICampusOrderItemService campusOrderItemService;

    /**
     * 查询订单商品关联列表
     */
    @PreAuthorize("@ss.hasPermi('campus:item:list')")
    @GetMapping("/list")
    public TableDataInfo list(CampusOrderItem campusOrderItem)
    {
        startPage();
        List<CampusOrderItem> list = campusOrderItemService.selectCampusOrderItemList(campusOrderItem);
        return getDataTable(list);
    }

    /**
     * 导出订单商品关联列表
     */
    @PreAuthorize("@ss.hasPermi('campus:item:export')")
    @Log(title = "订单商品关联", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, CampusOrderItem campusOrderItem)
    {
        List<CampusOrderItem> list = campusOrderItemService.selectCampusOrderItemList(campusOrderItem);
        ExcelUtil<CampusOrderItem> util = new ExcelUtil<CampusOrderItem>(CampusOrderItem.class);
        util.exportExcel(response, list, "订单商品关联数据");
    }

    /**
     * 获取订单商品关联详细信息
     */
    @PreAuthorize("@ss.hasPermi('campus:item:query')")
    @GetMapping(value = "/{itemId}")
    public AjaxResult getInfo(@PathVariable("itemId") Long itemId)
    {
        return success(campusOrderItemService.selectCampusOrderItemByItemId(itemId));
    }

    /**
     * 新增订单商品关联
     */
    @PreAuthorize("@ss.hasPermi('campus:item:add')")
    @Log(title = "订单商品关联", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody CampusOrderItem campusOrderItem)
    {
        return toAjax(campusOrderItemService.insertCampusOrderItem(campusOrderItem));
    }

    /**
     * 修改订单商品关联
     */
    @PreAuthorize("@ss.hasPermi('campus:item:edit')")
    @Log(title = "订单商品关联", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody CampusOrderItem campusOrderItem)
    {
        return toAjax(campusOrderItemService.updateCampusOrderItem(campusOrderItem));
    }

    /**
     * 删除订单商品关联
     */
    @PreAuthorize("@ss.hasPermi('campus:item:remove')")
    @Log(title = "订单商品关联", businessType = BusinessType.DELETE)
	@DeleteMapping("/{itemIds}")
    public AjaxResult remove(@PathVariable Long[] itemIds)
    {
        return toAjax(campusOrderItemService.deleteCampusOrderItemByItemIds(itemIds));
    }
}
