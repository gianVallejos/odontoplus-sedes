<template>
  <b-container id="container-template" v-if="this.$root.autorizadoVerSedes(curUser.schema)">
    <SpinnerContainer :url="url" ref="spinnerContainerRef" />
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Sedes" :items="breadcrumb" />
			</div>
      <div class="col-md-12 pt-1">
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
							   				  v-if="curUser.rolid == 1 && this.record_id != 1">
										<i class="fas fa-trash-alt"></i>&nbsp;Eliminar
									</b-button>
									<b-button variant="warning" v-on:click.prevent="onRegresar">
										<i class="fas fa-chevron-circle-left"></i>&nbsp;Regresar
									</b-button>
								</div>
							</div>
              <p class="form-description fz-3 pt-3 pr-1">
                <span class="help-required"> &nbsp; Campos obligatorios. </span>
              </p>
							<div class="pt-3 pb-2">
									<b-row>
										<b-col cols="12" class="pt-0 pb-0 d-none d-lg-block">
											<div class="form-title">
												<i class="far fa-building"></i>
												<div class="d-inline"> Información de Sede </div>
											</div>
										</b-col>
										<b-col cols="12" class="pt-0 pt-lg-2 pb-0 pb-lg-4">
                      <b-form-row>
                        <b-col cols="12" lg="6">
										    <b-form-group label="Nombre" label-for="nombre">
											    <b-form-input id="nombre" type="text" class="required" v-model="form.nombre"
														:disabled=isDisabled placeholder="Nombre" autocomplete="off"/>
													<span v-if="all_errors.nombre" :class="['label label-danger']">{{ all_errors.nombre[0] }}</span>
										    </b-form-group>
                      </b-col>
                      <b-col cols="12" lg="6">
										    <b-form-group label="Dirección" label-for="direccion">
											    <b-form-input id="direccion" type="text"	v-model="form.direccion" class="required"
														:disabled=isDisabled placeholder="Dirección" autocomplete="off"/>
													<span v-if="all_errors.direccion" :class="['label label-danger']">{{ all_errors.direccion[0] }}</span>
										    </b-form-group>
                      </b-col>
                      <b-col cols="12" lg="6">
												<b-form-group label="Ciudad" label-for="ciudad">
													<b-form-input id="ciudad" type="text"	v-model="form.ciudad" class="required"
														:disabled=isDisabled placeholder="Ciudad" autocomplete="off"/>
													<span v-if="all_errors.ciudad" :class="['label label-danger']">{{ all_errors.ciudad[0] }}</span>
												</b-form-group>
                      </b-col>
                      <b-col cols="12" lg="6">
												<b-form-group label="Teléfono" label-for="telefono">
													<b-form-input id="telefono" type="text"	v-model="form.telefono"
														:disabled=isDisabled placeholder="Teléfono" autocomplete="off"/>
													<span v-if="all_errors.telefono" :class="['label label-danger']">{{ all_errors.telefono[0] }}</span>
												</b-form-group>
                      </b-col>
                      <b-col cols="12" lg="3">
												<b-form-group label="Celular" label-for="celular">
													<b-form-input id="celular" type="text"	v-model="form.celular"
														:disabled=isDisabled placeholder="Celular" autocomplete="off"/>
													<span v-if="all_errors.celular" :class="['label label-danger']">{{ all_errors.celular[0] }}</span>
												</b-form-group>
                      </b-col>
                      <b-col cols="12" lg="3">
												<b-form-group label="Celular Auxiliar" label-for="celular_aux">
													<b-form-input id="celular_aux" type="text"	v-model="form.celular_aux"
														:disabled=isDisabled placeholder="Celular Auxiliar" autocomplete="off"/>
													<span v-if="all_errors.celular_aux" :class="['label label-danger']">{{ all_errors.celular_aux[0] }}</span>
												</b-form-group>
                      </b-col>
                      <b-col cols="12" lg="6">
												<b-form-group label="Email" label-for="email">
													<b-form-input id="email" type="text"	v-model="form.email"
														:disabled=isDisabled placeholder="Email" autocomplete="off"/>
													<span v-if="all_errors.email" :class="['label label-danger']">{{ all_errors.email[0] }}</span>
												</b-form-group>
                      </b-col>
                      </b-form-row>
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
									<b-button variant="danger" v-on:click.prevent="onEliminar(
											  'A continuación eliminará el registro actual y no podrá ser recuperado.' +
							   				  '<br /><br />¿Seguro que desea eliminar este registro?')"
							   				  v-if="curUser.rolid == 1 && this.record_id != 1">
										<i class="fas fa-trash-alt"></i>&nbsp;Eliminar
									</b-button>
									<b-button variant="warning" v-on:click.prevent="onRegresar">
										<i class="fas fa-chevron-circle-left"></i>&nbsp;Regresar
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
  import SpinnerContainer from '../widgets/spinner/spinner-container.vue'
	import axios from 'axios'

  export default{
    mounted() {
    	this.initActualView()
    },
    name: 'Sede-Form',
    components: {
      	PanelCard,
      	TitleComponent,
        SpinnerContainer
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
					nombre: '',
					ciudad: '',
					direccion: '',
					telefono: '',
					celular: '',
					celular_aux: '',
					email: ''
		},
		displayStatus: '',
        isDisabled: false,
		record_id: '',
		all_errors: [],
        breadcrumb: [
          { text: 'Inicio', href: this.url },
          { text: 'Sedes', href: this.url + '/sedes' },
          { text: this.title, active: true }
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
					this.form.nombre = this.record.nombre
	    		this.form.ciudad = this.record.ciudad
					this.form.direccion = this.record.direccion
					this.form.telefono = this.record.telefono
					this.form.celular = this.record.celular
					this.form.celular_aux = this.record.celular_aux
					this.form.email = this.record.email
	    	},
	    	onGuardarNuevo(){
	    		var request = { method: 'POST', url: this.url + '/sedes', data: this.form }
	    		var mssgOnFail = 'Existen campos inválidos, veríficalos antes de guardar.'
	    		this.onSubmit(request, mssgOnFail)
	    	},
	    	onGuardarModificar(){
	    		var request = { method: 'PUT', url: this.url + '/sedes/'+ this.record_id, data: this.form }
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
						var request = { method: 'DELETE', url: this.url + '/sedes/' + this.record_id, data: this.form }
		    			var mssgOnFail = 'Ha ocurrido un error al eliminar este registro.'
		    			this.onSubmit(request, mssgOnFail)
					}
				})
	    	},
			onSubmit(request, error_msg) {
				self = this
				if(request){
          self.$refs.spinnerContainerRef.showSpinner()
					axios(request).then((response) => {
						if(response.data.success){
              self.$refs.spinnerContainerRef.hideSpinner()
							if( response.data.success == 'created' ){
								self.setDisableForm()
								self.toastFunctionRedirect('Éxito', 'La sede ha sido creada correctamente.', 'success')
							}else if( response.data.success == 'updated' ){
								self.toastFunction('La sede ha sido modificada correctamente.', 'success')
								self.afterSuccessGuardar()
							}else if (response.data.success = 'deleted' ){
								self.form.is_active = !self.form.is_active
								self.toastFunctionRedirect('Éxito', 'La sede ha sido eliminada correctamente.', 'success')
							}
						}else if (response.data.error){
							if( response.data.error == 'cantDeleted'){
								self.toastFunction('La sede está relacionada a pacientes activos, por lo tanto no se puede eliminar.', 'error')
							}else{
								self.all_errors = response.data.error
								self.toastFunction(error_msg, 'error')
							}
              self.$refs.spinnerContainerRef.hideSpinner()
						}
					}).catch(function (error) {
						self.toastFunction('Ha ocurrido un error crítico, por favor comunicarse con Odontoplus.pe.', 'error')
            self.$refs.spinnerContainerRef.hideSpinner()
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
				this.record.nombre = this.form.nombre
				this.record.ciudad = this.form.ciudad
				this.record.direccion = this.form.direccion
				this.record.telefono = this.form.telefono
				this.record.celular = this.form.celular
				this.record.celular_aux = this.form.celular_aux
				this.record.email = this.form.email
			},
			cleanErrosMessage(){
				this.all_errors = []
			},
			setEmptyPasswordFields(){
				this.form.password = ''
				this.form.confirm_password = ''
			},
			redireccionarToIndex(){ //Btn Regresar
				window.location.href = this.url + '/sedes'
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
					window.location.href = this.url + '/sedes'
				})
			}
    }
  }

</script>
