import request from '@/utils/request';

/**
 * 发送消息到后端智能助手接口
 * @param {string} message
 */
export function sendMessageToDify(message) {
  return request({
    url: '/chat/send',
    method: 'post',
    data: message,
    headers: {
      'Content-Type': 'text/plain'
    }
  });
}
