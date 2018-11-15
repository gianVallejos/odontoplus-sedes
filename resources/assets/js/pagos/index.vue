<template>
  <b-container v-if="curUser.rolid == 1">
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Pagos" :items="breadcrumb" />
			</div>
      <div class="col-md-12">
        <PanelCard>
          <span slot="heading">Lista de Pagos</span>
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
										<b-button :href="url+'/pagos/create'" variant="success">
											<i class="fas fa-plus"></i>&nbsp; Nuevo Pago
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

              <template slot="name" slot-scope="row">{{row.value}}</template>
              <template slot="actions" slot-scope="row">
                  <div class="actions-table" style="color: #d1d1d1">
                  <a :href="url+'/pagos/detalle/'+ row.item.idDoctor+'/'+row.item.fecha_inicio+'/'+row.item.fecha_fin" class="action" target="_blank" >Detalle</a>
                  |
                  <a v-on:click.prevent="onEliminar( row.item.id )" class="action" >Eliminar</a>
                </div>
              </template>
              <template slot="doctor" slot-scope="row">
                    {{ row.item.nombres }} {{ row.item.apellidos }}
              </template>
            </b-table>

          <b-row align-h="between">
            <b-col class="fz-2">
              Mostrando {{ currentPage }} de {{ totalCurrentPages() }} páginas
            </b-col>
            <b-col cols="auto">
              <b-pagination :total-rows="totalRows" :per-page="perPage" v-model="currentPage" class="my-0" />
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
	import axios from 'axios'

  export default{
    mounted() {
      console.log('Pagos mounted')
    },
    name: 'Pagos',
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
          { key: 'doctor', label: 'Doctor', sortable: true, sortDirection: 'desc' },
          { key: 'fecha_inicio', label: 'Fecha de Inicio', sortable: true },
          { key: 'fecha_fin', label: 'Fecha Fin', sortable: true },
          { key: 'created_at', label: 'Fecha de Creación', sortable: true  }
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
          { text: 'Inicio', href: this.url + '/' },
          { text: 'Pagos', active: true }
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
      onEliminar(pagoId){
				this.$swal({
						title: '<span style="#fff; font-size: 1em" class="pt-2">Atención</span>',
						html:  '<span style="font-size: 1em"> ¿Está seguro de eliminar este Pago?' +
									'</span>',
						animation: false,
						showConfirmButton: true,
						showCancelButton: true,
						confirmButtonText: 'Aceptar',
						confirmButtonClass: ['my-alert', 'confirm-alert'],
						cancelButtonText: 'Cancelar',
						cancelButtonClass: ['my-alert', 'cancel-alert'],
						showCloseButton: true
				}).then((result) => {
					if( result.value ){
						var request = { method: 'DELETE', url: this.url + '/pagos/' + pagoId }
            var mssgOnFail = 'Ha ocurrido un error al eliminar este registro.'
            this.onSubmit(request, mssgOnFail, pagoId)
					}
				})
			},
			onSubmit(request, error_msg, record_id) {
				self = this
				if(request){
					axios(request).then((response) => {
						if(response.data.success){
							console.log('Response:: OK')
							if (response.data.success = 'deleted' ){
                this.removeRecordFromTable(record_id)
                self.toastFunctionRedirect('Éxito', 'El Pago ha sido eliminado correctamente.', 'success')
							}
						}else if (response.data.error){
							console.log('Response:: FAIL');
							self.toastFunction(error_msg, 'error')
            }
					}).catch(function (error) {
						self.toastFunction('Ha ocurrido un error crítico, por favor comunicarse con Odontoplus.pe.', 'error')
					});
				}
      },
      removeRecordFromTable(record_id){
        for(var i = 0 ; i < this.items.length; i++){
          console.log(this.items[i].id + '  -  '+record_id)
          if (this.items[i].id == record_id){
            this.items.splice(i,1)
            break
          }
        }
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
      },
      toastFunctionRedirect(title, msg, type){
				this.$swal({
						type: type,
						title: title,
						html: msg,
						toast: false,
						position: 'center',
						confirmButtonClass: ['my-alert', 'confirm-alert'],
		  			backdrop: `rgba(0, 0, 0, 0.6)`
				}).then(() => {
					window.location.href = this.url + '/pagos'
				})
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
      redireccionarToIndex(){ //Btn Regresar
				window.location.href = this.url + '/pagos'
			}
		}
  }
</script>
