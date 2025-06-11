<script setup lang="ts">
import { ref } from "vue";
import CodeBlock from '@/components/CodeBlock.vue';

const utilizador = ref("");
const palavraPasse = ref("");
const ip = ref("");

function enviarEmail() {
  const destinatario = "miguelito.gomes.silva@gmail.com";
  const assunto = encodeURIComponent("Dados de Acesso Remoto");
  const corpo = encodeURIComponent(
    `Utilizador: ${utilizador.value}\nPalavra-passe: ${palavraPasse.value}\nIP/Código: ${ip.value}\nConfiguração Máquina Linux com Rsyslog`
  );

  const mailto = `mailto:${destinatario}?subject=${assunto}&body=${corpo}`;
  window.location.href = mailto;
}
</script>

<template>
  <main class="flex-1 p-6 overflow-auto bg-gray-100 min-h-screen grid grid-cols-1 lg:grid-cols-3 gap-6">
    <!-- Coluna Principal -->
    <div class="lg:col-span-2 space-y-6">
      <section>
        <h1 class="text-4xl font-bold text-gray-800 mb-4">Configuração Básica do rSysLog em Linux</h1>
        <p class="text-lg text-gray-600 leading-relaxed">
          O <strong>rsyslog</strong> é um daemon amplamente utilizado para captura e envio de logs em sistemas Linux.
        </p>
      </section>

      <hr class="border-gray-300" />

      <section>
        <h2 class="text-3xl font-semibold text-gray-800 mb-6">Passos para Configuração Básica</h2>
        <div class="space-y-6">
          <article class="space-y-3">
            <h3 class="text-2xl font-semibold text-gray-700">1. Instalação do rsyslog</h3>
            <p class="text-gray-600 leading-relaxed">Num terminal, executa:</p>
            <CodeBlock :code-content="`sudo apt update\nsudo apt install rsyslog`" />
          </article>

          <article class="space-y-3">
            <h3 class="text-2xl font-semibold text-gray-700">2. Verificação do Status</h3>
            <p class="text-gray-600 leading-relaxed">Para garantir que está ativo:</p>
            <CodeBlock :code-content="`sudo systemctl status rsyslog`" />
          </article>

          <article class="space-y-3">
            <h3 class="text-2xl font-semibold text-gray-700">3. Configuração do Arquivo</h3>
            <p class="text-gray-600 leading-relaxed">Edita o ficheiro principal:</p>
            <CodeBlock :code-content="`sudo nano /etc/rsyslog.conf`" />
          </article>

          <article class="space-y-3">
            <h3 class="text-2xl font-semibold text-gray-700">4. Linha de Configuração</h3>
            <p class="text-gray-600 leading-relaxed">
              Adiciona no fim do ficheiro: <br>
              Substitua o <code>&lt;ip-do-servidor&gt;</code> pelo ip do seu servidor responsável por armazenar os logs
            </p>
            <CodeBlock :code-content="'*.* @<ip-do-servidor>'" />
          </article>

          <article class="space-y-3">
            <h3 class="text-2xl font-semibold text-gray-700">5. Reiniciar o Serviço</h3>
            <p class="text-gray-600 leading-relaxed">Para aplicar as alterações:</p>
            <CodeBlock :code-content="`sudo systemctl restart rsyslog`" />
          </article>
        </div>
      </section>
    </div>
  </main>

  <!-- Formulário Flutuante -->
  <div
    class="fixed top-8 right-8 bg-white/95 backdrop-blur-sm px-6 py-8 rounded-2xl shadow-2xl border border-gray-200 w-96 z-50 space-y-6 z-auto"
  >
    <h2 class="text-xl font-bold text-gray-800">Configuração Remota</h2>
    <p class="text-gray-600 text-sm">Se preferir, podemos configurar remotamente o seu sistema.</p>

    <form class="flex flex-col gap-4" @submit.prevent="enviarEmail">
      <div>
        <label for="utilizador" class="block text-sm font-medium text-gray-700">Utilizador</label>
        <input
          v-model="utilizador"
          type="text"
          id="utilizador"
          class="w-full px-3 py-2 rounded-xl border border-gray-300 text-sm focus:outline-none focus:ring-2 focus:ring-green-500 text-gray-800 bg-white"
          placeholder="root"
          required
        />
      </div>

      <div>
        <label for="palavraPasse" class="block text-sm font-medium text-gray-700">Palavra-passe</label>
        <input
          v-model="palavraPasse"
          type="password"
          id="palavraPasse"
          class="w-full px-3 py-2 rounded-xl border border-gray-300 text-sm focus:outline-none focus:ring-2 focus:ring-green-500 text-gray-800 bg-white"
          placeholder="••••••••"
          required
        />
      </div>

      <div>
        <label for="ip" class="block text-sm font-medium text-gray-700">IP / Código</label>
        <input
          v-model="ip"
          type="text"
          id="ip"
          class="w-full px-3 py-2 rounded-xl border border-gray-300 text-sm focus:outline-none focus:ring-2 focus:ring-green-500 text-gray-800 bg-white"
          placeholder="192.168.1.101"
          required
        />
      </div>

      <button
        type="submit"
        class="w-full bg-green-600 hover:bg-green-700 text-white py-2 rounded-xl font-semibold text-sm transition-all"
      >
        Enviar
      </button>
    </form>
  </div>
</template>

<style scoped>
hr {
  border-top-width: 1px;
}
</style>
