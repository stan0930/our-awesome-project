package com.ruoyi.campus.mapper;

import java.util.List;
import com.ruoyi.campus.domain.CampusClub;

/**
 * 社团管理Mapper接口
 * 
 * @author ruoyi
 * @date 2025-10-26
 */
public interface CampusClubMapper 
{
    /**
     * 查询社团管理
     * 
     * @param clubId 社团管理主键
     * @return 社团管理
     */
    public CampusClub selectCampusClubByClubId(Long clubId);

    /**
     * 查询社团管理列表
     * 
     * @param campusClub 社团管理
     * @return 社团管理集合
     */
    public List<CampusClub> selectCampusClubList(CampusClub campusClub);

    /**
     * 新增社团管理
     * 
     * @param campusClub 社团管理
     * @return 结果
     */
    public int insertCampusClub(CampusClub campusClub);

    /**
     * 修改社团管理
     * 
     * @param campusClub 社团管理
     * @return 结果
     */
    public int updateCampusClub(CampusClub campusClub);

    /**
     * 删除社团管理
     * 
     * @param clubId 社团管理主键
     * @return 结果
     */
    public int deleteCampusClubByClubId(Long clubId);

    /**
     * 批量删除社团管理
     * 
     * @param clubIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCampusClubByClubIds(Long[] clubIds);
}
