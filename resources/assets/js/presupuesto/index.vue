<template>
	<b-container class="pb-4">
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Presupuestos" :items="breadcrumb" />
			</b-col>
			<b-col cols="12" class="pt-1">
				<PanelCard>
					<span slot="heading">Lista de Presupuestos </span>
					<div slot="body" class="pt-3 pb-3 pl-3 pr-3">

						<div class="row pb-3">
							<div class="col-md-6">
								<div class="input-group d-inline-block">
									<b-input-group>
										<div class="input-group-append">
											<span class="icon-input">
				    							<i class="fas fa-search" aria-hidden="true"></i>
				    						</span>
				    					</div>
			    						<input v-model="filter" placeholder="Buscar..." type="text" class="odInput buscar">
								      	<div class="input-group-append">
									    	<b-btn class="pl-3 pr-3" variant="secondary" :disabled="!filter" @click="filter = ''">
									    		<i class="fas fa-times"></i>
									    	</b-btn>
									    </div>
								    </b-input-group>
								</div>
							</div>
							<div class="col-md-6">
								<div class="float-right d-inline-block">
									<b-button-group>
										<b-button :href="url+'/presupuestos/create'" variant="success">
											<i class="fas fa-plus"></i>&nbsp; Nuevo Presupuesto
										</b-button>
										<!--b-button variant="warning">
											<i class="fas fa-print"></i>&nbsp; Imprimir
										</b-button-->
									</b-button-group>
								</div>
							</div>
						</div>


						<b-table show-empty
									stacked="md"
								 :items="mydata"
								 :fields="fields"
								 :current-page="currentPage"
								 :per-page="perPage"
					             :filter="filter"
					             :sort-by.sync="sortBy"
					             :sort-desc.sync="sortDesc"
					             :sort-direction="sortDirection"
					             @filtered="onFiltered"
					             empty-text="No existen campos para mostrar"
											 responsive
											 empty-filtered-text="No existen pacientes que coincidan con la búsqueda" >
							<template slot="actions" slot-scope="row" class="md-2">
						        <div class="actions-table" style="color: #d1d1d1">
						        	<a :href="url+'/presupuestos/reporte/'+ row.item.id" class="action" target="_blank">Ver Presupuesto</a> |
											<a :href="url+'/ingresos/line-item/'+ row.item.ingresosId" class="action">Ver Ingresos</a>
						        </div>
						    </template>
						    <template slot="id" slot-scope="row">
						    	<a :href="url + '/presupuestos/reporte/' + row.item.id" target="_blank">
						    		{{ row.value }}
						    	</a>
						    </template>
						    <template slot="idPaciente" slot-scope="row">
								{{ row.value }}
						    </template>
						    <template slot="nombrePaciente" slot-scope="row">
						      		{{ row.value }}
						    </template>
						    <template slot="nombreDoctor" slot-scope="row">
						      		{{row.value }}
						    </template>
						    <template slot="fecha" slot-scope="row">
						      		{{row.value }}
						    </template>
					    </b-table>
					    <b-row>
					    	<b-col md="6" class="pt-3 fz-3">
					    		Mostrando {{ currentPage }} de {{ totalCurrentPages() }} páginas
					    	</b-col>
						    <b-col md="6" class="my-1 text-right">
						    	<b-pagination :total-rows="totalRows" :per-page="perPage" v-model="currentPage" class="float-right" />
						    </b-col>
					    </b-row>

					</div>
				</PanelCard>
			</b-col>
		</b-row>
	</b-container>

</template>

<script>
	import TitleComponent from '../widgets/titulo/index.vue'
	import PanelCard from '../widgets/panel/panel-component.vue'

	export default{
		components:{
			TitleComponent,
			PanelCard
		},
		props: [
			'url',
			'mydata'
		],
		data(){
			return{
				breadcrumb: [
			    	{ text: 'Inicio', href: this.url },
			    	{ text: 'Presupuestos', active: true}
			    ],
			    fields: [
				    { key: 'actions', label: 'Acción', 'class': 'action-td-width' },
				    { key: 'id', label: 'Nro', class: 'text-left text-md-center' },
				    { key: 'codigo', label: 'Historia', sortable: true, sortDirection: 'desc', 'class': 'text-left text-md-center' },
				    { key: 'nombrePaciente', label: 'Paciente', sortable: true, sortDirection: 'desc' },
				    { key: 'nombreDoctor', label: 'Doctor', sortable: true, sortDirection: 'desc' },
				    { key: 'fecha', label: 'Fecha', sortable: true, sortDirection: 'desc' }
			    ],
			    currentPage: 1,
			   	perPage: 10,
			    totalRows: this.mydata.length,
			    pageOptions: [ 5, 10, 15 ],
			    sortBy: null,
			    sortDesc: false,
			    sortDirection: 'asc',
			    filter: ''
			}
		},
		methods: {
			onFiltered (filteredItems) {
		      this.totalRows = filteredItems.length
		      this.currentPage = 1
		    },
		    totalCurrentPages(){
		 	   var res = Math.ceil(this.totalRows / this.perPage )
		       if( res == 0 ) return res + 1
		       return res
		    }
		}
	}
</script>
<style lang="stylus">
	.action-td-width
		width: 186px!important
		
	@media (max-width: 992px)	
		.action-td-width
			width: auto!important
</style>
