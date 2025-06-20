<script setup lang="ts">
import { computed } from 'vue'
import { useRoute } from 'vue-router'
import Sidebar from '@/components/Sidebar.vue'

const route = useRoute()

const isDashboard = computed(() => route.name === 'home')
</script>

<template>
  <div class="flex w-full h-screen overflow-hidden">
    <Sidebar :class="{ hidden: isDashboard }" />
    <main
      class="flex-1 h-full overflow-auto bg-gray-50 p-6 transition-all duration-300"
      :class="{ 'lg:pl-64': !isDashboard }"
    >
      <router-view />
    </main>
  </div>
</template>


<style scoped>
main {
  transition: padding 0.3s ease-in-out;
}
</style>
