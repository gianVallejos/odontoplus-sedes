<template>
	<b-container class="pb-4">
		<b-row>
			<b-col cols="12">
				<div class="input-group" slot="body">
					<span class="icon-input">
							<i class="fas fa-search" aria-hidden="true"></i>
						</span>
					<input v-model="filterPresupuestos"  placeholder="Buscar..." type="text" class="form-control odInput">
				</div>
			</b-col>
			<b-col cols="12" class="pt-3">
				<div class="row">
					<div class="col-lg-3 col-md-4 col-sm-6 col-12" v-for="item in items">
						<Dashbox :iconUrl="item.iconUrl" :subname="item.subname" :name="item.name" :color="item.color" :url="item.url" :for_admin="item.for_admin" :user="user" />
					</div>
				</div>
			</b-col>
			<b-col class="pt-3" cols="9">
				<PanelCard>
					<span slot="heading">Ingresos vs. Egresos</span>
					<GChart class="pt-4" type="ColumnChart" :data="incomesData" :options="incomesChart" :resizeDebounce="480" slot="body" />
				</PanelCard>
			</b-col>
			<b-col class="pt-3" cols="3">
				<div v-for="item in itemsMedium">
						<DashboxMed :iconUrl="item.iconUrl" :subname="item.subname" :name="item.name" :color="item.color" :url="item.url" :for_admin="item.for_admin" :user="user" />
				</div>
			</b-col>
			<b-col class="pt-3" cols="12" v-if="user.rolid == 1">
				<PanelCard>
					<span slot="heading">Reporte de Finanzas</span>
					<b-row slot="body">
						<b-col cols="6" class="vertical-line">
							<GChart class="pt-4" type="ColumnChart" :data="incomesData" :options="incomesChart" :resizeDebounce="480" />
							<div class="text-center pt-4 pb-4">
								<b-button :href="url + '/ingresos'" variant="success">Ir a Ingresos</b-button>
							</div>
						</b-col>
						<b-col cols="6">
							<GChart class="pt-4" type="ColumnChart" :data="outputsData" :options="outputsChart" :resizeDebounce="480" />
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
	import DashboxMed from '../widgets/dashbox/dashbox-med.vue'
	import PanelCard from '../widgets/panel/panel-component.vue'
	import FormBuscar from '../widgets/form/form-buscar-component.vue'
	import TableComponent from '../widgets/table/table-component.vue'
	import { GChart } from 'vue-google-charts'
	import axios from 'axios'

	export default{
		mounted(){
			console.log('Inicio Mounted')
			this.initChats()
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
			DashboxMed,
			PanelCard,
			FormBuscar,
			TableComponent,
			GChart
		},
		data(){
			return{
				breadcrumb: [
			    	{ text: 'Inicio', href: this.url }
			    ],
			    items: [
				    	{
				    		iconUrl: 'fas fa-child',
								subname: 'Nuevo',
				    		name: 'Paciente',
				    		color: 'nuevo',
				    		url: this.url + '/presupuestos',
				    		for_admin: false
				    	},
				    	{
				    		iconUrl: 'fas fa-calculator',
								subname: 'Nuevo',
				    		name: 'Presupuesto',
				    		color: 'info',
				    		url: this.url + '/pacientes',
				    		for_admin: false
				    	},
				    	{
				    		iconUrl: 'fas fa-money-check-alt',
								subname: 'Nuevo',
				    		name: 'Ingreso',
				    		color: 'nuevo',
				    		url: this.url + '/doctores',
				    		for_admin: false
				    	},
				    	{
				    		iconUrl: 'fas fa-money-bill',
								subname: 'Nuevo',
				    		name: 'Egreso',
				    		color: 'info',
				    		url: this.url + '/tratamientos',
				    		for_admin: false
				    	}
			    ],
					itemsMedium: [
							{
								iconUrl: 'fas fa-child',
								subname: 'Nuevo',
								name: 'Pago a Doctor',
								color: 'modificar',
								url: this.url + '/presupuestos',
								for_admin: false
							},
							{
								iconUrl: 'fas fa-money-check-alt',
								subname: 'Ver ',
								name: 'Estadísticas',
								color: 'modificar',
								url: this.url + '/doctores',
								for_admin: false
							},
							{
								iconUrl: 'fas fa-calculator',
								subname: 'Ver ',
								name: 'Ganancias',
								color: 'modificar',
								url: this.url + '/pacientes',
								for_admin: false
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
          title: '',
          fontSize: 14,
          fontFamily: 'Open Sans',
          subtitle: 'Sales, Expenses',
          legend: { position: 'bottom', alignment:'center' },
          range: { start: '', end: '' }
				},
				outputsData: [],
        outputsChart: {
          title: 'Egresos de los Últimos Seis Meses',
          fontSize: 14,
          fontFamily: 'Open Sans',
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
			initChats(){
				var today = this.currentDate()
				this.incomesChart.range.date = today
				this.outputsChart.range.date = today
				this.fillIncomesChart()
				this.fillOutputsChart()
			},
			fillIncomesChart(){
				var date = this.incomesChart.range.date
		        var request = { method: 'GET', url: this.url + '/reportes/ingresos/'+date }
		        axios(request).then((response) => {
							var incomes = response.data.ingresos
							this.incomesData = [['Mes', 'Ingresos']]
							for(var i=0 ; i<incomes.length; i++){
								this.incomesData.push([ incomes[i].mes.substring(0,3), parseInt(incomes[i].ingresos)])
							}
							if (incomes.length == 0) this.incomesData.push([ '', 0])
		        }).catch(function (error) {
		          console.log(error);
		        });
			},
			fillOutputsChart(){
				var date = this.outputsChart.range.date
        var request = { method: 'GET', url: this.url + '/reportes/egresos/'+ date }
        axios(request).then((response) => {
					var outputs = response.data.egresos
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
