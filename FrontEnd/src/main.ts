import './assets/main.css'
import { library } from '@fortawesome/fontawesome-svg-core'
import { faHouse, faGear, faDatabase, faGlobe, faBars , faFeather } from '@fortawesome/free-solid-svg-icons'
import { faWindows } from '@fortawesome/free-brands-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

import { createApp } from 'vue'
import { createPinia } from 'pinia'

import App from './App.vue'
import router from './router'

const app = createApp(App)

app.use(createPinia())
app.use(router)

library.add(faHouse, faGear, faDatabase, faWindows, faGlobe, faBars, faFeather)
createApp(App)
  .component('font-awesome-icon', FontAwesomeIcon) // Registra o FontAwesomeIcon globalmente
  .mount('#app')

app.mount('#app')
