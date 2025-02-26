const NotFound = () => import('@/components/notfound/notfound.vue');

export default [
  {
    path: '/api/404',
    component: NotFound
  },
  {
    path: '*',
    redirect: '/api/404'
  }
];