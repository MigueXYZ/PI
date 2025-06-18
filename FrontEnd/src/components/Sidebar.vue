<script setup lang="ts">
import { ref } from "vue";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import router from "../router";

const menuItems = [
  { label: "Início", route: "/", icon: "house", sub: "fas" },
  { label: "Configurações", route: "/settings", icon: "gear", sub: "fas" },
  { label: "Maquinas Linux", route: "/MaquinasLinux", icon: "database", sub: "fas" },
  { label: "Maquinas Windows", route: "/MaquinasWindows", icon: "windows", sub: "fab" },
  { label: "Switches Cisco", route: "/SwitchesCisco", icon: "globe", sub: "fas" },
  {
    label: "Serviços",
    icon: "bars",
    sub: "fas",
    subItems: [
      { label: "MySQL", route: "/mysql", icon: "database", sub: "fas" },
      { label: "Apache", route: "/apache", icon: "feather", sub: "fas" },
    ]
  },
];

const isOpen = ref(true);
const activeRoute = ref("/home");
const isServicesOpen = ref(false);

const toggleSidebar = () => {
  isOpen.value = !isOpen.value;
};

const toggleServices = () => {
  isServicesOpen.value = !isServicesOpen.value;
};

const navigateTo = (route: string) => {
  activeRoute.value = route;
  router.push(route);
};
</script>

<template>
  <div class="flex min-h-screen">
    <!-- Sidebar -->
    <aside
      class="w-72 h-screen bg-gray-900 text-white flex flex-col fixed z-20 transition-transform transform shadow-xl"
      :class="isOpen ? 'translate-x-0' : '-translate-x-full'"
    >
      <div class="p-6 bg-gray-800 flex items-center justify-between border-b border-gray-700">
        <h1 class="text-xl font-semibold tracking-wide">Dashboard</h1>
        <button
          class="text-gray-400 hover:text-white focus:outline-none"
          @click="toggleSidebar"
        >
          ✖
        </button>
      </div>

      <nav class="flex-1 p-6">
        <ul class="space-y-4">
          <li v-for="(item, index) in menuItems" :key="index">
            <template v-if="item.label === 'Serviços'">
              <button
                class="flex items-center gap-6 p-4 rounded-lg w-full text-left hover:bg-gray-700 hover:text-white text-lg group"
                @click="toggleServices"
                :class="{ 'bg-gray-700 text-white': isServicesOpen }"
              >
                <font-awesome-icon :icon="[item.sub, item.icon]" class="w-6 h-6" />
                <span class="font-medium group-hover:ml-4 transition-all duration-300 ease-in-out flex-1">
                  {{ item.label }}
                </span>
                <font-awesome-icon
                  :icon="['fas', isServicesOpen ? 'chevron-up' : 'chevron-down']"
                  class="w-4 h-4"
                />
              </button>
              <ul
                v-show="isServicesOpen"
                class="ml-12 mt-2 space-y-2 border-l border-gray-700 pl-4"
              >
                <li v-for="(subItem, subIndex) in item.subItems" :key="subIndex">
                  <a
                    href="#"
                    @click.prevent="navigateTo(subItem.route)"
                    class="flex items-center gap-4 p-3 rounded-lg text-gray-300 hover:bg-gray-700 hover:text-white text-base"
                    :class="{ 'bg-gray-700 text-white': activeRoute === subItem.route }"
                  >
                    <font-awesome-icon :icon="[subItem.sub, subItem.icon]" class="w-4 h-4" />
                    <span>{{ subItem.label }}</span>
                  </a>
                </li>
              </ul>
            </template>

            <template v-else>
              <a
                href="#"
                @click.prevent="navigateTo(item.route)"
                class="flex items-center gap-6 p-4 rounded-lg transition-all duration-300 text-gray-300 hover:bg-gray-700 hover:text-white text-lg group"
                :class="{ 'bg-gray-700 text-white': activeRoute === item.route }"
              >
                <font-awesome-icon :icon="[item.sub, item.icon]" class="w-6 h-6" />
                <span class="font-medium group-hover:ml-4 transition-all duration-300 ease-in-out">{{ item.label }}</span>
              </a>
            </template>
          </li>
        </ul>
      </nav>
    </aside>

    <!-- Conteúdo Principal -->
    <main
      class="flex-1 bg-gray-100 p-8 transition-all duration-300"
      :class="{ 'ml-72': isOpen, 'ml-0': !isOpen }"
    >
      <button
        class="!bg-green-600 !text-white px-5 py-3 rounded-lg shadow-md mb-6"
        @click="toggleSidebar"
      >
        ☰ Abrir Menu
      </button>
      <slot />
    </main>
  </div>
</template>

<style scoped>
aside {
  transition: all 0.3s ease-in-out;
}

nav ul li a,
nav ul li button {
  transition: all 0.2s ease-in-out;
  font-size: 1.1rem;
  margin-bottom: 2px;
  width: 100%;
  text-align: left;
}

button {
  background: none;
  border: none;
  cursor: pointer;
  color: inherit;
}

.group:hover .group-hover\:ml-4 {
  margin-left: 1rem;
}
</style>
