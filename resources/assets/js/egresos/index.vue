<template>	
	<b-container class="pb-4">				
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Dashboard" :items="breadcrumb" />				
			</b-col>
			<b-col cols="12" class="pt-3">				
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
									    		<i class="fas fa-sync-alt"></i>
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

						<b-table show-empty :items="egresos" :fields="fields" :current-page="currentPage" :per-page="perPage"
					             :filter="filter" :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection"
					             @filtered="onFiltered">
							<template slot="actions" slot-scope="row" class="md-2">
						        <div class="actions-table" style="color: #d1d1d1">						        	
						        	<a :href="url+'/egresos/'+ row.item.id"  class="action">Detalle</a>
						        	|
						        	<a :href="url+'/egresos/'+ row.item.id +'/edit/'" class="action">Modificar</a>
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
						    	<a :href="url + '/doctores/' + row.item.doctorId">
						      		{{ row.value }}
						      	</a>
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
					    		Mostrando {{ currentPage }} de {{ Math.round(totalRows / perPage) }} páginas					    		
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
		mounted(){
			console.log('mounted')
		},
		props: [
			'url',
			'egresos'
		],
		components:{
			TitleComponent,
			PanelCard
		},
		data(){
			return{
				mydata: [],
				breadcrumb: [
			    	{ text: 'Dashboard', href: this.url },
			    	{ text: 'Egresos', active: true}
			    ],			    
			    fields: [		    
				    { key: 'actions', label: '', 'class': 'text-left' },				    
				    { key: 'fecha', label: 'Fecha', sortable: true, sortDirection: 'desc' },				    
				    { key: 'concepto', label: 'Concepto', sortable: true, sortDirection: 'desc' },				    
				    { key: 'doctor', label: 'Doctor', sortable: true, sortDirection: 'desc' },
				    { key: 'tipo', label: 'Tipo', sortable: true, sortDirection: 'desc' },				    
				    { key: 'cantidad', label: 'Cantidad', sortable: true, sortDirection: 'desc', 'class': 'text-center' },
				    { key: 'monto', label: 'Monto', sortable: true, sortDirection: 'desc' },				    
				    { key: 'total', label: 'Total', sortable: true, sortDirection: 'desc' }   
			    ],
			    currentPage: 1,
			   	perPage: 10,
			    totalRows: 0,
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
		    }
		}
	}	
</script>