import './assets/main.css'
import { library } from '@fortawesome/fontawesome-svg-core'
import { faHouse, faGear, faDatabase, faGlobe, faBars , faFeather } from '@fortawesome/free-solid-svg-icons'
import { faWindows, faLinux, faPython } from '@fortawesome/free-brands-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

import { createApp } from 'vue'
import { createPinia } from 'pinia'

import App from './App.vue'
import router from './router'

library.add(faHouse, faGear, faDatabase, faWindows, faLinux ,faGlobe, faBars, faFeather, faPython)

const app = createApp(App)

app.use(createPinia())
app.use(router)
app.component('font-awesome-icon', FontAwesomeIcon)

app.mount('#app')
