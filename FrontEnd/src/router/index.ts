import { createRouter, createWebHistory } from 'vue-router'
import rSysLogView from '@/views/rSysLogView.vue'
import DashboardView from '@/views/DashboardView.vue'
import windowsView from '@/views/windowsView.vue'
import switchesCiscoView from '@/views/switchesCiscoView.vue'
import mySqlView from '@/views/MySqlView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: DashboardView,
    },
    {
      path:'/MaquinasLinux',
      name:'MaquinasLinux',
      component: rSysLogView,
    },
    {
      path:'/MaquinasWindows',
      name:'MaquinasWindows',
      component: windowsView,
    },
    {
      path:'/SwitchesCisco',
      name:'SwitchesCisco',
      component:switchesCiscoView,
    },
    {
      path:'/mysql',
      name:'MySQL',
      component:mySqlView,
    },
  ],
})

export default router
