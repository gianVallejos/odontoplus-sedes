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
import Pacientes from './pacientes/index.vue'
import PacienteForm from './pacientes/form.vue'
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
import Proveedores from './proveedores/index.vue'
import ProveedorForm from './proveedores/form.vue'
import ProveedorLineItems from './proveedores/line_items.vue'
import IngresosIndex from './ingresos/index.vue'
import IngresoForm from './ingresos/form.vue'
import IngresoLineItem from './ingresos/line-item.vue'
import IngresoReporte from './ingresos/reporte.vue'
import Reportes from './reportes/index.vue'
import EgresosIndex from './egresos/index.vue'
import EgresoForm from './egresos/form.vue'
import Precios from './precios/index.vue'

const app = new Vue({
    el: '#app',
    components: {
    	ContainerGeneral, Dashboard,
    	Pacientes, PacienteForm,
    	PresupuestoIndex, PresupuestoCreate, PresupuestoNuevo, PresupuestoReporte,
			Users, UserForm,
			Doctores, DoctorForm,
			IngresosIndex, IngresoForm, IngresoLineItem, IngresoReporte,
			Tratamientos, TratamientoForm,
			Empresas, EmpresaForm,
			Proveedores, ProveedorForm, ProveedorLineItems,
			EgresosIndex, EgresoForm,
			Precios,	
			Reportes	
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