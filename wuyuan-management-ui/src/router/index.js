import Vue from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter);

import loginRoutes from './login';
import homeRoutes from './home';
import notFoundRoutes from './notfound';

const routes = [
  {
    path: '/',
    redirect: '/api/admin/login'
  },
  ...loginRoutes,
  ...homeRoutes,
  ...notFoundRoutes
];

const router = new VueRouter({
  routes
});

// 导航守卫
router.beforeEach((to, from, next) => {
  if (to.path === '/api/admin/login') {
    next();
  } else {
    const token = localStorage.getItem('Authorization');
    if (!token) {
      console.log('未登录');
      next('/api/admin/login');
    } else {
      next();
    }
  }
});

export default router;