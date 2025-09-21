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
