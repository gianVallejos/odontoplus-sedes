<template>
  <b-container class="pb-4" v-if="this.$root.autorizadoVerEmpresa(curUser.schema, curUser.rolid)">
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Empresas" :items="breadcrumb" />
			</div>
      <div class="col-md-12 pt-1">
        <PanelCard>
          <span slot="heading">Lista de Empresas</span>
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
									    		<i class="fas fa-times"></i>
									    	</b-btn>
									    </div>
								    </b-input-group>
								</div>
							</div>
							<div class="col-md-6">
								<div class="float-right d-inline-block" v-if="curUser.rolid == 1">
									<b-button-group>
										<b-button :href="url+'/empresas/create'" variant="success">
											<i class="fas fa-plus"></i>&nbsp; Nueva Empresa
										</b-button>
									</b-button-group>
								</div>
							</div>
            </b-row>

            <!-- Main table element -->
            <b-table show-empty
                    :items="items"
                    :fields="fields"
                    :current-page="currentPage"
                    :per-page="perPage"
                    :filter="filter"
                    :sort-by.sync="sortBy"
                    :sort-desc.sync="sortDesc"
                    :sort-direction="sortDirection"
                    @filtered="onFiltered"
                    stacked="md"
                    responsive
                    empty-text="No existen campos para mostrar"
                    empty-filtered-text="No existen pacientes que coincidan con la búsqueda"
              >
              <template slot="actions" slot-scope="row">
                  <div class="actions-table text-left text-lg-center" style="color: #d1d1d1">
                    <a :href="url+'/empresas/'+ row.item.id" class="action" >Ver Empresa</a>
                    <span v-if="curUser.rolid == 1">|</span>
                    <a :href="url+'/empresas/'+ row.item.id+'/edit'" class="action" v-if="curUser.rolid == 1">Modificar</a>
                  </div>
              </template>
              <template slot="nombre" slot-scope="row">
                  <a :href="url + '/empresas/' + row.item.id ">
                    {{ row.value }}
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
			</div>
		</b-row>
  </b-container>
</template>

<script>
	import PanelCard from '../widgets/panel/panel-component.vue'
	import TitleComponent from '../widgets/titulo/index.vue'

  export default{
    name: 'empresas',
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
          { key: 'actions', label: 'Acción', 'class': 'action-width' },
          { key: 'nombre', label: 'Nombre', sortable: true, sortDirection: 'desc' },
          { key: 'ruc', label: 'RUC', sortable: true, sortDirection: 'desc' }
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
          { text: 'Empresas', active: true }
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
