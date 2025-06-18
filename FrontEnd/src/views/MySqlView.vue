<script setup lang="ts">
import CodeBlock from "@/components/CodeBlock.vue"
import { ref } from "vue";

const utilizador = ref("");
const palavraPasse = ref("");
const ip = ref("");

function enviarEmail() {
  const destinatario = "2221462@my.ipleiria.pt, 2222970@my.ipleiria.pt";
  const assunto = encodeURIComponent("Dados de Acesso Remoto");
  const corpo = encodeURIComponent(
    `Utilizador: ${
utilizador.value
}\nPalavra-passe: ${
palavraPasse.value
}\nIP/Código: ${
ip.value
}\nConfiguração MySQL`
  );

  const mailto = `mailto:${
destinatario
}?subject=${
assunto
}&body=${
corpo
}`;
  window.location.href = mailto;
}
</script>

<template>
  <main class="flex-1 p-8 overflow-auto bg-gray-100 min-h-screen grid grid-cols-1 lg:grid-cols-3 gap-8">
    <!-- Coluna Principal -->
    <div class="lg:col-span-2 space-y-16">
      <section>
        <h1 class="text-4xl font-bold text-gray-800 mb-6">Configuração do rSysLog para MySQL</h1>
        <p class="text-lg text-gray-600 leading-relaxed">
          Recolher os logs de MySQL para organizá-los no mesmo loccal como forma de centralização.
        </p>
      </section>

      <hr class="border-gray-300"/>

      <section>
        <h2 class="text-3xl font-semibold text-gray-800 mb-6">Configuração Automática</h2>
        <article class="space-y-6">
          <h3 class="text-2xl font-semibold text-gray-700">4. Script Automático (Linux)</h3>
          <p class="text-gray-600 leading-relaxed">
            Se estás a usar Ubuntu ou outra distribuição baseada em Debian, podes automatizar toda a configuração com este script.<br>
          </p>
          <div class="max-w-xl mx-auto p-4 bg-yellow-100 border-l-4 border-yellow-500 text-yellow-900 rounded-md shadow-md">
            <div class="flex items-start space-x-3">
              <svg class="w-6 h-6 text-yellow-500 mt-1" fill="none" stroke="currentColor" stroke-width="2"
                   viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round"
                      d="M13 16h-1v-4h-1m1-4h.01M12 2a10 10 0 1010 10A10 10 0 0012 2z"/>
              </svg>
              <div>
                <p><span class="font-bold">ATENÇÃO:</span> O script pode alterar as configurações do utilizador!</p>
              </div>
            </div>
          </div>
          <br>
          <a
            href="/bashscripts/configurar_mysql_logs.sh"
            download
            class="inline-flex items-center gap-3 !p-2 m-2 rounded-sm font-bold text-lg shadow-lg transition duration-200 bg-blue-600 !text-white hover:bg-green-600 hover:text-black"
          >
            <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" viewBox="0 0 512 512" fill="currentColor">
              <path d="M288 32c0-17.7-14.3-32-32-32s-32 14.3-32 32l0 242.7-73.4-73.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l128 128c12.5 12.5 32.8 12.5 45.3 0l128-128c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L288 274.7 288 32zM64 352c-35.3 0-64 28.7-64 64l0 32c0 35.3 28.7 64 64 64l384 0c35.3 0 64-28.7 64-64l0-32c0-35.3-28.7-64-64-64l-101.5 0-45.3 45.3c-25 25-65.5 25-90.5 0L165.5 352 64 352zm368 56a24 24 0 1 1 0 48 24 24 0 1 1 0-48z"/>
            </svg>
            <span>Fazer Download do Script</span>
          </a>
          <div class="bg-gray-100 rounded-xl text-sm text-gray-800 mt-4">
            <p class="mb-2 font-semibold">Como usar:</p>
            <CodeBlock :code-content="`chmod +x configurar_mysql_logs.sh
        sudo ./configurar_mysql_logs.sh`"/>
          </div>
        </article>
        <h2 class="text-3xl font-semibold text-gray-800 mb-10">Passos para Configuração Básica</h2>
        <div class="space-y-12">
          <!-- Etapa 1 -->
          <article class="space-y-6">
            <h3 class="text-2xl font-semibold text-gray-700">1. Edição do ficheiro conf do mysql</h3>

            <p class="text-gray-800">1º Passo - Abrir o ficheiro</p>
            <CodeBlock :code-content="`sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf`"/>

            <p class="text-gray-800 mt-4">2º Passo - Editar o ficheiro para ficar como este:</p>
            <CodeBlock :code-content="`[mysqld]
                  syslog = 1
                  log_error = syslog
                  general_log = 1
                  general_log_file = syslog
                  slow_query_log = 1
                  slow_query_log_file = syslog`"/>
          </article>

          <!-- Etapa 2 -->
          <article class="space-y-6">
            <h3 class="text-2xl font-semibold text-gray-700">2. Reiniciar o MySQL</h3>
            <p class="text-gray-800">
              Reinicie o MySQL com este comando:
            </p>
            <CodeBlock :code-content="`sudo systemctl restart mysql`"/>
          </article>
          <article class="space-y-6">
            <h3 class="text-2xl font-semibold text-gray-700">
              3. Verifique se ficou bem configurado
            </h3>
            <p class="text-gray-800">
              Verifique se o ficheiro do mysql tem algo, caso não tenha sido criado tente o seguinte comando:
            </p>
            <CodeBlock :code-content='`logger -t mysql "Teste de log do MySQL" `'/>
            <p class="text-gray-800">
              Verifique se o ficheiro do mysql tem lá "Teste de log do MySQL"
            </p>
          </article>
        </div>
      </section>
    </div>

    <!-- Formulário Flutuante -->
    <div class="fixed top-8 right-8 bg-white/95 backdrop-blur-sm px-6 py-8 rounded-2xl shadow-2xl border border-gray-200 w-96 z-50 space-y-6 z-auto">
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
          <label for="ip" class="block text-sm font-medium text-gray-700">IP</label>
          <input
            v-model="ip"
            type="text"
            id="ip"
            class="w-full px-3 py-2 rounded-xl border border-gray-300 text-sm focus:outline-none focus:ring-2 focus:ring-green-500 text-gray-800 bg-white"
            placeholder="192.168.1.100"
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
  </main>
</template>

<style scoped>
hr {
  border-top-width: 1px;
}
</style>
