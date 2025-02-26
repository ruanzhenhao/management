import request from '@/tool/request'


export function getMessage() {
    return request
    ({
        url: '/api/admin/home/message/messageTable',
        method: 'post',
    })
    
  }
  export function submitYes(teamId) {
    return request
    ({
        url: '/api/admin/home/message/yes',
        method: 'get',
        params: { teamId }
    })
    
  }
  export function submitNo(id) {
    return request
    ({
        url: '/api/admin/home/message/no',
        method: 'get',
        params: { id }
    })
    
  }    
