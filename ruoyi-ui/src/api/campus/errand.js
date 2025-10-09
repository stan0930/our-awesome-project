import request from '@/utils/request'

// 查询跑腿代办列表
export function listErrand(query) {
  return request({
    url: '/campus/errand/list',
    method: 'get',
    params: query
  })
}

// 查询跑腿代办详细
export function getErrand(orderId) {
  return request({
    url: '/campus/errand/' + orderId,
    method: 'get'
  })
}

// 新增跑腿代办
export function addErrand(data) {
  return request({
    url: '/campus/errand',
    method: 'post',
    data: data
  })
}

// 修改跑腿代办
export function updateErrand(data) {
  return request({
    url: '/campus/errand',
    method: 'put',
    data: data
  })
}

// 删除跑腿代办
export function delErrand(orderId) {
  return request({
    url: '/campus/errand/' + orderId,
    method: 'delete'
  })
}
