package com.ruoyi.campus.service.impl;

import java.util.List;

import com.ruoyi.campus.domain.CampusTopicComment;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.campus.mapper.CampusTopicMapper;
import com.ruoyi.campus.domain.CampusTopic;
import com.ruoyi.campus.service.ICampusTopicService;

/**
 * 校园话题Service业务层处理
 *
 * @author stan
 * @date 2025-09-21
 */
@Service
public class CampusTopicServiceImpl implements ICampusTopicService
{
    @Autowired
    private CampusTopicMapper campusTopicMapper;

    /**
     * 查询校园话题
     *
     * @param topicId 校园话题主键
     * @return 校园话题
     */
    @Override
    public CampusTopic selectCampusTopicByTopicId(Long topicId)
    {
        return campusTopicMapper.selectCampusTopicByTopicId(topicId);
    }

    /**
     * 查询校园话题列表
     *
     * @param campusTopic 校园话题
     * @return 校园话题
     */
    @Override
    public List<CampusTopic> selectCampusTopicList(CampusTopic campusTopic)
    {
        return campusTopicMapper.selectCampusTopicList(campusTopic);
    }

    /**
     * 新增校园话题
     *
     * @param campusTopic 校园话题
     * @return 结果
     */
    @Override
    public int insertCampusTopic(CampusTopic campusTopic)
    {
        campusTopic.setCreateTime(DateUtils.getNowDate());
        return campusTopicMapper.insertCampusTopic(campusTopic);
    }

    /**
     * 修改校园话题
     *
     * @param campusTopic 校园话题
     * @return 结果
     */
    @Override
    public int updateCampusTopic(CampusTopic campusTopic)
    {
        campusTopic.setUpdateTime(DateUtils.getNowDate());
        return campusTopicMapper.updateCampusTopic(campusTopic);
    }

    /**
     * 批量删除校园话题
     *
     * @param topicIds 需要删除的校园话题主键
     * @return 结果
     */
    @Override
    public int deleteCampusTopicByTopicIds(Long[] topicIds)
    {
        return campusTopicMapper.deleteCampusTopicByTopicIds(topicIds);
    }

    /**
     * 删除校园话题信息
     *
     * @param topicId 校园话题主键
     * @return 结果
     */
    @Override
    public int deleteCampusTopicByTopicId(Long topicId)
    {
        return campusTopicMapper.deleteCampusTopicByTopicId(topicId);
    }

    @Override
    public List<CampusTopicComment> selectCommentsByTopicId(Long topicId) {
        return campusTopicMapper.selectCommentsByTopicId(topicId);
    }
}
