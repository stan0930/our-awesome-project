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
import com.ruoyi.campus.domain.CampusOrder;
import com.ruoyi.campus.service.ICampusOrderService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

// 【新增】导入
import com.ruoyi.campus.domain.dto.CreateOrderDto;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.exception.ServiceException;

/**
 * 校园订单Controller
 * * @author ruoyi
 * @date (你的生成日期)
 */
@RestController
@RequestMapping("/campus/order")
public class CampusOrderController extends BaseController
{
    @Autowired
    private ICampusOrderService campusOrderService;

    /**
     * 查询校园订单列表
     */
    @PreAuthorize("@ss.hasPermi('campus:order:list')")
    @GetMapping("/list")
    public TableDataInfo list(CampusOrder campusOrder)
    {
        startPage();
        List<CampusOrder> list = campusOrderService.selectCampusOrderList(campusOrder);
        return getDataTable(list);
    }

    /**
     * 导出校园订单列表
     */
    @PreAuthorize("@ss.hasPermi('campus:order:export')")
    @Log(title = "校园订单", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, CampusOrder campusOrder)
    {
        List<CampusOrder> list = campusOrderService.selectCampusOrderList(campusOrder);
        ExcelUtil<CampusOrder> util = new ExcelUtil<CampusOrder>(CampusOrder.class);
        util.exportExcel(response, list, "校园订单数据");
    }

    /**
     * 获取校园订单详细信息
     */
    @PreAuthorize("@ss.hasPermi('campus:order:query')")
    @GetMapping(value = "/{orderId}")
    public AjaxResult getInfo(@PathVariable("orderId") Long orderId)
    {
        return success(campusOrderService.selectCampusOrderByOrderId(orderId));
    }

    /**
     * 新增校园订单
     */
    @PreAuthorize("@ss.hasPermi('campus:order:add')")
    @Log(title = "校园订单", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody CampusOrder campusOrder)
    {
        return toAjax(campusOrderService.insertCampusOrder(campusOrder));
    }

    /**
     * 修改校园订单
     */
    @PreAuthorize("@ss.hasPermi('campus:order:edit')")
    @Log(title = "校园订单", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody CampusOrder campusOrder)
    {
        return toAjax(campusOrderService.updateCampusOrder(campusOrder));
    }

    /**
     * 删除校园订单
     */
    @PreAuthorize("@ss.hasPermi('campus:order:remove')")
    @Log(title = "校园订单", businessType = BusinessType.DELETE)
    @DeleteMapping("/{orderIds}")
    public AjaxResult remove(@PathVariable Long[] orderIds)
    {
        return toAjax(campusOrderService.deleteCampusOrderByOrderIds(orderIds));
    }


    /**
     * 【新增】用户创建订单
     * 这个接口是给前台用户用的，不需要权限
     */
    @PostMapping("/create")
    public AjaxResult create(@RequestBody CreateOrderDto createOrderDto)
    {
        if (createOrderDto.getProductId() == null) {
            return AjaxResult.error("商品ID不能为空");
        }
        // 简单的校验
        if (StringUtils.isEmpty(createOrderDto.getAddress())) {
            return AjaxResult.error("收货地址不能为空");
        }

        try
        {
            Long orderId = campusOrderService.createOrder(createOrderDto);
            return AjaxResult.success("订单创建成功", orderId);
        }
        catch (ServiceException e)
        {
            // 捕获业务异常 (比如 "商品已售出")
            return AjaxResult.error(e.getMessage());
        }
        catch (Exception e)
        {
            // 捕获其他未知异常
            e.printStackTrace(); // 在后台打印详细错误
            return AjaxResult.error("创建订单失败，请联系管理员");
        }
    }
}
