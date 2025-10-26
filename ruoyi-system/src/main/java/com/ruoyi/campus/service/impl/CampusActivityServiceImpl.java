package com.ruoyi.campus.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.campus.mapper.CampusActivityMapper;
import com.ruoyi.campus.domain.CampusActivity;
import com.ruoyi.campus.service.ICampusActivityService;

/**
 * 社团活动Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-10-26
 */
@Service
public class CampusActivityServiceImpl implements ICampusActivityService 
{
    @Autowired
    private CampusActivityMapper campusActivityMapper;

    /**
     * 查询社团活动
     * 
     * @param activityId 社团活动主键
     * @return 社团活动
     */
    @Override
    public CampusActivity selectCampusActivityByActivityId(Long activityId)
    {
        return campusActivityMapper.selectCampusActivityByActivityId(activityId);
    }

    /**
     * 查询社团活动列表
     * 
     * @param campusActivity 社团活动
     * @return 社团活动
     */
    @Override
    public List<CampusActivity> selectCampusActivityList(CampusActivity campusActivity)
    {
        return campusActivityMapper.selectCampusActivityList(campusActivity);
    }

    /**
     * 新增社团活动
     * 
     * @param campusActivity 社团活动
     * @return 结果
     */
    @Override
    public int insertCampusActivity(CampusActivity campusActivity)
    {
        campusActivity.setCreateTime(DateUtils.getNowDate());
        return campusActivityMapper.insertCampusActivity(campusActivity);
    }

    /**
     * 修改社团活动
     * 
     * @param campusActivity 社团活动
     * @return 结果
     */
    @Override
    public int updateCampusActivity(CampusActivity campusActivity)
    {
        campusActivity.setUpdateTime(DateUtils.getNowDate());
        return campusActivityMapper.updateCampusActivity(campusActivity);
    }

    /**
     * 批量删除社团活动
     * 
     * @param activityIds 需要删除的社团活动主键
     * @return 结果
     */
    @Override
    public int deleteCampusActivityByActivityIds(Long[] activityIds)
    {
        return campusActivityMapper.deleteCampusActivityByActivityIds(activityIds);
    }

    /**
     * 删除社团活动信息
     * 
     * @param activityId 社团活动主键
     * @return 结果
     */
    @Override
    public int deleteCampusActivityByActivityId(Long activityId)
    {
        return campusActivityMapper.deleteCampusActivityByActivityId(activityId);
    }
}
