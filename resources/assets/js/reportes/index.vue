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
											<b-input id="inc_paciente_start" type="date" v-model="tratamientosChart.range.start" />
										</b-form-group>
									</b-col>
									<b-col cols="6">
										<b-form-group label="Hasta:" label-for="inc_end" class="mb-0">
											<b-input-group>
												<b-form-input id="inc_paciente_end" type="date" v-model="tratamientosChart.range.end" />
											   	<b-input-group-append>
											    	<b-btn variant="primary" v-on:click.prevent="fillTratamientosChart()" >
											    		<i class="fas fa-search"></i>
											    	</b-btn>
											    </b-input-group-append>
										    </b-input-group>								
									    </b-form-group>											
									</b-col>
								</b-form-row>
								<GChart class="pb-3" type="PieChart" :data="tratamientosData" :options="tratamientosChart" :resizeDebounce="480" />								
							</div>
						</b-col>	
						<b-col xl="6" cols="12">	
							<div class="square-reportes">
								<h5 class="text-center reportes-text">Ingresos de los últimos seis meses</h5>	
								<b-form-row>
									<b-col cols="8" offset="2">										
										<b-input-group>
											<b-form-input id="inc_ingreso_date" type="date" v-model="ingresosChart.range.date" />
											   <b-input-group-append>
											    <b-btn variant="primary" v-on:click.prevent="fillIngresosChart()" >
											    	<i class="fas fa-search"></i>
											    </b-btn>
											   </b-input-group-append>
										   </b-input-group>
									</b-col>
								</b-form-row>											
								<GChart class="pb-3" type="ColumnChart" :data="ingresosData" :options="ingresosChart" :resizeDebounce="480" />							
							</div>													
						</b-col>
						<b-col xl="6" cols="12">
							<div class="square-reportes">
								<h5 class="text-center reportes-text">Egresos de los últimos seis meses</h5>
								<b-form-row>
									<b-col cols="8" offset="2">										
										<b-input-group>
											<b-form-input id="inc_egreso_date" type="date" v-model="egresosChart.range.date" />
											   <b-input-group-append>
											    <b-btn variant="primary" v-on:click.prevent="fillEgresosChart()" >
											    	<i class="fas fa-search"></i>
											    </b-btn>
											   </b-input-group-append>
										   </b-input-group>
									</b-col>
								</b-form-row>
								<GChart class="pb-3" type="ColumnChart" :data="egresosData" :options="egresosChart" :resizeDebounce="480" />
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
											    	<b-btn variant="primary" v-on:click.prevent="fillIngresosPorPacientesChart()" >
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
											<b-input id="inc_paciente_start" type="date" v-model="ingresosEmpresasChart.range.start" />
										</b-form-group>
									</b-col>
									<b-col cols="6">
										<b-form-group label="Hasta:" label-for="inc_end" class="mb-0">
											<b-input-group>
												<b-form-input id="inc_paciente_end" type="date" v-model="ingresosEmpresasChart.range.end" />
											   	<b-input-group-append>
											    	<b-btn variant="primary" v-on:click.prevent="fillIncomesEmpresaChart()" >
											    		<i class="fas fa-search"></i>
											    	</b-btn>
											    </b-input-group-append>
										    </b-input-group>								
									    </b-form-group>											
									</b-col>
								</b-form-row>
								<GChart class="pb-3" type="PieChart" :data="ingresosEmpresasData" :options="ingresosEmpresasChart" :resizeDebounce="480" />
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
          			{ text: 'Inicio', href: this.url + '/' },
        			  { text: 'Reportes', active: true }
			  	],
				width: 480,
				height: 480,
				ingresosData: [],
		        ingresosChart: {			        
		          title: '',
		          fontSize: 13,
		          fontFamily: 'Open Sans',
		          subtitle: 'Sales, Expenses',          
		          height: 285,          
		          legend: 'none',
		          range: { date: '' }
				},
				egresosData: [],
				egresosChart: {			        
					title: '',
					fontSize: 13,
					fontFamily: 'Open Sans',
					height: 285,
					legend: 'none',
					range: { date: '' }
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
				ingresosEmpresasData: [],
				ingresosEmpresasChart: {			        
					title: '',
					fontSize: 13,
					fontFamily: 'Open Sans',
					height: 285,
					legend: { position: 'bottom', alignment:'center' },
					range: { start: '', end: '' }
				},
				tratamientosData: [],
				tratamientosChart: {			        
					title: '',
					fontSize: 12,
					fontFamily: 'Open Sans',
					height: 285,
					legend: 'none',
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
				var sixMonthsAgo = this.getMyDate()			
				
				this.setDatesToChart(this.getMyDate())				
				
				this.fillDataCharts()
			},
			setDatesToChart(today){
				this.ingresosChart.range.date = today
				this.egresosChart.range.date = today
			},
			fillDataCharts(){
				this.fillIngresosChart()
				this.fillEgresosChart()
				this.fillIngresosPorPacientesChart()
				this.fillIncomesEmpresaChart()
				this.fillTratamientosChart()
				this.fillBalanceChart()
			},
			setMyDateToToday() {
				this.myDate = new Date();		      
			},
			addADayToMyDate() {
				if (this.myDate){ // as myDate can be null		        
					this.myDate = new Date(this.myDate.setDate(this.myDate.getDate()));
				}
			},
			getMyDate(){
				this.setMyDateToToday()
				this.addADayToMyDate()
				return this.myDate && this.myDate.toISOString().split('T')[0]			    	
			},
      		fillIngresosChart(){
				var date = this.ingresosChart.range.date 
				var request = { method: 'GET', url: this.url + '/reportes/ingresos/'+date }
				
				if( date != '' ){
					axios(request).then((response) => {										
						var ingresos = response.data.ingresos

						this.ingresosData = [['Mes', 'Ingresos']]

						for(var i=0 ; i < ingresos.length; i++){
							this.ingresosData.push([ ingresos[i].mes.substring(0,3), parseInt(ingresos[i].ingresos)])
						}
						if (ingresos.length == 0) this.ingresosData.push([ '', 0])
					}).catch(function (error) {
						this.toastFunction('Ha ocurrido un error, inténtelo nuevamente.', 'error')
					});
				}else{
					this.toastFunction('Debe seleccionar una fecha antes de buscar', 'error')
				}
				
			},
			fillEgresosChart(){
				var date = this.egresosChart.range.date 
				var request = { method: 'GET', url: this.url + '/reportes/egresos/' + date }
				
				if( date != '' ){
					axios(request).then((response) => {
						var egresos = response.data.egresos
						this.egresosData = [['Mes', 'Egresos']]					
						for(var i=0 ; i < egresos.length; i++){
							this.egresosData.push([ egresos[i].mes.substring(0,3), parseInt(egresos[i].egresos)])
						}					
						if (egresos.length == 0) this.egresosData.push([ '', 0])
					}).catch(function (error) {
						this.toastFunction('Ha ocurrido un error, inténtelo nuevamente.', 'error')
					});
				}else{
					this.toastFunction('Debe seleccionar una fecha antes de buscar', 'error')
				}
			},
			getRequestPacientes(start, end){
				if( start == '' && end == '' ){
					return { method: 'GET', url: this.url + '/reportes/obtener-ingresos-paciente'}
				}
				return { method: 'GET', url: this.url + '/reportes/obtener-ingresos-paciente/'+start+'/'+end }
			},
			fillIngresosPorPacientesChart(){
				var start = this.incomesPacienteChart.range.start 
				var end = this.incomesPacienteChart.range.end				
				if(this.validDateRage(start, end)){
					var request = this.getRequestPacientes(start, end)
					axios(request).then((response) => {
						var ingresos = response.data.ingresos
						this.incomesPacienteData = [['Nombre', 'Monto']]
						for(var i=0 ; i<ingresos.length; i++){
							this.incomesPacienteData.push([ ingresos[i].nombre, parseInt(ingresos[i].monto)])
						}
						if (ingresos.length == 0) this.incomesPacienteData.push([ '', 0])
					}).catch(function (error) {
						this.toastFunction('Ha ocurrido un error, inténtelo nuevamente.', 'error')
					});
				}else{
					this.toastFunction('El rango de fechas ingresado en invalido. La Fecha Inicial debe ser menor o igual a la Fecha Final','error')
				}
			},
			getRequestEmpresas(start, end){
				if( start == '' && end == '' ){
					return { method: 'GET', url: this.url + '/reportes/obtener-ingresos-empresa'}
				}
				return { method: 'GET', url: this.url + '/reportes/obtener-ingresos-empresa/'+start+'/'+end }
			},
			fillIncomesEmpresaChart(){
				var start = this.ingresosEmpresasChart.range.start 
				var end = this.ingresosEmpresasChart.range.end

				if(this.validDateRage(start, end)){					
					var request = this.getRequestEmpresas(start, end)
					axios(request).then((response) => {
						var ingresos = response.data.ingresos
						this.ingresosEmpresasData = [['Nombre', 'Monto']]
						for(var i=0 ; i < ingresos.length; i++){
							this.ingresosEmpresasData.push([ ingresos[i].nombre, parseInt(ingresos[i].ingresos)])
						}
					}).catch(function (error) {
						this.toastFunction('Ha ocurrido un error, inténtelo nuevamente.', 'error')
					});
				}else{
					this.toastFunction('El rango de fechas ingresado en invalido. La Fecha Inicial debe ser menor o igual a la Fecha Final','error')
				}
			},
			getRequestTratamientos(start, end){
				if( start == '' && end == '' ){
					return { method: 'GET', url: this.url + '/reportes/obtener-tratamientos'}
				}
				return { method: 'GET', url: this.url + '/reportes/obtener-tratamientos/'+ start+ '/'+ end }
			},
			fillTratamientosChart(){
				var start = this.tratamientosChart.range.start 
				var end = this.tratamientosChart.range.end
				
				if(this.validDateRage(start, end)){
					var request = this.getRequestTratamientos(start, end)
					axios(request).then((response) => {
						var treatments = response.data.tratamientos
						this.tratamientosData = [['Tratamiento', 'Ventas']]
						for(var i=0 ; i < treatments.length; i++){
							this.tratamientosData.push([ treatments[i].tratamiento, parseInt(treatments[i].numero)])
						}
					}).catch(function (error) {
						this.toastFunction('Ha ocurrido un error, inténtelo nuevamente.', 'error')
					});
				}else{
					this.toastFunction('El rango de fechas Ingresado en invalido. La Fecha Inicial debe ser menor o igual a la Fecha Final','error')
				}
			},
			getRequestBalance(start, end){
				if( start == '' && end == '' ){
					return { method: 'GET', url: this.url + '/reportes/obtener-balances'}
				}
				return { method: 'GET', url: this.url + '/reportes/obtener-balances/'+ start+ '/'+ end }
			},
			fillBalanceChart(){
				var start = this.balance.range.start
				var end = this.balance.range.end
				if(this.validDateRage(start, end)){
					var request = this.getRequestBalance(start, end)
					axios(request).then((response) => {
						this.balance.incomes = (response.data.ingresos[0].ingresos != null ) ? parseFloat(response.data.ingresos[0].ingresos).toFixed(2) : '0.00'
						this.balance.outputs = (response.data.egresos[0].egresos != null ) ? parseFloat(response.data.egresos[0].egresos).toFixed(2) : '0.00'
						this.balance.balance = ((this.balance.incomes - this.balance.outputs) != null ) ? parseFloat(this.balance.incomes - this.balance.outputs).toFixed(2) : '0.00'
					}).catch(function (error) {
						this.toastFunction('Ha ocurrido un error, inténtelo nuevamente.', 'error')
					});
				}else{
					this.toastFunction('El rango de fechas Ingresado en invalido. La Fecha Inicial debe ser menor o igual a la Fecha Final','error')
				}
			},
			validDateRage(start, end){
				if( start == '' && end != '' ) return false
				if( start != '' && end == '' ) return false
				return start <= end
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