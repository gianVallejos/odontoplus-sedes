<template>
  <b-container>
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Proveedores & Laboratorios" :items="breadcrumb" />
			</div>
      <div class="col-md-12">

        <PanelCard>
          <span slot="heading">Proveedor/Laboratorio</span>
          <div slot="body" class="pt-3 pb-3 pl-3 pr-3">
 							<b-row>							
									<b-col cols="6 pb-2">										
										<span>Empresa: </span> <div class="d-inline-block texto"> {{ this.supplier.empresa }} </div>
                  </b-col>
									<b-col cols="6 pb-2">
										<span>Dirección: </span><div class="d-inline-block texto"> {{ this.supplier.direccion }}</div>										
									</b-col>
									<b-col cols="6 pb-2">
										<span>Nombres:</span><div class="d-inline-block texto"> {{ this.supplier.nombres }}</div>
									</b-col>
									<b-col cols="6 pb-2">
										<span>Teléfono:</span><div class="d-inline-block texto"> {{ this.supplier.telefono }}</div>
									</b-col>
									<b-col cols="6 pb-2">
										<span>Ciudad:</span><div class="d-inline-block texto"> {{ this.supplier.ciudad }}</div>
									</b-col>
									<b-col cols="6 pb-2">
										<span>Email:</span><div class="d-inline-block texto"> {{ this.supplier.email }}</div>					
									</b-col>							
							</b-row>
          </div>
        </PanelCard>
        <br/>
        <PanelCard>
          <span slot="heading">Line Items</span>
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
                    <b-button size="sm" @click.stop="formNew($event.target)" variant="success">
                      Nuevo Line Item
                    </b-button>
									</b-button-group>
								</div>
							</div>
            </b-row>

            <!-- Main table element -->
            <b-table show-emptyjs
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
              <template slot="actions" slot-scope="row">
                  <div class="actions-table" style="color: #d1d1d1">						        	
                  <a href="#" class="action" @click.stop.prevent="formEdit(row, $event.target)" >Modificar</a>
                  |
                  <a href="#" class="action" @click.stop.prevent="onDelete(row)" >Eliminar</a>
                </div>
              </template>
            </b-table>

          <b-row align-h="between">
            <b-col align-self="start">
              Mostrando {{ currentPage }} de {{ Math.ceil(totalRows / perPage) }} páginas
            </b-col>
            <b-col cols="auto">
              <b-pagination :total-rows="totalRows" :per-page="perPage" v-model="currentPage" class="my-0" />
            </b-col>
          </b-row>

          <!-- Info modal -->
          <b-modal id="modalInfo" ref="LineItemFormModal" @hide="resetModal" :title="modalInfo.title" ok-only hide-footer>
						<b-form>
							<!--input type="hidden" name="_token" :value="csrf"-->
							<div class="pt-4 pb-2">
                <b-form-group label="Detalle" label-for="detalle">
                  <b-form-input id="detalle" type="text" v-model="form.detalle" placeholder="Detalle" autocomplete="off"/>
                  <span v-if="all_errors.detalle" :class="['label label-danger']">{{ all_errors.detalle[0] }}</span>
                </b-form-group>
                <b-form-group label="Monto" label-for="monto">
                  <b-form-input id="monto" type="number" step="any" min=0 v-model="form.monto" placeholder="Monto" autocomplete="off"/>
                  <span v-if="all_errors.monto" :class="['label label-danger']">{{ all_errors.monto[0] }}</span>
                </b-form-group>
							</div>
							<div class="text-center">
                <b-button type="submit" variant="success" v-on:click.prevent="form_mode == 'new' ? onCreate() : (form_mode == 'edit' ? onEdit() : null)" >
                  <i class="fas fa-save"></i>&nbsp;Guardar
                </b-button>
                <b-button variant="warning" v-on:click.prevent="hideModal()" >
                  <i class="fas fa-times-circle"></i>&nbsp;Cancelar
                </b-button>
  						</div>
						</b-form>
          </b-modal>

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
	import axios from 'axios'

  export default{
    mounted() { 
      var data = JSON.parse(this.data)
      this.items = data.line_items
      this.totalRows = data.line_items.length
      this.supplier = data.proveedor      
    },
    name: 'proveedores',
    components:{
			PanelCard,
      TitleComponent
		},
    props:[
      'data',
      'url'
    ],
    data(){
			return{
        fields: [
          { key: 'actions', label: 'Acciones' },
          { key: 'detalle', label: 'Detalle', sortable: true, sortDirection: 'desc' },
          { key: 'monto', label: 'Monto', sortable: true }
          ],
        supplier: [],
        items: [],
        currentPage: 1,
        perPage: 10,
        totalRows: 0,
        pageOptions: [ 5, 10, 15 ],
        sortBy: null,
        sortDesc: false,
        sortDirection: 'asc',
        filter: null,
        modalInfo: { title: '', content: '' },
        form: {
          id: '',
          detalle: '',
          monto: '',
          idProveedor:''
        },
        form_mode: '',
        row_index: '',
				all_errors: [],
        breadcrumb: [
          { text: 'Home', href: '/' },
          { text: 'Lista de Proveedores/Laboratorios', href: this.url+'/proveedores' },
          { text: 'Proveedor Line Item', active: true }
        ],
        toast_config: {
					position: 'top-center',
					className: '',
					duration: 3500,
					containerClass: 'container-template'
				}
			}
		},
    computed: {
      sortOptions () {
        return this.fields
          .filter(f => f.sortable)
          .map(f => { return { text: f.label, value: f.key } })
      }
    },
		methods:{
      onFiltered (filteredItems) {
        this.totalRows = filteredItems.length
        this.currentPage = 1
      },
      formNew (button) {
        this.form_mode = 'new'
        this.form.idProveedor = this.supplier.id
        this.modalInfo.title = 'Nuevo Line Item'
        this.$root.$emit('bv::show::modal', 'modalInfo', button)
      },
      formEdit (row, button) {
        this.form_mode = 'edit'
        this.row_index = row.index
        this.fillForm(row.item)
        this.modalInfo.title = 'Modificar Line Item'
        this.$root.$emit('bv::show::modal', 'modalInfo', button)
      },
      hideModal () {
        this.$refs.LineItemFormModal.hide()
      },
      resetModal () {
        this.cleanForm()
        this.all_errors = []   
        this.modalInfo.title = ''
        this.modalInfo.content = ''
      },
      onCreate(){
        var request = { method: 'POST', url: this.url + '/proveedorLineItems', data: this.form }
        this.onSubmit(request,'create', 'Line Item creado correctamente!', 'Existen campos inválidos. Por favor verificalos.')
      },
      onEdit(){
        var request = { method: 'PUT', url: this.url + '/proveedorLineItems/' + this.form.id, data: this.form }
        this.onSubmit(request,'update', 'Line Item actualizado correctamente!', 'Existen campos inválidos. Por favor verificalos.')
      },
      onDelete(row){
        this.row_index = row.index
        var request = { method: 'DELETE', url: this.url + '/proveedorLineItems/'+ row.item.id }
        if (confirm('¿Está seguro de eliminar este registro?')){
          this.onSubmit(request,'remove', 'Line Item eliminado correctamente!', 'El Line Item seleccionadado no pudo ser eliminado.')
        }
      },
      onSubmit (request, action, successMssg, failMssg) {
        axios(request).then((response) => {
          if(response.data.success){
            this.hideModal()
            this.refreshTable(action, response.data.record)
            this.toast_config.className = 'toast-success'
            this.$toasted.show( ( successMssg ),this.toast_config)
          }
          else if (response.data.error){
            this.all_errors = response.data.error
            this.toast_config.className = 'toast-danger'
            this.$toasted.show( ( failMssg ),this.toast_config)
          }
        }).catch(function (error) {
          console.log(error);
        });
      },
      refreshTable(action, item){
        if (action == 'create'){
          this.items.unshift(item)
        }
        else if (action == 'update'){
          this.items[this.row_index].detalle = item.detalle
          this.items[this.row_index].monto = item.monto
        }
        else if (action == 'remove'){
          this.items.splice(this.row_index, 1)
        }
      },
			fillForm(record){
        this.form.id = record.id
        this.form.idProveedor = record.idProveedor
        this.form.detalle = record.detalle
        this.form.monto = record.monto
      },
      cleanForm(){
          this.form.detalle = ''
          this.form.monto =  ''
			}
		}
  }
</script>