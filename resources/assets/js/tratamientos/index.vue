<template>
  <b-container class="pb-4">
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Tratamientos" :items="breadcrumb" />
			</b-col>
      <b-col cols="12" class="pt-1">
        <PanelCard>
          <span slot="heading">Lista de Tratamientos</span>
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
										<b-button :href="url+'/tratamientos/create'" variant="success">
											<i class="fas fa-plus"></i>&nbsp; Nuevo Tratamiento
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
                    stacked="md"
                    responsive
                    @filtered="onFiltered"
                    empty-text="No existen campos para mostrar"
                    empty-filtered-text="No existen pacientes que coincidan con la búsqueda" >
              <template slot="actions" slot-scope="row">
                  <div class="actions-table text-left text-lg-center" style="color: #d1d1d1">
                    <a :href="url+'/tratamientos/'+ row.item.id" class="action" >Ver Tratamiento</a>
                    <span v-if="curUser.rolid == 1">|</span>
                    <a :href="url+'/tratamientos/'+ row.item.id+'/edit'" class="action" v-if="curUser.rolid == 1" >Modificar</a>
                </div>
              </template>
              <template slot="detalle" slot-scope="row">
                  <a :href="url + '/tratamientos/' + row.item.id ">
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
          <div class="text-right" slot="footer">
            <b-button  variant="secondary" size="sm" :href="url + '/presupuestos/create'">
              <i class="fas fa-calculator"></i>&nbsp; Nuevo Presupuesto
            </b-button>
            <b-button  variant="warning" size="sm" @click.prevent="openModalPacientes">
              <i class="fas fa-money-check-alt"></i>&nbsp; Nuevo Ingreso
            </b-button>
          </div>
        </PanelCard>
			</b-col>
		</b-row>

    <b-modal ref="pacientesModalRef" id="pacientesModal" size="md" title="Seleccionar Paciente de Nuevo Ingreso">
			<b-row>
				<b-col cols="12">
					<b-input-group>
						<div class="input-group-append">
							<span class="icon-input">
									<i class="fas fa-search" aria-hidden="true"></i>
								</span>
							</div>
							<input v-model="filterPac" placeholder="Buscar..." type="text" class="odInput">
						</b-input-group>
				</b-col>
				<b-col cols="12" class="pt-3 pb-2">
					<b-table 	show-empty
										:items="pacientes"
										:fields="pacienteFields"
                    :current-page="currentPagePac"
  									:per-page="perPagePac"
										:filter="filterPac"
                    :sort-by.sync="sortByPac"
  									 :sort-desc.sync="sortDescPac"
  									 :sort-direction="sortDirectionPac"
									 	@filtered="onFilteredPac"
										empty-text="No existen campos para mostrar"
										empty-filtered-text="No existen pacientes que coincidan con la búsqueda">
							<template slot="nombres" slot-scope="row">
									{{ row.value }} {{ row.item.apellidos }}
							</template>
							<template slot="actions" slot-scope="row" class="md-2">
									<div class="actions-table" style="color: #d1d1d1">
										<a v-on:click.prevent="nuevoIngresoByIdPaciente(row.item.ingresoId)" href="#" class="action">Nuevo Ingreso</a>
									</div>
							</template>
					</b-table>
				</b-col>
				<b-col cols="12" class="text-center">
					<b-pagination :total-rows="totalRowsPac" :per-page="perPagePac" v-model="currentPagePac" class="d-inline-flex" />
				</b-col>
			</b-row>
			<div slot="modal-footer">
				<b-button  variant="secondary" size="sm" :href="url + '/pacientes/create'">
					<i class="fas fa-plus"></i>&nbsp; Nuevo Paciente
				</b-button>
				<b-button variant="primary" size="sm" @click="hideModal">
					<i class="fas fa-times"></i>&nbsp; Cerrar
				</b-button>
			</div>
		</b-modal>

  </b-container>
</template>

<script>
	import PanelCard from '../widgets/panel/panel-component.vue'
	import TitleComponent from '../widgets/titulo/index.vue'

  export default{
    name: 'Tratamientos',
    components:{
			PanelCard,
      TitleComponent
		},
    props:[
      'items',
      'url',
      'curUser',
      'pacientes'
    ],
    data(){
			return{
        fields: [
          { key: 'actions', label: 'Acción', 'class': 'td-tratamiento-table' },
          { key: 'detalle', label: 'Nombre de Tratamiento', sortable: true, sortDirection: 'desc' }
        ],
        pacienteFields: [
          { key: 'id', label: 'Historia', class: 'text-left text-lg-center' },
          { key: 'nombres', label: 'Nombre de Paciente', sortable: true, sortDirection: 'desc' },
          { key: 'actions', label: '', sortable: false }
        ],
        currentPage: 1,
        perPage: 7,
        totalRows: this.items.length,
        pageOptions: [ 5, 10, 15 ],
        sortBy: null,
        sortDesc: false,
        sortDirection: 'asc',
        filter: null,
        modalInfo: { title: '', content: '' },
        breadcrumb: [
          { text: 'Inicio', href: this.url + '/' },
          { text: 'Tratamientos', active: true }
        ],
        currentPagePac: 1,
        perPagePac: 7,
        totalRowsPac: this.pacientes.length,
        pageOptionsPac: [ 5, 10, 15 ],
        sortByPac: null,
        sortDescPac: false,
        sortDirectionPac: 'asc',
        filterPac: ''
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
      onFiltered (filteredItems) {
        // Trigger pagination to update the number of buttons/pages due to filtering
        this.totalRows = filteredItems.length
        this.currentPage = 1
      },
		  onFilteredPac (filteredItems) {
		   this.totalRowsPac = filteredItems.length
		   this.currentPagePac = 1
		  },
      totalCurrentPages(){
          var res = Math.round(this.totalRows / this.perPage)
          if( res == 0 ) return res + 1
          return Math.ceil(this.totalRows / this.perPage )
      },
      openModalPacientes(){
        this.$refs.pacientesModalRef.show()
      },
      hideModal(){
				this.$refs.pacientesModalRef.hide()
			},
			nuevoIngresoByIdPaciente(id){
					window.location = this.url + '/ingresos/line-item/' + id
			}
		}
  }
</script>
<style lang="stylus">
  .td-tratamiento-table
    width: 190px
  @media (max-width: 992px)
    .td-tratamiento-table
      width: auto
</style>
