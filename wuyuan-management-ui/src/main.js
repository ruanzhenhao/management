import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store/'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import '@/assets/css/global.css'
import request from '@/tool/request'
Vue.prototype.request = request;


Vue.config.productionTip = false



Vue.use(ElementUI)

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
