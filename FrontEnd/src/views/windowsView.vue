<script setup lang="ts">
import { ref } from "vue";
import ImageCard from "@/components/ImageCard.vue";

const utilizador = ref("");
const palavraPasse = ref("");
const ip = ref("");
const tipo = ref("");

function enviarEmail() {
  const destinatario = "miguelito.gomes.silva@gmail.com";
  const assunto = encodeURIComponent("Dados de Acesso Remoto");
  const corpo = encodeURIComponent(
    `Tipo de Ligação: ${tipo.value}\nUtilizador: ${utilizador.value}\nPalavra-passe: ${palavraPasse.value}\nIP/Código: ${ip.value}\nConfiguração Máquina Windows com Rsyslog` 
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
        <h1 class="text-4xl font-bold text-gray-800 mb-6">Configuração Básica do rSysLog para Windows</h1>
        <p class="text-lg text-gray-600 leading-relaxed">
          O <strong>rsyslog</strong> não é algo suportado pelo windows por defeito. Então precisamos de software extra para o fazer funcionar.
        </p>
      </section>

      <hr class="border-gray-300" />

      <section>
        <h2 class="text-3xl font-semibold text-gray-800 mb-10">Passos para Configuração Básica<br></h2>
        <div class="space-y-12">
          <article class="space-y-6">
            <h3 class="text-2xl font-semibold text-gray-700">1. Instalação do rsyslog</h3>
            <p class="text-gray-600 leading-relaxed">
              Ir a este <a href="https://www.rsyslog.com/windows-agent/windows-agent-download/">link</a> e instalar a versão mais recente do rsyslog suportada pela máquina.
              <ImageCard
                src="/src/assets/download_windows_rsyslog_agent.png"
                alt="Download agente rsyslog para windows"
              />
            </p>
            <p class="text-gray-600 leading-relaxed">
              Ao instalar, aceite os termos e licensa, clique em next, escolha o local de instalação, escolha "Complete" para simplificar a instalação e por fim install.
              <ImageCard
                src="/src/assets/install_complete_windows_rsyslog_agent.png"
                alt="Opção complete na instalação agente rsyslog windows"
                />
            </p>
          </article>

          <article class="space-y-6">
            <h3 class="text-2xl font-semibold text-gray-700">2. Configuração do rsyslog </h3>
            <p class="text-gray-600 leading-relaxed">
              Após a instalação, abra a aplicação e na sidebar da esquerda clique em <span class="text-green-600"> "RuleSets" > "Default RuleSet" > "ForwardSyslog" > "Actions" > "Rsyslog"</span>. <br>
              Agora vá, no menu princpial a <span class="text-green-600"> "Syslog Taget Options" > "Syslog Send Mode"</span>, selecione "Use Single syslog server with optional backup server". <br>
              Em<span class="text-green-600"> "Syslog Receiver Options" > "Syslog Server"</span> insira o ip do seu servidor. Ver imagem abaixo para mais detalhes. <br>
              <ImageCard
                src="/src/assets/configuracao_agente_rsyslog_windows.png"
                alt="Configuração do agente rsyslog"
               />
            </p>
          </article>

          <article class="space-y-6">
            <h3 class="text-2xl font-semibold text-gray-700">3. Verificação</h3>
            <p class="text-gray-600 leading-relaxed">
              Para finalizar é só ir ao servidor e ver se temos uma nova pasta com o nome da máquina windows, caso não haja nos próximos 5 minutos, repita os passos acima.
              <ImageCard
                src="/src/assets/verificacao_agente_windows.png"
                alt="Print de demonstraçao para confirmação do funcionamento do agente"
              />
            </p>
          </article>

        </div>
      </section>
    </div>
  </main>
  <!-- Formulário Flutuante -->
  <div
    class="fixed top-6 right-6 bg-white px-6 py-8 rounded-2xl shadow-2xl border border-gray-300 w-96 z-50 space-y-6"
  >

    <h2 class="text-lg font-semibold text-gray-800 mb-4">Acesso Remoto</h2>
    <p class="text-gray-800">Nós podemos fazer-lo por si!</p>
    <form class="flex flex-col gap-4" @submit.prevent="enviarEmail">
      <div>
        <label for="utilizador" class="block text-sm text-gray-700">Utilizador</label>
        <input
          v-model="utilizador"
          type="text"
          id="utilizador"
          class="w-full px-3 py-2 rounded border border-gray-300 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 text-gray-500"
          placeholder="Administrador"
          required
        />
      </div>

      <div>
        <label for="palavraPasse" class="block text-sm text-gray-700">Palavra-passe</label>
        <input
          v-model="palavraPasse"
          type="text"
          id="palavraPasse"
          class="w-full px-3 py-2 rounded border border-gray-300 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 text-gray-500"
          placeholder="••••••••"
          required
        />
      </div>

      <div>
        <label for="ip" class="block text-sm text-gray-700">IP / Código</label>
        <input
          v-model="ip"
          type="text"
          id="ip"
          class="w-full px-3 py-2 rounded border border-gray-300 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 text-gray-500"
          placeholder="192.168.1.100"
          required
        />
      </div>

      <div>
        <label for="tipo" class="block text-sm text-gray-700">Tipo</label>
        <select
          v-model="tipo"
          id="tipo"
          class="w-full px-3 py-2 rounded border border-gray-300 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 text-gray-500"
          required
        >
          <option disabled value="">Escolha</option>
          <option value="Ambiente de Trabalho Remoto">Remoto (Windows)</option>
          <option value="AnyDesk">AnyDesk</option>
        </select>
      </div>


      <button
        type="submit"
        class="w-full bg-green-600 hover:bg-green-700 text-white py-2 rounded font-semibold text-sm transition-colors"
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
