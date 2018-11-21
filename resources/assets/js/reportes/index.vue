<template>
	<b-container>
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Estadísticas" :items="breadcrumb" />
			</b-col>
			<b-col cols="12">
				<PanelCard>
					<span slot="heading">Reporte de Ingrseos VS Egresos</span>
					<b-row slot="body">
						<b-col xl="12" cols="12">
							<div class="square-reportes">
								<b-form-row>
									<b-col cols="8" offset="2">
										<b-input-group>
											<b-form-input id="inc_ingreso_date" type="date" v-model="ingresosChart.year" />
												 <b-input-group-append>
													<b-btn variant="primary" v-on:click.prevent="fillIngresosVSegresosChart()" >
														<i class="fas fa-search"></i>
													</b-btn>
												 </b-input-group-append>
											 </b-input-group>
									</b-col>
								</b-form-row>
								<b-col cols="12">
									<bar-chart :chart-data="ingresosVSegresosChart.data" :height = "300"></bar-chart>
								</b-col>
							</div>
						</b-col>
					</b-row>
				</PanelCard>
				<PanelCard>
					<span slot="heading">Reporte Estadístico</span>
					<b-row slot="body">
						<b-col xl="6" cols="12">
							<div class="square-reportes">
								<h5 class="text-center reportes-text">Estado Financiero</h5>
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
													<span class="title-balance">Utilidad: </span>
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
											<b-input id="inc_paciente_start" type="date" v-model="tratamientosChart.start_date" />
										</b-form-group>
									</b-col>
									<b-col cols="6">
										<b-form-group label="Hasta:" label-for="inc_end" class="mb-0">
											<b-input-group>
												<b-form-input id="inc_paciente_end" type="date" v-model="tratamientosChart.end_date" />
											   	<b-input-group-append>
											    	<b-btn variant="primary" v-on:click.prevent="fillTratamientosChart()" >
											    		<i class="fas fa-search"></i>
											    	</b-btn>
											    </b-input-group-append>
										    </b-input-group>
									    </b-form-group>
									</b-col>
								</b-form-row>
								<b-col cols="12">
									<pie-chart :chart-data="tratamientosChart.data" :height = "300"></pie-chart>
								</b-col>
							</div>
						</b-col>

						<b-col xl="6" cols="12">
							<div class="square-reportes">
								<h5 class="text-center reportes-text">Ingresos de los últimos seis meses</h5>
								<b-form-row>
									<b-col cols="8" offset="2">
										<b-input-group>
											<b-form-input id="inc_ingreso_date" type="date" v-model="ingresosChart.end_date" />
											   <b-input-group-append>
											    <b-btn variant="primary" v-on:click.prevent="fillIngresosChart()" >
											    	<i class="fas fa-search"></i>
											    </b-btn>
											   </b-input-group-append>
										   </b-input-group>
									</b-col>
								</b-form-row>
								<b-col cols="12">
									<bar-chart :chart-data="ingresosChart.data" :height = "300"></bar-chart>
								</b-col>
							</div>
						</b-col>

						<b-col xl="6" cols="12">
							<div class="square-reportes">
								<h5 class="text-center reportes-text">Egresos de los últimos seis meses</h5>
								<b-form-row>
									<b-col cols="8" offset="2">
										<b-input-group>
											<b-form-input id="inc_egreso_date" type="date" v-model="egresosChart.end_date" />
											   <b-input-group-append>
											    <b-btn variant="primary" v-on:click.prevent="fillEgresosChart()" >
											    	<i class="fas fa-search"></i>
											    </b-btn>
											   </b-input-group-append>
										   </b-input-group>
									</b-col>
								</b-form-row>
								<b-col cols="12">
									<bar-chart :chart-data="egresosChart.data" :height = "300"></bar-chart>
								</b-col>
							</div>
						</b-col>

						<b-col xl="6" cols="12">
							<div class="square-reportes">
								<h5 class="text-center reportes-text">Ingresos por Paciente</h5>
								<b-form-row>
									<b-col cols="6">
										<b-form-group label="Desde:" label-for="inc_start" class="mb-0">
											<b-input id="inc_paciente_start" type="date" v-model="ingresosPacienteChart.start_date" />
										</b-form-group>
									</b-col>
									<b-col cols="6">
										<b-form-group label="Hasta:" label-for="inc_end" class="mb-0">
											<b-input-group>
												<b-form-input id="inc_paciente_end" type="date" v-model="ingresosPacienteChart.end_date" />
											   	<b-input-group-append>
											    	<b-btn variant="primary" v-on:click.prevent="fillIngresosPorPacientesChart()" >
											    		<i class="fas fa-search"></i>
											    	</b-btn>
											    </b-input-group-append>
										    </b-input-group>
									    </b-form-group>
									</b-col>
								</b-form-row>
								<b-col cols="12">
									<horizontal-bar-chart :chart-data="ingresosPacienteChart.data" :height = "300"></horizontal-bar-chart>
								</b-col>
							</div>
						</b-col>

						<b-col xl="6" cols="12">
							<div class="square-reportes">
								<h5 class="text-center reportes-text" >Ingresos por Doctor</h5>
								<b-form-row>
									<b-col cols="6">
										<b-form-group label="Desde:" label-for="inc_start" class="mb-0">
											<b-input id="ing_doctor_start" type="date" v-model="ingresosDoctorChart.start_date" />
										</b-form-group>
									</b-col>
									<b-col cols="6">
										<b-form-group label="Hasta:" label-for="inc_end" class="mb-0">
											<b-input-group>
												<b-form-input id="ing_doctor_end" type="date" v-model="ingresosDoctorChart.end_date" />
													<b-input-group-append>
														<b-btn variant="primary" v-on:click.prevent="fillIngresosDoctorChart()" >
															<i class="fas fa-search"></i>
														</b-btn>
													</b-input-group-append>
												</b-input-group>
											</b-form-group>
									</b-col>
								</b-form-row>
								<b-col cols="12">
									<pie-chart :chart-data="ingresosDoctorChart.data" :height = "300"></pie-chart>
								</b-col>
							</div>
						</b-col>

						<!--b-col xl="6" cols="12">
							<div class="square-reportes">
								<h5 class="text-center reportes-text" >Ingresos por Empresa</h5>
								<b-form-row>
									<b-col cols="6">
										<b-form-group label="Desde:" label-for="inc_start" class="mb-0">
											<b-input id="inc_paciente_start" type="date" v-model="ingresosEmpresaChart.start_date" />
										</b-form-group>
									</b-col>
									<b-col cols="6">
										<b-form-group label="Hasta:" label-for="inc_end" class="mb-0">
											<b-input-group>
												<b-form-input id="inc_paciente_end" type="date" v-model="ingresosEmpresaChart.end_date" />
											   	<b-input-group-append>
											    	<b-btn variant="primary" v-on:click.prevent="fillIncomesEmpresaChart()" >
											    		<i class="fas fa-search"></i>
											    	</b-btn>
											    </b-input-group-append>
										    </b-input-group>
									    </b-form-group>
									</b-col>
								</b-form-row>
								<b-col cols="12">
									<pie-chart :chart-data="ingresosEmpresaChart.data" :height = "300"></pie-chart>
								</b-col>
							</div>
						</b-col-->

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
	import BarChart from '../widgets/charts/bar-chart.vue'
	import HorizontalBarChart from '../widgets/charts/horizontal-bar-chart.vue'
	import PieChart from '../widgets/charts/pie-chart.vue'
  import axios from 'axios'
	import Vue from 'vue'

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
			GChart,
			BarChart,
			HorizontalBarChart,
			PieChart,
		},
		data(){
			return{
				breadcrumb: [
          			{ text: 'Inicio', href: this.url + '/' },
        			  { text: 'Estadísticas', active: true }
			  	],
				width: 480,
				height: 480,
				ingresosVSegresosChart: {
					data: null,
					year: '2018'
				},
				ingresosChart: {
					data: null,
					end_date: ''
				},
				egresosChart: {
					data: null,
					end_date: ''
				},
				ingresosPacienteChart: {
					data: null,
					start_date: '',
					end_date: '',
				},
				ingresosEmpresaChart:{
					data: null,
					start_date: '',
					end_date: '',
				},
				ingresosDoctorChart:{
					data: null,
					start_date: '',
					end_date: '',
				},
				tratamientosChart:{
					data: null,
					start_date: '',
					end_date: '',
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
				this.ingresosChart.end_date = today
				this.egresosChart.end_date = today
			},
			fillDataCharts(){
				this.fillIngresosVSegresosChart()
				this.fillIngresosChart()
				this.fillEgresosChart()
				this.fillIngresosPorPacientesChart()
				//this.fillIncomesEmpresaChart()
				this.fillTratamientosChart()
				this.fillBalanceChart()
				this.fillIngresosDoctorChart()
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
			fillIngresosVSegresosChart(){
				var year = this.ingresosVSegresosChart.year
				var request_ingresos = { method: 'GET', url: this.url + '/reportes/obtener-ingresos-mensuales/'+year }
				var request_egresos = { method: 'GET', url: this.url + '/reportes/obtener-egresos-mensuales/'+year }
				if( year != '' ){
					axios(request_ingresos).then((response) => {
						let ingresos = response.data.ingresos
            let ingresos_montos = ingresos.map(i => parseInt(i.monto))

						axios(request_egresos).then((response) => {
							let egresos = response.data.egresos
	            let egresos_montos = egresos.map(i => parseInt(i.monto))

							this.ingresosVSegresosChart.data = {
								labels: ['ene','feb','mar','abr','may','jun','jul','ago','sep','oct','nov','dic'],
								datasets: [
									{
										label: 'Ingresos',
										backgroundColor: '#305f94',
										data: ingresos_montos
									},
									{
										label: 'Egresos',
										backgroundColor: '#30FF94',
										data: egresos_montos
									}
								]
							}

						}).catch(function (error) {
							this.toastFunction('Ha ocurrido un error, inténtelo nuevamente.', 'error')
						});
					}).catch(function (error) {
						this.toastFunction('Ha ocurrido un error, inténtelo nuevamente.', 'error')
					});
				}else{
					this.toastFunction('Debe seleccionar año antes de buscar', 'error')
				}

			},
      fillIngresosChart(){
				var date = this.ingresosChart.end_date
				var request = { method: 'GET', url: this.url + '/reportes/ingresos/'+date }

				if( date != '' ){
					axios(request).then((response) => {
						let ingresos = response.data.ingresos
            let meses = ingresos.map(i => i.mes.substring(0,3))
            let ingresos_montos = ingresos.map(i => parseInt(i.ingresos))

						this.ingresosChart.data = {
							labels: meses,
							datasets: [
								{
									label: 'Ingresos',
									backgroundColor: '#305f94',
									data: ingresos_montos
								}
							]
						}
					}).catch(function (error) {
						this.toastFunction('Ha ocurrido un error, inténtelo nuevamente.', 'error')
					});
				}else{
					this.toastFunction('Debe seleccionar una fecha antes de buscar', 'error')
				}

			},
			fillEgresosChart(){
				var date = this.egresosChart.end_date
				var request = { method: 'GET', url: this.url + '/reportes/egresos/' + date }

				if( date != '' ){
					axios(request).then((response) => {
						let egresos = response.data.egresos
            let meses = egresos.map(i => i.mes.substring(0,3))
            let egresos_montos = egresos.map(i => parseInt(i.egresos))

						this.egresosChart.data = {
							labels: meses,
							datasets: [
								{
									label: 'Egresos',
									backgroundColor: '#305f94',
									data: egresos_montos
								}
							]
						}

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
				var start = this.ingresosPacienteChart.start_date
				var end = this.ingresosPacienteChart.end_date
				if(this.validDateRage(start, end)){
					var request = this.getRequestPacientes(start, end)
					axios(request).then((response) => {
						let ingresos = response.data.ingresos
						let pacientes_nombres = ingresos.map(i => i.nombre)
            let ingresos_montos = ingresos.map(i => parseInt(i.monto))

						this.ingresosPacienteChart.data = {
							labels: pacientes_nombres,
							datasets: [
								{
									label: 'Ingresos',
									backgroundColor: "#0aab8a",
									data: ingresos_montos
								}
							]
						}

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
				var start = this.ingresosEmpresaChart.start_date
				var end = this.ingresosEmpresaChart.end_date

				if(this.validDateRage(start, end)){
					var request = this.getRequestEmpresas(start, end)
					axios(request).then((response) => {
						let ingresos = response.data.ingresos
            let empresas_nombres = ingresos.map(i => i.nombre)
            let ingresos_montos = ingresos.map(i => parseInt(i.ingresos))

						this.ingresosEmpresaChart.data = {
							labels: empresas_nombres,
							datasets: [
								{
									label: 'Ingresos',
									backgroundColor: ["#FF6384","#36A2EB","#FFCE56", "#4db6ac","#7e57c2"],
									data: ingresos_montos
								}
							]
						}
					}).catch(function (error) {
						this.toastFunction('Ha ocurrido un error, inténtelo nuevamente.', 'error')
					});
				}else{
					this.toastFunction('El rango de fechas ingresado en invalido. La Fecha Inicial debe ser menor o igual a la Fecha Final','error')
				}
			},
			getRequestIngresosDoctor(start, end){
				if( start == '' && end == '' ){
					return { method: 'GET', url: this.url + '/reportes/obtener-ingresos-doctor'}
				}
				return { method: 'GET', url: this.url + '/reportes/obtener-ingresos-doctor/'+start+'/'+end }
			},
			fillIngresosDoctorChart(){
				var start = this.ingresosDoctorChart.start_date
				var end = this.ingresosDoctorChart.end_date

				if(this.validDateRage(start, end)){
					var request = this.getRequestIngresosDoctor(start, end)
					axios(request).then((response) => {
						let ingresos = response.data.ingresos
						let doctor_nombres = ingresos.map(i => (i.nombres +' '+ i.apellidos))
						let ingresos_montos = ingresos.map(i => (parseFloat(i.total_doctor.replace(/,/g, ''))))

						this.ingresosDoctorChart.data = {
							labels: doctor_nombres,
							datasets: [
								{
									label: 'Ingresos',
									backgroundColor: ["#FF6384","#36A2EB","#FFCE56", "#4db6ac","#7e57c2"],
									data: ingresos_montos
								}
							]
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
				var start = this.tratamientosChart.start_date
				var end = this.tratamientosChart.end_date

				if(this.validDateRage(start, end)){
					var request = this.getRequestTratamientos(start, end)
					axios(request).then((response) => {
						let tratamientos = response.data.tratamientos
						let nombre_tratamientos = tratamientos.map(i => i.tratamiento)
            let numero_tratamientos = tratamientos.map(i => parseInt(i.numero))
						this.tratamientosChart.data = {
							labels: nombre_tratamientos,
							datasets: [
								{
									label: 'Tratamientos',
									backgroundColor: ["#FF6384","#36A2EB","#FFCE56", "#4db6ac","#7e57c2"],
									data: numero_tratamientos
								}
							]
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
