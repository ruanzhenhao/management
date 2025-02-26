const Login = () => import('@/components/login/login.vue');

export default [
  {
    path: '/api/admin/login',
    name: 'login',
    component: Login
  }
];