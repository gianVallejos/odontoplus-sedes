<template>
  <b-container>
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Doctores" :items="breadcrumb" />
			</div>
      <div class="col-md-12">
        <PanelCard>
          <span slot="heading">Lista de Doctores</span>
          <div slot="body" class="pt-3 pb-3 pl-3 pr-3">
            <!-- User Interface controls -->
            <b-row class="pb-3">
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
										<b-button :href="url+'/doctores/create'" variant="success">
											<i class="fas fa-plus"></i>&nbsp; Nuevo Doctor
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
                <template slot="actions" slot-scope="row">
                    <div class="actions-table" style="color: #d1d1d1">						        	
                    <a :href="url+'/doctores/'+ row.item.id" class="action" >Detalle</a>
                    |
                    <a :href="url+'/doctores/'+ row.item.id+'/edit'" class="action" >Modificar</a>
                  </div>
                </template>
                <template slot="nombres" slot-scope="row">
                    <a :href="url + '/doctores/' + row.item.id ">
                      {{ row.value }} {{ row.item.apellidos }}
                    </a>
                </template>
                <template slot="dni" slot-scope="row">                    
                      {{ row.value }}
                </template>
                <template slot="email" slot-scope="row">                    
                      {{ row.value }}
                </template>
                <template slot="celular" slot-scope="row">                    
                      {{ row.value }}
                </template>
                <template slot="margen_ganancia" slot-scope="row">                                      
                      {{ (row.value == null) ? '0%' : row.value + '%' }}
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
      console.log('doctores mounted')
    },
    name: 'doctores',
    components:{
			PanelCard,
      TitleComponent
		},
    props:[
      'items',
      'url',
      'curUser'
    ],
    data(){
			return{
        fields: [
          { key: 'actions', label: '', 'class': 'action-width' },
          { key: 'nombres', label: 'Nombres', sortable: true, sortDirection: 'desc' },
          { key: 'dni', label: 'DNI', sortable: true },
          { key: 'email', label: 'Email', sortable: true },
          { key: 'celular', label: 'Celular', sortable: true },
          { key: (this.curUser.rolid == 1) ? 'margen_ganancia' : '', label: 'Margen de Ganancia', sortable: true, 'class': 'text-center' }
        ],
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
            { text: 'Inicio', href: this.url },
            { text: 'Doctores', active: true}
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
			onSubmit (evt) {
		      evt.preventDefault();
		      alert(JSON.stringify(this.form));
		  },
      info (item, index, button) {
        this.modalInfo.title = `Row index: ${index}`
        this.modalInfo.content = JSON.stringify(item, null, 2)
        this.$root.$emit('bv::show::modal', 'modalInfo', button)
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