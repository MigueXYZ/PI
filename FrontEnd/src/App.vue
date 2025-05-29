<script setup lang="ts">
import Sidebar from "@/components/Sidebar.vue";
</script>

<template>
  <div class="flex w-full h-screen overflow-hidden">
    <Sidebar />
    <main class="flex-1 h-full overflow-auto bg-gray-50 p-6 lg:pl-64 transition-all duration-300">
      <router-view />
    </main>
  </div>
</template>


<style scoped>
main {
  transition: padding 0.3s ease-in-out;
}
</style>
