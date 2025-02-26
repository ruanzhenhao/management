import request from '@/tool/request'

export function getTaskByTeam(teamName)
{
    return request({
        url: '/api/admin/home/task/getTaskByTeam',
        method: 'post',
        params: { teamName }
    })
}
export function getTaskByTeamID(teamId)
{
    return request({
        url: '/api/admin/home/task/getTaskByID',
        method: 'get',
        params: { teamId }
    })
}

export function getTaskInfo(taskId)
{
    return request({
        url: '/api/admin/home/task/getTaskInfo',
        method: 'get',
        params: { taskId }
    })
}

export function submitMission(data)
{
    return request({
        url: '/api/admin/home/task/submitMission',
        method: 'post',
        data: data
    })
}

export function uploadFile(data)
{
    return request({
        url: '/api/admin/home/task/upload',
        method: 'post',
        data: data
    })
}

export function getaskList()
{
    return request({
        url: '/api/admin/home/task/taskList',
        method: 'get'
    })
}

export function getTaskTable(data)
{
    return request({
        url: '/api/admin/home/task/getTaskTable',
        method: 'post',
        params: {data}
    })
}


export function getsubmitInfoData(id)
{
    return request({
        url: '/api/admin/home/task/getSubmitInfo',
        method: 'post',
        params: {id}
    })

}


export function getDownloadData(filesDTO)
{
    return request({
        url: '/api/admin/home/task/download',
        method: 'post',
        data: filesDTO,
        responseType: 'blob' 
    })

}

export function success(data)
{
    return request({
        url: '/api/admin/home/task/success',
        method: 'post',
        params: {
            taskId: data.taskId,
            type: data.type
        }
    })
}
export function task_return(data)
{
    return request({
        url: '/api/admin/home/task/return',
        method: 'post',
        params: {
            taskId: data.taskId,
            type: data.type
        }
    })
}