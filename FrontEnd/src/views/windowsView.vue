<script setup lang="ts">
import { ref } from "vue";
import CodeBlock from "@/components/CodeBlock.vue";
import ImageCard from "@/components/ImageCard.vue";
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
        <h2 class="text-3xl font-semibold text-gray-800 mb-10">Passos para Configuração Básica</h2>
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
    <div class="bg-white p-8 rounded-2xl shadow-xl border border-gray-200">
      <h2 class="text-2xl font-semibold text-gray-800 mb-6">Enviar Configuração</h2>
      <form class="space-y-6">
        <div>
          <label for="user" class="block text-gray-700 font-medium mb-1">Utilizador</label>
          <input type="text" id="user" class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="root" />
        </div>
        <div>
          <label for="password" class="block text-gray-700 font-medium mb-1">Palavra-passe</label>
          <input type="password" id="password" class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="••••••••" />
        </div>
        <div>
          <label for="ip" class="block text-gray-700 font-medium mb-1">Endereço IP</label>
          <input type="text" id="ip" class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="192.168.1.100" />
        </div>
        <div class="pt-4">
          <button type="submit" class="w-full bg-green-500 text-white py-3 rounded-lg font-semibold hover:bg-blue-700 transition-colors">Submeter</button>
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
