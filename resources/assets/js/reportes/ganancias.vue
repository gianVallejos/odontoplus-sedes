<template>
  <b-container v-if="curUser.rolid == 1">
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Reporte de Ganancias" :items="breadcrumb" />
			</div>
      <div class="col-md-12 pt-1">
        <PanelCard>
          <span slot="heading">Detalle de Ganancias</span>
          <div slot="body" class="pt-3 pb-3 pl-3 pr-3">
            <!-- User Interface controls -->
            <b-row class="pb-3">
							<div class="col-md-6">
								<div class="input-group d-inline-block">
								<b-form-row>
									<b-col cols="4">
										<b-form-group label="Desde:" label-for="fechainicio" class="mb-0">
											<b-input id="fechainicio" type="date" v-model="form.fechaInicio" />
											<span v-if="all_errors.fechaInicio" :class="['label label-danger']">{{ all_errors.fechaInicio[0] }}</span>
										</b-form-group>
									</b-col>
									<b-col cols="4">
										<b-form-group label="Hasta:" label-for="fechafin" class="mb-0">
											<b-input id="fechafin" type="date" v-model="form.fechaFin" />
											<span v-if="all_errors.fechaFin" :class="['label label-danger']">{{ all_errors.fechaFin[0] }}</span>
									  </b-form-group>
									</b-col>
									<b-col cols="4" class="pt-4 mt-1">
											<b-btn variant="primary" v-on:click.prevent="refreshIngresosTable()" >
												<i class="fas fa-search"></i>&nbsp;&nbsp;Buscar
											</b-btn>
									</b-col>
								</b-form-row>


								</div>
							</div>
							<div class="col-md-6 pt-4 mt-1">
								<div class="float-right d-inline-block">
									<b-button-group>
										<b-button variant="primary" v-on:click.prevent="goToPDFView()" >
											<i class="fas fa-file-alt"></i>&nbsp; Reporte
										</b-button>
									</b-button-group>
								</div>
							</div>
            </b-row>
            <!-- Main table element -->
            <b-table show-empty
                    stacked="md"
                    :items="gananciasRecords"
                    :fields="fields"
                    :current-page="currentPage"
                    :per-page="perPage"
                    :filter="filter"
                    :sort-by.sync="sortBy"
                    :sort-desc.sync="sortDesc"
                    :sort-direction="sortDirection"
                    @filtered="onFiltered"
                    empty-text="No existen campos para mostrar"
                    empty-filtered-text="No existen pacientes que coincidan con la búsqueda" >

							<template slot="index" slot-scope="row">
								{{ row.index + 1 }}
							</template>
							<template slot="nombres" slot-scope="row">
								{{ row.value }} {{ row.item.apellidos }}
							</template>
							<template slot="monto" slot-scope="row" class="hide-print">
								S/. {{ row.item.monto }}
							</template>
							<template slot="total" slot-scope="row">
								S/. {{ row.item.total }}
							</template>

							<template slot="doctor" slot-scope="row">
								S/. {{ row.item.doctor }}
							</template>
							<template slot="ganancia" slot-scope="row">
								S/. {{ redondearADos(row.item.total - row.item.doctor) }}
							</template>
            </b-table>

          <b-row align-h="between">
            <b-col class="fz-2">
              Mostrando {{ currentPage }} de {{ totalCurrentPages() }} páginas
            </b-col>
            <b-col cols="auto">
              <b-pagination :total-rows="totalRows" :per-page="perPage" v-model="currentPage" class="my-0" />
            </b-col>
          </b-row>
          </div>
        </PanelCard>
			</div>
		</b-row>
  </b-container>
</template>

<script>
  console.log( this.props )
	import PanelCard from '../widgets/panel/panel-component.vue'
	import TitleComponent from '../widgets/titulo/index.vue'
  import axios from 'axios'

  export default{
    mounted() {
			console.log('Ganancias mounted')
			this.initDates()
			this.initTable()
    },
    name: 'Ganancias',
    components:{
			PanelCard,
      TitleComponent
		},
    props:[
      'url',
      'curUser'
    ],
    data(){
			return{
        fields: [
					{ key: 'index', label: '#' },
					{ key: 'fecha', label: 'Fecha', sortable: true, sortDirection: 'desc' },
					{ key: 'nombres', label: 'Doctor', sortable: true, sortDirection: 'desc' },
					{ key: 'tratamiento', label: 'Tratamiento', sortable: true, sortDirection: 'desc' },
					{ key: 'cantidad', label: 'Cantidad', sortable: true, 'class': 'text-center', sortDirection: 'desc' },
					{ key: 'monto', label: 'Monto', sortable: true, 'class': 'text-center', sortDirection: 'desc' },
					{ key: 'total', label: 'Total', sortable: true, 'class': 'text-center', sortDirection: 'desc' },
					{ key: 'ganancia', label: 'Ganancia', sortable: true, 'class': 'text-center', sortDirection: 'desc'}
				],
				gananciasRecords: [ ],
				form: {
					fechaInicio:'',
					fechaFin:''
				},
		all_errors: [],
        currentPage: 1,
        perPage: 10,
        totalRows: 0,
        pageOptions: [ 5, 10, 15 ],
        sortBy: null,
        sortDesc: false,
        sortDirection: 'asc',
        filter: null,
        modalInfo: { title: '', content: '' },
        breadcrumb: [
          { text: 'Inicio', href: this.url + '/' },
          { text: 'Reporte de Ganancias', active: true }
        ]
			}
		},
    computed: {
      sortOptions () {
        // Create an options list from our fields
        return this.fields
          .filter(f => f.sortable)
          .map(f => { return { text: f.label, value: f.key } })
      }
    },
		methods:{
			initTable(){
				//this.gananciasRecords = this.items
				this.refreshIngresosTable()
			},
			initDates(){
				var today = new Date()
				today = today.toISOString().split('T')[0]
				this.form.fechaInicio = today
				this.form.fechaFin = today
			},
			goToPDFView(){
				if( this.validForm() ){
					window.open(this.url + '/reportes/ganancias/' + this.form.fechaInicio + '/' + this.form.fechaFin, '_blank')
				}
				else{
					this.toastFunction('El periodo de fechas es inválido.', 'error')
				}
			},
			refreshIngresos(){
				alert(this.form)
			},
			refreshIngresosTable(){

				if( this.validForm() ){
					var request = { method: 'GET', url: this.url + '/reportes/gananciasJSON/'+this.form.fechaInicio+'/'+this.form.fechaFin }
					axios(request).then((response) => {
						this.gananciasRecords = JSON.parse(response.data.ingresos)
						this.totalRows = this.gananciasRecords.length
					});
				}
				else{
					this.toastFunction('El periodo de fechas es inválido.', 'error')
				}

			},
			cleanErrors(){
				this.all_errors = []
			},
			validForm(){
				this.cleanErrors()
				if( this.form.fechaInicio == '' ){
					this.all_errors.fechaInicio = ['Fecha inválida']
				}
				if( this.form.fechaFin == '' ){
					this.all_errors.fechaFin = ['Fecha inválida']
				}
				if( this.form.fechaInicio != '' && this.form.fechaFin != '' && this.form.fechaInicio > this.form.fechaFin){
					this.all_errors.fechaFin = ['Rango de fechas inválido']
					this.all_errors.fechaInicio = ['Rango de fechas inválido']
				}
				return Object.keys(this.all_errors).length === 0
			},
      onFiltered (filteredItems) {
        // Trigger pagination to update the number of buttons/pages due to filtering
        this.totalRows = filteredItems.length
        this.currentPage = 1
      },
	  redondearADos(total){
	   	return parseFloat(Math.round(total * 100) / 100).toFixed(2)
	  },
      totalCurrentPages(){
        var res = Math.round(this.totalRows / this.perPage)
        if( res == 0 ) return res + 1
        return Math.ceil(this.totalRows / this.perPage )
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
