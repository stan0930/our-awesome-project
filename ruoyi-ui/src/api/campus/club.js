import request from '@/utils/request'

// 查询社团管理列表
export function listClub(query) {
  return request({
    url: '/campus/club/list',
    method: 'get',
    params: query
  })
}

// 查询社团管理详细
export function getClub(clubId) {
  return request({
    url: '/campus/club/' + clubId,
    method: 'get'
  })
}

// 新增社团管理
export function addClub(data) {
  return request({
    url: '/campus/club',
    method: 'post',
    data: data
  })
}

// 修改社团管理
export function updateClub(data) {
  return request({
    url: '/campus/club',
    method: 'put',
    data: data
  })
}

// 删除社团管理
export function delClub(clubId) {
  return request({
    url: '/campus/club/' + clubId,
    method: 'delete'
  })
}
