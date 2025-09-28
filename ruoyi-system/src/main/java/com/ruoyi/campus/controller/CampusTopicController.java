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
import com.ruoyi.campus.domain.CampusTopic;
import com.ruoyi.campus.domain.CampusTopicComment;
import com.ruoyi.campus.service.ICampusTopicService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 校园话题Controller
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/campus/topic")
public class CampusTopicController extends BaseController
{
    @Autowired
    private ICampusTopicService campusTopicService;

    /**
     * 查询校园话题列表
     */
    @PreAuthorize("@ss.hasPermi('campus:topic:list')")
    @GetMapping("/list")
    public TableDataInfo list(CampusTopic campusTopic)
    {
        startPage();
        campusTopic.setUserId(getUserId());
        List<CampusTopic> list = campusTopicService.selectCampusTopicList(campusTopic);
        return getDataTable(list);
    }

    /**
     * 获取指定话题下的评论列表
     */
    @GetMapping("/comments/{topicId}")
    public AjaxResult getComments(@PathVariable("topicId") Long topicId)
    {
        List<CampusTopicComment> list = campusTopicService.selectCommentsByTopicId(topicId);
        return AjaxResult.success(list);
    }

    /**
     * 点赞或取消点赞
     */
    @PutMapping("/toggleLike/{topicId}")
    public AjaxResult toggleLike(@PathVariable("topicId") Long topicId)
    {
        Long userId = getUserId();
        boolean isLiked = campusTopicService.toggleLike(topicId, userId);
        return AjaxResult.success("操作成功", isLiked);
    }

    /**
     * 获取校园话题详细信息
     */
    @PreAuthorize("@ss.hasPermi('campus:topic:query')")
    @GetMapping(value = "/{topicId}")
    public AjaxResult getInfo(@PathVariable("topicId") Long topicId)
    {
        return success(campusTopicService.selectCampusTopicByTopicId(topicId));
    }

    /**
     * 新增校园话题
     */
    @PreAuthorize("@ss.hasPermi('campus:topic:add')")
    @Log(title = "校园话题", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody CampusTopic campusTopic)
    {
        campusTopic.setUserId(getUserId());
        campusTopic.setCreateBy(getUsername());
        return toAjax(campusTopicService.insertCampusTopic(campusTopic));
    }

    /**
     * 修改校园话题
     */
    @PreAuthorize("@ss.hasPermi('campus:topic:edit')")
    @Log(title = "校园话题", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody CampusTopic campusTopic)
    {
        campusTopic.setUpdateBy(getUsername());
        return toAjax(campusTopicService.updateCampusTopic(campusTopic));
    }

    /**
     * 删除校园话题
     */
    @PreAuthorize("@ss.hasPermi('campus:topic:remove')")
    @Log(title = "校园话题", businessType = BusinessType.DELETE)
    @DeleteMapping("/{topicIds}")
    public AjaxResult remove(@PathVariable Long[] topicIds)
    {
        return toAjax(campusTopicService.deleteCampusTopicByTopicIds(topicIds));
    }
}
