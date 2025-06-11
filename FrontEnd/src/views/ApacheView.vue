<script setup lang="ts">
import CodeBlock from "@/components/CodeBlock.vue"
import { ref } from "vue";

const utilizador = ref("");
const palavraPasse = ref("");
const ip = ref("");

function enviarEmail() {
  const destinatario = "miguelito.gomes.silva@gmail.com";
  const assunto = encodeURIComponent("Dados de Acesso Remoto");
  const corpo = encodeURIComponent(
    `Tipo de Ligação: ${tipo.value}\nUtilizador: ${utilizador.value}\nPalavra-passe: ${palavraPasse.value}\nIP/Código: ${ip.value}\nConfiguração MySQL`
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
        <h1 class="text-4xl font-bold text-gray-800 mb-6">Configuração do rSysLog para MySQL</h1>
        <p class="text-lg text-gray-600 leading-relaxed">
          Recolher os logs de MySQL para organizá-los no mesmo loccal como forma de centralização.
        </p>
      </section>

      <hr class="border-gray-300" />

      <section>
        <h2 class="text-3xl font-semibold text-gray-800 mb-10">Passos para Configuração Básica</h2>
        <div class="space-y-12">
          <!-- Etapa 1 -->
          <article class="space-y-6">
            <h3 class="text-2xl font-semibold text-gray-700">1. Edição do ficheiro conf do mysql</h3>

            <p class="text-gray-800">1º Passo - Abrir o ficheiro</p>
            <CodeBlock :code-content="`sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf`" />

            <p class="text-gray-800 mt-4">2º Passo - Editar o ficheiro para ficar como este:</p>
            <CodeBlock :code-content="`[mysqld]
                  syslog = 1
                  log_error = syslog
                  general_log = 1
                  general_log_file = syslog
                  slow_query_log = 1
                  slow_query_log_file = syslog`" />
          </article>

          <!-- Etapa 2 -->
          <article class="space-y-6">
            <h3 class="text-2xl font-semibold text-gray-700">2. Reiniciar o MySQL</h3>
            <p class="text-gray-800">
              Reinicie o MySQL com este comando:
            </p>
            <CodeBlock :code-content="`sudo systemctl restart mysql`" />
          </article>
          <article class="space-y-6">
            <h3 class="text-2xl font-semibold text-gray-700">
              3. Verifique se ficou bem configurado
            </h3>
            <p class="text-gray-800">
             Verifique se o ficheiro do mysql tem algo, caso não tenha sido criado tente o seguinte comando:
            </p>
            <CodeBlock :code-content='`logger -t mysql "Teste de log do MySQL" `' />
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
