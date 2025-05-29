<script setup lang="ts">
import { ref } from "vue";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import router from "../router";

const menuItems = [
  { label: "Início", route: "/", icon: "house", sub:"fas"},
  { label: "Configurações", route: "/settings", icon: "gear", sub:"fas" },
  { label: "Maquinas Linux", route: "/MaquinasLinux", icon: "database", sub:"fas"},
  { label: "Maquinas Windows", route: "/MaquinasWindows", icon:"windows", sub:"fab"},
];

const isOpen = ref(false);
const activeRoute = ref("/home");

const toggleSidebar = () => {
  isOpen.value = !isOpen.value;
};

const navigateTo = (route: string) => {
  activeRoute.value = route;
  isOpen.value = false; // Fecha a Sidebar no mobile
  router.push(route);
};
</script>

<template>
  <div class="flex min-h-screen">
    <!-- Sidebar -->
    <aside
      class="lg:w-72 w-4/5 h-screen bg-gray-900 text-white flex flex-col fixed lg:relative z-20 transition-transform transform shadow-xl lg:translate-x-0"
      :class="isOpen ? 'translate-x-0' : '-translate-x-full'"
    >
      <!-- Cabeçalho da Sidebar -->
      <div class="p-6 bg-gray-800 flex items-center justify-between border-b border-gray-700">
        <h1 class="text-xl font-semibold tracking-wide">Dashboard</h1>
        <button
          class="lg:hidden text-gray-400 hover:text-white focus:outline-none"
          @click="toggleSidebar"
        >
          ✖
        </button>
      </div>

      <!-- Links de navegação -->
      <nav class="flex-1 p-6">
        <ul class="space-y-4">
          <li v-for="(item, index) in menuItems" :key="index">
            <a
              href="#"
              @click.prevent="navigateTo(item.route)"
              class="flex items-center gap-6 p-4 rounded-lg transition-all duration-300 text-gray-300 hover:bg-gray-700 hover:text-white text-lg group"
              :class="{ 'bg-gray-700 text-white': activeRoute === item.route }"
            >
              <!-- Ícone FontAwesome -->
              <font-awesome-icon :icon="[item.sub, item.icon]" class="w-6 h-6" />
              <span class="font-medium group-hover:ml-4 transition-all duration-300 ease-in-out">{{ item.label }}</span>
            </a>
          </li>
        </ul>
      </nav>
    </aside>

    <!-- Conteúdo Principal -->
    <main class="flex-1 bg-gray-100 p-8 transition ml-72 lg:ml-72">
      <button
        class="lg:hidden bg-blue-500 text-white px-5 py-3 rounded-lg shadow-md mb-6"
        @click="toggleSidebar"
      >
        ☰ Abrir Menu
      </button>
      <slot />
    </main>
  </div>
</template>

<style scoped>
/* Estilos adicionais para tornar a sidebar mais elegante */
aside {
  transition: all 0.3s ease-in-out;
}

nav ul li a {
  transition: all 0.2s ease-in-out;
  font-size: 1.1rem;
  margin-bottom: 2px; /* Adiciona uma margem de 2px entre os itens */
}

button {
  transition: all 0.2s ease-in-out;
}

.group:hover .group-hover\:ml-4 {
  margin-left: 1rem; /* Expande o texto da sidebar ao passar o mouse */
}
</style>
