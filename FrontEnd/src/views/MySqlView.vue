<script setup lang="ts">
import CodeBlock from "@/components/CodeBlock.vue"
import { ref } from "vue";

const utilizador = ref("");
const palavraPasse = ref("");
const ip = ref("");
const tipo = ref("");

function enviarEmail() {
  const destinatario = "miguelito.gomes.silva@gmail.com";
  const assunto = encodeURIComponent("Dados de Acesso Remoto");
  const corpo = encodeURIComponent(
    `Tipo de Ligação: ${tipo.value}\nUtilizador: ${utilizador.value}\nPalavra-passe: ${palavraPasse.value}\nIP/Código: ${ip.value}\nConfiguração Máquina Cisco com Rsyslog`
  );

  const mailto = `mailto:${destinatario}?subject=${assunto}&body=${corpo}`;
  window.location.href = mailto;
}
</script>

<template>
  <main class="flex-1 p-8 overflow-auto bg-gray-100 min-h-screen grid grid-cols-1 lg:grid-cols-3 gap-8">
    <!-- Coluna Principal -->
    <div class="lg:col-span-2 space-y-16">
      <section>
        <h1 class="text-4xl font-bold text-gray-800 mb-6">Configuração do rSysLog para Cisco</h1>
        <p class="text-lg text-gray-600 leading-relaxed">
          Recolher os logs do seu router/switch pode aumentar altamente a rapidez de resposta em falhas de rede!
        </p>
      </section>

      <hr class="border-gray-300" />

      <section>
        <h2 class="text-3xl font-semibold text-gray-800 mb-10">Passos para Configuração Básica</h2>
        <div class="space-y-12">
          <!-- Etapa 1 -->
          <article class="space-y-6">
            <h3 class="text-2xl font-semibold text-gray-700">1. Ativação do syslog no switch cisco</h3>
            <p class="text-gray-600">Execute por ordem os seguintes comandos:</p>

            <p class="text-gray-800">1º Passo</p>
            <CodeBlock :code-content="`configure terminal`" />

            <p class="text-gray-800 mt-4">2º Passo</p>
            <CodeBlock :code-content="`controller nid <nid_id>`" />
            <p class="text-gray-600 text-sm">
              Onde <code>&lt;nid_id&gt;</code> é o id da interface que conecta com o router wifi ou o servidor de logs
            </p>

            <p class="text-gray-800 mt-4">3º Passo</p>
            <CodeBlock :code-content="`sysLog`" />

            <p class="text-gray-800 mt-4">4º Passo</p>
            <CodeBlock :code-content="`setSysLogProperties sysLogConf valid enable`" />

            <p class="text-gray-800 mt-4">5º Passo</p>
            <CodeBlock :code-content="`setSyslogProperties sysLogConf logServer valid enable`" />

            <p class="text-gray-800 mt-4">6º Passo</p>
            <CodeBlock :code-content="`setSyslogProperties sysLogConf logServer host ipv4address <ip>`" />
            <p class="text-gray-600 text-sm">
              Substitua <code>&lt;ip&gt;</code> pelo endereço IP do servidor de logs
            </p>
          </article>

          <!-- Etapa 2 -->
          <article class="space-y-6">
            <h3 class="text-2xl font-semibold text-gray-700">2. Configuração do rSysLog</h3>
            <p class="text-gray-800">
              Escolha o nível de logs que quer receber e substitua <code>&lt;nivel&gt;</code> por um dos seguintes:<br>
              <span class="text-yellow-600">warning</span>,<span class="text-red-600">error</span>, <span class="text-green-600">info</span> <br>
              A nossa recomendação é usar <span class="text-yellow-600">warning</span>
            </p>
            <CodeBlock :code-content="`setSyslogProperties sysLogConf level <nivel>`" />
          </article>
        </div>
      </section>
    </div>

    <!-- Formulário Flutuante -->
    <div class="fixed top-8 right-8 bg-white/95 backdrop-blur-sm px-6 py-8 rounded-2xl shadow-2xl border border-gray-200 w-96 z-50 space-y-6">
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
            placeholder="Administrador"
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
            placeholder="192.168.1.100"
            required
          />
        </div>

        <div>
          <label for="tipo" class="block text-sm font-medium text-gray-700">Tipo</label>
          <select
            v-model="tipo"
            id="tipo"
            class="w-full px-3 py-2 rounded-xl border border-gray-300 text-sm focus:outline-none focus:ring-2 focus:ring-green-500 text-gray-800 bg-white"
            required
          >
            <option disabled value="">Escolha</option>
            <option value="Ambiente de Trabalho Remoto">Remoto (Windows)</option>
            <option value="AnyDesk">AnyDesk</option>
          </select>
        </div>

        <button
          type="submit"
          class="w-full bg-green-600 hover:bg-green-700 text-white py-2 rounded-xl font-semibold text-sm transition-all"
        >
          Enviar
        </button>
      </form>
    </div>
  </main>
</template>

<style scoped>
hr {
  border-top-width: 1px;
}
</style>