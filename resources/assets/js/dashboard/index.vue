<template lang="html">
	<b-container class="pb-4">
		<b-row>
			<b-col cols="12">
				<PanelCard>
							<div class="input-group" slot="body">
									<span class="icon-input">
										<i class="fas fa-search" aria-hidden="true"></i>
									</span>
									<input v-model="filterPacientesOdontoplus"
												 placeholder="Buscar paciente, presupuesto o ingreso"
												 v-on:input="showTableAction()"
												 type="text"
												 class="form-control odInput">
									<div class="input-group-append">
									<b-btn class="pl-3 pr-3" variant="secondary" :disabled="!filterPacientesOdontoplus" @click="cleanSearchTableAction()" v-if="showTablePacientesOP">
										<i class="fas fa-times"></i>
									</b-btn>
								</div>
							</div>

					<div class="search-content mt-3" slot="body" v-if="showTablePacientesOP">
						<b-table	show-empty
											:items=pacientes
											:filter="filterPacientesOdontoplus"
											:fields="pacienteFieldsOP"
											responsive
											stacked="md"
											empty-text="No existen campos para mostrar"
											empty-filtered-text="No existen pacientes que coincidan con la búsqueda" >
								<template slot="actions" slot-scope="row">
									<div class="actions-table" style="color: #d1d1d1">
											<a :href="url + '/pacientes/' + row.item.id" target="_blank" class="action">Ver Paciente</a> |
											<a :href="url + '/presupuestos/reporte/' + row.item.presupuestosId" target="_blank"
												 class="action" v-if="row.item.presupuestosId != null">Ver Presupuesto</a><span v-if="row.item.presupuestosId != null"> | </span>
											<a :href="url + '/ingresos/line-item/' + row.item.ingresoId" target="_blank" class="action">Ver Ingresos</a>
									</div>
								</template>
								<template slot="nombres" slot-scope="row">
										{{ row.value }} {{ row.item.apellidos }}
								</template>
						</b-table>
					</div>
				</PanelCard>
			</b-col>
			<b-col cols="12" class="pt-3">
				<div class="row">
					<div class="col-lg-3 col-md-6 col-sm-6 col-12" v-for="item in items">
						<div class="dashbox" :class="item.color" v-on:click="openDashboxUrl(item.url, item.show_modal)" v-if="item.for_admin == false || user.rolid == 1" >
							<b-container>
								<b-row>
									<b-col cols="3" class="icono pr-0 pl-0">
										<i :class="item.iconUrl"></i>
									</b-col>
									<b-col cols="9" class="text-left pt-1 pl-2 pr-0">
										<div class="subtitle-dashbox">{{ item.subname }}</div>
										<div class="title-dashbox">
											{{ item.name }}
										</div>
									</b-col>
								</b-row>
							</b-container>
						</div>
						<!-- <Dashbox :iconUrl="item.iconUrl" :subname="item.subname" :name="item.name" :color="item.color" :url="item.url" :for_admin="item.for_admin" :user="user" /> -->
					</div>
				</div>
			</b-col>
			<b-col class="pt-3" cols="12" :lg="isAdmin() ? '9' : '12'">
				<PanelCard v-if="isAdmin()">
					<span slot="heading">Ingresos vs. Egresos</span>
					<b-row slot="body" class="px-3 pb-3">
						<b-col cols="12" class="pb-3">
							<b-form-row>
								<b-col cols="3">
									<b-input-group prepend="Año">
										<b-form-select id="yead" v-model="ingresosVSegresosChart.year" :options="years" v-on:input="fillIngresosVSegresosChart()" />
									</b-input-group>
								</b-col>
								<b-col cols="6">
									<div class="float-left input-group">
										<div class="input-group-prepend">
											<div class="input-group-text fz-4"> Sede </div>
										</div>
										<b-form-select v-model="ingresosVSegresosChart.sede" v-on:input="fillIngresosVSegresosChart()">
											<option value=null >Todas las sedes</option>
											<option v-for="(sede, index) in sedes" :key="index" :value="sede.id">
												{{ sede.nombre }}
											</option>
										</b-form-select>
									</div>
								</b-col>
							</b-form-row>
						</b-col>
						<b-col xl="12" cols="12">
							<div class="chart-area" v-if="chartIsLoading" >
								<SpinnerSmall :url="url" />
							</div>
							<bar-chart v-if="!chartIsLoading" :chart-data="ingresosVSegresosChart.data" :height = "350"></bar-chart>
						</b-col>
					</b-row>
				</PanelCard>

				<PanelCard v-if="!isAdmin()">
					<span slot="heading">  Nuevos Pacientes - {{this.getCurrentYear()}}</span>
					<b-row slot="body" class="px-3 pb-3">
						<b-col xl="12" cols="12">
							<div class="chart-area" v-if="chartIsLoading" >
								<SpinnerSmall :url="url" />
							</div>
							<bar-chart v-if="!chartIsLoading" :chart-data="nuevosPacientesChart.data" :height = "320"></bar-chart>
						</b-col>
					</b-row>
				</PanelCard>

			</b-col>
			<b-col class="pt-3 d-none d-lg-block" cols="3" v-if="isAdmin()">
				<div v-for="item in itemsMedium" class="mb-2">
						<DashboxMed :iconUrl="item.iconUrl" :subname="item.subname" :name="item.name" :color="item.color" :url="item.url" :for_admin="item.for_admin" :user="user" />
				</div>
			</b-col>
			<b-col class="pt-2 mt-2 d-none d-lg-block" cols="12">
					<PanelCard>
						<div slot="body" class="text-center">
								<a :href="url + '/doctores/create'" class="sub-link">Nuevo Doctor</a>
								<a :href="url + '/doctores'" class="sub-link">Doctores</a>
								<a :href="url + '/tratamientos/create'" class="sub-link">Nuevo Tratamiento</a>
								<a :href="url + '/tratamientos'" class="sub-link">Tratamientos</a>
								<a :href="url + '/precios'" class="sub-link">Nuevo Precio</a>
								<a :href="url + '/precios'" class="sub-link">Precios</a>
								<a :href="url + '/users/create'" class="sub-link" v-if="isAdmin()">Nuevo Usuario</a>
								<a :href="url + '/users'" class="sub-link" v-if="isAdmin()">Usuarios</a>
								<a :href="url + '/users/' + user.id" class="sub-link" v-if="!isAdmin()">Mi Perfil</a>
						</div>
					</PanelCard>
			</b-col>
		</b-row>

		<b-modal ref="pacientesModalRef" id="pacientesModal" size="md" title="Seleccionar Paciente de Nuevo Ingreso">
			<b-row>
				<b-col cols="12">
					<b-input-group>
						<div class="input-group-append">
							<span class="icon-input">
									<i class="fas fa-search" aria-hidden="true"></i>
								</span>
							</div>
							<input v-model="filterPaciente" placeholder="Buscar..." type="text" class="odInput">
						</b-input-group>
				</b-col>
				<b-col cols="12" class="pt-3 pb-2">
					<b-table 	show-empty
										:items="pacientes"
										:fields="pacienteFields"
										:current-page="currentPage"
										:per-page="perPage"
										:filter="filterPaciente"
										:sort-by.sync="sortBy"
										:sort-desc.sync="sortDesc"
										:sort-direction="sortDirection"
									 	@filtered="onFilteredPacientes"
										:empty-text="emptyMessage"
										responsive
										empty-filtered-text="No existen pacientes que coincidan con la búsqueda">
							<template slot="codigo" slot-scope="row">
									<a v-on:click.prevent="nuevoIngresoByIdPaciente(row.item.ingresoId)" href="#" class="link-color" >{{ row.value }}</a>
							</template>
							<template slot="nombres" slot-scope="row">
									<a v-on:click.prevent="nuevoIngresoByIdPaciente(row.item.ingresoId)" href="#" class="link-color" >{{ row.value }} {{ row.item.apellidos }}</a>
							</template>
							<template slot="actions" slot-scope="row" class="md-2">
									<div class="actions-table" style="color: #d1d1d1">
										<a v-on:click.prevent="nuevoIngresoByIdPaciente(row.item.ingresoId)" href="#" class="action">Nuevo Ingreso</a>
									</div>
							</template>
					</b-table>
				</b-col>
				<b-col cols="12" class="text-center">
					<b-pagination :total-rows="totalRows" :per-page="perPage" v-model="currentPage" class="d-inline-flex" />
				</b-col>
			</b-row>
			<div slot="modal-footer">
				<b-button  variant="secondary" size="sm" :href="url + '/pacientes/create'">
					<i class="fas fa-plus"></i>&nbsp; Nuevo Paciente
				</b-button>
				<b-button variant="primary" size="sm" @click="hideModal">
					<i class="fas fa-times"></i>&nbsp; Cerrar
				</b-button>
			</div>
		</b-modal>

	</b-container>

</template>

<script>
	import TitleComponent from '../widgets/titulo/index.vue'
	import Dashbox from '../widgets/dashbox/dashbox-component.vue'
	import DashboxMed from '../widgets/dashbox/dashbox-med.vue'
	import PanelCard from '../widgets/panel/panel-component.vue'
	import BarChart from '../widgets/charts/bar-chart.vue'
	import SpinnerSmall from '../widgets/spinner/spinner-small.vue'
	import SpinnerContainer from '../widgets/spinner/spinner-container.vue'
	import axios from 'axios'

	export default{
		mounted(){
			this.initCharts()
		},
		created() {
			if ( this.isScreenSmSize() ) {
				window.location.href = this.url + '/citas'
			}
		},
		props: [
			'url',
			'pacientes',
			'sedes',
			'user'
		],
		components:{
			TitleComponent,
			Dashbox,
			DashboxMed,
			PanelCard,
			BarChart,
			SpinnerSmall,
			SpinnerContainer
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
			    		color: 'info',
							show_modal: 0,
			    		url: this.url + '/pacientes/create',
			    		for_admin: false
			    	},
			    	{
			    		iconUrl: 'fas fa-calculator',
							subname: 'Nuevo',
			    		name: 'Presupuesto',
			    		color: 'nuevo',
							show_modal: 0,
			    		url: this.url + '/presupuestos/create',
			    		for_admin: false
			    	},
			    	{
			    		iconUrl: 'fas fa-money-check-alt',
							subname: 'Nuevo',
			    		name: 'Ingreso',
			    		color: 'guardar',
							show_modal: 1,
			    		url: this.url + '/',
			    		for_admin: false
			    	},
			    	{
			    		iconUrl: 'fas fa-calendar-alt',
							subname: 'Nueva',
			    		name: 'Cita',
			    		color: 'modificar',
							show_modal: 0,
			    		url: this.url + '/citas/create',
			    		for_admin: false
			    	}
		    ],
				itemsMedium: [
						{
							iconUrl: 'fas fa-credit-card',
							subname: 'Nuevo',
							name: 'Pago a Doctor',
							color: 'info',
							url: this.url + '/pagos/create',
							for_admin: true
						},
						{
							iconUrl: 'fas fa-money-bill',
							subname: 'Ver ',
							name: 'Egresos',
							color: 'nuevo',
							url: this.url + '/egresos',
							for_admin: true
						},
						{
							iconUrl: 'fas fa-chart-line',
							subname: 'Ver ',
							name: 'Estadísticas',
							color: 'guardar',
							url: this.url + '/reportes',
							for_admin: true
						},
						{
							iconUrl: 'fas fa-hand-holding-usd',
							subname: 'Ver ',
							name: 'Ganancias Totales',
							color: 'modificar',
							url: this.url + '/ganancias',
							for_admin: true
						},

						{
							iconUrl: 'fas fa-users',
							subname: 'Ver ',
							name: 'Usuarios',
							color: 'info',
							url: this.url + '/users',
							for_admin: true
						}
				],
				pacienteFields: [
			    { key: 'codigo', label: 'Historia', class: 'text-center' },
			    { key: 'nombres', label: 'Nombre de Paciente', sortable: true, sortDirection: 'desc' },
			    { key: 'actions', label: '', sortable: false }
		    ],
				pacienteFieldsOP: [
					{ key: 'actions', label: 'Acción', class: 'at-width', sortable: false },
					{ key: 'nombres', label: 'Nombres de Paciente' },
					{ key: 'codigo', label: 'Historia' },
					{ key: 'dni', label: 'DNI' },
					{ key: 'celular', label: 'Celular' },
					{ key: 'telefono', label: 'Teléfono' }
				],
				ingresosVSegresosChart: {
					data: null,
					year: null,
					sede: null
				},
				nuevosPacientesChart: {
					data: null
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
				showTablePacientesOP: false,
				currentPage: 1,
				filterPacientesOdontoplus: '',
		   	perPage: 7,
		    totalRows: 0,
		    pageOptions: [ 5, 10, 15 ],
		    sortBy: null,
		    sortDesc: false,
		    sortDirection: 'asc',
		    filterPaciente: '',
		    emptyMessage: 'No existen campos para mostrar',
				chartIsLoading: false
			}
		},
		methods:{
			initCharts(){
				if ( this.isAdmin() ){
					this.ingresosVSegresosChart.year = this.getCurrentYear()
					this.fillIngresosVSegresosChart()
				}
				else{
					this.fillNuevosPacientesChart()
				}
			},
			isScreenSmSize(){
				if (screen.width <= 480){
					return true
				}
				return false
			},
			hideModal(){
				this.$refs.pacientesModalRef.hide()
			},
			onFilteredPacientes (filteredItems) {
		    this.totalRows = filteredItems.length
		    this.currentPage = 1
		  },
			openDashboxUrl: function (url, show_modal) {
					if( show_modal == 1 ){
						this.$refs.pacientesModalRef.show()
					}else{
						window.location = url
					}
		  },
			nuevoIngresoByIdPaciente(id){
					window.location = this.url + '/ingresos/line-item/' + id
			},
			isAdmin(){
				if( this.user.rolid == 1 ) return true
				return false
			},
			showTableAction(){
					if( this.filterPacientesOdontoplus != '' ){
						this.showTablePacientesOP = true
					}else {
						this.showTablePacientesOP = false
					}
			},
			cleanSearchTableAction(){
					this.filterPacientesOdontoplus = ''
					this.showTablePacientesOP = false
			},
			fillIngresosVSegresosChart(){
				var year = this.ingresosVSegresosChart.year
				var sede = this.ingresosVSegresosChart.sede
				var request_ingresos = { method: 'GET', url: this.url + '/reportes/obtener-ingresos-mensuales/' + year + '/' + sede }
				var request_egresos = { method: 'GET', url: this.url + '/reportes/obtener-egresos-mensuales/' + year + '/' + sede }
				if( year != ''){
					this.chartIsLoading = true
					var self = this
					axios(request_ingresos).then((response) => {
						let ingresos = response.data.ingresos
						let ingresos_montos = ingresos.map(i => parseInt(i.monto))
						axios(request_egresos).then((response) => {
							let egresos = response.data.egresos
							let egresos_montos = egresos.map(i => parseInt(i.monto))

							self.ingresosVSegresosChart.data = {
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
							self.toastFunction('Ha ocurrido un error con la información de egresos, inténtelo nuevamente.', 'error')
						});
					}).catch(function (error) {
						self.toastFunction('Ha ocurrido un error con la información de ingresos, inténtelo nuevamente.', 'error')
					});
				}else{
					this.toastFunction('Debe seleccionar año antes de buscar', 'error')
				}

			},
			fillNuevosPacientesChart(){
				var request = { method: 'GET', url: this.url + '/reportes/obtener-nuevos-pacientes-anio-actual' }
				this.chartIsLoading = true
				var self = this
				axios(request).then((response) => {
					let records = response.data.records
					let cantidades = records.map(r => parseInt(r.cantidad))
					self.nuevosPacientesChart.data = {
						labels: ['enero','febrero','marzo','abril','mayo','junio','julio','agosto','septiembre','octubre','noviembre','diciembre'],
						datasets: [
							{
								label: 'Nro. Nuevos Pacientes',
								backgroundColor: '#305f94',
								data: cantidades
							}
						]
					}
					self.chartIsLoading = false
				}).catch(function (error) {
					self.toastFunction('Ha ocurrido un error con la información de pacientes, inténtelo nuevamente.', 'error')
				});

			},
			getCurrentYear(){
				var todaydate = new Date()
				return 1900+todaydate.getYear()
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
	.at-width
		width: 265px

	.dashbox
		padding: 1.35em 1.1em
		color: #fff

	.subtitle-dashbox
		font-family: 'Open Sans', sans-serif
		font-size: .9em

	.title-dashbox
		font-size: 1.2em
		font-family: 'Open Sans', sans-serif
		text-transform: uppercase

	.icono
		line-height: 50px
		vertical-align: middle
		margin-top: 2px

	.panel-sec
		background: #fff
		padding: .9em 1.2em
	.sub-link
		font-size: .9em
		padding-right: 52px
		&:last-of-type
			padding-right: 0px
	.chart-area
		height: 350px

	@media (max-width: 992px)
		.at-width
			width: auto

</style>
