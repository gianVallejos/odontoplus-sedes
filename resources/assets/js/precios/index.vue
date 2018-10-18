<template>
  <b-container>
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Precios" :items="breadcrumb" />
			</b-col>
      <b-col cols="12">
        <PanelCard>
          <span slot="heading">Lista de Precios</span>
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
                      <b-button :href="this.url+'/tratamientos'" variant="secondary">
                        <i class="fas fa-tooth"></i>&nbsp; Ir a Tratamientos
                      </b-button>
                      <b-button :href="this.url+'/empresas'" variant="warning">
                        <i class="fas fa-building"></i>&nbsp; Ir a Empresas
                      </b-button>
                    </b-button-group>
                  </div>
							  </div>
            </b-row>

            <!-- Main table element -->
            <b-table show-empty
                    :items="data"
                    :fields="fields"
                    :current-page="currentPage"
                    :per-page="perPage"
                    :filter="filter"
                    :sort-by.sync="sortBy"
                    :sort-desc.sync="sortDesc"
                    :sort-direction="sortDirection"
                    @filtered="onFiltered" 
                    empty-text="No existen campos para mostrar" >

              <template slot="number" slot-scope="row">
                {{ row.index + 1 }}
              </template>
              <template slot="tratamiento" slot-scope="row">
                  <a :href="url + '/tratamientos/' + row.item.id_tratamiento">
                    {{ row.value }}
                  </a>
              </template>
              <template slot="empresa" slot-scope="row">
                <b-form-select class="small" v-model="data[row.index].id_empresa" v-on:input="onNewSelectedCompany(row.index)">
											<option v-for="(e,index) in companies" :key="e.index" :value="e.id">
												{{ e.nombre }}
											</option>
								</b-form-select>
              </template>
              <template slot="monto" slot-scope="row">
                <b-input-group class="small" prepend="S/.">
                  <b-form-input class="small" type="text" v-model="row.item.monto"></b-form-input>
                </b-input-group>
                <span v-if="all_errors.row_index == row.index" :class="['label label-danger']">{{ all_errors.monto[0] }}</span>
              </template>
              <template slot="actions" slot-scope="row">
									<b-button class="small" variant="success" v-on:click.prevent="onModificar(row.index)">
									  Guardar
									</b-button>
              </template>
            </b-table>

          <b-row align-h="between">
            <b-col class="fz-3" align-self="start">
              Mostrando {{ currentPage }} de {{ totalCurrentPages() }} páginas
            </b-col>
            <b-col cols="auto">
              <b-pagination :total-rows="totalRows" :per-page="perPage" v-model="currentPage" class="my-0" />
            </b-col>
          </b-row>
          </div>
        </PanelCard>
			</b-col>
		</b-row>
  </b-container>
</template>

<script>
	import PanelCard from '../widgets/panel/panel-component.vue'
  import TitleComponent from '../widgets/titulo/index.vue'
	import axios from 'axios'  

  export default{
    mounted() { 
      console.log('Precios mounted')
      this.data = this.prices
    },
    name: 'precios',
    components:{
			PanelCard,
      TitleComponent
		},
    props:[
      'companies',
      'prices',
      'url',
    ],
    data(){
			return{
        fields: [
          { key: 'number', label: '#' },
          { key: 'tratamiento', label: 'Nombre de Tratamiento', 'class': 'text-left' },
          { key: 'empresa', label: 'Empresa', 'class': 'input-empresa-table-width' },
          { key: 'monto', label: 'Monto', 'class': 'input-table-width' },
          { key: 'actions', label: '', 'class': 'input-table-width text-center' }
        ],
        all_errors: [],
        data: [],
        currentPage: 1,
        perPage: 10,
        totalRows: this.prices.length,
        pageOptions: [ 5, 10, 15 ],
        sortBy: null,
        sortDesc: false,
        sortDirection: 'asc',
        filter: null,
        breadcrumb: [
          { text: 'Dashboard', href: this.url + '/' },
          { text: 'Precios', active: true }
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
      onFiltered (filteredItems) {
        this.totalRows = filteredItems.length
        this.currentPage = 1
      },

      onNewSelectedCompany(row_index){
        this.cleanErrosMessage()
        var item = this.data[row_index]
        var request = { method: 'GET', url: this.url+'/consulta_precio?empresa_id='+ item.id_empresa + '&tratamiento_id=' + item.id_tratamiento}
        axios(request).then((response) => {
          if(response.data.price){
            this.data[row_index].monto = response.data.price[0].monto
            this.data[row_index].id = response.data.price[0].id
          }
          else{
            console.log('price not found!')
          }
        }).catch(function (error) {
          console.log(error);
        });
      },
      onModificar(row_index){
        this.cleanErrosMessage()
        var item = this.data[row_index]
        var data = { monto: item.monto }
        var request = { method: 'PUT', url: this.url+'/precios/'+ item.id, data: data }
        
        axios(request).then((response) => {
          if(response.data.success){
            this.toastFunction('Precio actualizado correctamente', 'success')
          }
          else if (response.data.error){
            this.all_errors = response.data.error
            this.all_errors.row_index = row_index
          }
        }).catch(function (error) {
          console.log(error);
        });
      },
      cleanErrosMessage(){
        this.all_errors = []
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
      },
      totalCurrentPages(){
        var res = Math.round(this.totalRows / this.perPage)
        if( res == 0 ) return res + 1
        return Math.ceil(this.totalRows / this.perPage )
      }
		}
  }
</script>