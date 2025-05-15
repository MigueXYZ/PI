<script setup lang="ts">
import { ref, computed } from 'vue'

const props = defineProps({
  codeContent: {
    type: String,
    required: true
  }
})

const isCopied = ref(false)

// Computed para limpar espaços extras
const cleanedCode = computed(() => props.codeContent.trim())

const copyToClipboard = async () => {
  try {
    await navigator.clipboard.writeText(cleanedCode.value)
    isCopied.value = true
    setTimeout(() => {
      isCopied.value = false
    }, 2000)
  } catch (err) {
    console.error('Failed to copy text:', err)
  }
}
</script>

<template>
  <div class="relative my-6 p-4 bg-gray-900 rounded-xl max-w-2xl mx-auto shadow-lg">
    <pre class="overflow-x-auto font-mono text-gray-100 whitespace-pre-wrap text-sm">
<code>{{ cleanedCode }}</code>
    </pre>
    <button
      class="absolute top-2 right-2 px-3 py-1 text-xs font-semibold text-white bg-blue-600 rounded-md hover:bg-blue-700 active:bg-blue-800 transition-all"
      @click="copyToClipboard"
      :aria-label="isCopied ? 'Copiado!' : 'Copiar código'"
    >
      {{ isCopied ? '✓ Copiado' : 'Copiar' }}
    </button>

  </div>

</template>
