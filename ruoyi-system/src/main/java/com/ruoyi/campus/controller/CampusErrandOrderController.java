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
import com.ruoyi.campus.domain.CampusErrandOrder;
import com.ruoyi.campus.service.ICampusErrandOrderService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 跑腿订单Controller
 *
 * @author ruoyi
 * @date 2025-10-08
 */
@RestController
@RequestMapping("/campus/errand")
public class CampusErrandOrderController extends BaseController
{
    @Autowired
    private ICampusErrandOrderService campusErrandOrderService;

    /**
     * 查询跑腿订单列表
     */
    @PreAuthorize("@ss.hasPermi('campus:errand:list')")
    @GetMapping("/list")
    public TableDataInfo list(CampusErrandOrder campusErrandOrder)
    {
        startPage();
        List<CampusErrandOrder> list = campusErrandOrderService.selectCampusErrandOrderList(campusErrandOrder);
        return getDataTable(list);
    }

    /**
     * 导出跑腿订单列表
     */
    @PreAuthorize("@ss.hasPermi('campus:errand:export')")
    @Log(title = "跑腿订单", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, CampusErrandOrder campusErrandOrder)
    {
        List<CampusErrandOrder> list = campusErrandOrderService.selectCampusErrandOrderList(campusErrandOrder);
        ExcelUtil<CampusErrandOrder> util = new ExcelUtil<CampusErrandOrder>(CampusErrandOrder.class);
        util.exportExcel(response, list, "跑腿订单数据");
    }

    /**
     * 获取跑腿订单详细信息
     */
    @PreAuthorize("@ss.hasPermi('campus:errand:query')")
    @GetMapping(value = "/{orderId}")
    public AjaxResult getInfo(@PathVariable("orderId") Long orderId)
    {
        return success(campusErrandOrderService.selectCampusErrandOrderByOrderId(orderId));
    }

    /**
     * 新增跑腿订单
     */
    @PreAuthorize("@ss.hasPermi('campus:errand:add')")
    @Log(title = "跑腿订单", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody CampusErrandOrder campusErrandOrder)
    {
        // 【修复】 在保存前，设置发布人ID为当前登录用户的ID
        campusErrandOrder.setPublisherId(getUserId());
        // 【修复】 同时设置创建者为当前用户名
        campusErrandOrder.setCreateBy(getUsername());
        return toAjax(campusErrandOrderService.insertCampusErrandOrder(campusErrandOrder));
    }

    /**
     * 修改跑腿订单
     */
    @PreAuthorize("@ss.hasPermi('campus:errand:edit')")
    @Log(title = "跑腿订单", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody CampusErrandOrder campusErrandOrder)
    {
        // 【修复】 设置更新者为当前用户名
        campusErrandOrder.setUpdateBy(getUsername());
        return toAjax(campusErrandOrderService.updateCampusErrandOrder(campusErrandOrder));
    }

    /**
     * 删除跑腿订单
     */
    @PreAuthorize("@ss.hasPermi('campus:errand:remove')")
    @Log(title = "跑腿订单", businessType = BusinessType.DELETE)
    @DeleteMapping("/{orderIds}")
    public AjaxResult remove(@PathVariable Long[] orderIds)
    {
        return toAjax(campusErrandOrderService.deleteCampusErrandOrderByOrderIds(orderIds));
    }
    /**
     * 【新增】接单接口
     */
    @Log(title = "跑腿订单", businessType = BusinessType.UPDATE)
    @PutMapping("/take/{orderId}")
    public AjaxResult takeOrder(@PathVariable Long orderId)
    {
        return toAjax(campusErrandOrderService.takeOrder(orderId, getUserId()));
    }
}
