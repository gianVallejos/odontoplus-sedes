<template>
	<b-container class="pb-4">
		<b-row>
			<b-col cols="12">
				<TitleComponent icono="fas fa-child" titulo="Pacientes" :items="breadcrumb" />
			</b-col>
			<b-col cols="12" class="pt-1">
				<PanelCard>
					<span slot="heading">Lista de Pacientes </span>
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
										<b-button :href="url+'/pacientes/create'" variant="success">
											<i class="fas fa-plus"></i>&nbsp; Nuevo Paciente
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
								 :items="items"
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
							<template slot="actions" slot-scope="row" class="md-2">
						        <div class="actions-table" style="color: #d1d1d1">
						        	<a :href="url+'/pacientes/'+ row.item.id"  class="action">Ver Paciente</a>
						        	|
						        	<a :href="url+'/pacientes/'+ row.item.id +'/edit'" class="action">Modificar</a>
						        </div>
						    </template>
						    <template slot="id" slot-scope="row">
						    	{{ row.value }}
						    </template>
						    <template slot="nombres" slot-scope="row">
						    	<a :href="url + '/pacientes/' + row.item.id ">
						      		{{ row.value }} {{ row.item.apellidos }}
						      	</a>
						    </template>
						    <template slot="dni" slot-scope="row">
						      		{{ row.value }}
						    </template>
						    <template slot="celular" slot-scope="row">
						      		{{row.value }}
						    </template>
						    <template slot="telefono" slot-scope="row">
						      		{{row.value }}
						    </template>
						    <template slot="empresa_nombre" slot-scope="row">
								<a :href="url + '/empresas/' + row.item.empresa_id ">
						      		{{row.value }}
						      	</a>
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
		name: 'Pacientes',
		components:{
			TitleComponent,
			PanelCard
		},
		props: [
			'items',
			'url'
		],
		data(){
			return{
				mydata: [],
				breadcrumb: [
			    	{ text: 'Inicio', href: this.url },
			    	{ text: 'Pacientes', active: true}
			    ],
			    fields: [
				    { key: 'actions', label: '', 'class': 'action-width' },
				    { key: 'nombres', label: 'Nombres', sortable: true, sortDirection: 'desc' },
				    { key: 'id', label: 'Historia', sortable: true, sortDirection: 'desc', 'class': 'text-center' },
				    { key: 'dni', label: 'DNI', sortable: true, sortDirection: 'desc' },
				    { key: 'celular', label: 'Celular', sortable: true, sortDirection: 'desc' },
				    { key: 'telefono', label: 'Teléfono', sortable: true, sortDirection: 'desc' },
				    { key: 'empresa_nombre', label: 'Empresa', sortable: true, sortDirection: 'desc' }
			    ],
			    currentPage: 1,
			   	perPage: 10,
			    totalRows: this.items.length,
			    pageOptions: [ 5, 10, 15 ],
			    sortBy: null,
			    sortDesc: false,
			    sortDirection: 'asc',
			    filter: ''
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
		methods: {
			onSubmit (evt) {
		      evt.preventDefault();
		      alert(JSON.stringify(this.form));
		  	},
	      	info (item, index, button) {
	        	this.modalInfo.title = `Row index: ${index}`
	        	this.modalInfo.content = JSON.stringify(item, null, 2)
	        	this.$root.$emit('bv::show::modal', 'modalInfo', button)
	      	},
	      	resetModal () {
		        this.modalInfo.title = ''
	        	this.modalInfo.content = ''
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
	      	}
		}
	}
</script>
