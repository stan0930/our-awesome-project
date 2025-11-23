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

@RestController
@RequestMapping("/campus/topic")
public class CampusTopicController extends BaseController
{
    @Autowired
    private ICampusTopicService campusTopicService;

    @PreAuthorize("@ss.hasPermi('campus:topic:list')")
    @GetMapping("/list")
    public TableDataInfo list(CampusTopic campusTopic)
    {
        startPage();
        campusTopic.setUserId(getUserId());
        List<CampusTopic> list = campusTopicService.selectCampusTopicList(campusTopic);
        return getDataTable(list);
    }

    // --- 【新增】获取“我的”相关列表的三个接口 ---
    /**
     * 获取我发布的话题列表
     */
    @GetMapping("/my-list")
    public TableDataInfo myList(CampusTopic campusTopic)
    {
        startPage();
        // 只查询当前登录用户发布的
        campusTopic.setUserId(getUserId());

        // 【修改】调用新创建的、只查询“我的”话题的服务
        List<CampusTopic> list = campusTopicService.selectMyCampusTopicList(campusTopic);

        return getDataTable(list);
    }

    /**
     * 获取我点赞的话题列表
     */
    @GetMapping("/my-likes")
    public TableDataInfo myLikes(CampusTopic campusTopic)
    {
        startPage();
        campusTopic.setUserId(getUserId()); // 用于判断liked状态
        List<CampusTopic> list = campusTopicService.selectMyLikedTopics(getUserId());
        return getDataTable(list);
    }

    /**
     * 获取我评论的话题列表
     */
    @GetMapping("/my-comments")
    public TableDataInfo myComments(CampusTopic campusTopic)
    {
        startPage();
        campusTopic.setUserId(getUserId()); // 用于判断liked状态
        List<CampusTopic> list = campusTopicService.selectMyCommentedTopics(getUserId());
        return getDataTable(list);
    }
    // --- 【新增结束】 ---


    @GetMapping("/comments/{topicId}")
    public AjaxResult getComments(@PathVariable("topicId") Long topicId)
    {
        List<CampusTopicComment> list = campusTopicService.selectCommentsByTopicId(topicId);
        return AjaxResult.success(list);
    }

    @PutMapping("/toggleLike/{topicId}")
    public AjaxResult toggleLike(@PathVariable("topicId") Long topicId)
    {
        Long userId = getUserId();
        boolean isLiked = campusTopicService.toggleLike(topicId, userId);
        return AjaxResult.success("操作成功", isLiked);
    }

    @PostMapping("/comment")
    public AjaxResult addComment(@RequestBody CampusTopicComment comment)
    {
        comment.setUserId(getUserId());
        return toAjax(campusTopicService.insertComment(comment));
    }

    @PreAuthorize("@ss.hasPermi('campus:topic:query')")
    @GetMapping(value = "/{topicId}")
    public AjaxResult getInfo(@PathVariable("topicId") Long topicId)
    {
        return success(campusTopicService.selectCampusTopicByTopicId(topicId));
    }

    @PreAuthorize("@ss.hasPermi('campus:topic:add')")
    @Log(title = "校园话题", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody CampusTopic campusTopic)
    {
        campusTopic.setUserId(getUserId());
        campusTopic.setCreateBy(getUsername());
        return toAjax(campusTopicService.insertCampusTopic(campusTopic));
    }

    @PreAuthorize("@ss.hasPermi('campus:topic:edit')")
    @Log(title = "校园话题", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody CampusTopic campusTopic)
    {
        campusTopic.setUpdateBy(getUsername());
        return toAjax(campusTopicService.updateCampusTopic(campusTopic, getUserId()));
    }

    @PreAuthorize("@ss.hasPermi('campus:topic:remove')")
    @Log(title = "校园话题", businessType = BusinessType.DELETE)
    @DeleteMapping("/{topicIds}")
    public AjaxResult remove(@PathVariable Long[] topicIds)
    {
        return toAjax(campusTopicService.deleteCampusTopicByTopicIds(topicIds, getUserId()));
    }
    // ... 在 myComments 方法之后 ...

    /**
     * 【新增】切换收藏状态
     */
    @PutMapping("/toggle-favorite/{topicId}")
    public AjaxResult toggleFavorite(@PathVariable("topicId") Long topicId) {
        Long userId = getUserId();
        boolean isFavorited = campusTopicService.toggleFavorite(topicId, userId);
        return AjaxResult.success("操作成功", isFavorited);
    }

    /**
     * 【新增】获取我收藏的话题列表
     */
    @GetMapping("/my-favorites")
    public TableDataInfo myFavorites() {
        startPage();
        List<CampusTopic> list = campusTopicService.selectMyFavoriteTopics(getUserId());
        return getDataTable(list);
    }
}
