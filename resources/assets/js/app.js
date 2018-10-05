//require('./bootstrap');

import Vue from 'vue'
import BootstrapVue from "bootstrap-vue"
import Toasted from 'vue-toasted'
Vue.use(BootstrapVue)
Vue.use(Toasted)

import HeaderComponent from './header/headerComponent.vue'
import NavComponent from './header/navComponent.vue'
import Flash from './widgets/alert/flash.vue'

import ContainerGeneral from './container-general/index.vue'
import Dashboard from './dashboard/index.vue'
import PacienteIndex from './paciente/index.vue'
import PacienteCreate from './paciente/create.vue'
import PacienteShow from './paciente/show.vue'
import FooterComponent from './footer/footerComponent.vue'
import Users from './users/index.vue'
import UserForm from './users/form.vue'
import Doctores from './doctores/index.vue'
import DoctorForm from './doctores/form.vue'
import Tratamientos from './tratamientos/index.vue'
import TratamientoForm from './tratamientos/form.vue'
import Empresas from './empresas/index.vue'
import EmpresaForm from './empresas/form.vue'

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
			Doctores,
			DoctorForm,
			Tratamientos,
			TratamientoForm,
			Empresas,
			EmpresaForm		
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