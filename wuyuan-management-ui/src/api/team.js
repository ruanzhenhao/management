import request from '@/tool/request'

export function getTeamListData(data)
{
    return request({
        url: '/api/admin/home/team/list',
        method: 'post',
        data: data
    });
}

export function selectUser(userName)
{
    return request({
        url: '/api/admin/home/team/selectUser',
        method: 'get',
        params:{userName}
    });
}

export function addTeam(data)
{
    return request({
        url: '/api/admin/home/team/createTeam',
        method: 'post',
        data: data
    });
}

export function getTop10(teamName)
{
    return request({
        url: '/api/admin/home/teamReport/top10',
        method: 'post',
        params:{ teamName }
    });
}

export function getTaskList(teamName)
{
    return request({
        url: '/api/admin/home/teamReport/taskList',
        method: 'get'
        ,params:{ teamName }
    });
}
export function getPercentage(teamName)
{
    return request({
        url: '/api/admin/home/teamReport/percentage',
        method: 'get',
        params:{ teamName }
    });
}
export function completeTask(taskId)
{
    return request({
        url: '/api/admin/home/teamReport/completeTask',
        method: 'get',
        params:{ taskId }
    });
}

export function getNotTask(teamName)
{
    return request({
        url: '/api/admin/home/teamReport/noTask',
        method: 'get',
        params:{ teamName }
    });
}

export function getTeamIntroduction(teamName)
{
    return request({
        url: '/api/admin/home/teamReport/introduction',
        method: 'get',
        params:{ teamName }
    });
}

export function getTeamTaskList(teamName)
{
    return request({
        url: '/api/admin/home/teamReport/getTeamTaskList',
        method: 'get',
        params:{ teamName }
    });
}

export function getTeamUserList(teamName)
{
    return request({
        url: '/api/admin/home/teamReport/getTeamUserList',
        method: 'post',
        params:{ teamName }
    });
}

export function setAdmin(data)
{
    return request({
        url: '/api/admin/home/teamReport/setAdmin',
        method: 'post',
        data: data
    });
}


export function transferBoss(data)
{
    return request({
        url: '/api/admin/home/teamReport/transferBoss',
        method: 'post',
        data: data
    });
}
export function managementUser(teamName)
{
    return request({
        url: '/api/admin/home/teamReport/management',
        method: 'get',
        params:{ teamName }
    });
}
export function changeIntroduction(data)
{
    return request({
        url: '/api/admin/home/teamReport/changeIntroduction',
        method: 'post',
        data: data
    });
}

export function getInvitationCode(teamName)
{
    return request({
        url: '/api/admin/home/teamReport/getInvitationCode',
        method: 'get',
        params:{ teamName }
    });
}

export function deleteTeamUser(data)
{
    return request({
        url: '/api/admin/home/teamReport/deleteTeamUser',
        method: 'post',
        data: data
    });
}

export function quitTeam(teamName)
{
    return request({
        url: '/api/admin/home/teamReport/quitTeam',
        method: 'post',
        params:{ teamName }
    });
}

export function deleteTeam(data)
{
    return request({
        url: '/api/admin/home/teamReport/deleteTeam',
        method: 'delete',
        data: data
    });
}

export function updateTeamName(data)
{
    return request({
        url: '/api/admin/home/teamReport/updateTeamName',
        method: 'post',
        data: data
    });
}

export function removeAdmin(data) {
    return request
    ({
        url: '/api/admin/home/teamReport/removeAdmin',
        method: 'post',
        data: data
    })
    
}

export function joinTeam(invitationCode) {
    return request
    ({
        url: '/api/admin/home/team/add',
        method: 'get',
        params : {invitationCode}
    })
    
}
