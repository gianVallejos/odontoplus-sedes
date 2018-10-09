<template>
	<b-col cols="12" class="pt-3">				
		<PanelCard>
			<span slot="heading">Ingreso por Tratamientos</span>
			<div slot="body" class="pt-3 pb-3 pl-3 pr-3">
				<b-row  v-if="!isAddTratamiento" >
					<b-col cols="12" class="text-center pt-0 pb-1">
						<b-btn variant="secondary" v-on:click.prevent="agregarTratamiento()" >
							<i class="fas fa-plus"></i>&nbsp; Agregar Tratamiento
						</b-btn>
					</b-col>
				</b-row>				
				<b-row class="pt-4" v-if="!isAddTratamiento" >				
					<b-table show-empty :items="record" :fields="fields" :current-page="currentPage" :per-page="perPage"
					             :filter="filter" :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection"
					             @filtered="onFiltered">
							<template slot="actions" slot-scope="row" class="md-2">
						        <div class="actions-table" style="color: #d1d1d1">						        	
						        	<a v-on:click="modificarIngresoDetalle( row.item.id, row.item.tratamiento, row.item.cantidad, row.item.monto )" class="action">Modificar</a>
						        	|
						        	<a v-on:click="eliminarIngresoDetalle(row.item.id)" class="action">Eliminar</a>
						        </div>
						    </template>
						    <template slot="tratamiento" slot-scope="row">
						      	{{ row.value }}
						    </template>						    	
						    <template slot="cantidad" slot-scope="row">
						      	{{ row.value }}
						    </template>
						    <template slot="monto" slot-scope="row">						    	
						     	S/ {{row.value }}
						    </template>		
						    <template slot="total" slot-scope="row">
						      		S/ {{row.value }}
						    </template>							    
					</b-table>					
				</b-row>
				<b-row v-if="!isAddTratamiento" >
				   	<b-col md="6" class="pt-3 fz-3">
				   		Mostrando {{ currentPage }} de {{ Math.round(totalRows / perPage) }} páginas				
					</b-col>
					<b-col md="6" class="my-1 text-right">
					   	<b-pagination :total-rows="totalRows" :per-page="perPage" v-model="currentPage" class="float-right" />
					</b-col>
				</b-row>

				<b-row  v-if="isAddTratamiento">					
					<b-col rows="12">
						<div class="pt-3 pb-3 pl-2 pr-2" >
						    <b-form-group label="Seleccionar Tratamiento" label-for="pacientes">
								<b-input-group>
							      	<b-form-input id="tratamientos" type="text" v-model="form.tratamiento" placeholder="Ningun Tratamiento Seleccionado" disabled />
							      	<b-input-group-append>
								    	<b-btn class="pl-3 pr-3" variant="success" v-b-modal.exampleModal >
								    		<i class="fas fa-search"></i>
								    	</b-btn>
								    </b-input-group-append>								    
							   	</b-input-group>
							   	<span v-if="allerros.tratamiento" :class="['label label-danger']">{{ allerros.tratamiento[0] }}</span>
							</b-form-group>
							<b-form-row>
								<b-col>
								    <b-form-group label="Cantidad" label-for="cantidad">
										<b-form-input v-on:input="calculateTotal" id="cantidad" type="text" v-model="form.cantidad" placeholder="Cantidad" autocomplete="off" class="required" :disabled=isDisabled required  />
										<span v-if="allerros.cantidad" :class="['label label-danger']">{{ allerros.cantidad[0] }}</span>
									</b-form-group>
								</b-col>
								<b-col>
									<b-form-group label="Monto" label-for="monto">
										<b-form-input v-on:input="calculateTotal" id="monto" type="text" v-model="form.monto" placeholder="Monto" autocomplete="off" class="required" :disabled=isDisabled required />
										<span v-if="allerros.monto" :class="['label label-danger']">{{ allerros.monto[0] }}</span>
									</b-form-group>
								</b-col>
								<b-col>
									<b-form-group label="Total" label-for="total">
										<b-form-input id="total" type="text" v-model="form.total" placeholder="Total" autocomplete="off" disabled />
										<span v-if="allerros.total" :class="['label label-danger']">{{ allerros.total[0] }}</span>
									</b-form-group>
								</b-col>
							</b-form-row>
							<b-col cols="12" class="text-center pt-3">
								<b-btn variant="secondary" v-if="isModificarIngreso" v-on:click.prevent="agregarModificar" >
									<i class="fas fa-edit"></i>&nbsp; Modificar
								</b-btn>
								<b-btn variant="success" v-if="!isModificarIngreso" v-on:click.prevent="agregarLineItem" >
									<i class="fas fa-save"></i>&nbsp; Guardar
								</b-btn>
								<b-btn variant="warning" v-on:click="cerrarAddTratamiento" >
									<i class="fas fa-times-circle"></i>&nbsp; Cancelar
								</b-btn>
							</b-col>
						</div>
					</b-col>
				</b-row>	

				<b-modal ref="myModalRef" id="exampleModal" size="md" title="Lista de Tratamientos">
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
							<b-table show-empty :items="tratamientos" :fields="fieldsPac" :current-page="currentPagePac" :per-page="perPagePac" :filter="filterPac" :sort-by.sync="sortByPac" :sort-desc.sync="sortDescPac" 
										:sort-direction="sortDirectionPac"
							             @filtered="onFilteredPac">							        
									<template slot="detalle" slot-scope="row">							    	
									    {{ row.value }}
									</template>
									<template slot="monto" slot-scope="row">							    	
									    S/ {{ row.value }}
									</template>
									<template slot="actions" slot-scope="row" class="md-2">
									    <div class="actions-table" style="color: #d1d1d1">						        	
									       <a v-on:click.prevent="agregarTratamientoFromModal(row.item.id, row.item.detalle, row.item.monto)" href="#" class="action">Seleccionar</a>
									    </div>
									</template>
							</b-table>
						</b-col>
						<b-col cols="12" class="text-center">
							<b-pagination :total-rows="totalRowsPac" :per-page="perPagePac" v-model="currentPagePac" class="d-inline-flex" />
						</b-col>
					</b-row>
					<b-button slot="modal-footer" variant="primary" size="sm" @click="hideModal">Cerrar</b-button>
				</b-modal>

			</div>
		</PanelCard>
	</b-col>
</template>
<script>
	import PanelCard from '../widgets/panel/panel-component.vue'
	import axios from 'axios'

	export default{
		mounted(){
			console.log('Line item detalle Mounted')
		},
		props:[
			'url',
			'record',
			'tratamientos',
			'id'
		],
		components: {
			PanelCard
		},
		data(){
			return{
				fields: [			
					{ key: 'actions', label: '' },		    
				    { key: 'tratamiento', label: 'Tratamiento', sortable: true, sortDirection: 'desc' },
				    { key: 'cantidad', label: 'Cantidad', sortable: true, sortDirection: 'desc', 'class': 'text-center' },
				    { key: 'monto', label: 'Monto', sortable: true, sortDirection: 'desc', 'class': 'text-center' },
				    { key: 'total', label: 'Total', sortable: true, sortDirection: 'desc', 'class': 'text-center' }	
			    ],
			    currentPage: 1,
			   	perPage: 10,
			    totalRows: 0,
			    pageOptions: [ 5, 10, 15 ],
			    sortBy: null,
			    sortDesc: false,
			    sortDirection: 'asc',
			    filter: '',
			    isDisabled: false,
			    allerros: [],
			    isAddTratamiento: false,
			    isModificarIngreso: false,
			    fieldsPac: [			
					{ key: 'id', label: 'Nro', class: 'text-center' }, 				    
				    { key: 'detalle', label: 'Tratamiento', sortable: true, sortDirection: 'desc' },
				    { key: 'monto', label: 'Monto', 'class': 'text-center' },
				    { key: 'actions', label: '', sortable: false }			    
			    ],
			    currentPagePac: 1,
			   	perPagePac: 10,
			    totalRowsPac: 0,
			    pageOptionsPac: [ 5, 10, 15 ],
			    sortByPac: null,
			    sortDescPac: false,
			    sortDirectionPac: 'asc',
			    filterPac: '',
			    form: {
			    	ingresoId: this.id,
			    	precioId: '',
			    	tratamiento: '',
					cantidad: 1,
					monto: 0,
					total: 0
			    },
			    ingresoDetalleId: ''
			}
		},
		methods: {
			onFiltered (filteredItems) {
		    	this.totalRows = filteredItems.length
		    	this.currentPage = 1
		    },
		    onFilteredPac (filteredItems) {
		    	this.totalRowsPac = filteredItems.length
		    	this.currentPagePac = 1
		    },
		    agregarTratamiento(){
		    	this.isAddTratamiento = true
		    	this.isModificarIngreso = false
		    },
		    cerrarAddTratamiento(){
		    	this.isAddTratamiento = false
		    	this.restartFormValues()
		    },
			hideModal(){
				this.$refs.myModalRef.hide()
			},
			agregarTratamientoFromModal(id, tratamiento, monto){
				this.form.precioId = id
				this.form.tratamiento = tratamiento
				this.form.monto = monto
				this.calculateTotal()
				this.hideModal()
			},
			calculateTotal(){				
				this.form.total = parseFloat(this.form.cantidad) * parseFloat(this.form.monto)				
			},
			restartFormValues(){
				this.form.precioId = ''
			    this.form.tratamiento = ''
				this.form.cantidad = 1
				this.form.monto = 0
				this.form.total = 0
				this.allerros = ''
			},
			agregarIngresoATabla(element){		
				this.record.unshift(element)				
			},
			agregarLineItem(){
				var mssgOnFail = 'Existen campos inválidos. Por favor verificalos.'
				var request = { method: 'POST', url: this.url + '/ingresos/line-item', data: this.form }
				axios(request).then((response) => {					
					if(response.data.success){
						console.log('Response:: OK')						
						this.agregarIngresoATabla({ id: response.data.last_ingreso, 
													idTratamiento: this.form.precioId, 
													tratamiento: this.form.tratamiento, 
													cantidad: this.form.cantidad, 
													monto: this.redondearADos(this.form.monto), 
													total: this.redondearADos(this.form.total) 
												})
						this.actualizarTotal(response.data.total, response.data.mg, response.data.mg_core)
						this.cerrarAddTratamiento()
						this.$toasted.show('Ingreso agregado correctamente', {
												position: 'top-center',
												className: 'toast-success',
												duration: 3500,
												containerClass: 'container-template'
											})
					}
					else if (response.data.error){
						console.log('Response:: FAIL');
						this.allerros = response.data.error
						this.$toasted.show( ( mssgOnFail ),this.toast_config)
					}
				}).catch(function (error) {
					console.log(error);
				})
			},
			agregarModificar(){
				var mssgOnFail = 'Existen campos inválidos. Por favor verificalos.'
				var request = { method: 'PUT', url: this.url + '/ingresos/line-item/' + this.ingresoDetalleId, data: this.form }				
				axios(request).then((response) => {										
					if(response.data.success){
						console.log('Response:: OK')										
						this.updateTabla(this.ingresoDetalleId,{
																  id: this.ingresoDetalleId, 
																  idTratamiento: this.form.precioId, 
																  tratamiento: this.form.tratamiento, 
																  cantidad: this.form.cantidad, 
																  monto: this.redondearADos(this.form.monto), 
																  total: this.redondearADos(this.form.total) 
																})
						this.actualizarTotal(response.data.total, response.data.mg, response.data.mg_core)
						this.cerrarAddTratamiento()
						this.$toasted.show('Ingreso modificado correctamente', {
												position: 'top-center',
												className: 'toast-success',
												duration: 3500,
												containerClass: 'container-template'
											})
						this.ingresoDetalleId = ''
					}
					else if (response.data.error){
						console.log('Response:: FAIL');
						this.allerros = response.data.error
						this.$toasted.show( ( mssgOnFail ),this.toast_config)
					}
				}).catch(function (error) {
					console.log(error);
				})
			},
			eliminarIngresoDetalle($id){
				if( confirm('¿Está seguro de eliminar este registro?') ){
					var request = { method: 'DELETE', url: this.url + '/ingresos/line-item/' + $id }				
					axios(request).then((response) => {										
						if(response.data.success){
							console.log('Response:: OK')							
							setTimeout(function () {
							    this.$toasted.show('Ingreso eliminado correctamente', {
												position: 'top-center',
												className: 'toast-success',
												duration: 3500,
												containerClass: 'container-template'})
							}.bind(this), 1500)

							window.location.href = this.url + '/ingresos/line-item/' + this.id
							this.ingresoDetalleId = ''
						}
						else if (response.data.error){
							console.log('Response:: FAIL');
							this.allerros = response.data.error
							this.$toasted.show( ( mssgOnFail ),this.toast_config)
						}
					}).catch(function (error) {
						console.log(error);
					})
				}
			},
			modificarIngresoDetalle(ingresoDetalleId, precioId, cantidad, monto){
				this.form.precioId = this.id
			    this.form.tratamiento = precioId
				this.form.cantidad = cantidad
				this.form.monto = monto
				this.form.total = parseFloat(cantidad) * parseFloat(monto)
				this.isAddTratamiento = true
				this.isModificarIngreso = true
				this.ingresoDetalleId = ingresoDetalleId				
			},
			updateTabla($act_id, $data){					
				for( var i = 0; i < this.record.length; i++ ){
					if( this.record[i].id == $act_id ){
						this.record[i] = $data
					}
				}
			},
	        redondearADos(total){
	        	return parseFloat(Math.round(total * 100) / 100).toFixed(2)
	        },
	        actualizarTotal(total, mg, mg_core){	        	
	        	this.$emit('calcular-total', total, mg, mg_core)
	        }
		}

	}
</script>