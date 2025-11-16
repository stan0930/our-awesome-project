import request from '@/utils/request'

// 查询校园订单列表
export function listOrder(query) {
  return request({
    url: '/campus/order/list',
    method: 'get',
    params: query
  })
}

// 查询校园订单详细
export function getOrder(orderId) {
  return request({
    url: '/campus/order/' + orderId,
    method: 'get'
  })
}

// 新增校园订单
export function addOrder(data) {
  return request({
    url: '/campus/order',
    method: 'post',
    data: data
  })
}

// 修改校园订单
export function updateOrder(data) {
  return request({
    url: '/campus/order',
    method: 'put',
    data: data
  })
}

// 删除校园订单
export function delOrder(orderId) {
  return request({
    url: '/campus/order/' + orderId,
    method: 'delete'
  })
}
