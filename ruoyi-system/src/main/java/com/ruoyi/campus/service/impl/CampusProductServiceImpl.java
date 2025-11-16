package com.ruoyi.campus.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;

// 【【【 1. 导入 SecurityUtils 】】】
import com.ruoyi.common.utils.SecurityUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.campus.mapper.CampusProductMapper;
import com.ruoyi.campus.domain.CampusProduct;
import com.ruoyi.campus.service.ICampusProductService;

/**
 * 校园二手商品Service业务层处理
 * * @author ruoyi
 * @date (你的生成日期)
 */
@Service
public class CampusProductServiceImpl implements ICampusProductService
{
    @Autowired
    private CampusProductMapper campusProductMapper;

    @Override
    public CampusProduct selectCampusProductByProductId(Long productId)
    {
        return campusProductMapper.selectCampusProductByProductId(productId);
    }

    @Override
    public List<CampusProduct> selectCampusProductList(CampusProduct campusProduct)
    {
        return campusProductMapper.selectCampusProductList(campusProduct);
    }

    /**
     * 【【【 2. 修改这个方法 】】】
     * 新增校园二手商品
     */
    @Override
    public int insertCampusProduct(CampusProduct campusProduct)
    {
        // 【【【 3. 在插入前，自动设置 user_id 和 create_by 】】】
        campusProduct.setUserId(SecurityUtils.getUserId());
        campusProduct.setCreateBy(SecurityUtils.getUsername());
        // 【【【 4. 设置创建时间 】】】
        campusProduct.setCreateTime(DateUtils.getNowDate());

        return campusProductMapper.insertCampusProduct(campusProduct);
    }

    @Override
    public int updateCampusProduct(CampusProduct campusProduct)
    {
        // 【【【 5. (顺便)把更新也改了 】】】
        campusProduct.setUpdateBy(SecurityUtils.getUsername());
        campusProduct.setUpdateTime(DateUtils.getNowDate());
        return campusProductMapper.updateCampusProduct(campusProduct);
    }

    @Override
    public int deleteCampusProductByProductIds(Long[] productIds)
    {
        return campusProductMapper.deleteCampusProductByProductIds(productIds);
    }

    @Override
    public int deleteCampusProductByProductId(Long productId)
    {
        return campusProductMapper.deleteCampusProductByProductId(productId);
    }
}
