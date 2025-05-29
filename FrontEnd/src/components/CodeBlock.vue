<script setup lang="ts">
import { ref, computed } from 'vue'

const props = defineProps<{
  codeContent: string
}>()

const isCopied = ref(false)

const lines = computed(() => props.codeContent.trim().split('\n'))

const copyToClipboard = async (): Promise<void> => {
  try {
    await navigator.clipboard.writeText(props.codeContent.trim())
    isCopied.value = true
    setTimeout(() => {
      isCopied.value = false
    }, 2000)
  } catch (err) {
    console.error('Falha ao copiar texto:', err)
  }
}
</script>

<template>
  <div class="relative my-4 bg-gray-900 rounded-md max-w-2xl mx-auto group">
    <!-- Botão que só aparece no hover -->
    <button
      class="absolute top-2 right-2 px-2 py-0.5 text-xs font-semibold text-white bg-blue-600 rounded opacity-0 group-hover:opacity-100 transition-opacity duration-200 hover:bg-blue-700"
      @click="copyToClipboard"
      :aria-label="isCopied ? 'Copiado!' : 'Copiar código'"
    >
      {{ isCopied ? '✓ Copiado' : 'Copiar' }}
    </button>
    
    <div class="p-3 font-mono text-sm text-gray-100 leading-5">
      <div v-for="(line, index) in lines" :key="index" class="flex">
        <span class="w-8 pr-3 text-gray-500 select-none text-right flex-shrink-0">{{ String(index + 1) }}</span>
        <span class="flex-1">{{ line }}</span>
      </div>
    </div>
  </div>
</template>