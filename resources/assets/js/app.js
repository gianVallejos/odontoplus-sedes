//require('./bootstrap');

import Vue from 'vue'
import BootstrapVue from "bootstrap-vue"
import Toasted from 'vue-toasted'
Vue.use(BootstrapVue)
Vue.use(Toasted)

import HeaderComponent from './header/headerComponent.vue'
import NavComponent from './header/navComponent.vue'

import ContainerGeneral from './container-general/index.vue'
import Dashboard from './dashboard/index.vue'
import PacienteIndex from './paciente/index.vue'
import PacienteCreate from './paciente/create.vue'
import PacienteShow from './paciente/show.vue'
import PresupuestoIndex from './presupuesto/index.vue'
import PresupuestoCreate from './presupuesto/create.vue'
import PresupuestoNuevo from './presupuesto/nuevo.vue'
import FooterComponent from './footer/footerComponent.vue'
import Users from './users/index.vue'
import UserForm from './users/form.vue'

const app = new Vue({
    el: '#app',
    components: {
    	ContainerGeneral, Dashboard,
    	PacienteIndex, PacienteCreate, PacienteShow,
    	PresupuestoIndex, PresupuestoCreate, PresupuestoNuevo,
		Users, UserForm		
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