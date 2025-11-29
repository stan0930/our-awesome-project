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
import com.ruoyi.campus.domain.CampusProduct;
import com.ruoyi.campus.service.ICampusProductService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 校园二手商品Controller
 * 
 * @author ruoyi
 * @date 2025-11-11
 */
@RestController
@RequestMapping("/campus/product")
public class CampusProductController extends BaseController {
    @Autowired
    private ICampusProductService campusProductService;

    /**
     * 查询校园二手商品列表
     */
    @PreAuthorize("@ss.hasPermi('campus:product:list')")
    @GetMapping("/list")
    public TableDataInfo list(CampusProduct campusProduct) {
        startPage();
        List<CampusProduct> list = campusProductService.selectCampusProductList(campusProduct);
        return getDataTable(list);
    }

    /**
     * 导出校园二手商品列表
     */
    @PreAuthorize("@ss.hasPermi('campus:product:export')")
    @Log(title = "校园二手商品", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, CampusProduct campusProduct) {
        List<CampusProduct> list = campusProductService.selectCampusProductList(campusProduct);
        ExcelUtil<CampusProduct> util = new ExcelUtil<CampusProduct>(CampusProduct.class);
        util.exportExcel(response, list, "校园二手商品数据");
    }

    /**
     * 获取校园二手商品详细信息
     */
    @PreAuthorize("@ss.hasPermi('campus:product:query')")
    @GetMapping(value = "/{productId}")
    public AjaxResult getInfo(@PathVariable("productId") Long productId) {
        return success(campusProductService.selectCampusProductByProductId(productId));
    }

    /**
     * 新增校园二手商品
     */
    @PreAuthorize("@ss.hasPermi('campus:product:add')")
    @Log(title = "校园二手商品", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody CampusProduct campusProduct) {
        campusProduct.setUserId(getUserId());
        return toAjax(campusProductService.insertCampusProduct(campusProduct));
    }

    /**
     * 修改校园二手商品
     */
    @PreAuthorize("@ss.hasPermi('campus:product:edit')")
    @Log(title = "校园二手商品", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody CampusProduct campusProduct) {
        return toAjax(campusProductService.updateCampusProduct(campusProduct));
    }

    /**
     * 删除校园二手商品
     */
    @PreAuthorize("@ss.hasPermi('campus:product:remove')")
    @Log(title = "校园二手商品", businessType = BusinessType.DELETE)
    @DeleteMapping("/{productIds}")
    public AjaxResult remove(@PathVariable Long[] productIds) {
        return toAjax(campusProductService.deleteCampusProductByProductIds(productIds));
    }

    /**
     * 【新增】获取商品详情(增加浏览次数)
     */
    @GetMapping("/detail/{productId}")
    public AjaxResult getDetail(@PathVariable("productId") Long productId) {
        return success(campusProductService.selectProductDetail(productId, getUserId()));
    }

    /**
     * 【新增】更新商品状态
     */
    @PutMapping("/status/{productId}")
    public AjaxResult updateStatus(@PathVariable("productId") Long productId,
            @RequestBody CampusProduct campusProduct) {
        return toAjax(campusProductService.updateProductStatus(productId, campusProduct.getStatus(), getUserId()));
    }

    /**
     * 【新增】切换收藏状态
     */
    @PutMapping("/toggle-favorite/{productId}")
    public AjaxResult toggleFavorite(@PathVariable("productId") Long productId) {
        boolean isFavorited = campusProductService.toggleFavorite(productId, getUserId());
        return AjaxResult.success("操作成功", isFavorited);
    }

    /**
     * 【新增】查询我的商品列表
     */
    @GetMapping("/my-products")
    public TableDataInfo myProducts(CampusProduct campusProduct) {
        startPage();
        campusProduct.setUserId(getUserId());
        List<CampusProduct> list = campusProductService.selectMyProducts(campusProduct);
        return getDataTable(list);
    }

    /**
     * 【新增】查询我的收藏列表
     */
    @GetMapping("/my-favorites")
    public TableDataInfo myFavorites() {
        startPage();
        List<CampusProduct> list = campusProductService.selectMyFavoriteProducts(getUserId());
        return getDataTable(list);
    }
}
