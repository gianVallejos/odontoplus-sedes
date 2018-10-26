<template>
  <b-container>
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Ganancias" :items="breadcrumb" />
			</div>
      <div class="col-md-12">
        <PanelCard>
          <span slot="heading">Ganancias Detalle</span>
          <div slot="body" class="pt-3 pb-3 pl-3 pr-3">
            <!-- User Interface controls -->
            <b-row class="pb-3">
							<div class="col-md-6">
								<div class="input-group d-inline-block">
									<!--b-input-group>
										<div class="input-group-append">
											<span class="icon-input">
				    							<i class="fas fa-search" aria-hidden="true"></i>
				    						</span>
				    					</div>
			    						<input v-model="filter" placeholder="Buscar..." type="text" class="odInput buscar">
								      	<div class="input-group-append">
									    	<b-btn class="pl-3 pr-3" variant="secondary" :disabled="!filter" @click="filter = ''">
									    		<i class="fas fa-sync-alt"></i>
									    	</b-btn>
									    </div>
								    </b-input-group-->

								<b-form-row>
									<b-col cols="6">
										<b-form-group label="Desde:" label-for="fechainicio" class="mb-0">
											<b-input id="fechainicio" type="date" v-model="form.fechaInicio" />
											<span v-if="all_errors.fechaInicio" :class="['label label-danger']">{{ all_errors.fechaInicio[0] }}</span>
										</b-form-group>
									</b-col>
									<b-col cols="6">
										<b-form-group label="Hasta:" label-for="fechafin" class="mb-0">
											<b-input-group>
												<b-form-input id="fechafin" type="date" v-model="form.fechaFin" />
												<b-input-group-append>
													<b-btn variant="primary" v-on:click.prevent="refreshIngresos()" >
														<i class="fas fa-search"></i>
													</b-btn>
												</b-input-group-append>
											</b-input-group>	
											<span v-if="all_errors.fechaFin" :class="['label label-danger']">{{ all_errors.fechaFin[0] }}</span>
									  </b-form-group>											
									</b-col>
								</b-form-row>


								</div>
							</div>
							<div class="col-md-6">							
								<div class="float-right d-inline-block">
									<b-button-group>										
										<b-button variant="primary" v-on:click.prevent="goToPDFView()">
											<i class="far fa-file-pdf"></i>&nbsp; PDF
										</b-button>
									</b-button-group>
								</div>
							</div>
            </b-row>

            <!-- Main table element -->
            <b-table show-empty
                    stacked="md"
                    :items="items"
                    :fields="fields"
                    :current-page="currentPage"
                    :per-page="perPage"
                    :filter="filter"
                    :sort-by.sync="sortBy"
                    :sort-desc.sync="sortDesc"
                    :sort-direction="sortDirection"
                    @filtered="onFiltered"
                    empty-text="No existen campos para mostrar" >

							<template slot="index" slot-scope="row">
								{{ row.index + 1 }}
							</template>
							<template slot="doctor_nombre" slot-scope="row">
								{{ row.item.nombres }} {{ row.item.apellidos }}
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
								S/. {{ row.item.total - row.item.doctor  }}
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

  export default{
    mounted() { 
      console.log('Ganancias mounted')
    },
    name: 'Ganancias',
    components:{
			PanelCard,
      TitleComponent
		},
    props:[
      'items',
      'url'
    ],
    data(){
			return{
        fields: [
					{ key: 'index', label: '#' },
					{ key: 'doctor_nombre', label: 'Doctor', sortable: true, sortDirection: 'desc' },
					{ key: 'tratamiento', label: 'Tratamiento', sortable: true, sortDirection: 'desc' },
					{ key: 'cantidad', label: 'Cantidad', sortable: true, sortDirection: 'desc' },
					{ key: 'monto', label: 'Precio', sortable: true, sortDirection: 'desc' },
					{ key: 'total', label: 'Total', sortable: true, sortDirection: 'desc' },			        
					{ key: 'doctor', label: 'Doctor', sortable: true, sortDirection: 'desc'},			        
					{ key: 'ganancia', label: 'Ganancia', sortable: true, sortDirection: 'desc'}		
				],
				form: {
					fechaInicio:'',
					fechaFin:''
				},
		    all_errors: [],
        currentPage: 1,
        perPage: 10,
        totalRows: this.items.length,
        pageOptions: [ 5, 10, 15 ],
        sortBy: null,
        sortDesc: false,
        sortDirection: 'asc',
        filter: null,
        modalInfo: { title: '', content: '' },
        breadcrumb: [
          { text: 'Dashboard', href: this.url + '/' },
          { text: 'Ganancias', active: true }
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
			goToPDFView(){
				if( this.validForm() ){
					window.location.href = this.url + '/reportes/ganancias/' + this.form.fechaInicio + '/' + this.form.fechaFin
				}
				else{
					this.toastFunction('El periodo de fechas es inválido.', 'error')
				}
			},
			refreshIngresos(){
				alert(this.form)
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