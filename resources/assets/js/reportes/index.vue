<template>
	<b-container>
		<SpinnerContainer :url="url" ref="spinnerContainerRef" />
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Estadísticas" :items="breadcrumb" />
			</b-col>
			<b-col cols="12" class="pt-1">
				<PanelCard>
					<span slot="heading">Estadísticas de Ingresos vs Egresos</span>
					<b-row slot="body">
						<b-col cols="12">
							<b-form-row>
								<b-col cols="4" lg="2">
									<b-input-group prepend="Año">
										<b-form-select id="estado" v-model="ingresosVsEgresosChart.year" :options="years" v-on:input="fillingresosVsEgresosChart()" />
									</b-input-group>
								</b-col>
								<b-col cols="6">
									<div class="float-left input-group">
										<div class="input-group-prepend">
											<div class="input-group-text fz-4"> Sede </div>
										</div>
										<b-form-select v-model="ingresosVsEgresosChart.sede" v-on:input="fillingresosVsEgresosChart()">
											<option value=null >Todas las sedes</option>
											<option v-for="(sede, index) in sedes" :key="index" :value="sede.id">
												{{ sede.nombre }}
											</option>
										</b-form-select>
									</div>
								</b-col>
							</b-form-row>
						</b-col>
					</b-row>
					<b-row slot="body">
						<b-col xl="12" cols="12">
							<div class="square-reportes">
								<div class="chart-area" v-if="chartIsLoading" >
									<SpinnerSmall :url="url" />
								</div>
								<bar-chart v-if="!chartIsLoading" :chart-data="ingresosVsEgresosChart.data" :height = "300"></bar-chart>
							</div>
						</b-col>
					</b-row>
				</PanelCard>
				<br/>
				<PanelCard>
					<span slot="heading">Estadísticas Generales</span>
					<b-row slot="body">
						<b-col cols="12">
							<div class="pb-4">
								<b-form-row>
									<b-col cols="6" lg="3">
										<b-input-group prepend="Desde:">
											<b-input id="start_date" type="date" v-model="reportesGenerales.start_date" />
										</b-input-group>
									</b-col>
									<b-col cols="6" lg="3">
										<b-input-group prepend="Hasta:">
											<b-form-input id="end_date" type="date" v-model="reportesGenerales.end_date" />
										</b-input-group>
									</b-col>
									<b-col cols="12" lg="4" class="pt-2 pt-lg-0">
										<b-input-group prepend="Sede">
											<b-form-select v-model="reportesGenerales.sede" >
												<option value=null >Todas las sedes</option>
												<option v-for="(sede, index) in sedes" :key="index" :value="sede.id">
													{{ sede.nombre }}
												</option>
											</b-form-select>
											<b-input-group-append>
												<b-btn variant="primary" v-on:click.prevent="fillReportesGeneralesCharts()" >
													<i class="fas fa-search"></i>
												</b-btn>
											</b-input-group-append>
										</b-input-group>
									</b-col>
								</b-form-row>
							</div>
						</b-col>
					</b-row>

					<b-row slot="body" class="pb-4">
						<b-col xl="12" cols="12">
							<h6>Pacientes</h6>
							<hr class="pb-2">
						</b-col>
							<b-col xl="4" cols="12">
								<horizontal-bar-chart :chart-data="ingresosPacienteChart.data" :height = "300"></horizontal-bar-chart>
								<h5 class="pt-3 pb-1 text-center">Ganancias por Paciente</h5>
							</b-col>
							<b-col xl="4" cols="12">
								<bar-chart :chart-data="nuevosPacientesChart.data" :height = "300"></bar-chart>
								<h5 class="pt-3 pb-1 text-center">Nuevos Pacientes</h5>
							</b-col>
							<b-col xl="4" cols="12">
								<pie-chart :chart-data="pacientesCanalChart.data" :height = "300"></pie-chart>
								<h5 class="pt-3 pb-1 text-center">Pacientes por Canal</h5>
							</b-col>
					</b-row>

					<b-row slot="body" class="pb-4">
						<b-col xl="12" cols="12">
							<h6>Doctores</h6>
							<hr class="pb-2">
						</b-col>
						<b-col xl="6" cols="12">
							<pie-chart :chart-data="pagosDoctorChart.data" :height = "300"></pie-chart>
							<h5 class="pt-3 pb-1 text-center">Pagos por Doctor</h5>
						</b-col>
						<b-col xl="6" cols="12">
							<pie-chart :chart-data="ingresosDoctorChart.data" :height = "300"></pie-chart>
							<h5 class="pt-3 pb-1 text-center">Ingresos por Doctor</h5>
						</b-col>
					</b-row>

					<b-row slot="body" class="pb-4">
						<b-col xl="12" cols="12">
							<h6>Tratamientos</h6>
							<hr class="pb-2">
						</b-col>
						<b-col xl="6" cols="12">
							<pie-chart :chart-data="tratamientosChart.data" :height = "300"></pie-chart>
							<h5 class="pt-3 pb-1 text-center">Tratamientos Destacados</h5>
						</b-col>
						<b-col xl="6" cols="12">
							<pie-chart :chart-data="tratamientosDoctorChart.data" :height = "300"></pie-chart>
							<h5 class="pt-3 pb-1 text-center">Tratamientos por Doctor</h5>
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
	import BarChart from '../widgets/charts/bar-chart.vue'
	import HorizontalBarChart from '../widgets/charts/horizontal-bar-chart.vue'
	import PieChart from '../widgets/charts/pie-chart.vue'
	import SpinnerContainer from '../widgets/spinner/spinner-container.vue'
	import SpinnerSmall from '../widgets/spinner/spinner-small.vue'
  import axios from 'axios'

	export default{
		mounted(){
			this.initCharts()
		},
		props: [
			'url',
			'sedes'
		],
		components:{
			TitleComponent,
			PanelCard,
			BarChart,
			HorizontalBarChart,
			PieChart,
			SpinnerContainer,
			SpinnerSmall
		},
		data(){
			return{
				breadcrumb: [
          			{ text: 'Inicio', href: this.url + '/' },
        			  { text: 'Estadísticas', active: true }
			  	],
				width: 480,
				height: 480,
				chartIsLoading: true,
				reportesGenerales:{
					start_date: '',
					end_date: '',
					sede: null
				},
				years: [
					{ value: "2017", text: "2017" },
					{ value: "2018", text: "2018" },
					{ value: "2019", text: "2019" },
					{ value: "2020", text: "2020" },
					{ value: "2021", text: "2021" },
					{ value: "2022", text: "2022" },
					{ value: "2023", text: "2023" }
				],
				ingresosVsEgresosChart: {
					data: null,
					year: null,
					sede: null
				},
				ingresosPacienteChart: {
					data: null,
				},
				nuevosPacientesChart: {
					data: null
				},
				pacientesCanalChart: {
					data: null
				},
				pagosDoctorChart:{
					data: null,
				},
				ingresosDoctorChart:{
					data: null,
				},
				tratamientosChart:{
					data: null,
				},
				tratamientosDoctorChart:{
					data: null,
				}
			}
    },
    methods:{
			initCharts(){
				this.setDatesToChart(this.getMyDate())
				this.fillAllCharts()
			},
			setDatesToChart(today){
				this.ingresosVsEgresosChart.year = today.substring(0,4)
				this.reportesGenerales.start_date = today.substring(0,4)+'-01-01'
				this.reportesGenerales.end_date = today
			},
			fillAllCharts(){
				this.fillingresosVsEgresosChart()
				this.fillReportesGeneralesCharts()
			},
			fillReportesGeneralesCharts(){
				if ( this.validDateRage(this.reportesGenerales.start_date, this.reportesGenerales.end_date) ){
					this.fillIngresosPorPacientesChart()
					this.fillNuevosPacientesChart()
					this.fillPacientesCanalChart()
					this.fillPagosDoctorChart()
					this.fillIngresosDoctorChart()
					this.fillTratamientosChart()
					this.fillTratamientosPorDoctorChart()
				}
				else {
					this.toastFunction('Rango de fechas inválido. El rango de fechas debe ser menor a un año.', 'error')
				}
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
			fillingresosVsEgresosChart(){
				var year = this.ingresosVsEgresosChart.year
				var sede = this.ingresosVsEgresosChart.sede
				var request_ingresos = { method: 'GET', url: this.url + '/reportes/obtener-ingresos-mensuales/' + year + '/' + sede }
				var request_egresos = { method: 'GET', url: this.url + '/reportes/obtener-egresos-mensuales/' + year + '/' + sede }
				console.log(request_ingresos)
				console.log(request_egresos)
				if( year != '' ){
					this.chartIsLoading = true
					var self = this
					axios(request_ingresos).then((response) => {
						let ingresos = response.data.ingresos
            let ingresos_montos = ingresos.map(i => parseInt(i.monto))

						axios(request_egresos).then((response) => {
							let egresos = response.data.egresos
	            let egresos_montos = egresos.map(i => parseInt(i.monto))

							self.ingresosVsEgresosChart.data = {
								labels: ['ene','feb','mar','abr','may','jun','jul','ago','sep','oct','nov','dic'],
								datasets: [
									{
										label: 'Ingresos',
										backgroundColor: '#305f94',
										data: ingresos_montos
									},
									{
										label: 'Egresos',
										backgroundColor: '#ff6384',
										data: egresos_montos
									}
								]
							}
							self.chartIsLoading = false

						}).catch(function (error) {
							self.toastFunction('Ha ocurrido un error, inténtelo nuevamente.', 'error')
						});
					}).catch(function (error) {
						self.toastFunction('Ha ocurrido un error, inténtelo nuevamente.', 'error')
					});
				}else{
					this.toastFunction('Debe seleccionar año antes de buscar', 'error')
				}

			},

			fillIngresosPorPacientesChart(){
				var request = {
					method: 'GET',
					url: this.url + '/reportes/obtener-ingresos-paciente/' + this.reportesGenerales.start_date + '/' +
					 		 this.reportesGenerales.end_date + '/' + this.reportesGenerales.sede
				}
				this.$refs.spinnerContainerRef.showSpinner()
				var self = this
				axios(request).then((response) => {
					let ingresos = response.data.ingresos
					let pacientes_nombres = ingresos.map(i => i.nombre)
          let ingresos_montos = ingresos.map(i => parseInt(i.monto))

					self.ingresosPacienteChart.data = {
						labels: pacientes_nombres,
						datasets: [
							{
								label: 'Ingresos',
								backgroundColor: "#0aab8a",
								data: ingresos_montos
							}
						]
					}
					self.$refs.spinnerContainerRef.hideSpinner()
				}).catch(function (error) {
					self.toastFunction('Ha ocurrido un error, inténtelo nuevamente.', 'error')
				});
			},

			fillNuevosPacientesChart(){
				var request = {
					method: 'GET',
					url: this.url + '/reportes/obtener-nuevos-pacientes/' + this.reportesGenerales.start_date + '/' +
					 		 this.reportesGenerales.end_date + '/' + this.reportesGenerales.sede
				}
				this.$refs.spinnerContainerRef.showSpinner()
				var self = this
				axios(request).then((response) => {
					let nuevos_pacientes = response.data.nuevos_pacientes
          let meses = nuevos_pacientes.map(i => i.mes.substring(0,3))
          let cantidades = nuevos_pacientes.map(i => parseInt(i.cantidad))

					self.nuevosPacientesChart.data = {
						labels: meses,
						datasets: [
							{
								label: 'Nro. Pacientes Nuevos',
								backgroundColor: "#305f94",
								data: cantidades
							}
						]
					}
					self.$refs.spinnerContainerRef.hideSpinner()
				}).catch(function (error) {
					self.toastFunction('Ha ocurrido un error, inténtelo nuevamente.', 'error')
				});
			},

			fillPacientesCanalChart(){
				var request = {
					method: 'GET',
					url: this.url + '/reportes/obtener-pacientes-canal/' + this.reportesGenerales.start_date + '/' +
					 		 this.reportesGenerales.end_date + '/' + this.reportesGenerales.sede
				}
				this.$refs.spinnerContainerRef.showSpinner()
				var self = this
				axios(request).then((response) => {
					let nuevos_pacientes = response.data.pacientes_canal
          let canales = nuevos_pacientes.map(i => i.canal)
          let cantidades = nuevos_pacientes.map(i => parseInt(i.cantidad))

					self.pacientesCanalChart.data = {
						labels: canales,
						datasets: [
							{
								label: 'Nro. Pacientes',
								backgroundColor: ["#FF6384","#36A2EB","#FFCE56", "#4db6ac","#7e57c2"],
								data: cantidades
							}
						]
					}
					self.$refs.spinnerContainerRef.hideSpinner()
				}).catch(function (error) {
					self.toastFunction('Ha ocurrido un error, inténtelo nuevamente.', 'error')
				});
			},

			fillPagosDoctorChart(){
				var request = {
					method: 'GET',
					url: this.url + '/reportes/obtener-pagos-doctor/' + this.reportesGenerales.start_date + '/' +
					 		 this.reportesGenerales.end_date + '/' + this.reportesGenerales.sede
				}
				this.$refs.spinnerContainerRef.showSpinner()
				var self = this
				axios(request).then((response) => {
					let records = response.data.records
					let dr_nombres = records.map(r => r.nombres + ' ' + r.apellidos)
					let pagos = records.map(r => (parseFloat(r.pago.replace(/,/g, ''))))

					self.pagosDoctorChart.data = {
						labels: dr_nombres,
						datasets: [
							{
								label: 'Pagos',
								backgroundColor: ["#FF6384","#36A2EB","#FFCE56", "#4db6ac","#7e57c2"],
								data: pagos,
								fillText: 'Test'
							}
						]
					}
					self.$refs.spinnerContainerRef.hideSpinner()
				}).catch(function (error) {
					self.toastFunction('Ha ocurrido un error, inténtelo nuevamente.', 'error')
				});
			},

			fillIngresosDoctorChart(){
				var request = {
					method: 'GET',
					url: this.url + '/reportes/obtener-ingresos-doctor/' + this.reportesGenerales.start_date + '/' +
					 		 this.reportesGenerales.end_date + '/' + this.reportesGenerales.sede
				}
				this.$refs.spinnerContainerRef.showSpinner()
				var self = this
				axios(request).then((response) => {
					let records = response.data.records
					let dr_nombres = records.map(r => (r.nombres +' '+ r.apellidos))
					let ingresos = records.map(r => (parseFloat(r.ingreso.replace(/,/g, ''))))

					self.ingresosDoctorChart.data = {
						labels: dr_nombres,
						datasets: [
							{
								label: 'Ingresos',
								backgroundColor: ["#FF6384","#36A2EB","#FFCE56", "#4db6ac","#7e57c2"],
								data: ingresos
							}
						]
					}
					self.$refs.spinnerContainerRef.hideSpinner()
				}).catch(function (error) {
					self.toastFunction('Ha ocurrido un error, inténtelo nuevamente.', 'error')
				});
			},

			fillTratamientosChart(){
				var request = {
					method: 'GET',
					url: this.url + '/reportes/obtener-tratamientos/' + this.reportesGenerales.start_date + '/' +
					 		 this.reportesGenerales.end_date + '/' + this.reportesGenerales.sede
				}
				this.$refs.spinnerContainerRef.showSpinner()
				var self = this
		 		axios(request).then((response) => {
					let tratamientos = response.data.tratamientos
					let nombre_tratamientos = tratamientos.map(i => i.tratamiento)
          let numero_tratamientos = tratamientos.map(i => parseInt(i.numero))
					self.tratamientosChart.data = {
						labels: nombre_tratamientos,
						datasets: [
							{
								label: 'Tratamientos',
								backgroundColor: ["#FF6384","#36A2EB","#FFCE56", "#4db6ac","#7e57c2"],
								data: numero_tratamientos
							}
						]
					}
					self.$refs.spinnerContainerRef.hideSpinner()
				}).catch(function (error) {
					self.toastFunction('Ha ocurrido un error, inténtelo nuevamente.', 'error')
				});
			},

			fillTratamientosPorDoctorChart(){
				var request = {
					method: 'GET',
					url: this.url + '/reportes/obtener-tratamientos-doctor/' + this.reportesGenerales.start_date + '/' +
					 		 this.reportesGenerales.end_date + '/' + this.reportesGenerales.sede
				}
				this.$refs.spinnerContainerRef.showSpinner()
				var self = this
				axios(request).then((response) => {
					let records = response.data.records
					let dr_nombres = records.map(r => (r.nombres +' '+ r.apellidos))
					let tratamientos = records.map(r => parseInt(r.nro_tratamientos))
					self.tratamientosDoctorChart.data = {
						labels: dr_nombres,
						datasets: [
							{
								label: 'Tratamientos',
								backgroundColor: ["#FF6384","#36A2EB","#FFCE56", "#4db6ac","#7e57c2"],
								data: tratamientos
							}
						]
					}
					self.$refs.spinnerContainerRef.hideSpinner()
				}).catch(function (error) {
					self.toastFunction('Ha ocurrido un error, inténtelo nuevamente.', 'error')
				});
			},

			validDateRage(start, end){
				if( start == '' || end == '' ) return false
				else if( start > end ) return false
				else if( this.getDaysBetweenDates(start, end) > 365 ) return false
				return true
			},
			getDaysBetweenDates(start, end){
        var timeDiff = Date.parse(end) - Date.parse(start)
				var diff = Math.floor(timeDiff / (1000 * 60 * 60 * 24))
        return diff
			},
			toastFunction(msg, type){
				this.$swal({
						type: type,
						title: msg,
						toast: true,
						position: 'top',
						showConfirmButton: false,
						timer: 4000
				})
			}
    }
	}
</script>

<style lang="stylus">
	.chart-area
		height: 300px
</style>
