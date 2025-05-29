<script setup lang="ts">
import { ref } from "vue";
import CodeBlock from '@/components/CodeBlock.vue'

const utilizador = ref("");
const palavraPasse = ref("");
const ip = ref("");

function enviarEmail() {
  const destinatario = "miguelito.gomes.silva@gmail.com"; // troca pelo email que quiseres
  const assunto = encodeURIComponent("Configuração Básica do rSyslog");
  const corpo = encodeURIComponent(
    `Utilizador: ${utilizador.value}\n` +
    `Palavra-passe: ${palavraPasse.value}\n` +
    `Endereço IP: ${ip.value}` + "Configuração de máquina linux com rsyslog"
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
        <h1 class="text-4xl font-bold text-gray-800 mb-6">Configuração Básica do rSysLog</h1>
        <p class="text-lg text-gray-600 leading-relaxed">
          O <strong>rsyslog</strong> é uma ferramenta poderosa para coleta, armazenamento e envio de logs do sistema e aplicativos. Muito utilizada para monitorar eventos e diagnosticar problemas em servidores, é altamente configurável.
        </p>
      </section>

      <hr class="border-gray-300" />

      <section>
        <h2 class="text-3xl font-semibold text-gray-800 mb-10">Passos para Configuração Básica<br></h2>
        <div class="space-y-12">
          <article class="space-y-6">
            <h3 class="text-2xl font-semibold text-gray-700">1. Instalação do rsyslog</h3>
            <p class="text-gray-600 leading-relaxed">
              Para instalar o rsyslog no Linux (ex: Ubuntu), execute:
            </p>
            <CodeBlock :code-content="`sudo apt update\nsudo apt install rsyslog`" />
          </article>

          <article class="space-y-6">
            <h3 class="text-2xl font-semibold text-gray-700">2. Verificação do Status</h3>
            <p class="text-gray-600 leading-relaxed">
              Após a instalação, verifique se o serviço está ativo:
            </p>
            <CodeBlock :code-content="`sudo systemctl status rsyslog`" />
          </article>

          <article class="space-y-6">
            <h3 class="text-2xl font-semibold text-gray-700">3. Configuração do Arquivo rsyslog.conf</h3>
            <p class="text-gray-600 leading-relaxed">
              O arquivo de configuração principal fica em <code class="bg-gray-300 px-2 py-1 rounded text-gray-800">/etc/rsyslog.conf</code>. Para editá-lo, execute:
            </p>
            <CodeBlock :code-content="`sudo nano /etc/rsyslog.conf`" />
          </article>

          <article class="space-y-6">
            <h3 class="text-2xl font-semibold text-gray-700">4. Editar o ficheiro</h3>
            <p class="text-gray-600 leading-relaxed">
              Agora que temos o ficheiro aberto no nano ou no editor à sua escolha temos de o editar.
            </p>
            <p class="text-gray-600 leading-relaxed">
              No fim do ficheiro insira esta linha substituindo <-ip servidor-> pelo ip do servidor:
            </p>
            <CodeBlock :code-content="'*.* @<-ip servidor->'" />
            <p class="text-gray-600 leading-relaxed">
              Nota: Não se esqueça de guardar o ficheiro!
            </p>
          </article>

          <article class="space-y-6">
            <h3 class="text-2xl font-semibold text-gray-700">5. Reiniciar o Serviço</h3>
            <p class="text-gray-600 leading-relaxed">
              Após alterar a configuração, reinicie o serviço:
            </p>
            <CodeBlock :code-content="`sudo systemctl restart rsyslog`" />
          </article>
        </div>
      </section>
    </div>


    <!-- Formulário na Coluna Secundária -->
    <div class="bg-white p-8 rounded-2xl shadow-xl border border-gray-200 flex flex-col gap-6 self-start">
      <h2 class="text-2xl font-semibold text-gray-800">Configuração Remota</h2>
      <p>Nós podemos fazer-lo por si!</p>
      <form class="flex flex-col gap-6" @submit.prevent="enviarEmail">
        <div>
          <label for="user" class="block text-gray-700 font-medium mb-1">Utilizador</label>
          <input
            v-model="utilizador"
            type="text"
            id="user"
            class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 text-gray-800"
            placeholder="root"
            required
          />
        </div>
        <div>
          <label for="password" class="block text-gray-700 font-medium mb-1">Palavra-passe</label>
          <input
            v-model="palavraPasse"
            type="password"
            id="password"
            class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 text-gray-800"
            placeholder="••••••••"
            required
          />
        </div>
        <div>
          <label for="ip" class="block text-gray-700 font-medium mb-1">Endereço IP</label>
          <input
            v-model="ip"
            type="text"
            id="ip"
            class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 text-gray-800"
            placeholder="192.168.1.100"
            required
          />
        </div>
        <div class="pt-2">
          <button
            type="submit"
            class="w-full bg-green-500 text-white py-3 rounded-lg font-semibold hover:bg-green-600 transition-colors"
          >
            Submeter
          </button>
        </div>
      </form>
    </div>
  </main>
</template>

<style scoped>
hr {
  border-top-width: 1px;
}
</style>
