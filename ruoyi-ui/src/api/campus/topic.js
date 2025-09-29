import request from '@/utils/request'

// 查询校园话题列表
export function listTopic(query) {
  return request({
    url: '/campus/topic/list',
    method: 'get',
    params: query
  })
}

// 查询校园话题详细
export function getTopic(topicId) {
  return request({
    url: '/campus/topic/' + topicId,
    method: 'get'
  })
}

// 新增校园话题
export function addTopic(data) {
  return request({
    url: '/campus/topic',
    method: 'post',
    data: data
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

// 根据话题ID获取评论列表
export function getComments(topicId) {
  return request({
    url: '/campus/topic/comments/' + topicId,
    method: 'get'
  })
}

// 点赞或取消点赞
export function toggleLike(topicId) {
  return request({
    url: '/campus/topic/toggleLike/' + topicId,
    method: 'put'
  })
}

// 新增评论或回复
export function addComment(data) {
  return request({
    url: '/campus/topic/comment',
    method: 'post',
    data: data
  })
}

// --- “我的”模块相关API ---

// 查询我发布的话题列表
export function listMyTopic(query) {
  return request({
    url: '/campus/topic/my-list',
    method: 'get',
    params: query
  })
}

// 查询我点赞的话题列表
export function listMyLikes(query) {
  return request({
    url: '/campus/topic/my-likes',
    method: 'get',
    params: query
  })
}

// 查询我评论的话题列表
export function listMyComments(query) {
  return request({
    url: '/campus/topic/my-comments',
    method: 'get',
    params: query
  })
}
