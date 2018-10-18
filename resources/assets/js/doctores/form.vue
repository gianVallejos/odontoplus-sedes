<template>
  <b-container id="container-template">
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Doctores" :items="breadcrumb" />
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
									<b-button variant="danger" v-on:click.prevent="onEliminar(
											  'A continuación eliminará el registro actual y no podrá ser recuperado.' + 
							   				  '<br /><br />¿Seguro que desea eliminar este registro?')" 
							   				  v-if="curUser.rolid == 1">
										<i class="fas fa-trash-alt"></i>&nbsp;Eliminar
									</b-button>
									<b-button variant="warning" v-on:click.prevent="onRegresar">
										<i class="fas fa-chevron-circle-left"></i>&nbsp;Regresar
									</b-button>
								</div>
							</div>

							<div class="pt-4 pb-2">
									<b-row>
										<b-col cols="6" class="pt-3 pb-4">
											<div class="form-title">
												<i class="fas fa-user"></i>
												<div class="d-inline"> Información General </div>
											</div>
											<p class="form-description fz-3 pt-3 pr-4">
												La información general de doctor nos sirve para poder identificarlo a lo largo del sistema.
											</p>
											<br/>
											<p class="form-description fz-3 pt-3 pr-4">
												<span class="help-required"> &nbsp; Campos obligatorios. </span>												
											</p>
										</b-col>
										<b-col cols="6" class="pt-3 pb-4">
										    <b-form-group label="Nombres" label-for="nombres">
											    <b-form-input id="nombres" type="text" class="required" 
											    			  v-model="form.nombres" placeholder="Nombres" autocomplete="off" :disabled=isDisabled />
												<span v-if="all_errors.nombres" :class="['label label-danger']">{{ all_errors.nombres[0] }}</span>
										    </b-form-group>
											<b-form-group label="Apellidos" label-for="apellidos">
												<b-form-input   id="apellidos" type="text" class="required" 
																v-model="form.apellidos" placeholder="Apellidos" autocomplete="off" :disabled=isDisabled />
												<span v-if="all_errors.apellidos" :class="['label label-danger']">{{ all_errors.apellidos[0] }}</span>
										    </b-form-group>
											<b-form-group label="DNI" label-for="dni">
												<b-form-input id="dni" type="text" class="required" 
												  			  v-model="form.dni" maxlength="8" placeholder="DNI" autocomplete="off" :disabled=isDisabled />
												<span v-if="all_errors.dni" :class="['label label-danger']">{{ all_errors.dni[0] }}</span>
										    </b-form-group>
											<b-form-group label="Margen de Ganancia (%)" label-for="margen_ganancia">
												<b-form-input id="margen_ganancia" type="text" 
															  v-model="form.margen_ganancia" placeholder="Margen de Ganancia (%)" 
															  autocomplete="off" :disabled=isDisabled />
												<span v-if="all_errors.margen_ganancia" :class="['label label-danger']">{{ all_errors.margen_ganancia[0] }}</span>
										    </b-form-group>				
										</b-col>
									</b-row>

									<b-row>
										<b-col cols="6" class="pt-3 pb-4">
											<div class="form-title">
												<i class="fas fa-user-md"></i>
												<div class="d-inline"> Información del Doctor </div>
											</div>
											<p class="form-description fz-3 pt-3 pr-4">
												La información del doctor nos brinda datos útiles para tener un mejor monitoreo de doctores y colaboradores.
											</p>
											<br/>
											<p class="form-description fz-3 pt-3 pr-4">
												<span class="help-required"> &nbsp; Campos obligatorios. </span>												
											</p>
										</b-col>
										<b-col cols="6" class="pt-3 pb-4">
												<b-form-group label="Fecha de Nacimiento" label-for="fechanacimiento">
													<b-form-input id="fechanacimiento" type="date" class="required" v-model="form.fechanacimiento" :disabled=isDisabled />
													<span v-if="all_errors.fechanacimiento" :class="['label label-danger']">{{ all_errors.fechanacimiento[0] }}</span>
												</b-form-group>

												<b-form-group label="Género" label-for="genero">
												    	<b-form-select id="genero" v-model="form.genero" :options="genero.options" :disabled=isDisabled />
												    	<span v-if="all_errors.genero" :class="['label label-danger']">{{ all_errors.genero[0] }}</span>
												    </b-form-group>

												<b-form-group label="Estado Civil" label-for="estado">
													<b-form-select id="estado" v-model="form.estado" :options="estadoCivil" :disabled=isDisabled />
													<span v-if="all_errors.estado" :class="['label label-danger']">{{ all_errors.estado[0] }}</span>
												</b-form-group>
										</b-col>
									</b-row>

									<b-row>
										<b-col cols="6" class="pt-3 pb-4">
											<div class="form-title">
												<i class="far fa-address-card"></i>
												<div class="d-inline">Información de Contacto</div>
											</div>
											<p class="form-description fz-3 pt-3 pr-4">
												La información de contacto del doctor es una colección de datos importantes para guardar contacto con el doctor en caso de alguna emergencia.
											</p>
											<br/>
											<p class="form-description fz-3 pt-3 pr-4">
												<span class="help-required"> &nbsp; Campos obligatorios. </span>												
											</p>
										</b-col>
										<b-col cols="6" class="pt-3 pb-4">
												<b-form-group label="Dirección" label-for="direccion">
													<b-form-input id="direccion" type="text" class="required" v-model="form.direccion" placeholder="Dirección" required autocomplete="off" :disabled=isDisabled />
													<span v-if="all_errors.direccion" :class="['label label-danger']">{{ all_errors.direccion[0] }}</span>
												</b-form-group>		
												<b-form-group label="Email" label-for="email">
													<b-form-input id="email" type="email" v-model="form.email" placeholder="Email" autocomplete="off" :disabled=isDisabled />
													<span v-if="all_errors.email" :class="['label label-danger']">{{ all_errors.email[0] }}</span>
										    </b-form-group>	
												<b-form-group label="Teléfono" label-for="telefono">
											    <b-form-input id="telefono" type="text" v-model="form.telefono" placeholder="Teléfono" :disabled=isDisabled />
											    <span v-if="all_errors.telefono" :class="['label label-danger']">{{ all_errors.telefono[0] }}</span>
										    </b-form-group>
										    <b-form-row>
										    	<b-col cols="6">
												    <b-form-group label="Celular" label-for="celular">
													    <b-form-input id="celular" type="text" v-model="form.celular" placeholder="Celular" :disabled=isDisabled />
													    <span v-if="all_errors.celular" :class="['label label-danger']">{{ all_errors.celular[0] }}</span>
												    </b-form-group>
											    </b-col>
											    <b-col cols="6">
												    <b-form-group label="Celular Alternativo" label-for="celular_aux">
													    <b-form-input id="celular_aux" type="text" v-model="form.celular_aux" placeholder="Celular Alternativo" :disabled=isDisabled  />
													    <span v-if="all_errors.celular_aux" :class="['label label-danger']">{{ all_errors.celular_aux[0] }}</span>
												    </b-form-group>
											    </b-col>
										    </b-form-row>
										</b-col>
									</b-row>

							</div>

							<div class="text-center">								
								<div v-if="displayStatus == 'show'">									
									<b-button variant="primary" v-on:click.prevent="onDisplayModificar">
										<i class="fas fa-edit"></i>&nbsp; Modificar
									</b-button>
									<b-button variant="danger" v-on:click.prevent="onEliminar(
											  'A continuación eliminará el registro actual y no podrá ser recuperado.' + 
							   				  '<br /><br />¿Seguro que desea eliminar este registro?')" 
							   				  v-if="curUser.rolid == 1">
										<i class="fas fa-trash-alt"></i>&nbsp;Eliminar
									</b-button>
									<b-button variant="warning" v-on:click.prevent="onRegresar" >
										<i class="fas fa-chevron-circle-left"></i>&nbsp;Regresar
									</b-button>
								</div>
								<div v-if="displayStatus != 'show'">	
									<b-button v-if="displayStatus == 'edit'" variant="success" v-on:click.prevent="onGuardarModificar">
										<i class="fas fa-save"></i>&nbsp; Guardar
									</b-button>						
									<b-button v-if="displayStatus == 'new'" variant="success" v-on:click.prevent="onGuardarNuevo">
										<i class="fas fa-save"></i>&nbsp; Guardar
									</b-button>
									<b-button v-if="displayStatus == 'edit'" variant="warning" v-on:click.prevent="onCancelarModificar">
										<i class="fas fa-times-circle"></i>&nbsp;Cancelar
									</b-button>
									<b-button v-if="displayStatus == 'new'" variant="warning" v-on:click.prevent="onCancelarNuevo">
										<i class="fas fa-times-circle"></i>&nbsp;Cancelar
									</b-button>
								</div>
							</div>

						</b-form>

          </div>
        </PanelCard>

			</div>
		</b-row>
  </b-container>
</template>

<script>
  import PanelCard from '../widgets/panel/panel-component.vue'
	import TitleComponent from '../widgets/titulo/index.vue'
	import axios from 'axios'

  export default{
    mounted() {     	
    	this.initActualView()
		console.log('Doctores Form Component')
    },
    name: 'Doctor-Form',
    components: {
      PanelCard,
      TitleComponent
    },
    props:[
      	'title',
      	'url',
		'record',
		'curUser',
		'view_mode'
    ],
    data(){
      return{
      	myDate: new Date(),
        form: {
				nombres: '',
				apellidos: '',
				dni: '',
				email: '',
				direccion: '',
				telefono: '',
				celular: '',
				margen_ganancia: '',
				genero: 'Masculino',
				estado: 'Soltero',
				celular_aux: '',
				fechanacimiento: this.getMyDate()
		},
		record_id: '',
		all_errors: [],
        breadcrumb: [
          { text: 'Dashboard', href: this.url },
          { text: 'Doctores', href: this.url+'/doctores' },
          { text: this.title, active: true },
		],
		displayStatus: '',
        isDisabled: false,
		genero: {
			options: [ 
						  {value: "Masculino", text: "Masculino"}, 
						  {value: "Femenino", text: "Femenino"}
			] 
		},
		estadoCivil: [
			{ value: "Soltero", text: "Soltero" },
			{ value: "Casado", text: "Casado" },
			{ value: "Viudo", text: "Viudo" },
			{ value: "Divorciado", text: "Divorciado" },
		]
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
    		this.form.nombres = this.record.nombres
			this.form.apellidos = this.record.apellidos
			this.form.dni = this.record.dni
			this.form.email = this.record.email
			this.form.direccion = this.record.direccion
			this.form.telefono = this.record.telefono
			this.form.celular = this.record.celular
			this.form.margen_ganancia = this.record.margen_ganancia
			this.form.genero = this.record.genero
			this.form.estado = this.record.estado
			this.form.celular_aux = this.record.celular_aux
			this.form.fechanacimiento = this.record.fechanacimiento

    	},
    	onGuardarNuevo(){
    		var request = { method: 'POST', url: this.url + '/doctores', data: this.form }
    		var mssgOnFail = 'Existen campos inválidos, veríficalos antes de guardar.'
    		this.onSubmit(request, mssgOnFail)    															
    	},
    	onGuardarModificar(){
    		var request = { method: 'PUT', url: this.url + '/doctores/'+ this.record_id, data: this.form }    			
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
					var request = { method: 'DELETE', url: this.url + '/doctores/' + this.record_id, data: this.form }
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
							self.toastFunctionRedirect('Éxito', 'El doctor ha sido creado correctamente. <br />Redireccionando...', 'success')
						}else if( response.data.success == 'updated' ){													
							self.toastFunction('El doctor ha sido modificado correctamente.', 'success')
							self.afterSuccessGuardar()							
						}else if (response.data.success = 'deleted' ){							
							self.form.is_active = !self.form.is_active
							self.toastFunctionRedirect('Éxito', 'El doctor ha sido eliminado correctamente. <br />Redireccionando...', 'success')
						}
					}else if (response.data.error){
						if( response.data.error == 'cantDeleted'){
							self.toastFunction('El doctor está relacionado a presupuestos activos por lo tanto no se puede eliminar.', 'error')
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
    		this.record_id = this.record_id
    		this.record.nombres = this.form.nombres
			this.record.apellidos = this.form.apellidos
			this.record.dni = this.form.dni
			this.record.email = this.form.email
			this.record.direccion = this.form.direccion
			this.record.telefono = this.form.telefono
			this.record.celular = this.form.celular
			this.record.margen_ganancia = this.form.margen_ganancia
			this.record.genero = this.form.genero
			this.record.estado = this.form.estado
			this.record.celular_aux = this.form.celular_aux
			this.record.fechanacimiento = this.form.fechanacimiento
    	},
		cleanErrosMessage(){
			this.all_errors = []
		},
		setEmptyPasswordFields(){
			this.form.password = ''
			this.form.confirm_password = ''
		},
		redireccionarToIndex(){ //Btn Regresar
			window.location.href = this.url + '/doctores'
		},
    	onRegresar(){
    		this.redireccionarToIndex()
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
		}

    }
  }

</script>