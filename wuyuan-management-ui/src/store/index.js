
import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    // 存储token
    Authorization: localStorage.getItem('Authorization') ? localStorage.getItem('Authorization') : '',
    username: localStorage.getItem('username') ? localStorage.getItem('username') : '',
    img: localStorage.getItem('img') ? localStorage.getItem('img') : '',
    id: localStorage.getItem('id') ? localStorage.getItem('id') : '',
    phone: localStorage.getItem('phone') ? localStorage.getItem('phone') : '',
    teamId: localStorage.getItem('teamId') ? localStorage.getItem('teamId') : '',
    teamName: localStorage.getItem('teamName') ? localStorage.getItem('teamName') : '',
    taskId: localStorage.getItem('taskId') ? localStorage.getItem('taskId') : '', // 修改这里
  },
  getters: {
  },
  mutations: {
    changeTaskId(state, taskId) { // 修改函数名以避免冲突
      console.log("当前任务id为" + taskId)
      state.taskId = taskId
      localStorage.setItem('taskId', taskId)
    },
    changeTeamName(state, teamName) {
      console.log("当前团队名为" + teamName)
      state.teamName = teamName
      localStorage.setItem('teamName', teamName)
    },
    changeTeamId(state, teamId) {
      console.log("当前团队id为" + teamId)
      state.teamId = teamId
      localStorage.setItem('teamId', teamId)
    },
    changePhone(state, phone) {
      console.log("当前电话为" + phone)
      state.phone = phone
      localStorage.setItem('phone', phone)
    },
    changeimg(state, img) { // 修改函数名以符合命名惯例
      console.log("当前头像为" + img)
      state.img = img
      localStorage.setItem('img', img)
    },
    changeUserName(state, username) {
      console.log("当前登录名为" + username)
      state.username = username
      localStorage.setItem('username', username)
    },
    changeID(state, id) {
      console.log("当前id为" + id)
      state.id = id
      localStorage.setItem('id', id)  
    },
    
    // 修改token，并将token存入localStorage
    changeLogin(state, user) {
      console.log(state)
      state.Authorization = user.Authorization;
      localStorage.setItem('Authorization', user.Authorization);
    }
  },
  actions: {
  },
  modules: {
  }
})