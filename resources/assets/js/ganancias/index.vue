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
            	<div class="col-lg-9 col-md-12">
            		<div class="input-group d-inline-block">
            		<b-form-row>
            			<b-col cols="6" lg="3">
            				<b-form-group label="Desde:" label-for="fechainicio" class="mb-0">
            					<b-input id="fechainicio" type="date" v-model="form.fechaInicio" />
            					<span v-if="all_errors.fechaInicio" :class="['label label-danger']">{{ all_errors.fechaInicio[0] }}</span>
            				</b-form-group>
            			</b-col>
            			<b-col cols="6" lg="3">
            				<b-form-group label="Hasta:" label-for="fechafin" class="mb-0">
            					<b-input id="fechafin" type="date" v-model="form.fechaFin" />
            					<span v-if="all_errors.fechaFin" :class="['label label-danger']">{{ all_errors.fechaFin[0] }}</span>
            			  </b-form-group>
            			</b-col>

            			<b-col cols="9" lg="4" class="pt-lg-0 pt-3">
            				<b-form-group label="Sede">
            					<b-form-select v-model="form.sede">
            						<option value = null >Todas las sedes</option>
            						<option v-for="(sede, index) in sedes" :key="index" :value="sede.id">
            							{{ sede.nombre }}
            						</option>
            					</b-form-select>
            					<span v-if="all_errors.sede" :class="['label label-danger']">{{ all_errors.sede[0] }}</span>
            				</b-form-group>
            			</b-col>

            			<b-col cols="3" lg="2" class="pt-4 mt-lg-1 mt-4">
            					<b-btn variant="primary" v-on:click.prevent="refreshIngresosTable()" >
            						<i class="fas fa-search"></i>&nbsp;&nbsp;Buscar
            					</b-btn>
            			</b-col>
            		</b-form-row>

            		</div>
            	</div>
							<div class="col-lg-3 col-md-12 pt-lg-4 mt-lg-1 pt-0 mt-0">
								<div class="float-none float-lg-right d-inline-block text-center text-lg-right" style="width: 100%">
									<b-button-group>
										<b-button variant="primary" v-on:click.prevent="goToPDFView()" >
											<i class="fas fa-file-alt"></i>&nbsp; Reporte
										</b-button>
									</b-button-group>
								</div>
							</div>
            </b-row>
            <!-- Main table element -->
            <SpinnerContainer :url="url" ref="spinnerContainerRef" />
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
                    responsive = true
                    @filtered="onFiltered"
                    empty-text="No existen campos para mostrar"
                    empty-filtered-text="No existen pacientes que coincidan con la búsqueda" >

							<template slot="index" slot-scope="row">
								{{ row.index + 1 }}
							</template>
							<template slot="nombres" slot-scope="row">
								{{ row.item.apellidos }}
							</template>
							<template slot="codigo" slot-scope="row">
								{{ row.value }} 						
							</template>
							<template slot="monto" slot-scope="row" class="hide-print">
								S/. {{ row.item.monto }}
							</template>
							<template slot="total" slot-scope="row">
								S/. {{ row.item.total }}
							</template>
              <template slot="costo_variable" slot-scope="row">
								S/. {{ row.item.costo_variable }}
							</template>
 							<template slot="igv" slot-scope="row">
								S/. {{ row.item.igv }}
							</template>						
							<template slot="doctor" slot-scope="row">
								S/. {{ row.item.doctor}}
							</template>
							<template slot="total_empresa" slot-scope="row">
								S/. {{ row.item.total_empresa }}
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
	import PanelCard from '../widgets/panel/panel-component.vue'
	import TitleComponent from '../widgets/titulo/index.vue'
  import SpinnerContainer from '../widgets/spinner/spinner-small.vue'
  import axios from 'axios'

  export default{
    mounted() {
			this.initDates()
			this.initTable()
    },
    name: 'Ganancias',
    components:{
			PanelCard,
      TitleComponent,
      SpinnerContainer
		},
    props:[
      'url',
      'curUser',
			'sedes'
    ],
    data(){
			return{
        fields: [
					{ key: 'index', label: '#' },
					{ key: 'fecha', label: 'Fecha', sortable: true, sortDirection: 'desc' },
					{ key: 'nombres', label: 'Doctor', sortable: true, class: 'd-none d-lg-table-cell' },
					{ key: 'codigo', label: 'Código', sortable: true, class: 'd-none d-lg-table-cell' },
					{ key: 'tratamiento', label: 'Tratamiento', sortable: true, class: 'd-none d-lg-table-cell' },
					{ key: 'nombre_sede', label: 'Sede', sortable: true, class: 'd-none d-lg-table-cell' },
					{ key: 'cantidad', label: 'Cant', sortable: true, 'class': 'text-left text-lg-center' },
					{ key: 'monto', label: 'Monto', sortable: true, 'class': 'text-left text-lg-center' },
					{ key: 'total', label: 'Total', sortable: true, 'class': 'text-left text-lg-center' },
          { key: 'costo_variable', label: 'C.V.', sortable: true, 'class': 'text-left text-lg-center' },
          { key: 'igv', label: 'IGV', sortable: true, 'class': 'text-left text-lg-center' },
          { key: 'doctor', label: 'DR', sortable: true, 'class': 'text-left text-lg-center' },
					{ key: 'total_empresa', label: 'Ganancia', sortable: true, 'class': 'text-left text-lg-center'}
				],
				gananciasRecords: [ ],
				form: {
					fechaInicio:'',
					fechaFin:'',
					sede: null
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
					window.open(this.url + '/ganancias/reporte/' + this.form.fechaInicio + '/' + this.form.fechaFin + '/' + this.form.sede, '_blank')
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
					var request = { method: 'GET', url: this.url + '/ganancias/' + this.form.fechaInicio + '/' + this.form.fechaFin + '/' + this.form.sede }
					this.$refs.spinnerContainerRef.showSpinner()
          axios(request).then((response) => {
						this.gananciasRecords = JSON.parse(response.data.ingresos)
						this.totalRows = this.gananciasRecords.length
            this.$refs.spinnerContainerRef.hideSpinner()
					});
				}
				else{
					this.toastFunction('El periodo de fechas o sede son inválidos.', 'error')
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
				if( isNaN(this.form.sede) && this.form.sede != null && this.form.sede != "null" ){
					this.all_errors.sede = ['La sede seleccionada es inválida']
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
	  					timer: 4000
				})
			}
		}
  }
</script>
