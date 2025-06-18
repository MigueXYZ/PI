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
    `Utilizador: ${utilizador.value}\nPalavra-passe: ${palavraPasse.value}\nIP/Código: ${ip.value}\nConfiguração MySQL`
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
        <h1 class="text-4xl font-bold text-gray-800 mb-6">Configuração do rSysLog para APpache</h1>
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
            <h3 class="text-2xl font-semibold text-gray-700">1. Edição do ficheiro conf do apache</h3>

            <p class="text-gray-800">1º Passo - Abrir o ficheiro</p>
            <CodeBlock :code-content="`sudo nano /etc/apache2/sites-available/000-default.conf`" />

            <p class="text-gray-800 mt-4">2º Passo - Editar o ficheiro para ficar como este:</p>
            <CodeBlock :code-content='`
              <VirtualHost *:80>
                  # ... outras diretivas ...

                  # Configuração de logs para syslog
                  ErrorLog "syslog:local1"
                  CustomLog "syslog:local2" combined

                  # ... outras diretivas ...
              </VirtualHost>
            `' />
            <p class="text-gray-800">3º Passo - Criar um ficheiro conf de apache</p>
            <CodeBlock :code-content="`sudo nano /etc/rsyslog.d/20-apache.conf`" />

            <p class="text-gray-800 mt-4">2º Passo - Editar o ficheiro para ficar como este: (substitua <code>&lt;ip-servidor&gt;</code> pelo ip do seu servidor)</p>
            <CodeBlock :code-content='`
              # Enviar para servidor remoto (ajuste o IP)
              local1.* @<ip-servidor>:514
              local2.* @<ip-servidor>:514
            `' />
          </article>

          <!-- Etapa 2 -->
          <article class="space-y-6">
            <h3 class="text-2xl font-semibold text-gray-700">2. Reiniciar o Apache r Rsyslog</h3>
            <p class="text-gray-800">
              Reinicie o Apache com este comando:
            </p>
            <CodeBlock :code-content="`sudo systemctl restart apache2`" />
            <p class="text-gray-800">
              Reinicie o Rsyslog com este comando:
            </p>
            <CodeBlock :code-content="`sudo systemctl restart rsyslog`" />
          </article>
          <article class="space-y-6">
            <h3 class="text-2xl font-semibold text-gray-700">
              3. Verifique se ficou bem configurado
            </h3>
            <p class="text-gray-800">
             Verifique se o ficheiro do apache existe, caso não tenha sido criado tente o seguinte comando:
            </p>
            <CodeBlock :code-content='`curl -I http://localhost`' />
            <p class="text-gray-800">
              Verifique se o ficheiro foi criado e se tem o respetivo log.
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
