<template>	
	<b-container class="pb-4">				
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Ingresos" :items="breadcrumb" />				
			</b-col>
			<b-col cols="12" class="pt-3">				
				<PanelCard>
					<span slot="heading">Lista de Ingresos </span>
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
										<b-button :href="url+'/ingresos/create'" variant="success">
											<i class="fas fa-plus"></i>&nbsp; Nuevo Ingreso
										</b-button>
										<!--b-button variant="warning">
											<i class="fas fa-print"></i>&nbsp; Imprimir
										</b-button-->
									</b-button-group>
								</div>
							</div>
						</div>

						<b-table show-empty 
								 :items="ingresos" 
								 :fields="fields" 
								 :current-page="currentPage" 
								 :per-page="perPage"
					             :filter="filter" 
					             :sort-by.sync="sortBy" 
					             :sort-desc.sync="sortDesc" 
					             :sort-direction="sortDirection"
					             @filtered="onFiltered"
					             empty-text="No existen campos para mostrar" >
							<template slot="actions" slot-scope="row" class="md-2">
						        <div class="actions-table" style="color: #d1d1d1">						        	
						        	<a :href="url+'/ingresos/line-item/'+ row.item.id"  class="action">Detalle</a>
						        	|
						        	<a :href="url+'/ingresos/'+ row.item.id +'/edit/'" class="action">Modificar</a>
						        </div>
						    </template>
						    <template slot="fecha" slot-scope="row">
						    	{{ row.value }}
						    </template>
						    <template slot="hc" slot-scope="row">
						      		{{ row.value }}
						    </template>						    	
						    <template slot="nombrePaciente" slot-scope="row">
						    	<a :href="url + '/pacientes/' + row.item.hc + '/false'">
						      		{{ row.value }}
						      	</a>
						    </template>
						    <template slot="nombreDoctor" slot-scope="row">
						    	<a :href="url + '/doctores/' + row.item.idDoctor ">
						      		{{row.value }}
						      	</a>
						    </template>		
						    <template slot="monto_total" slot-scope="row">
						      		S/ {{row.value }}
						    </template>	
						    <template slot="mg" slot-scope="row">
						      		S/ {{row.value }}
						    </template>		
						    <template slot="mg_core" slot-scope="row">
						      		S/ {{row.value }}
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
		mounted(){
			console.log('mounted')
		},
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
			    	{ text: 'Dashboard', href: this.url },
			    	{ text: 'Ingresos', active: true}
			    ],			    
			    fields: [				    
				    { key: 'actions', label: '', 'class': 'action-width text-left' },				    
				    { key: 'fecha', label: 'Fecha', sortable: true, sortDirection: 'desc' },
				    { key: 'hc', label: 'HC', sortable: true, sortDirection: 'desc', 'class': 'text-center' },
				    { key: 'nombrePaciente', label: 'Paciente', sortable: true, sortDirection: 'desc' },
				    { key: 'nombreDoctor', label: 'Doctor', sortable: true, sortDirection: 'desc' },			        
				    { key: 'monto_total', label: 'Monto Total', sortable: true, sortDirection: 'desc' },
				    { key: (this.curUser.rolid == 1) ? 'mg' : '', label: 'M. Doctor', sortable: true, sortDirection: 'desc' },
				    { key: (this.curUser.rolid == 1) ? 'mg_core' : '', label: 'CORE', sortable: true, sortDirection: 'desc' }
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