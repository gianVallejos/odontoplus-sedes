<template>
	<b-container class="pb-4">
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Egresos" :items="breadcrumb" />
			</b-col>
			<b-col cols="12" class="pt-1">
				<PanelCard>
					<span slot="heading">Lista de Egresos </span>
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
										<b-button :href="url+'/egresos/create'" variant="success">
											<i class="fas fa-plus"></i>&nbsp; Nuevo Egreso
										</b-button>
										<!--b-button variant="warning">
											<i class="fas fa-print"></i>&nbsp; Imprimir
										</b-button-->
									</b-button-group>
								</div>
							</div>
						</div>

						<b-table show-empty
								 :items="egresos"
								 :fields="fields"
								 :current-page="currentPage"
								 :per-page="perPage"
					             :filter="filter"
					             :sort-by.sync="sortBy"
					             :sort-desc.sync="sortDesc"
					             :sort-direction="sortDirection"
											 stacked="md"
											 responsive = true
					             @filtered="onFiltered"
					             empty-text="No existen campos para mostrar"
											 empty-filtered-text="No existen pacientes que coincidan con la búsqueda" >
							<template slot="actions" slot-scope="row" class="md-2">
						        <div class="actions-table text-left text-lg-center" style="color: #d1d1d1">
						        	<a :href="url+'/egresos/'+ row.item.id"  class="action">Ver Egreso</a>
						        	<span v-if="curUser.rolid == 1">
							        	|
							        	<a :href="url+'/egresos/'+ row.item.id +'/edit'" class="action">Modificar</a>
						        	</span>
						        </div>
						    </template>
						    <template slot="fecha" slot-scope="row">
						    	{{ row.value }}
						    </template>
						    <template slot="concepto" slot-scope="row">
						    	<a :href="url + '/egresos/' + row.item.id">
						      		{{ row.value }}
						      	</a>
						    </template>
						    <template slot="doctor" slot-scope="row">
						      		{{ row.value }}
						    </template>
						    <template slot="tipo" slot-scope="row">
						      	{{ row.value }}
						    </template>
						    <template slot="cantidad" slot-scope="row">
						      	{{ row.value }}
						    </template>
						    <template slot="monto" slot-scope="row">
						      	S/ {{ row.value }}
						    </template>
						    <template slot="total" slot-scope="row">
						      	S/ {{ row.value }}
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
			'egresos',
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
			    	{ text: 'Egresos', active: true}
			    ],
			    fields: [
				    { key: 'actions', label: '', 'class': 'action-width text-left' },
				    { key: 'fecha', label: 'Fecha', sortable: true, sortDirection: 'desc' },
				    { key: 'concepto', label: 'Concepto', sortable: true, sortDirection: 'desc' },
				    { key: 'doctor', label: 'Doctor', sortable: true, sortDirection: 'desc', class: 'd-none d-lg-table-cell' },
						{ key: 'tipo', label: 'Tipo', sortable: true, sortDirection: 'desc', class: 'd-none d-lg-table-cell' },
				    { key: 'nombre_sede', label: 'Sede', sortable: true, sortDirection: 'desc', class: 'd-none d-lg-table-cell' },
				    { key: 'cantidad', label: 'Cantidad', sortable: true, sortDirection: 'desc', 'class': 'text-center' },
				    { key: 'monto', label: 'Monto', sortable: true, sortDirection: 'desc' },
				    { key: 'total', label: 'Total', sortable: true, sortDirection: 'desc' }
			    ],
			    currentPage: 1,
			   	perPage: 10,
			    totalRows: this.egresos.length,
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
