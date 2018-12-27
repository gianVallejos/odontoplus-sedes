//require('./bootstrap');

import Vue from 'vue'
import BootstrapVue from "bootstrap-vue"
import VueSweetalert2 from 'vue-sweetalert2'

Vue.use(BootstrapVue)
Vue.use(VueSweetalert2)
/*
var WebFont = require('webfontloader');
	  WebFont.load({
	    google: {
	      families: ['Open Sans', 'Rubik']
	    }
	  });
*/

import HeaderComponent from './header/headerComponent.vue'
import NavComponent from './header/navComponent.vue'

import Dashboard from './dashboard/index.vue'
import CitaForm from './citas/form.vue'
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
import Sedes from './sedes/index.vue'
import SedeForm from './sedes/form.vue'
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
import Pagos from './pagos/index.vue'
import PagosForm from './pagos/form.vue'
import PagosReporte from './pagos/reporte.vue'
import Ganancias from './ganancias/ganancias.vue'
import GananciasReporte from './ganancias/ganancias_reporte.vue'

import Mixin from './mixins/permisos.js'

const app = new Vue({
    mixins: [Mixin],
    el: '#app',
    components: {
    	Dashboard,
    	Pacientes, PacienteForm,
      CitaForm,
    	PresupuestoIndex, PresupuestoCreate, PresupuestoNuevo, PresupuestoReporte,
			Users, UserForm,
			Doctores, DoctorForm,
			IngresosIndex, IngresoForm, IngresoLineItem, IngresoReporte,
			Tratamientos, TratamientoForm,
			Empresas, EmpresaForm,
			Sedes, SedeForm,
			Proveedores, ProveedorForm, ProveedorLineItems,
			EgresosIndex, EgresoForm,
			Precios,
			Reportes,
			Pagos, PagosForm, PagosReporte,
			Ganancias, GananciasReporte
    }
})

const header = new Vue({
  mixins: [Mixin],
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
