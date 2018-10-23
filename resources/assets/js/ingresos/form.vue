<template>
  <b-container id="container-template">
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Ingresos" :items="breadcrumb" />
			</div>
      <div class="col-md-12">
        <PanelCard>
          <span slot="heading">{{ title }}</span>
          <div slot="body" class="pt-3 pb-3 pl-3 pr-3">
 
						<b-form>
							<!--input type="hidden" name="_token" :value="csrf"-->
							<div class="text-center">
								<div v-if="displayStatus != 'show'">	
									<b-button v-if="displayStatus == 'edit'" type="submit" variant="success" v-on:click.prevent="onGuardarModificar">
										<i class="fas fa-save"></i>&nbsp; Guardar
									</b-button>						
									<b-button v-if="displayStatus == 'new'" type="submit" variant="success" v-on:click.prevent="onGuardarNuevo">
										<i class="fas fa-save"></i>&nbsp; Guardar
									</b-button>
									<b-button v-if="displayStatus == 'edit'" variant="warning" v-on:click.prevent="onCancelarModificar">
										<i class="fas fa-times-circle"></i>&nbsp;Cancelar
									</b-button>
									<b-button v-if="displayStatus == 'new'" variant="warning" v-on:click.prevent="onCancelarNuevo">
										<i class="fas fa-times-circle"></i>&nbsp;Cancelar
									</b-button>
								</div>
								<div v-if="displayStatus == 'show'">									
									<b-button variant="primary" v-on:click.prevent="onDisplayModificar">
										<i class="fas fa-edit"></i>&nbsp; Modificar
									</b-button>
									<!--b-button variant="danger" v-on:click.prevent="onEliminar(
											  'A continuación eliminará el registro actual y no podrá ser recuperado.' + 
							   				  '<br /><br />¿Seguro que desea eliminar este registro?')" 
							   				  v-if="curUser.rolid == 1">
										<i class="fas fa-trash-alt"></i>&nbsp;Eliminar
									</b-button-->
									<b-button variant="warning" v-on:click.prevent="onRegresar">
										<i class="fas fa-times-circle"></i>&nbsp;Cancelar
									</b-button>
								</div>
							</div>

							<div class="pt-4 pb-2">
									<b-row>
										<b-col cols="6" class="pt-3 pb-4">
											<div class="form-title">
												<i class="fas fa-file-invoice-dollar"></i>
												<div class="d-inline">Información de Ingreso</div>
											</div>
											<p class="form-description fz-3 pt-3 pr-4">
												La información de ingresos servirá para gestionar el historial financiero de un paciente según los tratamientos realizados a los largo de su historia clínica.
											</p>
											<br/>
											<p class="form-description fz-3 pt-3 pr-4">
												<span class="help-required"> &nbsp; Campos obligatorios. </span>												
											</p>
										</b-col>
										<b-col cols="6" class="pt-3 pb-4">
										    <b-form-group label="Fecha de Creación" label-for="fecha">
											    <b-form-input id="fecha" type="date" v-model="form.fecha"  
											    			   disabled autocomplete="off" />
											    <span v-if="all_errors.fecha" :class="['label label-danger']">{{ all_errors.fecha[0] }}</span>
										    </b-form-group>
												
										    <b-form-group label="Paciente" label-for="pacientes">
												<b-input-group>
											      	<b-form-input id="pacientes" type="text" v-model="form.paciente"  
											      				  :disabled=isDisabled class="required" 
											      				  placeholder="Ningun Paciente Seleccionado" disabled />
											      	<b-input-group-append>
												    	<b-btn class="pl-3 pr-3" variant="success" 
												    		   v-b-modal.pacienteModal  :disabled=isDisabled >
												    		<i class="fas fa-search"></i>
												    	</b-btn>
												    </b-input-group-append>
										    	</b-input-group>
										    	<span v-if="all_errors.paciente" :class="['label label-danger']">{{ all_errors.paciente[0] }}</span>
											</b-form-group>
										</b-col>
									</b-row>
							</div>

							<div class="text-center">
								<div v-if="displayStatus != 'show'">	
									<b-button v-if="displayStatus == 'edit'" type="submit" variant="success" v-on:click.prevent="onGuardarModificar">
										<i class="fas fa-save"></i>&nbsp; Guardar
									</b-button>						
									<b-button v-if="displayStatus == 'new'" type="submit" variant="success" v-on:click.prevent="onGuardarNuevo">
										<i class="fas fa-save"></i>&nbsp; Guardar
									</b-button>
									<b-button v-if="displayStatus == 'edit'" variant="warning" v-on:click.prevent="onCancelarModificar">
										<i class="fas fa-times-circle"></i>&nbsp;Cancelar
									</b-button>
									<b-button v-if="displayStatus == 'new'" variant="warning" v-on:click.prevent="onCancelarNuevo">
										<i class="fas fa-times-circle"></i>&nbsp;Cancelar
									</b-button>
								</div>
								<div v-if="displayStatus == 'show'">									
									<b-button variant="primary" v-on:click.prevent="onDisplayModificar">
										<i class="fas fa-edit"></i>&nbsp; Modificar
									</b-button>
									<!--b-button variant="danger" v-on:click.prevent="onEliminar(
											  'A continuación eliminará el registro actual y no podrá ser recuperado.' + 
							   				  '<br /><br />¿Seguro que desea eliminar este registro?')" 
							   				  v-if="curUser.rolid == 1">
										<i class="fas fa-trash-alt"></i>&nbsp;Eliminar
									</b-button-->
									<b-button variant="warning" v-on:click.prevent="onRegresar">
										<i class="fas fa-times-circle"></i>&nbsp;Cancelar
									</b-button>
								</div>
							</div>

						</b-form>

          </div>
        </PanelCard>

			</div>
		</b-row>
		<b-modal ref="myModalRef" id="pacienteModal" size="md" title="Lista de Pacientes">
							<b-row>
								<b-col cols="12">
									<b-input-group>
										<div class="input-group-append">
											<span class="icon-input">
				    							<i class="fas fa-search" aria-hidden="true"></i>
				    						</span>
				    					</div>
			    						<input v-model="filter" placeholder="Buscar..." type="text" class="odInput">
								    </b-input-group>
								</b-col>
								<b-col cols="12" class="pt-3 pb-2">
									<b-table 
										show-empty 
										:items="pacientes" 
										:fields="fields" 
										:current-page="currentPage" 
										:per-page="perPage" 
										:filter="filter" 
										:sort-by.sync="sortBy" 
										:sort-desc.sync="sortDesc" 
										:sort-direction="sortDirection"
							             @filtered="onFiltered"
							             empty-text="No existen campos para mostrar" >
										<template slot="nombres" slot-scope="row">							    	
									    		{{ row.value }} {{ row.item.apellidos }}							    	
									    </template>
									    <template slot="actions" slot-scope="row" class="md-2">
									        <div class="actions-table" style="color: #d1d1d1">						
									        	<a v-on:click="agregarPaciente(row.item.id, row.item.nombres, row.item.apellidos)" href="#" class="action">Seleccionar</a>
									        </div>
									    </template>
									</b-table>
								</b-col>
								<b-col cols="12" class="text-center">
									<b-pagination :total-rows="totalRows" :per-page="perPage" v-model="currentPage" class="d-inline-flex" />
								</b-col>
							</b-row>
			<b-button slot="modal-footer" variant="primary" size="sm" @click="hideModal">Cerrar</b-button>
		</b-modal>

  </b-container>
</template>

<script>
  	import PanelCard from '../widgets/panel/panel-component.vue'
	import TitleComponent from '../widgets/titulo/index.vue'
	import axios from 'axios'

  	export default{
    	mounted() { 
      		this.initActualView()
			console.log('Ingresos Form Component')	
		},
	    name: 'Ingreso-Form',
	    components: {
	      	PanelCard,
	      	TitleComponent
	    },
	    props:[
	      	'title',
	      	'url',
			'record',
			'pacientes',
			'doctores',
			'curUser',
			'view_mode'
	    ],
	    data(){
	      return{
	      	myDate: new Date(),
	        form: {
				fecha: this.getMyDate(),
				idPaciente: '',
				paciente: ''
			},
			displayStatus: '',
        	isDisabled: false,
			record_id: '',
			all_errors: [],
	        breadcrumb: [
	          { text: 'Inicio', href: this.url },
	          { text: 'Ingresos', href: this.url + '/ingresos' },
	          (this.record != null ) ? { text: 'Ingresos por Items', href: this.url + '/ingresos/line-item/' + this.record.id }	 : { text: this.title, active: true },
			],
			fields: [				    				    
				    { key: 'id', label: 'Nro', class: 'text-center' }, 			
				    { key: 'nombres', label: 'Nombre de Paciente', sortable: true, sortDirection: 'desc' },
				    { key: 'actions', label: '', sortable: false },				    
			    ],
			currentPage: 1,
			perPage: 10,
			totalRows: 0,
			pageOptions: [ 5, 10, 15 ],
			sortBy: null,
			sortDesc: false,
			sortDirection: 'asc',
			filter: '',
			isDelete: false,
			display: ''
	      }	      
	    },
	    methods:{
	    		initActualView(){    		
					this.displayStatus = this.view_mode
			    	if( this.displayStatus == 'new' ){
			    		this.onDisplayNuevo()
			    	}else if( this.displayStatus == 'show' ){
			    		this.onDisplayDetalle()
			    	}else if( this.displayStatus == 'edit' ){
			    		this.onDisplayModificar()
			    		this.setControllerDataToForms()
			    	}     	   
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
		    	onDisplayNuevo(){    		
		    		this.displayStatus = 'new'
					this.setEnableForm()
		    	}, 
		    	onDisplayDetalle(){
		    		this.displayStatus = 'show'
					this.setDisableForm()
					this.setControllerDataToForms()

		    	},	
		    	onDisplayModificar(){
		    		this.displayStatus = 'edit'
		    		this.setEnableForm()			
		    	},
		    	setEnableForm(){
		    		this.isDisabled = false
		    	},
		    	setDisableForm(){
		    		this.isDisabled = true
		    	},
		    	setControllerDataToForms(){
		    		this.record_id = this.record.id
					this.form.fecha = this.record.fecha
					this.form.idPaciente = this.record.hc
					this.form.paciente = this.record.nombrePaciente				
		    	},
		    	onGuardarNuevo(){
		    		var request = { method: 'POST', url: this.url + '/ingresos', data: this.form }
		    		var mssgOnFail = 'Existen campos inválidos, veríficalos antes de guardar.'
		    		this.onSubmit(request, mssgOnFail)    															
		    	},
		    	onGuardarModificar(){
		    		var request = { method: 'PUT', url: this.url + '/ingresos/'+ this.record_id, data: this.form }    			
		    		var mssgOnFail = 'Existen campos inválidos, veríficalos antes de guardar.'
		    		this.onSubmit(request, mssgOnFail)
		    	},
		    	onEliminar(msg){
		    		this.$swal({ 
								title: '<span style="#fff; font-size: 1em" class="pt-2">Atención</span>', 
								html:  '<span style="font-size: 1em">' + msg +
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
							var request = { method: 'DELETE', url: this.url + '/ingresos/' + this.record_id, data: this.form }
			    			var mssgOnFail = 'Ha ocurrido un error al eliminar este registro.'
			    			this.onSubmit(request, mssgOnFail)  
						}	
					})
		    	},
				onSubmit(request, error_msg) {
					self = this
					if(request){
						axios(request).then((response) => {
							if(response.data.success){
								console.log('Response:: OK')
								if( response.data.success == 'created' ){							
									self.setDisableForm()
									self.toastFunctionRedirect('Éxito', 'El ingreso ha sido creado correctamente. <br />Redireccionando...', 'success')
								}else if( response.data.success == 'updated' ){													
									self.toastFunction('El ingreso ha sido modificado correctamente.', 'success')
									self.afterSuccessGuardar()							
								}else if (response.data.success = 'deleted' ){							
									self.form.is_active = !self.form.is_active
									self.toastFunctionRedirect('Éxito', 'El ingreso ha sido eliminado correctamente. <br />Redireccionando...', 'success')
								}
							}else if (response.data.error){
								if( response.data.error == 'cantDeleted'){
									self.toastFunction('El ingreso tiene tratamientos agregados por lo tanto no se puede eliminar.', 'error')
								}else{
									console.log('Response:: FAIL');
									self.all_errors = response.data.error
									self.toastFunction(error_msg, 'error')
								}
							}
						}).catch(function (error) {
							self.toastFunction('Ha ocurrido un error crítico, por favor comunicarse con Odontoplus.pe.', 'error')
						});
					}
				},
				afterSuccessGuardar(){	
					this.displayStatus = 'show'
					this.setDisableForm()
					this.setFormDataToUser()
					this.cleanErrosMessage()
					this.setEmptyPasswordFields()
				},
		    	setFormDataToUser(){
		    		this.record.id = this.record_id
					this.record.fecha = this.form.fecha
					this.record.idPaciente = this.form.hc
					this.record.paciente = this.form.nombrePaciente
		    	},
				cleanErrosMessage(){
					this.all_errors = []
				},
				setEmptyPasswordFields(){
					this.form.password = ''
					this.form.confirm_password = ''
				},
				redireccionarToIndex(){ //Btn Regresar
					window.location.href = this.url + '/ingresos'
				},
		    	onRegresar(){
		    		window.location.href = this.url + '/ingresos/line-item/' + this.record.id
		    	},
				onCancelarModificar(){
					this.displayStatus = 'show'
					this.setControllerDataToForms()
					this.setDisableForm()
					this.cleanErrosMessage()
					this.setEmptyPasswordFields()
				},
				onCancelarNuevo(){
					this.redireccionarToIndex()
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
						this.redireccionarToIndex()
					})	
				},
				hideModal(){
					this.$refs.myModalRef.hide()
				},
				onFiltered (filteredItems) {
			      this.totalRows = filteredItems.length
			      this.currentPage = 1
			    },
			    agregarPaciente(id, nombres, apellidos){
			    	//alert(id)
			    	this.form.idPaciente = id
			    	this.form.paciente = nombres + ' ' + apellidos
			    	this.$refs.myModalRef.hide()
			    }

	    }
    }

</script>