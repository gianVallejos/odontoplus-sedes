<template>
	<b-container>
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Reportes" :items="breadcrumb" />
			</b-col>
			<b-col cols="12">
				<PanelCard>
					<span slot="heading">Reporte Estadístico</span>
					<b-row slot="body">
						<b-col xl="6" cols="12">
							<div class="square-reportes">
								<h5 class="text-center reportes-text">Balance Financiero</h5>
								<b-form-row>
									<b-col cols="6">
										<b-form-group label="Desde:" label-for="inc_start" class="mb-0">
											<b-input id="inc_paciente_start" type="date" v-model="balance.range.start" />
										</b-form-group>
									</b-col>
									<b-col cols="6">
										<b-form-group label="Hasta:" label-for="inc_end" class="mb-0">
											<b-input-group>
												<b-form-input id="inc_paciente_end" type="date" v-model="balance.range.end" />
											   	<b-input-group-append>
											    	<b-btn variant="primary" v-on:click.prevent="fillBalanceChart()" >
											    		<i class="fas fa-search"></i>
											    	</b-btn>
											    </b-input-group-append>
										    </b-input-group>								
									    </b-form-group>											
									</b-col>
								</b-form-row>
								<div class="balanceLayout">
									<div class="balanceLayout-general">
										<div class="content">
											<b-row>
												<b-col cols="12">
													<span class="title-balance">Ingresos: </span>
													<span class="float-right pt-1 pb-1">S/ {{balance.incomes}}</span>
												</b-col>
												<b-col cols="12">
													<span class="title-balance">Egresos: </span>
													<span class="float-right pt-1 pb-1">S/ {{balance.outputs}}</span>
												</b-col>
												<b-col cols="12">
													<div class="line-balance"></div>
												</b-col>
												<b-col cols="12">
													<span class="title-balance">Balance: </span>
													<span class="float-right pt-1 pb-1">S/ {{balance.balance}}</span>
												</b-col>
											</b-row>
										</div>
									</div>
								</div>								
							</div>
						</b-col>
						
						<b-col xl="6" cols="12">							
							<div class="square-reportes">
								<h5 class="text-center reportes-text">Tratamientos Destacados</h5>
								<b-form-row>
									<b-col cols="6">
										<b-form-group label="Desde:" label-for="inc_start" class="mb-0">
											<b-input id="inc_paciente_start" type="date" v-model="treatmentsChart.range.start" />
										</b-form-group>
									</b-col>
									<b-col cols="6">
										<b-form-group label="Hasta:" label-for="inc_end" class="mb-0">
											<b-input-group>
												<b-form-input id="inc_paciente_end" type="date" v-model="treatmentsChart.range.end" />
											   	<b-input-group-append>
											    	<b-btn variant="primary" v-on:click.prevent="fillTreatmentsChart()" >
											    		<i class="fas fa-search"></i>
											    	</b-btn>
											    </b-input-group-append>
										    </b-input-group>								
									    </b-form-group>											
									</b-col>
								</b-form-row>
								<GChart class="pb-3" type="PieChart" :data="treatmentsData" :options="treatmentsChart" :resizeDebounce="480" />								
							</div>
						</b-col>	
						<b-col xl="6" cols="12">	
							<div class="square-reportes">
								<h5 class="text-center reportes-text">Ingresos de los últimos seis meses</h5>
								<!--
								<b-form-row>
									<b-col cols="6">
										<b-form-group label="Desde:" label-for="inc_start" class="mb-0">
											<b-input id="inc_start" type="date" v-model="incomesChart.range.start"/>
										</b-form-group>
									</b-col>
									<b-col cols="6">
										<b-form-group label="Hasta:" label-for="inc_end" class="mb-0">
											<b-input-group>
												<b-form-input id="inc_end" type="date" v-model="incomesChart.range.end" />
											   	<b-input-group-append>
											    	<b-btn variant="primary" v-on:click.prevent="fillIncomesChart()" >
											    		<i class="fas fa-search"></i>
											    	</b-btn>
											    </b-input-group-append>
										    </b-input-group>								
									    </b-form-group>	
									</b-col>
								</b-form-row>	
								-->						
								<GChart class="pb-3" type="ColumnChart" :data="incomesData" :options="incomesChart" :resizeDebounce="480" />							
							</div>													
						</b-col>
						<b-col xl="6" cols="12">
							<div class="square-reportes">
								<h5 class="text-center reportes-text">Egresos de los últimos seis meses</h5>
								<!--
								<b-form-row>
									<b-col cols="6">
										<b-form-group label="Desde:" label-for="inc_start" class="mb-0">
											<b-input class="mb-2 mr-sm-2 mb-sm-0" id="outp_start" type="date" v-model="outputsChart.range.start"/>
										</b-form-group>
									</b-col>
									<b-col cols="6">
										<b-form-group label="Hasta:" label-for="inc_end" class="mb-0">
											<b-input-group>
												<b-form-input id="outp_end" type="date" v-model="outputsChart.range.end" />
											   	<b-input-group-append>
											    	<b-btn variant="primary" v-on:click.prevent="fillOutputsChart()" >
											    		<i class="fas fa-search"></i>
											    	</b-btn>
											    </b-input-group-append>
										    </b-input-group>								
									    </b-form-group>											
									</b-col>
								</b-form-row>
								-->
								<GChart class="pb-3" type="ColumnChart" :data="outputsData" :options="outputsChart" :resizeDebounce="480" />
							</div>
						</b-col>

						<b-col xl="6" cols="12">
							<div class="square-reportes">
								<h5 class="text-center reportes-text">Ingresos por Paciente</h5>
								<b-form-row>
									<b-col cols="6">
										<b-form-group label="Desde:" label-for="inc_start" class="mb-0">
											<b-input id="inc_paciente_start" type="date" v-model="incomesPacienteChart.range.start" />
										</b-form-group>
									</b-col>
									<b-col cols="6">
										<b-form-group label="Hasta:" label-for="inc_end" class="mb-0">
											<b-input-group>
												<b-form-input id="inc_paciente_end" type="date" v-model="incomesPacienteChart.range.end" />
											   	<b-input-group-append>
											    	<b-btn variant="primary" v-on:click.prevent="fillIncomesPacientesChart()" >
											    		<i class="fas fa-search"></i>
											    	</b-btn>
											    </b-input-group-append>
										    </b-input-group>								
									    </b-form-group>											
									</b-col>
								</b-form-row>
								<GChart class="pb-3" type="BarChart" :data="incomesPacienteData" :options="incomesPacienteChart" :resizeDebounce="480" />				
							</div>
						</b-col>
						<b-col xl="6" cols="12">
							<div class="square-reportes">
								<h5 class="text-center reportes-text" >Ingresos por Empresa</h5>
								<b-form-row>
									<b-col cols="6">
										<b-form-group label="Desde:" label-for="inc_start" class="mb-0">
											<b-input id="inc_paciente_start" type="date" v-model="incomesCompanyChart.range.start" />
										</b-form-group>
									</b-col>
									<b-col cols="6">
										<b-form-group label="Hasta:" label-for="inc_end" class="mb-0">
											<b-input-group>
												<b-form-input id="inc_paciente_end" type="date" v-model="incomesCompanyChart.range.end" />
											   	<b-input-group-append>
											    	<b-btn variant="primary" v-on:click.prevent="fillIncomesEmpresaChart()" >
											    		<i class="fas fa-search"></i>
											    	</b-btn>
											    </b-input-group-append>
										    </b-input-group>								
									    </b-form-group>											
									</b-col>
								</b-form-row>
								<GChart class="pb-3" type="PieChart" :data="incomesCompanyData" :options="incomesCompanyChart" :resizeDebounce="480" />
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
			this.initCharts()
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
          			{ text: 'Dashboard', href: this.url + '/' },
        			  { text: 'Reportes', active: true }
			  	],
				width: 480,
				height: 480,
				incomesData: [],
        incomesChart: {			        
          title: '',
          fontSize: 13,
          fontFamily: 'Open Sans',
          subtitle: 'Sales, Expenses',          
          height: 285,          
          legend: 'none',
          range: { start: '', end: '' }
				},
				outputsData: [],
					outputsChart: {			        
					title: '',
					fontSize: 13,
					fontFamily: 'Open Sans',
					height: 285,
					legend: 'none',
					range: { start: '', end: '' }
				},
				incomesPacienteData: [],
					incomesPacienteChart: {			        
					title: '',
					fontSize: 13,
					fontFamily: 'Open Sans',
					height: 285,
					legend: 'none',
					range: { start: '', end: '' }
				},
				incomesCompanyData: [],
				incomesCompanyChart: {			        
					title: '',
					fontSize: 13,
					fontFamily: 'Open Sans',
					height: 285,
					legend: { position: 'bottom', alignment:'center' },
					range: { start: '', end: '' }
				},
				treatmentsData: [],
				treatmentsChart: {			        
					title: '',
					fontSize: 12,
					fontFamily: 'Open Sans',
					height: 285,
					width:480	,
					pieHole: 0.5,
					legend: {position: 'rigth'},
					range: { start: '', end: '' }
				},
				pieSliceText: 'none',
				balance: {			        
					incomes: '',
					outputs: '',
					balance: '',
					range: { start: '', end: '' }
				}
			}
    },
    methods:{
			initCharts(){
				var sixMonthsAgo = this.currentDate(-4)
				var today = this.currentDate()

				this.incomesChart.range.start = sixMonthsAgo
				this.incomesChart.range.end = today

				this.outputsChart.range.start = sixMonthsAgo
				this.outputsChart.range.end = today

				this.incomesPacienteChart.range.start = sixMonthsAgo
				this.incomesPacienteChart.range.end = today

				this.incomesCompanyChart.range.start = sixMonthsAgo
				this.incomesCompanyChart.range.end = today

				this.treatmentsChart.range.start = sixMonthsAgo
				this.treatmentsChart.range.end = today
				
				this.balance.range.start = sixMonthsAgo
				this.balance.range.end = today
				
				this.fillIncomesChart()
				this.fillOutputsChart()
				this.fillIncomesPacientesChart()
				this.fillIncomesEmpresaChart()
				this.fillTreatmentsChart()
				this.fillBalanceChart()
			},
      fillIncomesChart(){
				var start = this.incomesChart.range.start 
				var end = this.incomesChart.range.end
				var request = { method: 'GET', url: this.url + '/reportes/ingresos?start='+start+'&end='+end }
				if(this.validDateRage(start, end)){
					axios(request).then((response) => {
						var incomes = response.data.incomes
						this.incomesData = [['Mes', 'Ingresos']]
						for(var i=0 ; i<incomes.length; i++){
							this.incomesData.push([ incomes[i].mes.substring(0,3), parseInt(incomes[i].ingresos)])
						}
						console.log(incomes.length)
						if (incomes.length == 0) this.incomesData.push([ '', 0])
					}).catch(function (error) {
						console.log(error);
					});
				}
			},
			fillOutputsChart(){
				var start = this.outputsChart.range.start 
				var end = this.outputsChart.range.end
				var request = { method: 'GET', url: this.url + '/reportes/egresos?start='+start+'&end='+end }
				if(this.validDateRage(start, end)){
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
				}
			},
			fillIncomesPacientesChart(){
				var start = this.incomesPacienteChart.range.start 
				var end = this.incomesPacienteChart.range.end
				var request = { method: 'GET', url: this.url + '/reportes/ingresos/por_paciente?start='+start+'&end='+end }
				if(this.validDateRage(start, end)){
					axios(request).then((response) => {
						var incomes = response.data.incomes
						this.incomesPacienteData = [['Nombre', 'Monto']]
						for(var i=0 ; i<incomes.length; i++){
							this.incomesPacienteData.push([ incomes[i].nombre, parseInt(incomes[i].monto)])
						}
						if (incomes.length == 0) this.incomesPacienteData.push([ '', 0])
					}).catch(function (error) {
						console.log(error);
					});
				}
			},
			fillIncomesEmpresaChart(){
				var start = this.incomesCompanyChart.range.start 
				var end = this.incomesCompanyChart.range.end

				if(this.validDateRage(start, end)){
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
				}
			},
			fillTreatmentsChart(){
				var start = this.treatmentsChart.range.start 
				var end = this.treatmentsChart.range.end
				var request = { method: 'GET', url: this.url + '/reportes/tratamientos/destacados?start='+start+'&end='+end }

				if(this.validDateRage(start, end)){
					axios(request).then((response) => {
						var treatments = response.data.treatments
						this.treatmentsData = [['Tratamiento', 'Ventas']]
						for(var i=0 ; i<treatments.length; i++){
							this.treatmentsData.push([ treatments[i].tratamiento, parseInt(treatments[i].numero)])
						}
					}).catch(function (error) {
						console.log(error);
					});
				}
			},
			fillBalanceChart(){
				var start = this.balance.range.start
				var end = this.balance.range.end
				var request = { method: 'GET', url: this.url + '/reportes/balance?start='+start+'&end='+end }
				if(this.validDateRage(start, end)){
					axios(request).then((response) => {
						console.log(response.data.ingresos)
						console.log('egresos: ' + JSON.stringify(response.data.egresos))
						this.balance.incomes = (response.data.ingresos[0].ingresos != null ) ? parseFloat(response.data.ingresos[0].ingresos).toFixed(2) : '0.00'
						this.balance.outputs = (response.data.egresos[0].egresos != null ) ? parseFloat(response.data.egresos[0].egresos).toFixed(2) : '0.00'
						this.balance.balance = ((this.balance.incomes - this.balance.outputs) != null ) ? parseFloat(this.balance.incomes - this.balance.outputs).toFixed(2) : '0.00'
					}).catch(function (error) {
						console.log(error);
					});
				}
			},
			currentDate(months_back){
				var today = new Date()
				if (months_back)
					return `${today.getFullYear()}-${("0"+(today.getMonth()+months_back).toString()).slice(-2)}-01`
				else
					return `${today.getFullYear()}-${("0"+(today.getMonth()+1).toString()).slice(-2)}-${("0"+today.getDate().toString()).slice(-2)}`
			},
			validDateRage(start, end){
				var valid_range = start <= end
				if(!valid_range) this.toastFunction('El rango de fechas Ingresado en invalido. La Fecha Inicial debe ser menor o igual a la Fecha Final','error')
				return valid_range
			},
			toastFunction(msg, type){
				this.$swal({
						type: type,
						title: msg,
						toast: true,
						position: 'top',
						showConfirmButton: false,
							timer: 3000
				})
			}
    }
	}
</script>