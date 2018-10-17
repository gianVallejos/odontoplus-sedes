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
            </b-row>

            <!-- Main table element -->
            <b-table show-empty
                    stacked="md"
                    :items="data"
                    :fields="fields"
                    :current-page="currentPage"
                    :per-page="perPage"
                    :filter="filter"
                    :sort-by.sync="sortBy"
                    :sort-desc.sync="sortDesc"
                    :sort-direction="sortDirection"
                    @filtered="onFiltered" >

              <template slot="number" slot-scope="row">
                {{ row.index + 1 }}
              </template>
              <template slot="empresa" slot-scope="row">
                <b-form-select class="small" v-model="data[row.index].id_empresa" v-on:input="onNewSelectedCompany(row.index)">
											<option v-for="(e,index) in companies" :key="e.index" :value="e.id">
												{{ e.nombre }}
											</option>
								</b-form-select>
              </template>
              <template slot="monto" slot-scope="row">
                <b-form-input class="small" type="number" step="0.1" v-model="row.item.monto">
                </b-form-input>
              </template>
              <template slot="actions" slot-scope="row">
									<b-button class="small" variant="success" v-on:click.prevent="onModificar(row.index)">
									  Guardar
									</b-button>
              </template>
            </b-table>

          <b-row align-h="between">
            <b-col class="fz-3" align-self="start">
              Mostrando {{ currentPage }} de {{ Math.ceil(totalRows / perPage) }} páginas
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
      console.table((this.prices))
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
          { key: 'tratamiento', label: 'Tratamiento', 'class': 'text-left' },
          { key: 'empresa', label: 'Empresa' },
          { key: 'monto', label: 'Monto', 'class': 'text-center' },
          { key: 'actions', label: '' }
          ],
        selected_company: 1,
        data:[],
        currentPage: 1,
        perPage: 10,
        totalRows: this.prices.length,
        pageOptions: [ 5, 10, 15 ],
        sortBy: null,
        sortDesc: false,
        sortDirection: 'asc',
        filter: null,
        modalInfo: { title: '', content: '' },
        breadcrumb: [
          { text: 'Home', href: '/' },
          { text: 'Lista de Precios', active: true }
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
        // Trigger pagination to update the number of buttons/pages due to filtering
        this.totalRows = filteredItems.length
        this.currentPage = 1
      },

      onNewSelectedCompany(row_index){
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
          console.log(JSON.stringify(this.data[row_index]))
        }).catch(function (error) {
          console.log(error);
        });
      },
      onModificar(row_index){
        var item = this.data[row_index]
        var data = { monto: item.monto }
        var request = { method: 'PUT', url: this.url+'/precios/'+ item.id, data: data }
        
        axios(request).then((response) => {
          if(response.data.success){
            console.log('heee!')
          }
          else{
            console.log('price not found!')
          }
        }).catch(function (error) {
          console.log(error);
        });
      }
		}
  }
</script>
