<script setup lang="ts">
defineProps<{
  src: string;
  alt?: string;
}>();
</script>

<template>
  <div class="bg-white rounded-2xl shadow-xl border border-gray-200 overflow-hidden">
    <img :src="src" :alt="alt" class="w-full h-auto object-cover" />
  </div>
</template>
