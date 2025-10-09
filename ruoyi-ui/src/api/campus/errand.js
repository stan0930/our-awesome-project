import request from '@/utils/request'

// 查询跑腿订单列表
export function listErrand(query) {
  return request({
    url: '/campus/errand/list',
    method: 'get',
    params: query
  })
}

// 查询跑腿订单详细
export function getErrand(orderId) {
  return request({
    url: '/campus/errand/' + orderId,
    method: 'get'
  })
}

// 新增跑腿订单
export function addErrand(data) {
  return request({
    url: '/campus/errand',
    method: 'post',
    data: data
  })
}

// 修改跑腿订单
export function updateErrand(data) {
  return request({
    url: '/campus/errand',
    method: 'put',
    data: data
  })
}

// 删除跑腿订单
export function delErrand(orderId) {
  return request({
    url: '/campus/errand/' + orderId,
    method: 'delete'
  })
}

// 接单接口
export function takeErrandOrder(orderId) {
  return request({
    url: '/campus/errand/take/' + orderId,
    method: 'put'
  })
}

// --- 【新增】“我的跑腿”相关API ---

// 查询我发布的跑腿订单列表
export function listMyPublished(query) {
  return request({
    url: '/campus/errand/my-published',
    method: 'get',
    params: query
  })
}

// 查询我接受的跑腿订单列表
export function listMyTaken(query) {
  return request({
    url: '/campus/errand/my-taken',
    method: 'get',
    params: query
  })
}
