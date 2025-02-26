import request from '@/tool/request'
//    7日内完成任务的统计折线图
export function getComplete(id) {
    return request({
      url: '/api/admin/home/task/complete',
      method: 'post',
      params: { id }
    });
  }
//    获取任务状态统计  
export function getTaskType(id) {
    return request({
      url: '/api/admin/home/task/taskTypeList',
      method: 'post',
      params: { id }
    });
 }
 //    获取未完成任务数量
export function getNoTask(id) {
    return request({
      url: '/api/admin/home/task/noTask',
      method: 'post',
      params: { id }
    });
  }
// 获取团队成员数量
export function countTeam(id) {
    return request({
      url: '/api/admin/home/team/count',
      method: 'post',
      params: { id }
    });
  }
// 获取团队列表
  export function getTeamList(id) 
  {
    return request({
      url: `/api/admin/home/team/list/${id}`,
      method: 'get',
      
    });
  }
// 获取团队成员完成任务前5名
export function getTop5(id) {
    return request({
      url: '/api/admin/home/team/top5',
      method: 'get',
      params: { id }
    });
  }  
