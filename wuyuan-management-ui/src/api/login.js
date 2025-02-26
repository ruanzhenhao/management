import request from '@/tool/request'

export function login(data) {
    return request
    ({
        url: '/api/admin/login',
        method: 'post',
        data: data
    })
}

export default login;

export function register(data) {
    return request
    ({
        url: '/api/admin/register',
        method: 'post',
        data: data
    })
  
}

