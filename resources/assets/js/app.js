//require('./bootstrap');

import Vue from 'vue'
import BootstrapVue from "bootstrap-vue"
import Toasted from 'vue-toasted'
import VueSweetalert2 from 'vue-sweetalert2'

Vue.use(BootstrapVue)
Vue.use(Toasted)
Vue.use(VueSweetalert2)

import HeaderComponent from './header/headerComponent.vue'
import NavComponent from './header/navComponent.vue'
import Flash from './widgets/alert/flash.vue'

import ContainerGeneral from './container-general/index.vue'
import Dashboard from './dashboard/index.vue'
import PacienteIndex from './paciente/index.vue'
import PacienteCreate from './paciente/create.vue'
import PacienteShow from './paciente/show.vue'
import PresupuestoIndex from './presupuesto/index.vue'
import PresupuestoCreate from './presupuesto/create.vue'
import PresupuestoNuevo from './presupuesto/nuevo.vue'
import PresupuestoReporte from './presupuesto/reporte.vue'
import FooterComponent from './footer/footerComponent.vue'
import Users from './users/index.vue'
import UserForm from './users/form.vue'
import Doctores from './doctores/index.vue'
import DoctorForm from './doctores/form.vue'
import Tratamientos from './tratamientos/index.vue'
import TratamientoForm from './tratamientos/form.vue'
import Empresas from './empresas/index.vue'
import EmpresaForm from './empresas/form.vue'
import IngresosIndex from './ingresos/index.vue'
import IngresoForm from './ingresos/form.vue'
import IngresoLineItem from './ingresos/line-item.vue'

const app = new Vue({
    el: '#app',
    components: {
    	ContainerGeneral, Dashboard,
    	PacienteIndex, PacienteCreate, PacienteShow,
    	PresupuestoIndex, PresupuestoCreate, PresupuestoNuevo, PresupuestoReporte,
		Users, UserForm,
    	PacienteIndex,
    	PacienteCreate,
    	PacienteShow,
		Users, UserForm,
		Doctores, DoctorForm,
		Tratamientos, TratamientoForm,
		Empresas, EmpresaForm,
		IngresosIndex, IngresoForm, IngresoLineItem
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