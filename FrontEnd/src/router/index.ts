import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import rSysLogView from '@/views/rSysLogView.vue'
import DashboardView from '@/views/DashboardView.vue'

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
  ],
})

export default router
