package com.ruoyi.campus.mapper;

import java.util.List;
import com.ruoyi.campus.domain.CampusTopic;
import com.ruoyi.campus.domain.CampusTopicComment;

/**
 * 校园话题Mapper接口
 *
 * @author stan
 * @date 2025-09-21
 */
public interface CampusTopicMapper
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
     * 删除校园话题
     *
     * @param topicId 校园话题主键
     * @return 结果
     */
    public int deleteCampusTopicByTopicId(Long topicId);

    /**
     * 批量删除校园话题
     *
     * @param topicIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCampusTopicByTopicIds(Long[] topicIds);
    /**
     * 根据话题ID查询评论列表
     * @param topicId 话题ID
     * @return 评论列表
     */
    public List<CampusTopicComment> selectCommentsByTopicId(Long topicId);
}
