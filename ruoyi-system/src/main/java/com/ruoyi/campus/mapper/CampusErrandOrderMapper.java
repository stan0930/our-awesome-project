package com.ruoyi.campus.mapper;

import java.util.List;
import com.ruoyi.campus.domain.CampusErrandOrder;

/**
 * 跑腿代办Mapper接口
 * 
 * @author stan
 * @date 2025-10-08
 */
public interface CampusErrandOrderMapper 
{
    /**
     * 查询跑腿代办
     * 
     * @param orderId 跑腿代办主键
     * @return 跑腿代办
     */
    public CampusErrandOrder selectCampusErrandOrderByOrderId(Long orderId);

    /**
     * 查询跑腿代办列表
     * 
     * @param campusErrandOrder 跑腿代办
     * @return 跑腿代办集合
     */
    public List<CampusErrandOrder> selectCampusErrandOrderList(CampusErrandOrder campusErrandOrder);

    /**
     * 新增跑腿代办
     * 
     * @param campusErrandOrder 跑腿代办
     * @return 结果
     */
    public int insertCampusErrandOrder(CampusErrandOrder campusErrandOrder);

    /**
     * 修改跑腿代办
     * 
     * @param campusErrandOrder 跑腿代办
     * @return 结果
     */
    public int updateCampusErrandOrder(CampusErrandOrder campusErrandOrder);

    /**
     * 删除跑腿代办
     * 
     * @param orderId 跑腿代办主键
     * @return 结果
     */
    public int deleteCampusErrandOrderByOrderId(Long orderId);

    /**
     * 批量删除跑腿代办
     * 
     * @param orderIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCampusErrandOrderByOrderIds(Long[] orderIds);
}
