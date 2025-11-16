import request from '@/utils/request'

// 查询校园话题列表
export function listTopic(query) {
  return request({
    url: '/campus/topic/list',
    method: 'get',
    params: query
  })
}

// 【【【 确保你有这个方法 】】】
// 新增校园话题 (发布帖子)
export function addTopic(data) {
  return request({
    url: '/campus/topic', // 它会 POST 到 CampusTopicController
    method: 'post',
    data: data
  })
}

// 查询校园话题详细
export function getTopic(topicId) {
  return request({
    url: '/campus/topic/' + topicId,
    method: 'get'
  })
}

// 修改校园话题
export function updateTopic(data) {
  return request({
    url: '/campus/topic',
    method: 'put',
    data: data
  })
}

// 删除校园话题
export function delTopic(topicId) {
  return request({
    url: '/campus/topic/' + topicId,
    method: 'delete'
  })
}

// 【【【 以下是你“点赞收藏”功能可能有的API 】】】
// (如果你之前没加，加了也没事)

// 切换点赞
export function toggleLike(topicId) {
  return request({
    url: '/campus/topic/toggleLike/' + topicId,
    method: 'put'
  })
}

// 切换收藏
export function toggleFavorite(topicId) {
  return request({
    url: '/campus/topic/toggle-favorite/' + topicId,
    method: 'put'
  })
}

// 获取评论
export function getComments(topicId) {
  return request({
    url: '/campus/topic/comments/' + topicId,
    method: 'get'
  })
}

// 新增评论
export function addComment(data) {
  return request({
    url: '/campus/topic/comment',
    method: 'post',
    data: data
  })
}
