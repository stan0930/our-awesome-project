import request from '@/utils/request'

// 查询订单商品关联列表
export function listItem(query) {
  return request({
    url: '/campus/item/list',
    method: 'get',
    params: query
  })
}

// 查询订单商品关联详细
export function getItem(itemId) {
  return request({
    url: '/campus/item/' + itemId,
    method: 'get'
  })
}

// 新增订单商品关联
export function addItem(data) {
  return request({
    url: '/campus/item',
    method: 'post',
    data: data
  })
}

// 修改订单商品关联
export function updateItem(data) {
  return request({
    url: '/campus/item',
    method: 'put',
    data: data
  })
}

// 删除订单商品关联
export function delItem(itemId) {
  return request({
    url: '/campus/item/' + itemId,
    method: 'delete'
  })
}
