//require('./bootstrap');

import Vue from 'vue'
import BootstrapVue from "bootstrap-vue"
import Toasted from 'vue-toasted'

Vue.use(BootstrapVue)
Vue.use(Toasted, {position: 'bottom-right', theme: 'primary', duration: 1000})

import HeaderComponent from './header/headerComponent.vue'
import NavComponent from './header/navComponent.vue'
import ContainerGeneral from './container-general/index.vue'
import Dashboard from './dashboard/index.vue'
import FooterComponent from './footer/footerComponent.vue'
import Users from './users/index.vue'

const app = new Vue({
    el: '#app',
    components: {
    	ContainerGeneral,
			Dashboard,
			Users			
    }
})

const header = new Vue({
	el: '#header',
	components: {
		HeaderComponent,
		NavComponent
	}
})

const footer = new Vue({
	el: '#footer',
	components: {
		FooterComponent
	}
})