<script setup lang="ts">
  import CodeBlock from "@/components/CodeBlock.vue"
</script>

<template>
  <article class="space-y-6">
    <h3 class="text-2xl font-semibold text-gray-700">
      Ferramenta SSH-Auto-Config (Windows Only)
    </h3>

    <p class="text-gray-600 leading-relaxed">
      Se preferires uma ferramenta ainda mais completa e automática, podes usar o programa
      <strong>SSH-Auto-Config</strong>, desenvolvido para configurar acessos remotos via SSH e aplicar automaticamente configurações úteis como o envio de logs por <code>rsyslog</code>, configuração do <code>MySQL</code> e do <code>Apache</code>.
    </p>

    <div class="bg-green-100 border-l-4 border-green-500 text-green-900 p-4 rounded-md shadow-md">
      <p><strong>Compatível com:</strong> Windows</p>
      <p><strong>Aviso:</strong> É necessário executar como <code>Administrador</code> no Windows</p>
    </div>

    <a
      href="https://github.com/ssprata/ssh-auto-config/releases/"
      class="inline-flex items-center gap-3 !p-2 m-2 rounded-sm font-bold text-lg shadow-lg transition duration-200 bg-purple-600 !text-white hover:bg-purple-700 hover:text-white"
    >
      <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" viewBox="0 0 512 512" fill="currentColor">
        <path d="M288 32c0-17.7-14.3-32-32-32s-32 14.3-32 32l0 242.7-73.4-73.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l128 128c12.5 12.5 32.8 12.5 45.3 0l128-128c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L288 274.7 288 32zM64 352c-35.3 0-64 28.7-64 64l0 32c0 35.3 28.7 64 64 64l384 0c35.3 0 64-28.7 64-64l0-32c0-35.3-28.7-64-64-64l-101.5 0-45.3 45.3c-25 25-65.5 25-90.5 0L165.5 352 64 352zm368 56a24 24 0 1 1 0 48 24 24 0 1 1 0-48z"/>
      </svg>
      <span>Fazer Download do SSH-Auto-Config</span>
    </a>

    <div class="bg-gray-100 rounded-xl text-sm text-gray-800 mt-4 space-y-2">
      <p class="font-semibold">Como usar:</p>
      <CodeBlock :code-content="`1. Faz download da versão mais recente de 'NewAutoLog-vX.X.exe' (onde X.X é a versão)
2. Corre o executável com duplo clique (executa como administrador)
3. Preenche os campos obrigatórios:
   - User: o utilizador root do sistema a configurar (ex: root)
   - IP Address: o IP do sistema onde vais aplicar as configurações
   - Port: a porta SSH (por defeito: 22)
   - Password: a password do utilizador root do sistema
4. Clica em 'Connect' para estabelecer a ligação SSH
5. Em 'Server IP', introduz o IP do servidor de destino para onde os logs devem ser enviados
6. Usa os botões disponíveis para aplicar configurações:
   - Rsyslog Config: ativa o envio de logs via rsyslog
   - MySQL Config: aplica configuração remota ao servidor MySQL
   - Apache Config: ajusta as definições do Apache automaticamente`" />
    </div>
  </article>
</template>
