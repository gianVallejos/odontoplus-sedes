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
                    :items="items"
                    :fields="fields"
                    :current-page="currentPage"
                    :per-page="perPage"
                    :filter="filter"
                    :sort-by.sync="sortBy"
                    :sort-desc.sync="sortDesc"
                    :sort-direction="sortDirection"
                    @filtered="onFiltered" >
              <template slot="empresa" slot-scope="row">
                <b-badge :variant="row.value == '1' ? 'success' : 'danger'">{{ row.value == '1' ? 'Activo':'Inactivo'}}</b-badge>
              </template>
              <template slot="monto" slot-scope="row">
                <b-badge :variant="row.value == '1' ? 'success' : 'danger'">{{ row.value == '1' ? 'Activo':'Inactivo'}}</b-badge>
              </template>
              <template slot="actions" slot-scope="row">
                  <div class="actions-table" style="color: #d1d1d1">						        	
                  <a :href="url+'/tratamientos/'+ row.item.id" class="action" >Guardar</a>
                  |
                  <a :href="url+'/tratamientos/'+ row.item.id+'/edit'" class="action" >Modificar</a>
                </div>
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
  console.log( this.props )
	import PanelCard from '../widgets/panel/panel-component.vue'
	import TitleComponent from '../widgets/titulo/index.vue'

  export default{
    mounted() { 
      console.log('tratamientos mounted')
      this.setDataTable()
    },
    name: 'tratamientos',
    components:{
			PanelCard,
      TitleComponent
		},
    props:[
      'items',
      'url'
    ],
    data(){
			return{
        fields: [
          { key: 'tratamiento', label: 'Tratamiento', sortable: true, 'class': 'text-left' },
          { key: 'empresa', label: 'Empresa', sortable: true, sortDirection: 'desc' },
          { key: 'monto', label: 'Monto', sortable: true, 'class': 'text-center' },
          { key: 'actions', label: 'Acciones' }
          ],
        data:[],  
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
      setDataTable (){
        console.log(this.items)

        for(var i = 0; i < this.items.length; i++){
          console.log( typeof this.items[i].id_tratamiento)
          var item_id = -1

          if (this.items[i].id_tratamiento == 1){
            this.data.push(
              {
                id_tratamiento: this.items[i].id_tratamiento,
                tratamiento: this.items[i].tratamiento,
                pricebook: [
                  { empresa: this.items[i].empresa, monto: this.items[i].monto }
                ]
              }
            ) 
            item_id++
          }
          else{
           this.data[item_id].pricebook.push({ empresa: this.items[i].empresa, monto: this.items[i].monto })
            
          }
         

        }
        console.log(this.data)

      }
		}
  }
</script>
