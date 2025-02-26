
const TeamInfo = () => import('@/components/home/team/teamInfo.vue');
const Home = () => import('@/components/home/home.vue');
const User = () => import('@/components/home/user/user.vue');
const Team = () => import('@/components/home/team/team.vue');
const Task = () => import('@/components/home/task/task.vue');
const Message = () => import('@/components/home/message/message.vue');
const TeamUser = () => import('@/components/home/teamUser/teamUser.vue');
const UserInfo = () => import('@/components/home/user/info.vue');
const UserEditor = () => import('@/components/home/user/editor.vue');

const submitTask = () => import('@/components/home/task/submitTask.vue');
const CreateTeam = () => import('@/components/home/team/createTeam.vue');

const checkTask = () => import('@/components/home/task/checkTask.vue');

export default [
  {
    path: '/api/admin/home',
    name: 'home',
    component: Home,
    children: [
      {
        path: 'user',
        name: 'user',
        component: User,
      },
      {
        path: 'team',
        name: 'team',
        component: Team,
      },
      
      {
        path: 'team/createTeam', // 这是一个相对路径
        name: 'createTeam',
        component: CreateTeam,
      },
      {
        path: 'team/info/:teamName',
        name: 'teamInfo',
        component: TeamInfo,
        
      },
      {
        path: 'task',
        name: 'task',
        component: Task,
      },
      {
        path: 'task/submitTask',
        name: 'submitTask',
        component: submitTask,
       
      },
      {
        path:'task/checkTask',
        name:'checkTask',
        component:checkTask
      },
      {
        path: 'message',
        name: 'message',
        component: Message,
      },
      {
        path: 'teamUser',
        name: 'teamUser',
        component: TeamUser,
      },
      {
        path: 'user/info',
        name: 'info',
        component: UserInfo,
      },
      {
        path: 'user/info/editor',
        name: 'editor',
        component: UserEditor,
      }
    ]
  }
];