package com.ruoyi.campus.service;

import java.util.List;
import com.ruoyi.campus.domain.CampusTopic;
import com.ruoyi.campus.domain.CampusTopicComment;

/**
 * 校园话题Service接口
 *
 * @author stan
 * @date 2025-09-21
 */
public interface ICampusTopicService
{
    /**
     * 查询校园话题
     *
     * @param topicId 校园话题主键
     * @return 校园话题
     */
    public CampusTopic selectCampusTopicByTopicId(Long topicId);

    /**
     * 查询校园话题列表
     *
     * @param campusTopic 校园话题
     * @return 校园话题集合
     */
    public List<CampusTopic> selectCampusTopicList(CampusTopic campusTopic);

    /**
     * 新增校园话题
     *
     * @param campusTopic 校园话题
     * @return 结果
     */
    public int insertCampusTopic(CampusTopic campusTopic);

    /**
     * 修改校园话题
     *
     * @param campusTopic 校园话题
     * @return 结果
     */
    public int updateCampusTopic(CampusTopic campusTopic);

    /**
     * 批量删除校园话题
     *
     * @param topicIds 需要删除的校园话题主键集合
     * @return 结果
     */
    public int deleteCampusTopicByTopicIds(Long[] topicIds);

    /**
     * 删除校园话题信息
     *
     * @param topicId 校园话题主键
     * @return 结果
     */
    public int deleteCampusTopicByTopicId(Long topicId);

    public List<CampusTopicComment> selectCommentsByTopicId(Long topicId);
}
