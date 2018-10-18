<template>
  <b-container id="container-template">
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Tratamientos" :items="breadcrumb" />
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
												<i class="fas fa-tooth"></i>
												<div class="d-inline"> Información de Tratamiento</div>
											</div>
											<p class="form-description fz-3 pt-3 pr-4">
												La información de un tratamiento se utilizará para identificarlo en presupuestos.
												<br />Al crear un tratamiento, el precio estandar será asignado a todas las empresas registradas en el sistema.
												<br />Los precios pueden ser modificados por empresa en la sección de <a :href="url + '/precios'">precios</a>.
											</p>
											<br/>
											<p class="form-description fz-3 pt-3 pr-4">
												<span class="help-required"> &nbsp; Campos obligatorios. </span>												
											</p>
										</b-col>
										<b-col cols="6" class="pt-3 pb-4">
										    <b-form-group label="Nombre de Tratamiento" label-for="detalle">
											    <b-form-input id="detalle" type="text" class="required" v-model="form.detalle" 
											    			  :disabled=isDisabled placeholder="Nombre de Tratamiento" autocomplete="off"/>
													<span v-if="all_errors.detalle" :class="['label label-danger']">{{ all_errors.detalle[0] }}</span>
										    </b-form-group>
										    <b-form-group label="Precio Estándar" label-for="precio_estandar" v-if="displayStatus == 'new'">
											    <b-form-input id="precio_estandar" type="number" step="0.1" class="required" v-model="form.precio_estandar" 
											    			  :disabled=isDisabled placeholder="Precio Estandar" autocomplete="off"/>
													<span v-if="all_errors.precio_estandar" :class="['label label-danger']">{{ all_errors.precio_estandar[0] }}</span>
										    </b-form-group>	
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
    	console.log(JSON.stringify(this.record))
    	this.initActualView()
		console.log('Tratamiento Form Component')	

    },
    name: 'Tratamiento-Form',
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
        form: {
				detalle: '',
				precio_estandar: ''
		},
		record_id: '',
		all_errors: [],
        breadcrumb: [
          { text: 'Dashboard', href: this.url },
          { text: 'Tratamientos', href: this.url + '/tratamientos' },
          { text: this.title, active: true },
		],
		displayStatus: '',
        isDisabled: false
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
				this.form.detalle = this.record.detalle
	    	},
	    	onGuardarNuevo(){
	    		var request = { method: 'POST', url: this.url + '/tratamientos', data: this.form }
	    		var mssgOnFail = 'Existen campos inválidos, veríficalos antes de guardar.'
	    		this.onSubmit(request, mssgOnFail)    															
	    	},
	    	onGuardarModificar(){
	    		var request = { method: 'PUT', url: this.url + '/tratamientos/'+ this.record_id, data: this.form }    			
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
						var request = { method: 'DELETE', url: this.url + '/tratamientos/' + this.record_id, data: this.form }
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
								self.toastFunctionRedirect('Éxito', 'El tratamiento ha sido creado correctamente. <br />Redireccionando...', 'success')
							}else if( response.data.success == 'updated' ){													
								self.toastFunction('El tratamiento ha sido modificado correctamente.', 'success')
								self.afterSuccessGuardar()							
							}else if (response.data.success = 'deleted' ){							
								self.form.is_active = !self.form.is_active
								self.toastFunctionRedirect('Éxito', 'El tratamiento ha sido eliminado correctamente. <br />Redireccionando...', 'success')
							}
						}else if (response.data.error){
							if( response.data.error == 'cantDeleted'){
								self.toastFunction('El tratamiento está relacionado a presupuestos activos por lo tanto no se puede eliminar.', 'error')
							}else if(response.data.error == 'commitFailed'){
								self.toastFunction('Ha ocurrido un error al insertar el tratamiento o sus precios')
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
				this.record.detalle = this.form.detalle
	    	},
			cleanErrosMessage(){
				this.all_errors = []
			},
			setEmptyPasswordFields(){
				this.form.password = ''
				this.form.confirm_password = ''
			},
			redireccionarToIndex(){ //Btn Regresar
				window.location.href = this.url + '/tratamientos'
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