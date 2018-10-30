<template>
	<b-col cols="12" class="pt-3">				
		<PanelCard>
			<span slot="heading">Agregar Tratamientos</span>
			<div slot="body" class="pt-3 pb-3 pl-3 pr-3">
				<b-row  v-if="!isAddTratamiento" >
					<b-col cols="12" class="text-center pt-0 pb-1">
						<b-btn variant="secondary" v-on:click.prevent="agregarTratamiento()" >
							<i class="fas fa-plus"></i>&nbsp; Agregar Tratamiento
						</b-btn>
						<b-btn variant="primary" :href="this.url + '/ingresos/reporte/' + this.id" target="_blank">
							<i class="fas fa-file-alt"></i>&nbsp; Reporte
						</b-btn>
						<b-btn :href="url + '/ingresos'" variant="warning">
							<i class="fas fa-chevron-circle-left"></i>&nbsp;Regresar
						</b-btn>
					</b-col>
				</b-row>				
				<b-row class="pt-4" v-if="!isAddTratamiento" >				
					<b-table 	show-empty 
								:items="record" 
								:fields="fields" 
								:current-page="currentPage" 
								:per-page="perPage"
					            :filter="filter" 
					            :sort-by.sync="sortBy" 
					            :sort-desc.sync="sortDesc" 
					            :sort-direction="sortDirection"
					            @filtered="onFiltered"
					            empty-text="No existen campos para mostrar" >
							<template slot="actions" slot-scope="row" class="md-2">
						        <div class="actions-table" style="color: #d1d1d1" v-if="curUser.rolid == 1">							        						        	
						        	<a v-on:click="modificarIngresoDetalle( row.item.id, row.item.fecha, row.item.idDoctor, row.item.tratamiento, row.item.cantidad, row.item.monto )" class="action">Modificar</a>
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
						    <template slot="mg" slot-scope="row">
						      		S/ {{row.value }}
						    </template>
						    <template slot="mg_core" slot-scope="row">
						      		S/ {{row.value }}
						    </template>					    
					</b-table>					
				</b-row>
				<b-row v-if="!isAddTratamiento" >
				   	<b-col md="6" class="pt-3 fz-3">
				   		Mostrando {{ currentPage }} de {{ totalCurrentPages() }} páginas				
					</b-col>
					<b-col md="6" class="my-1 text-right">
					   	<b-pagination :total-rows="totalRows" :per-page="perPage" v-model="currentPage" class="float-right" />
					</b-col>
				</b-row>

				<b-row  v-if="isAddTratamiento">					
					<b-col rows="12">
						<div class="pt-3 pb-3 pl-2 pr-2" >
							<b-form-row>
								<b-col cols="3">
									<b-form-group label="Fecha" label-for="fecha">
										<b-form-input id="fecha" type="date" v-model="form.fecha"  
											    			   :disabled=isDisabled autocomplete="off" class="required" />
										<span v-if="allerros.fecha" :class="['label label-danger']">{{ allerros.fecha[0] }}</span>
									</b-form-group>
								</b-col>
								<b-col cols="9">
									<b-form-group label="Doctor">
										<b-form-select v-model="form.doctor" :disabled=isDisabled class="required" >
											<option :value="null">Ningun Doctor Seleccionado</option>
											<option v-for="(doctor, index) in doctores" :key="index" :value="doctor.id">
												{{ doctor.nombres }} {{ doctor.apellidos}}
											</option>
										</b-form-select>
										<span v-if="allerros.doctor" :class="['label label-danger']">{{ allerros.doctor[0] }}</span>
									</b-form-group>
								</b-col>								
							</b-form-row>

							<b-form-row>
								<b-col>
									<b-form-group label="Seleccionar Tratamiento" label-for="pacientes">
										<b-input-group>
									      	<b-form-input id="tratamientos" type="text" v-model="form.tratamiento" 
									      				  placeholder="Ningun Tratamiento Seleccionado" class="required" disabled />
									      	<b-input-group-append>
										    	<b-btn class="pl-3 pr-3" variant="success" v-b-modal.exampleModal >
										    		<i class="fas fa-search"></i>
										    	</b-btn>
										    </b-input-group-append>								    
									   	</b-input-group>
									   	<span v-if="allerros.tratamiento" :class="['label label-danger']">{{ allerros.tratamiento[0] }}</span>
									</b-form-group>
								</b-col>
								<b-col cols="2">
								    <b-form-group label="Cantidad" label-for="cantidad">
										<b-form-input v-on:input="calculateTotal" id="cantidad" type="text" v-model="form.cantidad" placeholder="Cantidad" autocomplete="off" class="required" :disabled=isDisabled required  />
										<span v-if="allerros.cantidad" :class="['label label-danger']">{{ allerros.cantidad[0] }}</span>
									</b-form-group>
								</b-col>
								<b-col cols="2">
									<b-form-group label="Monto" label-for="monto">
										<b-form-input v-on:input="calculateTotal" id="monto" type="text" v-model="form.monto" placeholder="Monto" autocomplete="off" class="required" :disabled=isDisabled required />
										<span v-if="allerros.monto" :class="['label label-danger']">{{ allerros.monto[0] }}</span>
									</b-form-group>
								</b-col>
								<b-col cols="2">
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
							<b-table show-empty 
									 :items="tratamientos" 
									 :fields="fieldsPac" 
									 :current-page="currentPagePac" 
									 :per-page="perPagePac" 
									 :filter="filterPac" 
									 :sort-by.sync="sortByPac" 
									 :sort-desc.sync="sortDescPac" 
									 :sort-direction="sortDirectionPac"
							         @filtered="onFilteredPac"
							         empty-text="No existen campos para mostrar" >							        
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
			'doctores',
			'id',
			'curUser'
		],
		components: {
			PanelCard
		},
		data(){
			return{
				fields: [			
					{ key: 'actions', label: '' },		    
					{ key: 'fecha', label: 'Fecha', sortable: true, sortDirection: 'desc' },
					{ key: 'nombreDoctor', label: 'Doctor', sortable: true, sortDirection: 'desc' },
				    { key: 'tratamiento', label: 'Tratamiento', sortable: true, sortDirection: 'desc' },
				    { key: 'cantidad', label: 'Cantidad', sortable: true, sortDirection: 'desc', 'class': 'text-center' },
				    { key: 'monto', label: 'Monto', sortable: true, sortDirection: 'desc', 'class': 'text-center' },
				    { key: 'total', label: 'Total', sortable: true, sortDirection: 'desc', 'class': 'text-center' },
				    { key: (this.curUser.rolid == 1) ? 'mg' : ''	, label: 'Doctor', sortable: true, sortDirection: 'desc', 'class': 'text-center' },
				    { key: (this.curUser.rolid == 1) ? 'mg_core' : ''	, label: 'CORE', sortable: true, sortDirection: 'desc', 'class': 'text-center' }				    
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
					total: 0,
					fecha: this.getMyDate(),
					doctor: null
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
				this.form.total = this.redondearADos(parseFloat(this.form.cantidad) * parseFloat(this.form.monto))				
			},
			restartFormValues(){
				this.form.precioId = ''
			    this.form.tratamiento = ''
				this.form.cantidad = 1
				this.form.monto = 0
				this.form.total = 0
				this.form.fecha = this.getMyDate()
				this.form.doctor = null
				this.allerros = ''
			},
			agregarIngresoATabla(element){		
				this.record.unshift(element)				
			},
			getDoctorId(nombreDoctor){
				for( var i = 0; i < this.doctores.length; i++ ){
					if( this.doctores[i].id == idDoctor )
						return this.doctores[i].nombres + ' ' + this.doctores[i].apellidos
				}
			},
			getDoctorName(idDoctor){
				for( var i = 0; i < this.doctores.length; i++ ){
					if( this.doctores[i].id == idDoctor )
						return this.doctores[i].nombres + ' ' + this.doctores[i].apellidos
				}
			},
			agregarLineItem(){
				var mssgOnFail = 'Existen campos inválidos. Por favor verificalos.'
				var request = { method: 'POST', url: this.url + '/ingresos/line-item', data: this.form }
				axios(request).then((response) => {					
					if(response.data.success){
						console.log('Response:: OK')		
						console.log('!!!: ' + JSON.stringify(response.data))				
						this.agregarIngresoATabla({ id: response.data.last_ingreso, 
													idTratamiento: this.form.precioId, 
													fecha: this.form.fecha,
													tratamiento: this.form.tratamiento, 
													cantidad: this.form.cantidad,
													monto: this.redondearADos(this.form.monto),
													total: this.redondearADos(this.form.total),
													idDoctor: this.form.doctor,
													nombreDoctor: this.getDoctorName(this.form.doctor),
													mg: this.redondearADos(response.data.mg),
													mg_core: this.redondearADos(response.data.mg_core)
												})
						console.log('table: ' + JSON.stringify(this.record))
						this.actualizarTotal(response.data.total)
						this.cerrarAddTratamiento()
						this.toastFunction('Ingreso agregado correctamente', 'success')						
					}
					else if (response.data.error){
						console.log('Response:: FAIL');
						this.allerros = response.data.error
						this.toastFunction(mssgOnFail, 'error')
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
																  fecha: this.form.fecha,
																  tratamiento: this.form.tratamiento, 
																  cantidad: this.form.cantidad,
																  monto: this.redondearADos(this.form.monto),
																  total: this.redondearADos(this.form.total),
																  idDoctor: this.form.doctor,
																  nombreDoctor: this.getDoctorName(this.form.doctor),
																  mg: this.redondearADos(response.data.mg),
																  mg_core: this.redondearADos(response.data.mg_core)
																})
						this.actualizarTotal(response.data.total)
						this.cerrarAddTratamiento()
						this.toastFunction('Ingreso modificado correctamente.', 'success')						
						this.ingresoDetalleId = ''
					}
					else if (response.data.error){
						console.log('Response:: FAIL');
						this.allerros = response.data.error
						this.toastFunction(mssgOnFail, 'error')
					}
				}).catch(function (error) {
					console.log(error);
				})
			},
			eliminarIngresoDetalle($id){
				this.$swal({ 
								title: '<span style="#fff; font-size: 1em" class="pt-2">Atención</span>', 
								html:  '<span style="font-size: 1em">' +
									   'A continuación eliminará el registro actual y no podrá ser recuperado.' + 
							   		   '<br /><br />¿Seguro que desea eliminar este registro?' +
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
						var request = { method: 'DELETE', url: this.url + '/ingresos/line-item/' + $id }				
						axios(request).then((response) => {										
							if(response.data.success){
								console.log('Response:: OK')					
								this.toastFunctionRedirect('Éxito', 'El registro ha sido eliminado correctamente. <br />Redireccionando...', 'success')
								this.ingresoDetalleId = ''
							}
							else if (response.data.error){
								console.log('Response:: FAIL');
								this.allerros = response.data.error
								this.toastFunction(mssgOnFail, 'error')
							}
						}).catch(function (error) {
							console.log(error);
						})
					}
				})
			},
			modificarIngresoDetalle(ingresoDetalleId, fecha, doctorId, precioId, cantidad, monto){				
				this.form.precioId = this.id
			    this.form.tratamiento = precioId
				this.form.cantidad = cantidad
				this.form.fecha = fecha
				this.form.doctor = doctorId
				this.form.monto = monto
				this.form.total = this.redondearADos(parseFloat(cantidad) * parseFloat(monto))
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
	        actualizarTotal(total){	        	
	        	this.$emit('calcular-total', total)
	        },
	      	totalCurrentPages(){
	        	var res = Math.round(this.totalRows / this.perPage)
        		if( res == 0 ) return res + 1
        		return Math.ceil(this.totalRows / this.perPage )
	      	},
			setMyDateToToday() {
				this.myDate = new Date();		      
			},
			addADayToMyDate() {
				if (this.myDate){ // as myDate can be null		        
					this.myDate = new Date(this.myDate.setDate(this.myDate.getDate()));
				}
			},
			getMyDate(){
				this.setMyDateToToday()
				this.addADayToMyDate()
				return this.myDate && this.myDate.toISOString().split('T')[0]			    	
			},
	        redondearADos(total){
	        	return parseFloat(Math.round(total * 100) / 100).toFixed(2)
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
			toastFunctionRedirect(title, msg, type){
				this.$swal({
						type: type,
						title: title,
						html: msg,
						toast: false,
						position: 'center',
						showConfirmButton: false,
		  				timer: 3000,
		  				backdrop: `rgba(0, 0, 0, 0.6)`
				}).then(() => {
					window.location.href = this.url + '/ingresos/line-item/' + this.id
				})	
			}
		}

	}
</script>