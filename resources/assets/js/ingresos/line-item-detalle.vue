<template>
	<b-col cols="12" class="pt-3">
		<SpinnerContainer :url="url" ref="spinnerContainerRef" />
		<PanelCard>
			<span slot="heading">Agregar Tratamientos</span>
			<div slot="body" class="pt-3 pb-3 pl-3 pr-3">
				<b-row  v-if="!isAddTratamiento" >
					<b-col cols="12" class="text-center pt-0 pb-1">
						<b-btn variant="success" v-on:click.prevent="agregarTratamiento()" >
							<i class="fas fa-plus"></i>&nbsp; Registrar Pago
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
											responsive
											stacked="md"
					            empty-text="No existen campos para mostrar"
											empty-filtered-text="No existen pacientes que coincidan con la búsqueda">
							<template slot="actions" slot-scope="row">
						        <div class="actions-table">
						        	<a  v-if="curUser.rolid == 1 || curUser.rolid == 2 " v-on:click="modificarIngresoDetalle( row.item.id, row.item.fecha, row.item.idDoctor, row.item.tratamiento,
																															row.item.cantidad, row.item.monto, row.item.codigo, row.item.tipo_pago, row.item.sede )" class="action">Modificar</a>
						        	<a  v-if="curUser.rolid == 1 " v-on:click="eliminarIngresoDetalle(row.item.id)" class="action">Eliminar</a>
						        </div>
						    </template>
								<template slot="fecha" slot-scope="row">
						      	{{ row.value }}
						    </template>
								<template slot="nombreDoctor" slot-scope="row">
						      	{{ row.value }}
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
						<div class="pt-0 pt-lg-3 pb-3 pl-2 pr-2" >
							<b-form-row>
								<b-col cols="6" lg="2">
									<b-form-group label="Fecha" label-for="fecha">
										<b-form-input id="fecha" type="date" v-model="form.fecha"
											    			   :disabled=isDisabled autocomplete="off" class="required" />
										<span v-if="allerros.fecha" :class="['label label-danger']">{{ allerros.fecha[0] }}</span>
									</b-form-group>
								</b-col>
								<b-col cols="6" lg="2">
									<b-form-group label="Código" label-for="codigo">
										<b-form-input id="codigo" type="text" v-model="form.codigo" placeholder="Código de Boleta/Factura"
																	 :disabled=isDisabled autocomplete="off" />
										<span v-if="allerros.codigo" :class="['label label-danger']">{{ allerros.codigo[0] }}</span>
									</b-form-group>
								</b-col>
								<b-col cols="6" lg="2">
									<b-form-group label="Tipo de Pago" label-for="tipo_pago">
										<b-form-select id="tipo_pago" v-model="form.tipo_pago" :options="tipo_pago.options" :disabled=isDisabled />
										<span v-if="allerros.tipo_pago" :class="['label label-danger']">{{ allerros.tipo_pago[0] }}</span>
									</b-form-group>
								</b-col>
								<b-col cols="6" lg="2">
									<b-form-group label="Sede">
										<b-form-select v-model="form.sede" class="required" >
											<option v-for="(sede, index) in sedes" :key="index" :value="sede.id">
												{{ sede.nombre }}
											</option>
										</b-form-select>
										<span v-if="allerros.sede" :class="['label label-danger']">{{ allerros.sede[0] }}</span>
									</b-form-group>
								</b-col>
								<b-col cols="12" lg="4">
									<b-form-group label="Doctor">
										<b-form-select v-model="form.doctor" :disabled=isModificarIngreso class="required" >
											<option :value="null">Ningun Doctor Seleccionado</option>
											<option v-for="(doctor, index) in doctores" :key="index" :value="doctor.id">
												{{ doctor.nombres }} {{ doctor.apellidos}}
											</option>
										</b-form-select>
										<span v-if="allerros.doctor" :class="['label label-danger']">{{ allerros.doctor[0] }}</span>
									</b-form-group>
								</b-col>
							</b-form-row>

							<div v-for="trat in form.trats">
								<b-form-row>
									<b-col>
										<b-form-group label="Seleccionar Tratamiento" label-for="pacientes">
											<b-input-group>
										      	<b-form-input id="tratamientos" type="text" v-model="trat.tratamiento"
										      				  placeholder="Ningun Tratamiento Seleccionado" class="required" disabled />
										      	<b-input-group-append>
											    	<b-btn class="pl-3 pr-3" variant="success" @click="abrirModalBuscarTratamientos(trat.id)" >
											    		<i class="fas fa-search"></i>
											    	</b-btn>
											    </b-input-group-append>
										   	</b-input-group>
										   	<span v-if="allerros.tratamiento" :class="['label label-danger']">{{ allerros.tratamiento[0] }}</span>
										</b-form-group>
									</b-col>
									<b-col cols="2">
									    <b-form-group label="Cantidad" label-for="cantidad">
											<b-form-input v-on:input="calculateTotal(trat.id)" id="cantidad" type="text" v-model="trat.cantidad" placeholder="Cantidad" autocomplete="off" class="required" :disabled=isDisabled required  />
											<span v-if="allerros.cantidad" :class="['label label-danger']">{{ allerros.cantidad[0] }}</span>
										</b-form-group>
									</b-col>
									<b-col cols="2">
										<b-form-group label="Monto" label-for="monto">
											<b-form-input v-on:input="calculateTotal(trat.id)" id="monto" type="text" v-model="trat.monto" placeholder="Monto" autocomplete="off" class="required" :disabled=isDisabled required />
											<span v-if="allerros.monto" :class="['label label-danger']">{{ allerros.monto[0] }}</span>
										</b-form-group>
									</b-col>
									<b-col cols="2">
										<b-form-group label="Total" label-for="total">
											<b-form-input id="total" type="text" v-model="trat.total" placeholder="Total" autocomplete="off" disabled />
											<span v-if="allerros.total" :class="['label label-danger']">{{ allerros.total[0] }}</span>
										</b-form-group>
									</b-col>
								</b-form-row>
							</div>

							<b-col cols="12" class="text-right pr-0">
								<b-form-group v-if="!isModificarIngreso">
									<b-btn @click="addTrat" variant="secondary">
										<i class="fas fa-plus"></i> Otro Tratamiento
									</b-btn>
									<b-btn @click="removeTrat" variant="warning">
										<i class="fas fa-eraser"></i> Limpiar
									</b-btn>
								</b-form-group>
							</b-col>

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

				<b-modal ref="tratamientosModal" id="tratamientosModal" size="md" title="Lista de Tratamientos" no-fade>
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
									 	stacked="md"
										responsive
							      @filtered="onFilteredPac"
							      empty-text="No existen campos para mostrar"
										empty-filtered-text="No existen pacientes que coincidan con la búsqueda" >
									<template slot="id" slot-scope="row">
											<a v-on:click.prevent="agregarTratamientoFromModal(row.item.id, row.item.detalle, row.item.monto, row.item.costo_variable)" href="#" class="link-color">{{ row.value }}</a>
									</template>
									<template slot="detalle" slot-scope="row">
										 <a v-on:click.prevent="agregarTratamientoFromModal(row.item.id, row.item.detalle, row.item.monto, row.item.costo_variable)" href="#" class="link-color">{{ row.value }}</a>
									</template>
									<template slot="monto" slot-scope="row">
									    S/ {{ row.value }}
									</template>
									<template slot="actions" slot-scope="row" class="md-2">
									    <div class="actions-table" style="color: #d1d1d1">
									       <a v-on:click.prevent="agregarTratamientoFromModal(row.item.id, row.item.detalle, row.item.monto, row.item.costo_variable)" href="#" class="action">Seleccionar</a>
									    </div>
									</template>
							</b-table>
						</b-col>
						<b-col cols="12" class="text-center">
							<b-pagination :total-rows="totalRowsPac" :per-page="perPagePac" v-model="currentPagePac" class="d-inline-flex" />
						</b-col>
					</b-row>
					<div slot="modal-footer">
						<b-button  variant="secondary" size="sm" :href="url + '/tratamientos/create'">
							<i class="fas fa-plus"></i>&nbsp; Nuevo Tratamiento
						</b-button>
						<b-button variant="primary" size="sm" @click="hideModal">
							<i class="fas fa-times"></i>&nbsp; Cerrar
						</b-button>
					</div>
				</b-modal>

			</div>
		</PanelCard>
	</b-col>
</template>
<script>
	import PanelCard from '../widgets/panel/panel-component.vue'
	import SpinnerContainer from '../widgets/spinner/spinner-container.vue'
	import axios from 'axios'

	export default{
		props:[
			'url',
			'ingreso',
			'record',
			'tratamientos',
			'doctores',
			'sedes',
			'id',
			'curUser',
			'presupuesto_id'
		],
		components: {
			PanelCard,
			SpinnerContainer
		},
		data(){
			return{
				fields: [
						{ key: 'actions', label: 'Acción', 'class': 'td-with-action' },
						{ key: 'fecha', label: 'Fecha', sortable: true, sortDirection: 'desc' },
						{ key: 'codigo', label: 'Código', sortable: true, sortDirection: 'desc', class: 'd-none d-lg-table-cell' },
						{ key: 'tipo_pago_nombre', label: 'Pago', sortable: true, class: 'd-none d-lg-block', sortDirection: 'desc' },
						{ key: 'nombre_sede', label: 'Sede', sortable: true, sortDirection: 'desc' },
						{ key: 'nombreDoctor', label: 'Doctor', sortable: true, sortDirection: 'desc', 'class': 'td-width d-none d-lg-table-cell' },
						{ key: 'tratamiento', label: 'Tratamiento', sortable: true, sortDirection: 'desc', 'class': 'td-width-trat' },
						{ key: 'cantidad', label: 'Cant.', sortable: true, sortDirection: 'desc', 'class': 'text-left text-lg-center' },
						{ key: 'monto', label: 'Monto', sortable: true, sortDirection: 'desc', 'class': 'text-left text-lg-center' },
						{ key: 'total', label: 'Total', sortable: true, sortDirection: 'desc', 'class': 'text-left text-lg-center' },
				    // { key: (this.curUser.rolid == 1) ? 'mg' : ''	, label: 'Doctor', sortable: true, sortDirection: 'desc', 'class': 'text-center' },
				    // { key: (this.curUser.rolid == 1) ? 'mg_core' : ''	, label: 'Empresa', sortable: true, sortDirection: 'desc', 'class': 'text-center' }
			    ],
			    currentPage: 1,
			   	perPage: 7,
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
					{ key: 'id', label: 'Nro', class: 'text-left text-md-center' },
				    { key: 'detalle', label: 'Tratamiento', sortable: true, sortDirection: 'desc' },
				    { key: 'monto', label: 'Monto', 'class': 'text-left text-md-center' },
				    { key: 'actions', label: '', sortable: false }
			    ],
	    		tipo_pago: {
	    			options: [
	    						  {value: "1", text: "Efectivo"},
	    						  {value: "2", text: "Tarjeta Débito"},
	                  {value: "3", text: "Tarjeta Crédito"}
	    			]
	    		},
			    currentPagePac: 1,
			   	perPagePac: 7,
			    totalRowsPac: 0,
			    pageOptionsPac: [ 5, 10, 15 ],
			    sortByPac: null,
			    sortDescPac: false,
			    sortDirectionPac: 'asc',
			    filterPac: '',
					trat_id_general: null,
			    form: {
			    	ingresoId: this.id,
						codigo: '',
						tipo_pago: 1,
						trats: [{id: 0, precioId: '', tratamiento: '', cantidad: 1, monto: 0, costo_variable: 0, total: 0}],
						cantidad: 1,
						monto: 0,
						total: 0,
						igv : 0,
						fecha: this.getMyDate(),
						sede: this.ingreso.pacienteSedeId,
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
			 this.form.sede = this.ingreso.pacienteSedeId
		   this.isAddTratamiento = true
		   this.isModificarIngreso = false
		  },
		  cerrarAddTratamiento(){
		   this.isAddTratamiento = false
		   this.restartFormValues()
		  },
			abrirModalBuscarTratamientos(id){
				this.trat_id_general = id
				this.$refs.tratamientosModal.show()
			},
			hideModal(){
				this.trat_id_general = null
				this.$refs.tratamientosModal.hide()
			},
			addTrat(){
				this.form.trats.push({id: this.form.trats.length, precioId: '', tratamiento: '', cantidad: 1, monto: 0, costo_variable: 0, total: 0})
			},
			removeTrat(){
				this.form.trats = []
				this.form.trats = [{id: 0, precioId: '', tratamiento: '', cantidad: 1, monto: 0, costo_variable: 0, total: 0}]
			},
			agregarTratamientoFromModal(id, tratamiento, monto, costo_variable){
				if( this.trat_id_general != null ){
					this.form.trats[this.trat_id_general].precioId = id
					this.form.trats[this.trat_id_general].tratamiento = tratamiento
					this.form.trats[this.trat_id_general].monto = monto
					this.form.trats[this.trat_id_general].costo_variable = costo_variable
					console.log(JSON.stringify(this.form))
					this.calculateTotal(this.trat_id_general)
					this.hideModal()
				}else{
					this.toastFunction('Ha ocurrido un error, consultar con Odontoplus', 'error')
				}
			},
			calculateTotal(id){
					var res = this.redondearADos(parseFloat(this.form.trats[id].cantidad) * parseFloat(this.form.trats[id].monto))
					if( !isNaN(res) ){
						this.form.trats[id].total = res
					}
			},
			restartFormValues(){
				this.removeTrat()
				// this.form.precioId = ''
			  // this.form.tratamiento = ''
				// this.form.cantidad = 1
				// this.form.monto = 0
				// this.form.total = 0

				this.form.fecha = this.getMyDate()
				this.form.doctor = null
				this.form.codigo = ''
				this.form.tipo_pago = 1
				this.form.sede = 1
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
				if( this.validarTratamientos() ){
					var mssgOnFail = 'Existen campos inválidos. Por favor verificalos.'
					this.form.igv = this.form.codigo !== '' ? 18 : 0;
					var request = { method: 'POST', url: this.url + '/ingresos/line-item', data: this.form }
					this.$refs.spinnerContainerRef.showSpinner()
					var _self = this
					axios(request).then((response) => {
            console.log(response.data);
						if(response.data.success){
							_self.toastFunctionRedirect('Éxito', 'Los tratamientos han sido agregado correctamente.', 'success')
							_self.$refs.spinnerContainerRef.hideSpinner()
						}
						else if (response.data.error){
							_self.allerros = response.data.error
							_self.toastFunction(mssgOnFail, 'error')
							_self.$refs.spinnerContainerRef.hideSpinner()
						}
					}).catch(function (error) {
            console.log(error);
						_self.$refs.spinnerContainerRef.hideSpinner()
					})
				}
			},
			validarTratamientos(){
				if( this.form.fecha == '' ){
						this.toastFunction('Debe seleccionar una fecha para guardar los ingresos', 'error')
						return false
				}
				if( this.form.doctor == null ){
						this.toastFunction('Debe seleccionar un doctor guardar los ingresos', 'error')
						return false
				}
				for( var i = 0; i < this.form.trats.length; i++ ){
						if( this.form.trats[i].precioId == '' ){
								this.toastFunction('Debe seleccionar un tratamiento, en la línea '+ (i+1), 'error')
								return false
						}else if( this.form.trats[i].cantidad == '' ){
								this.toastFunction('Debe seleccionar una cantidad, en la línea '+ (i+1), 'error')
								return false
						}else if( this.form.trats[i].monto == '' ){
								this.toastFunction('Debe seleccionar un monto, en la línea '+ (i+1), 'error')
								return false
						}else if( this.form.trats[i].cantidad < 0 ){
								this.toastFunction('La cantidad debe ser un número positivo, en la línea '+ (i+1), 'error')
								return false
						}else if( this.form.trats[i].monto < 0 ){
								this.toastFunction('El monto debe ser un número positivo, en la línea '+ (i+1), 'error')
								return false
						}else if( isNaN(this.form.trats[i].cantidad) ){
								this.toastFunction('La cantidad debe ser únicamente un número, en la línea '+ (i+1), 'error')
								return false
						}else if( isNaN(this.form.trats[i].monto) ){
								this.toastFunction('El monto debe ser únicamente un número, en la línea '+ (i+1), 'error')
								return false
						}
				}
				return true
			},
			agregarModificar(){
				if( this.validarTratamientos() ){
					var mssgOnFail = 'Existen campos inválidos. Por favor verificalos.'
					this.form.igv = this.form.codigo !== '' ? 18 : 0;
					var request = { method: 'PUT', url: this.url + '/ingresos/line-item/' + this.ingresoDetalleId, data: this.form }
					this.$refs.spinnerContainerRef.showSpinner()
					var self = this
					axios(request).then((response) => {
						if(response.data.success){
							self.updateTabla(this.ingresoDetalleId,{
																	  id: this.ingresoDetalleId,
																	  idTratamiento: this.form.trats[0].precioId,
																	  fecha: this.form.fecha,
																	  tratamiento: this.form.trats[0].tratamiento,
																	  cantidad: this.form.trats[0].cantidad,
																	  monto: this.redondearADos(this.form.trats[0].monto),
																	  total: this.redondearADos(this.form.trats[0].total),
																	  idDoctor: this.form.doctor,
																	  nombreDoctor: this.getDoctorName(this.form.doctor),
																		sede: this.form.sede,
																		codigo: this.form.codigo,
																		tipo_pago: this.form.tipo_pago,
																	  mg: this.redondearADos(response.data.mg),
																	  mg_core: this.redondearADos(response.data.mg_core)
																	})
							self.actualizarTotal(response.data.total)
							self.cerrarAddTratamiento()
							self.toastFunction('Ingreso modificado correctamente.', 'success')
							self.ingresoDetalleId = ''
							self.$refs.spinnerContainerRef.hideSpinner()
						}
						else if (response.data.error){
							self.allerros = response.data.error
							self.toastFunction(mssgOnFail, 'error')
							self.$refs.spinnerContainerRef.hideSpinner()
						}
					}).catch(function (error) {
						self.$refs.spinnerContainerRef.hideSpinner()
					})
				}
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
						this.$refs.spinnerContainerRef.showSpinner()
						axios(request).then((response) => {
							if(response.data.success){
								this.toastFunctionRedirect('Éxito', 'El registro ha sido eliminado correctamente.', 'success')
								this.ingresoDetalleId = ''
								this.$refs.spinnerContainerRef.hideSpinner()
							}
							else if (response.data.error){
								this.allerros = response.data.error
								this.toastFunction(mssgOnFail, 'error')
								this.$refs.spinnerContainerRef.hideSpinner()
							}
						}).catch(function (error) {
							this.$refs.spinnerContainerRef.hideSpinner()
						})
					}
				})
			},
			modificarIngresoDetalle(ingresoDetalleId, fecha, doctorId, tratamiento, cantidad, monto, codigo, tipo_pago, sedeId){
					this.form.trats[0].id = 0
					this.form.trats[0].precioId = this.getIdTratamientoByNombre(tratamiento)
			    this.form.trats[0].tratamiento = tratamiento
					this.form.trats[0].cantidad = cantidad
					this.form.trats[0].monto = monto
					this.form.trats[0].total = this.redondearADos(parseFloat(cantidad) * parseFloat(monto))
					this.form.fecha = fecha
					this.form.doctor = doctorId
					this.form.codigo = codigo
					this.form.tipo_pago = tipo_pago
					this.form.sede = sedeId
					this.isAddTratamiento = true
					this.isModificarIngreso = true
					this.ingresoDetalleId = ingresoDetalleId
			},
			getIdTratamientoByNombre(nombre){
					for(var i = 0; i < this.tratamientos.length; i++ ){
						if( this.tratamientos[i].detalle == nombre){
							return this.tratamientos[i].id
						}

					}
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
		  				timer: 4000
				})
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
					window.location.reload(true)
					//window.location.href = this.url + '/ingresos/line-item/' + this.id
				})
			}
		}

	}
</script>
<style lang="stylus">
	.td-with-action{
		width: 78px
	}
	.td-width{
		width: 150px
	}
	.td-width-trat{
		width: 180px
	}
	@media (max-width: 992px)
		.td-with-action
			width: auto!important
		.td-width
			width: auto!important
		.td-width-trat
			width: auto!important
		
</style>
