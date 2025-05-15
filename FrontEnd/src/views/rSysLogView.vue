<script setup lang="ts">
import CodeBlock from "@/components/CodeBlock.vue";
</script>

<template>
  <main class="flex-1 p-8 overflow-auto">
    <div class="max-w-3xl mx-auto space-y-16">
      <section>
        <h1 class="text-4xl font-bold text-gray-800 mb-6">Configuração Básica do rSysLog</h1>
        <p class="text-lg text-gray-600 leading-relaxed">
          O <strong>rsyslog</strong> é uma ferramenta poderosa para coleta, armazenamento e envio de logs do sistema e aplicativos. Muito utilizada para monitorar eventos e diagnosticar problemas em servidores, é altamente configurável.
        </p>
      </section>

      <hr class="border-gray-300" />

      <section>
        <h2 class="text-3xl font-semibold text-gray-800 mb-10">Passos para Configuração Básica</h2>

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
            <h3 class="text-2xl font-semibold text-gray-700">4. Reiniciar o Serviço</h3>
            <p class="text-gray-600 leading-relaxed">
              Após alterar a configuração, reinicie o serviço:
            </p>
            <CodeBlock :code-content="`sudo systemctl restart rsyslog`" />
          </article>

          <article class="space-y-6">
            <h3 class="text-2xl font-semibold text-gray-700">5. Monitorização dos Logs</h3>
            <p class="text-gray-600 leading-relaxed">
              Para monitorar os logs em tempo real:
            </p>
            <CodeBlock :code-content="`tail -f /var/log/syslog`" />
          </article>
        </div>
      </section>
    </div>
  </main>
</template>

<style scoped>
hr {
  border-top-width: 1px;
}
</style>
