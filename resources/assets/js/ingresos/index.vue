<template>
	<b-container class="pb-4">
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Ingresos" :items="breadcrumb" />
			</b-col>
			<b-col cols="12" class="pt-1">
				<PanelCard>
					<span slot="heading">Lista de Ingresos </span>
					<div slot="body" class="pt-3 pb-3 pl-3 pr-3">

						<div class="row pb-3">
							<div class="col-md-12">
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
						</div>

						<b-table show-empty
								 stacked="md"
								 :items="ingresos"
								 :fields="fields"
								 :current-page="currentPage"
								 :per-page="perPage"
					             :filter="filter"
					             :sort-by.sync="sortBy"
					             :sort-desc.sync="sortDesc"
					             :sort-direction="sortDirection"
					             @filtered="onFiltered"
											 responsive
					             empty-text="No existen campos para mostrar"
											 empty-filtered-text="No existen pacientes que coincidan con la búsqueda" >
							<template slot="actions" slot-scope="row" class="md-2">
						        <div class="actions-table" style="color: #d1d1d1">
						        	<a :href="url+'/ingresos/line-item/'+ row.item.id"  class="action">Ver Ingreso</a>
						        </div>
						    </template>
						    <template slot="hc" slot-scope="row">
						      		{{ row.value }}
						    </template>
						    <template slot="nombrePaciente" slot-scope="row">
						      		{{ row.value }}
						    </template>
						    <template slot="monto_total" slot-scope="row">
						      		S/ {{row.value }}
						    </template>
						    <template slot="fecha" slot-scope="row">
						    	{{ row.value }}
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
	import axios from 'axios'

	export default{		
		props: [
			'url',
			'ingresos',
			'curUser'
		],
		components:{
			TitleComponent,
			PanelCard
		},
		data(){
			return{
				mydata: [],
				breadcrumb: [
			    	{ text: 'Inicio', href: this.url },
			    	{ text: 'Ingresos', active: true}
			    ],
			    fields: [
				    { key: 'actions', label: 'Acción', 'class': 'action-width text-left text-md-center' },
				    { key: 'hc', label: 'HC', sortable: true, sortDirection: 'desc', 'class': 'text-left text-md-center' },
				    { key: 'nombrePaciente', label: 'Paciente', sortable: true, sortDirection: 'desc' },
				    { key: 'monto_total', label: 'Monto Total', sortable: true, sortDirection: 'desc' },
				    { key: 'fecha', label: 'Fecha de Creación', sortable: true, sortDirection: 'desc' }
			    ],
			    currentPage: 1,
			   	perPage: 10,
			    totalRows: this.ingresos.length,
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
	        	var res = Math.round(this.totalRows / this.perPage)
        		if( res == 0 ) return res + 1
        		return Math.ceil(this.totalRows / this.perPage )
	      	}
		}
	}
</script>
