package com.ruoyi.campus.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.campus.mapper.CampusClubMapper;
import com.ruoyi.campus.domain.CampusClub;
import com.ruoyi.campus.service.ICampusClubService;

/**
 * 社团管理Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-10-26
 */
@Service
public class CampusClubServiceImpl implements ICampusClubService 
{
    @Autowired
    private CampusClubMapper campusClubMapper;

    /**
     * 查询社团管理
     * 
     * @param clubId 社团管理主键
     * @return 社团管理
     */
    @Override
    public CampusClub selectCampusClubByClubId(Long clubId)
    {
        return campusClubMapper.selectCampusClubByClubId(clubId);
    }

    /**
     * 查询社团管理列表
     * 
     * @param campusClub 社团管理
     * @return 社团管理
     */
    @Override
    public List<CampusClub> selectCampusClubList(CampusClub campusClub)
    {
        return campusClubMapper.selectCampusClubList(campusClub);
    }

    /**
     * 新增社团管理
     * 
     * @param campusClub 社团管理
     * @return 结果
     */
    @Override
    public int insertCampusClub(CampusClub campusClub)
    {
        campusClub.setCreateTime(DateUtils.getNowDate());
        return campusClubMapper.insertCampusClub(campusClub);
    }

    /**
     * 修改社团管理
     * 
     * @param campusClub 社团管理
     * @return 结果
     */
    @Override
    public int updateCampusClub(CampusClub campusClub)
    {
        campusClub.setUpdateTime(DateUtils.getNowDate());
        return campusClubMapper.updateCampusClub(campusClub);
    }

    /**
     * 批量删除社团管理
     * 
     * @param clubIds 需要删除的社团管理主键
     * @return 结果
     */
    @Override
    public int deleteCampusClubByClubIds(Long[] clubIds)
    {
        return campusClubMapper.deleteCampusClubByClubIds(clubIds);
    }

    /**
     * 删除社团管理信息
     * 
     * @param clubId 社团管理主键
     * @return 结果
     */
    @Override
    public int deleteCampusClubByClubId(Long clubId)
    {
        return campusClubMapper.deleteCampusClubByClubId(clubId);
    }
}
