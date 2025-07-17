<template>
  <div class="w-full min-h-screen flex justify-center items-start bg-gray-50 px-4 py-10">
    <div class="w-full max-w-5xl bg-white shadow-lg text-center rounded-xl p-6">
      <h1 class="text-4xl font-bold text-gray-900">Dashboard</h1>
      <p class="text-gray-700 mt-3 text-lg">
        Bem-vindo ao painel de controlo! Aqui você pode acessar as configurações de sistemas e serviços de forma rápida e fácil.
      </p>

      <!-- Configuração De Sistemas -->
      <h2 class="mt-10 mb-6 text-3xl font-semibold text-green-700">Configuração De Sistemas</h2>
      <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-6">
        <button
          class="flex flex-col items-center justify-center p-6 bg-gray-100 rounded-lg shadow hover:bg-green-100 transition"
          @click="navigateTo('/AutoTool')"
        >
          <font-awesome-icon :icon="['fab', 'python']" class="text-3xl mb-2 text-green-600" />
          <span class="font-semibold text-gray-800">Ferramenta Automática (Windows)</span>
        </button>
        <button
          class="flex flex-col items-center justify-center p-6 bg-gray-100 rounded-lg shadow hover:bg-green-100 transition"
          @click="navigateTo('/MaquinasLinux')"
        >
          <font-awesome-icon :icon="['fab', 'linux']" class="text-3xl mb-2 text-green-600" />
          <span class="font-semibold text-gray-800">Maquinas Linux</span>
        </button>
        <button
          class="flex flex-col items-center justify-center p-6 bg-gray-100 rounded-lg shadow hover:bg-green-100 transition"
          @click="navigateTo('/MaquinasWindows')"
        >
          <font-awesome-icon :icon="['fab', 'windows']" class="text-3xl mb-2 text-green-600" />
          <span class="font-semibold text-gray-800">Maquinas Windows</span>
        </button>
        <button
          class="flex flex-col items-center justify-center p-6 bg-gray-100 rounded-lg shadow hover:bg-green-100 transition"
          @click="navigateTo('/SwitchesCisco')"
        >
          <font-awesome-icon :icon="['fas', 'globe']" class="text-3xl mb-2 text-green-600" />
          <span class="font-semibold text-gray-800">Switches Cisco</span>
        </button>
      </div>

      <!-- Configuração De Serviços -->
      <h2 class="mt-10 mb-6 text-3xl font-semibold text-green-700">Configuração De Serviços</h2>
      <div class="grid grid-cols-1 sm:grid-cols-2  gap-6">
        <button
          class="flex flex-col items-center justify-center p-6 bg-gray-100 rounded-lg shadow hover:bg-green-100 transition"
          @click="navigateTo('/mysql')"
        >
          <font-awesome-icon :icon="['fas', 'database']" class="text-3xl mb-2 text-green-600" />
          <span class="font-semibold text-gray-800">MySQL</span>
        </button>
        <button
          class="flex flex-col items-center justify-center p-6 bg-gray-100 rounded-lg shadow hover:bg-green-100 transition"
          @click="navigateTo('/apache')"
        >
          <font-awesome-icon :icon="['fas', 'feather']" class="text-3xl mb-2 text-green-600" />
          <span class="font-semibold text-gray-800">Apache</span>
        </button>
      </div>
    </div>
  </div>
</template>
