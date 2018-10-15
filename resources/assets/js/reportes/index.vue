<template>
	<b-container>
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Reportes" :items="breadcrumb" />
			</b-col>
			<b-col cols="12">
				<PanelCard>
					<span slot="heading">Reporte de Ingresos & Egresos</span>
					<b-row slot="body">
						<b-col cols="6" class="vertical-line">
							<b-form inline >
									<b-input class="mb-2 mr-sm-2 mb-sm-0" id="inc_start" type="date" v-model="incomesChart.range.start"/>
									<b-input class="mb-2 mr-sm-2 mb-sm-0" id="inc_end" type="date" v-model="incomesChart.range.end"/>
									<b-button variant="primary" v-on:click.prevent="fillIncomesChart()">
										<i class="fas fa-redo-alt"></i>
									</b-button>
							</b-form>
							<GChart class="pt-4" type="ColumnChart" :data="incomesData" :options="incomesChart" />
						</b-col>
						<b-col cols="6">
							<b-form inline >
								<b-input class="mb-2 mr-sm-2 mb-sm-0" id="outp_start" type="date" v-model="outputsChart.range.start"/>
								<b-input class="mb-2 mr-sm-2 mb-sm-0" id="outp_end" type="date" v-model="outputsChart.range.end"/>
								<b-button variant="primary" v-on:click.prevent="fillOutputsChart()">
									<i class="fas fa-redo-alt"></i>
								</b-button>
							</b-form>
							<GChart class="pt-4" type="ColumnChart" :data="outputsData" :options="outputsChart" />
						</b-col>
					</b-row>
					<hr slot="body" />
					<b-row slot="body">
						<b-col cols="6" class="vertical-line">
							<b-form inline >
									<b-input class="mb-2 mr-sm-2 mb-sm-0" id="inc_paciente_start" type="date" v-model="incomesPacienteChart.range.start"/>
									<b-input class="mb-2 mr-sm-2 mb-sm-0" id="inc_paciente_end" type="date" v-model="incomesPacienteChart.range.end"/>
									<b-button variant="primary" v-on:click.prevent="fillIncomesPacientesChart()">
										<i class="fas fa-redo-alt"></i>
									</b-button>
							</b-form>
							<GChart class="pt-4" type="BarChart" :data="incomesPacienteData" :options="incomesPacienteChart" />
						</b-col>
						<b-col cols="6">
							<b-form inline >
								<b-input class="mb-2 mr-sm-2 mb-sm-0" id="inc_company_start" type="date" v-model="incomesCompanyChart.range.start"/>
								<b-input class="mb-2 mr-sm-2 mb-sm-0" id="inc_company_end" type="date" v-model="incomesCompanyChart.range.end"/>
								<b-button variant="primary" v-on:click.prevent="fillIncomesEmpresaChart()">
									<i class="fas fa-redo-alt"></i>
								</b-button>
							</b-form>
							<GChart class="pt-4" type="PieChart" :data="incomesCompanyData" :options="incomesCompanyChart" />
						</b-col>
					</b-row>
					<hr slot="body" />
					<b-row slot="body">
						<b-col cols="6" class="vertical-line">
							<b-form inline >
									<b-input class="mb-2 mr-sm-2 mb-sm-0" id="inc_paciente_start" type="date" v-model="treatmentsChart.range.start"/>
									<b-input class="mb-2 mr-sm-2 mb-sm-0" id="inc_paciente_end" type="date" v-model="treatmentsChart.range.end"/>
									<b-button variant="primary" v-on:click.prevent="fillTreatmentsChart()">
										<i class="fas fa-redo-alt"></i>
									</b-button>
							</b-form>
							<GChart class="pt-4" type="PieChart" :data="treatmentsData" :options="treatmentsChart" />
						</b-col>
						<b-col cols="6">
							<b-form inline >
								<b-input class="mb-2 mr-sm-2 mb-sm-0" id="inc_company_start" type="date" v-model="balance.range.start"/>
								<b-input class="mb-2 mr-sm-2 mb-sm-0" id="inc_company_end" type="date" v-model="balance.range.end"/>
								<b-button variant="primary" v-on:click.prevent="fillBalanceChart()">
									<i class="fas fa-redo-alt"></i>
								</b-button>
							</b-form>

							<div class="balance-chart">
								<span class="title">Balance</span>
								<div class="text-center body">
									<b-row> 
											<b-col class="text-left label"> Ingresos: </b-col>
											<b-col class="text-right amount"> S/. {{balance.incomes}} </b-col>	
									</b-row>
									<b-row class="balance-line">
										<b-col class="text-left label"> Egresos: </b-col>
										<b-col class="text-right amount"> S/. {{balance.outputs}} </b-col>	
									</b-row>
									<hr/>
									<b-row class="balance-line">
										<b-col class="text-left label"> Balance: </b-col>
										<b-col class="text-right amount"> S/. {{balance.balance}} </b-col>	
									</b-row>
								</div>
							</div>

						</b-col>
					</b-row>
				</PanelCard>
			</b-col>
		</b-row>

	</b-container>
</template>

<script>
	import TitleComponent from '../widgets/titulo/index.vue'
	import PanelCard from '../widgets/panel/panel-component.vue'
  import { GChart } from 'vue-google-charts'
  import axios from 'axios'
  

	export default{
		mounted(){
			console.log('Reports Mounted')
			this.incomesChart.range.start = this.currentDate(-5)
			this.incomesChart.range.end = this.currentDate()
			this.outputsChart.range.start = this.currentDate(-5)
			this.outputsChart.range.end = this.currentDate()
			this.incomesPacienteChart.range.start = this.currentDate(-5)
			this.incomesPacienteChart.range.end = this.currentDate()
			this.incomesCompanyChart.range.start = this.currentDate(-5)
			this.incomesCompanyChart.range.end = this.currentDate()
			this.treatmentsChart.range.start = this.currentDate(-5)
			this.treatmentsChart.range.end = this.currentDate()
			this.balance.range.start = this.currentDate(-5)
			this.balance.range.end = this.currentDate()
			this.fillIncomesChart()
			this.fillOutputsChart()
			this.fillIncomesPacientesChart()
			this.fillIncomesEmpresaChart()
			this.fillTreatmentsChart()
			this.fillBalanceChart()
		},
		props: [
			'url'
		],
		components:{
			TitleComponent,
			PanelCard,
			GChart
		},
		data(){
			return{
				breadcrumb: [
          { text: 'Home', href: this.url },
          { text: 'Reportes', href: '/' }
			  ],
				incomesData: [],
        incomesChart: {			        
          title: 'Ingresos por mes',
          fontSize: 13,
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
          fontSize: 13,
          fontFamily: 'Open Sans',
          width: 500,
          height: 285,
					legend: { position: 'bottom', alignment:'center' },
          range: { start: '', end: '' }
				},
				incomesPacienteData: [],
        incomesPacienteChart: {			        
          title: 'Ingresos por paciente',
          fontSize: 13,
          fontFamily: 'Open Sans',
          width: 500,
          height: 285,
					legend: { position: 'bottom', alignment:'center' },
          range: { start: '', end: '' }
				},
				incomesCompanyData: [],
        incomesCompanyChart: {			        
          title: 'Ingresos por Empresa',
          fontSize: 13,
          fontFamily: 'Open Sans',
          width: 500,
          height: 285,
					legend: { position: 'bottom', alignment:'center' },
          range: { start: '', end: '' }
				},
				treatmentsData: [],
        treatmentsChart: {			        
          title: 'Tratamientos Destacados',
          fontSize: 13,
          fontFamily: 'Open Sans',
          width: 500,
          height: 285,
					legend: { position: 'bottom', alignment:'center' },
          range: { start: '', end: '' }
				},
				balance: {			        
          incomes: '',
          outputs: '',
					balance: '',
					range: { start: '', end: '' }
        }
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
        }).catch(function (error) {
          console.log(error);
        });
			},
			fillIncomesPacientesChart(){
				var start = this.incomesPacienteChart.range.start 
				var end = this.incomesPacienteChart.range.end
        var request = { method: 'GET', url: this.url + '/reportes/ingresos/por_paciente?start='+start+'&end='+end }
        axios(request).then((response) => {
					var incomes = response.data.incomes
					this.incomesPacienteData = [['Nombre', 'Monto']]
					for(var i=0 ; i<incomes.length; i++){
						this.incomesPacienteData.push([ incomes[i].nombre, parseInt(incomes[i].monto)])
					}
        }).catch(function (error) {
          console.log(error);
        });
			},
			fillIncomesEmpresaChart(){
				var start = this.incomesCompanyChart.range.start 
				var end = this.incomesCompanyChart.range.end
        var request = { method: 'GET', url: this.url + '/reportes/ingresos/por_empresa?start='+start+'&end='+end }
        axios(request).then((response) => {
					var incomes = response.data.incomes
					this.incomesCompanyData = [['Nombre', 'Monto']]
					for(var i=0 ; i<incomes.length; i++){
						this.incomesCompanyData.push([ incomes[i].nombre, parseInt(incomes[i].ingresos)])
					}
        }).catch(function (error) {
          console.log(error);
        });
			},
			fillTreatmentsChart(){
				var start = this.treatmentsChart.range.start 
				var end = this.treatmentsChart.range.end
        var request = { method: 'GET', url: this.url + '/reportes/tratamientos/destacados?start='+start+'&end='+end }
        axios(request).then((response) => {
					var treatments = response.data.treatments
					this.treatmentsData = [['Tratamiento', 'Ventas']]
					for(var i=0 ; i<treatments.length; i++){
						this.treatmentsData.push([ treatments[i].tratamiento, parseInt(treatments[i].numero)])
					}
        }).catch(function (error) {
          console.log(error);
        });
			},
			fillBalanceChart(){
				var start = this.balance.range.start
				var end = this.balance.range.end
        var request = { method: 'GET', url: this.url + '/reportes/balance?start='+start+'&end='+end }
        axios(request).then((response) => {
					console.log(response.data.ingresos)
					this.balance.incomes = parseFloat(response.data.ingresos[0].ingresos).toFixed(2)
					this.balance.outputs = parseFloat(response.data.egresos[0].egresos).toFixed(2)
					this.balance.balance = parseFloat(this.balance.incomes - this.balance.outputs).toFixed(2)
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