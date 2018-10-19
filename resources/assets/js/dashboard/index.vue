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
					<div class="input-group" slot="body">
						<span class="icon-input">
					    	<i class="fas fa-search" aria-hidden="true"></i>
					    </span>
						<input v-model="filterPacientes"  placeholder="Buscar..." type="text" class="form-control odInput">
					</div>
					<div class="table mt-3 mb-4" slot="body">
						<b-table show-empty
					             :items="pacientes"
					             :fields="fieldsPacientes"					             
					             :filter="filterPacientes"	
					             :empty-text="emptyMessage"		
					    >					      
					    	<template slot="hc" slot-scope="row">
					    		{{ row.value }}
					    	</template>
					    	<template slot="nombre" slot-scope="row">
					    		{{ row.value }}
					    	</template>
					    	<template slot="actions" slot-scope="row">
					    		<a :href="url + '/pacientes/' + row.item.hc + '/false'">Ver Paciente</a>
					    	</template>

					    </b-table>
					</div>
					<b-button slot="footer" :href="url + '/pacientes'" variant="primary">Ver Pacientes</b-button>
				</PanelCard>
			</b-col>
			<b-col class="pt-5" cols="6">
				<PanelCard>
					<span slot="heading">Últimos Presupuestos</span>
					<div class="input-group" slot="body">
						<span class="icon-input">
					    	<i class="fas fa-search" aria-hidden="true"></i>
					    </span>
						<input v-model="filterPresupuestos"  placeholder="Buscar..." type="text" class="form-control odInput">
					</div>
					<div class="table mt-3 mb-4" slot="body">
						<b-table show-empty
					             :items="presupuestos"
					             :fields="fieldsPresupuestos"					             
					             :filter="filterPresupuestos"	
					             :empty-text="emptyMessage"	
					    >					      
					    	<template slot="pacientes" slot-scope="row">
					    		{{ row.value }}
					    	</template>
					    	<template slot="doctores" slot-scope="row">
					    		{{ row.value }}
					    	</template>
					    	<template slot="actions" slot-scope="row">
					    		<a :href="url + '/presupuestos/reporte/' + row.item.id" target="_blank">Ver Presupuesto</a>
					    	</template>

					    </b-table>
					</div>
					<b-button slot="footer" :href="url + '/presupuestos'" variant="primary">Ver Presupuestos</b-button>
				</PanelCard>
			</b-col>
			<b-col class="pt-5" cols="12" v-if="user.rolid == 1">
				<PanelCard>
					<span slot="heading">Reporte de Finanzas</span>
					<b-row slot="body">
						<b-col cols="6" class="vertical-line">
							<GChart class="pt-4" type="ColumnChart" :data="incomesData" :options="incomesChart" />
							<div class="text-center pt-4 pb-4">
								<b-button :href="url + '/ingresos'" variant="success">Ir a Ingresos</b-button>
							</div>
						</b-col>
						<b-col cols="6">
							<GChart class="pt-4" type="ColumnChart" :data="outputsData" :options="outputsChart" />
							<div class="text-center pt-4 pb-4">
								<b-button :href="url + '/egresos'" variant="success">Ir a Egresos</b-button>
							</div>
						</b-col>
					</b-row>
					<b-button slot="footer" :href="url + '/reportes'" variant="primary">Ver Reportes</b-button>
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
	import axios from 'axios'

	export default{
		mounted(){
			console.log('Dashboard Mounted')
			this.incomesChart.range.start = this.currentDate(-4)
			this.incomesChart.range.end = this.currentDate()
			this.outputsChart.range.start = this.currentDate(-4)
			this.outputsChart.range.end = this.currentDate()
			this.fillIncomesChart()
			this.fillOutputsChart()
		},
		props: [
			'url',
			'pacientes',
			'presupuestos',
			'user'
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
				    		url: this.url + '/doctores'
				    	},
				    	{ 
				    		iconUrl: 'fas fa-tooth',
				    		name: 'Tratamientos',
				    		color: 'guardar',
				    		url: this.url + '/tratamientos'
				    	},
				    	{ 
				    		iconUrl: 'fas fa-dollar-sign',
				    		name: 'Precios',
				    		color: 'modificar',
				    		url: this.url + '/precios'
				    	},
				    	{ 
				    		iconUrl: 'fas fa-building',
				    		name: 'Empresas',
				    		color: 'guardar',
				    		url: this.url + '/empresas'
				    	},
				    	{ 
				    		iconUrl: 'fas fa-money-check-alt',
				    		name: 'Ingresos',
				    		color: 'info',
				    		url: this.url + '/ingresos'
				    	},
				    	{ 
				    		iconUrl: 'fas fa-money-bill',
				    		name: 'Egresos',
				    		color: 'nuevo',
				    		url: this.url + '/egresos'
				    	}			    	
			    ],
				chartData: [
			        ['Year', 'Sales', 'Expenses'],
			        ['2014', 1000, 400],
			        ['2015', 1170, 460],
			        ['2016', 660, 1120],
			        ['2017', 1030, 540]
			    ],


				incomesData: [],
        incomesChart: {			        
          title: 'Ingresos de los Últimos Seis Meses',
          fontSize: 14,
          fontFamily: 'Open Sans',
          subtitle: 'Sales, Expenses',
          width: 500,
          height: 285,
          legend: { position: 'bottom', alignment:'center' },
          range: { start: '', end: '' }
				},
				outputsData: [],
        outputsChart: {			        
          title: 'Egresos de los Últimos Seis Meses',
          fontSize: 14,
          fontFamily: 'Open Sans',
          width: 500,
          height: 285,
					legend: { position: 'bottom', alignment:'center' },
          range: { start: '', end: '' }
				},


			    fieldsPacientes: [				    				    
				    { key: 'hc', label: 'HC', sortable: true, sortDirection: 'desc', 'class': 'text-center' },
				    { key: 'nombres', label: 'Paciente', sortable: true, sortDirection: 'desc' },
				    { key: 'actions', label: '', 'class': 'text-left' }
			    ],
			    filterPacientes: '',
			    fieldsPresupuestos: [				    				    				    
				    { key: 'pacientes', label: 'Paciente', sortable: true, sortDirection: 'desc' },
				    { key: 'doctores', label: 'Doctor', sortable: true, sortDirection: 'desc' },
				    { key: 'actions', label: '', 'class': 'text-left' }
			    ],
			    filterPresupuestos: '',
			    emptyMessage: 'No existen campos para mostrar'
			}
		},
		methods:{
			fillIncomesChart(){
				var start = this.incomesChart.range.start 
				var end = this.incomesChart.range.end
        var request = { method: 'GET', url: this.url + '/reportes/ingresos?start='+start+'&end='+end }
        axios(request).then((response) => {
					var incomes = response.data.incomes
					this.incomesData = [['Mes', 'Ingresos']]
					for(var i=0 ; i<incomes.length; i++){
						this.incomesData.push([ incomes[i].mes.substring(0,3), parseInt(incomes[i].ingresos)])
					}
					if (outputs.length == 0) this.outputsData.push([ '', 0])
        }).catch(function (error) {
          console.log(error);
        });
			},
			fillOutputsChart(){
				var start = this.outputsChart.range.start 
				var end = this.outputsChart.range.end
        var request = { method: 'GET', url: this.url + '/reportes/egresos?start='+start+'&end='+end }
        axios(request).then((response) => {
					var outputs = response.data.outputs
					this.outputsData = [['Mes', 'Egresos']]
					for(var i=0 ; i<outputs.length; i++){
						this.outputsData.push([ outputs[i].mes.substring(0,3), parseInt(outputs[i].egresos)])
					}
					if (outputs.length == 0) this.outputsData.push([ '', 0])
        }).catch(function (error) {
          console.log(error);
        });
			},
			currentDate(months_back){
				var today = new Date()
				if (months_back)
					return `${today.getFullYear()}-${("0"+(today.getMonth()+months_back).toString()).slice(-2)}-01`
				else
					return `${today.getFullYear()}-${("0"+(today.getMonth()+1).toString()).slice(-2)}-${("0"+today.getDate().toString()).slice(-2)}`
			}
		}
	}
</script>