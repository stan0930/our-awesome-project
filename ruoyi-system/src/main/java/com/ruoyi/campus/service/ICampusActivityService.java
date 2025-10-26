package com.ruoyi.campus.service;

import java.util.List;
import com.ruoyi.campus.domain.CampusActivity;

/**
 * 社团活动Service接口
 * 
 * @author ruoyi
 * @date 2025-10-26
 */
public interface ICampusActivityService 
{
    /**
     * 查询社团活动
     * 
     * @param activityId 社团活动主键
     * @return 社团活动
     */
    public CampusActivity selectCampusActivityByActivityId(Long activityId);

    /**
     * 查询社团活动列表
     * 
     * @param campusActivity 社团活动
     * @return 社团活动集合
     */
    public List<CampusActivity> selectCampusActivityList(CampusActivity campusActivity);

    /**
     * 新增社团活动
     * 
     * @param campusActivity 社团活动
     * @return 结果
     */
    public int insertCampusActivity(CampusActivity campusActivity);

    /**
     * 修改社团活动
     * 
     * @param campusActivity 社团活动
     * @return 结果
     */
    public int updateCampusActivity(CampusActivity campusActivity);

    /**
     * 批量删除社团活动
     * 
     * @param activityIds 需要删除的社团活动主键集合
     * @return 结果
     */
    public int deleteCampusActivityByActivityIds(Long[] activityIds);

    /**
     * 删除社团活动信息
     * 
     * @param activityId 社团活动主键
     * @return 结果
     */
    public int deleteCampusActivityByActivityId(Long activityId);
}
