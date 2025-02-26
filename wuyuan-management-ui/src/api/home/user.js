import request from '@/tool/request'


export function updateHeadshot(updatedData) {
    return request({
      url: '/api/admin/home/user/headshot',
      method: 'put',
      data: updatedData
    });
  }

export function getUser(id) {
    return request({
      url: '/api/admin/home/user',
      method: 'get',
      params: { id }
    });
  }  
export function changeUser(user) 
{
  return request({
    url: '/api/admin/home/user/changeInfo',
    method: 'put',
    data: user
  });
}  

export function changePassword(updatedData)
{
  return request({
    url: '/api/admin/home/user/changePassword',
    method: 'put',
    data:  updatedData 
  });
  
} 




