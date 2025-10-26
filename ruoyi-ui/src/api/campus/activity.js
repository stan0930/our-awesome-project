import request from '@/utils/request'

// 查询社团活动列表
export function listActivity(query) {
  return request({
    url: '/campus/activity/list',
    method: 'get',
    params: query
  })
}

// 查询社团活动详细
export function getActivity(activityId) {
  return request({
    url: '/campus/activity/' + activityId,
    method: 'get'
  })
}

// 新增社团活动
export function addActivity(data) {
  return request({
    url: '/campus/activity',
    method: 'post',
    data: data
  })
}

// 修改社团活动
export function updateActivity(data) {
  return request({
    url: '/campus/activity',
    method: 'put',
    data: data
  })
}

// 删除社团活动
export function delActivity(activityId) {
  return request({
    url: '/campus/activity/' + activityId,
    method: 'delete'
  })
}
