import request from '@/utils/request'

// 查询校园二手商品列表
export function listProduct(query) {
  return request({
    url: '/campus/product/list',
    method: 'get',
    params: query
  })
}

// 查询校园二手商品详细
export function getProduct(productId) {
  return request({
    url: '/campus/product/' + productId,
    method: 'get'
  })
}

// 新增校园二手商品
export function addProduct(data) {
  return request({
    url: '/campus/product',
    method: 'post',
    data: data
  })
}

// 修改校园二手商品
export function updateProduct(data) {
  return request({
    url: '/campus/product',
    method: 'put',
    data: data
  })
}

// 删除校园二手商品
export function delProduct(productId) {
  return request({
    url: '/campus/product/' + productId,
    method: 'delete'
  })
}
