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
									<b-input class="mb-2 mr-sm-2 mb-sm-0" id="incomesStartDate" type="date" v-model="incomesChart.range.start"/>
									<b-input class="mb-2 mr-sm-2 mb-sm-0" id="incomesEndDate" type="date" v-model="incomesChart.range.end"/>
									<b-button variant="primary" v-on:click.prevent="fillIncomesChart()">
										<i class="fas fa-redo-alt"></i>
									</b-button>
							</b-form>
							<GChart class="pt-4" type="ColumnChart" :data="incomesData" :options="incomesChart" />
							<div class="text-center pt-4 pb-4">	
								<b-button href="#" variant="success">Ir a Ingresos</b-button>
							</div>
						</b-col>
						<b-col cols="6">
							<b-form inline >
								<b-input class="mb-2 mr-sm-2 mb-sm-0" id="incomesStartDate" type="date" v-model="outputsChart.range.start"/>
								<b-input class="mb-2 mr-sm-2 mb-sm-0" id="incomesEndDate" type="date" v-model="outputsChart.range.end"/>
								<b-button variant="primary" v-on:click.prevent="fillOutputsChart()">
									<i class="fas fa-redo-alt"></i>
								</b-button>
							</b-form>
							<GChart class="pt-4" type="ColumnChart" :data="outputsData" :options="outputsChart" />
							<div class="text-center pt-4 pb-4">
								<b-button href="#" variant="success">Ver a Egresos</b-button>
							</div>
						</b-col>
					</b-row>
				</PanelCard>
			</b-col>
		</b-row>

		<br/>

		<b-row>
			<b-col cols="12">
				<PanelCard>
					<span slot="heading">Ingresos por Pacientes & Empresas</span>
					<b-row slot="body">
						<b-col cols="6" class="vertical-line">
							<b-form inline >
									<b-input class="mb-2 mr-sm-2 mb-sm-0" id="incomesStartDate" type="date" v-model="incomesPacienteChart.range.start"/>
									<b-input class="mb-2 mr-sm-2 mb-sm-0" id="incomesEndDate" type="date" v-model="incomesPacienteChart.range.end"/>
									<b-button variant="primary" v-on:click.prevent="fillIncomesPacientesChart()">
										<i class="fas fa-redo-alt"></i>
									</b-button>
							</b-form>
							<GChart class="pt-4" type="ColumnChart" :data="incomesPacienteData" :options="incomesPacienteChart" />
							<div class="text-center pt-4 pb-4">	
								<b-button href="#" variant="success">Ir a Ingresos</b-button>
							</div>
						</b-col>
						<b-col cols="6">
							<b-form inline >
								<b-input class="mb-2 mr-sm-2 mb-sm-0" id="incomesStartDate" type="date" v-model="outputsChart.range.start"/>
								<b-input class="mb-2 mr-sm-2 mb-sm-0" id="incomesEndDate" type="date" v-model="outputsChart.range.end"/>
								<b-button variant="primary" v-on:click.prevent="fillOutputsChart()">
									<i class="fas fa-redo-alt"></i>
								</b-button>
							</b-form>
							<GChart class="pt-4" type="ColumnChart" :data="outputsData" :options="outputsChart" />
							<div class="text-center pt-4 pb-4">
								<b-button href="#" variant="success">Ver a Egresos</b-button>
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
			this.incomesChart.range.start = this.currentDate(-4)
			this.incomesChart.range.end = this.currentDate()
			this.outputsChart.range.start = this.currentDate(-4)
			this.outputsChart.range.end = this.currentDate()
			this.incomesPacienteChart.range.start = this.currentDate(-4)
			this.incomesPacienteChart.range.end = this.currentDate()
			this.fillIncomesChart()
			this.fillOutputsChart()
			this.fillIncomesPacientesChart()
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
          fontSize: 16,
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
          fontSize: 16,
          fontFamily: 'Open Sans',
          width: 500,
          height: 285,
					legend: { position: 'bottom', alignment:'center' },
          range: { start: '', end: '' }
				},
				incomesPacienteData: [],
        incomesPacienteChart: {			        
          title: 'Ingresos por paciente',
          fontSize: 16,
          fontFamily: 'Open Sans',
          width: 500,
          height: 285,
					legend: { position: 'bottom', alignment:'center' },
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
        var request = { method: 'GET', url: this.url + '/reportes/ingresos_paciente?start='+start+'&end='+end }
        axios(request).then((response) => {
					var incomes = response.data.incomes
					this.incomesData = [['Mes', 'Egresos']]
					for(var i=0 ; i<incomes.length; i++){
						this.incomesData.push([ incomes[i].mes.substring(0,3), parseInt(incomes[i].egresos)])
					}
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