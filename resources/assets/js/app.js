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
import FooterComponent from './footer/footerComponent.vue'
import Users from './users/index.vue'
import UserForm from './users/form.vue'
import Doctores from './doctores/index.vue'
//import DoctoresForm from './udoctores/form.vue'
import Flash from './widgets/alert/flash.vue'

const app = new Vue({
    el: '#app',
    components: {
    	ContainerGeneral,
			Dashboard,
    	PacienteIndex,
    	PacienteCreate,
    	PacienteShow,
			Users,
			UserForm,
			Doctores		
    }
})

const alert = new Vue({
	el: '#alert',
	components: {
		Flash
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