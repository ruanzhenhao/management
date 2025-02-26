import request from '@/tool/request'

export function getTeanData(data) {
    return request
    ({
        url: '/api/admin/home/team/teamData',
        method: 'post',
        data: data
    })
    
}