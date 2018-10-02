<template>
	<b-container class="pb-4">
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Dashboard" :items="breadcrumb" />
			</b-col>
			<b-col cols="12" class="pt-3">
				<div class="row">
					<div class="col-lg-3 col-md-4 col-sm-6 col-12" v-for="item in items">
						<Dashbox :iconUrl="item.iconUrl" :name="item.name" :color="item.color" :url="item.url" />						
					</div>					
				</div>
			</b-col>
			<b-col class="pt-5" cols="6">
				<PanelCard>
					<span slot="heading">Últimos Pacientes</span>
					<FormBuscar slot="body" />
					<div class="table mt-3 mb-4" slot="body">
						<TableComponent :fields="ultimosPacientes" />
					</div>
					<b-button slot="footer" href="#" variant="primary">Ver Pacientes</b-button>
				</PanelCard>
			</b-col>
			<b-col class="pt-5" cols="6">
				<PanelCard>
					<span slot="heading">Últimos Presupuestos</span>
					<FormBuscar slot="body" />
					<div class="table mt-3 mb-4" slot="body">
						<TableComponent :fields="ultimosPacientes" />
					</div>
					<b-button slot="footer" href="#" variant="primary">Ver Pacientes</b-button>
				</PanelCard>
			</b-col>
			<b-col class="pt-5" cols="12">
				<PanelCard>
					<span slot="heading">Reporte de Ingresos & Egresos</span>
					<b-row slot="body">
						<b-col cols="6" class="vertical-line">
							<GChart class="pt-4" type="LineChart" :data="chartData" :options="chartOptions" />
							<div class="text-center pt-4 pb-4">
								<b-button href="#" variant="success">Ir a Ingresos</b-button>
							</div>
						</b-col>
						<b-col cols="6">
							<GChart class="pt-4" type="LineChart" :data="chartData" :options="chartOptionsEgresos" />
							<div class="text-center pt-4 pb-4">
								<b-button href="#" variant="success">Ver a Egresos</b-button>
							</div>
						</b-col>
					</b-row>
					<b-button slot="footer" href="#" variant="primary">Ver Reportes</b-button>
				</PanelCard>
			</b-col>
		</b-row>
	</b-container>
</template>

<script>
	import TitleComponent from '../widgets/titulo/index.vue'
	import Dashbox from '../widgets/dashbox/dashbox-component.vue'
	import PanelCard from '../widgets/panel/panel-component.vue'
	import FormBuscar from '../widgets/form/form-buscar-component.vue'
	import TableComponent from '../widgets/table/table-component.vue'
	import { GChart } from 'vue-google-charts'

	export default{
		mounted(){
			console.log('Dashboard Mounted')
		},
		props: [
			'url'
		],
		components:{
			TitleComponent,
			Dashbox,
			PanelCard,
			FormBuscar,
			TableComponent,
			GChart
		},
		data(){
			return{
				breadcrumb: [
			    	{ text: 'Dashboard', href: this.url }
			    ],
			    items: [			    	
				    	{ 
				    		iconUrl: 'fas fa-calculator',
				    		name: 'Presupuesto',
				    		color: 'info',
				    		url: this.url + '/presupuestos'
				    	},
				    	{ 
				    		iconUrl: 'fas fa-child',
				    		name: 'Pacientes',
				    		color: 'nuevo',
				    		url: this.url + '/pacientes'
				    	},
				    	{ 
				    		iconUrl: 'fas fa-user-md',
				    		name: 'Doctores',
				    		color: 'modificar',
				    		url: '/'
				    	},
				    	{ 
				    		iconUrl: 'fas fa-tooth',
				    		name: 'Tratamientos',
				    		color: 'guardar',
				    		url: '/'
				    	},
				    	{ 
				    		iconUrl: 'fas fa-dollar-sign',
				    		name: 'Precios',
				    		color: 'modificar',
				    		url: '/'
				    	},
				    	{ 
				    		iconUrl: 'fas fa-building',
				    		name: 'Empresas',
				    		color: 'guardar',
				    		url: '/'
				    	},
				    	{ 
				    		iconUrl: 'fas fa-money-check-alt',
				    		name: 'Ingresos',
				    		color: 'info',
				    		url: '/'
				    	},
				    	{ 
				    		iconUrl: 'fas fa-money-bill',
				    		name: 'Egresos',
				    		color: 'nuevo',
				    		url: '/'
				    	}			    	
			    ],
			    ultimosPacientes: [
				  { 'Nro Historia': 10, Nombre: 'Lorem Ipsum' },
				  { 'Nro Historia': 30, Nombre: 'Lorem Ipsum' },
				  { 'Nro Historia': 45, Nombre: 'Lorem Ipsum' },
				  { 'Nro Historia': 20, Nombre: 'Lorem Ipsum' },
				  { 'Nro Historia': 10, Nombre: 'Lorem Ipsum' },
				  { 'Nro Historia': 30, Nombre: 'Lorem Ipsum' }
				],
				chartData: [
			        ['Year', 'Sales', 'Expenses'],
			        ['2014', 1000, 400],
			        ['2015', 1170, 460],
			        ['2016', 660, 1120],
			        ['2017', 1030, 540]
			    ],
			    chartOptions: {			        
			        title: 'Ingresos de los Últimos Seis Meses',
			        fontSize: 16,
			        fontFamily: 'Open Sans',
			        subtitle: 'Sales, Expenses',
			        width: 530,
			        height: 285,
			        legend: { position: 'bottom' }
			    },
			    chartOptionsEgresos: {			        
			        title: 'Egresos de los Últimos Seis Meses',
			        subtitle: 'Sales, Expenses',
			        fontSize: 16,
			        fontFamily: 'Open Sans',
			        width: 500,
			        height: 285,
			        legend: { position: 'bottom' }
			    }
			}
		}
	}
</script>