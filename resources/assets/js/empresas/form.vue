<template>
  <b-container id="container-template" v-if="this.$root.autorizadoVerEmpresa(curUser.schema, curUser.rolid)">
    <SpinnerContainer :url="url" ref="spinnerContainerRef" />
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Empresas" :items="breadcrumb" />
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

							<div class="pt-4 pb-2">
									<b-row>
										<b-col cols="6" class="pt-3 pb-4">
											<div class="form-title">
												<i class="far fa-building"></i>
												<div class="d-inline"> Información de Empresa </div>
											</div>
											<p class="form-description fz-3 pt-3 pr-4">
												La gestión de empresas es esencial para el manejo de diferentes precios de tratamientos en caso de convenios o alianzas estratégicas.
											</p>
											<br/>
											<p class="form-description fz-3 pt-3 pr-4">
												<span class="help-required"> &nbsp; Campos obligatorios. </span>
											</p>
										</b-col>
										<b-col cols="6" class="pt-3 pb-4">
										    <b-form-group label="Nombre" label-for="nombre">
											    <b-form-input id="nombre" type="text" class="required"
											    	v-model="form.nombre" :disabled=isDisabled
											    	placeholder="Nombre" autocomplete="off"/>
													<span v-if="all_errors.nombre" :class="['label label-danger']">{{ all_errors.nombre[0] }}</span>
										    </b-form-group>
										    <b-form-group label="RUC" label-for="ruc">
											    <b-form-input id="ruc" type="text"
											    	v-model="form.ruc" :disabled=isDisabled
											    	maxlength="12" placeholder="RUC" autocomplete="off"/>
													<span v-if="all_errors.ruc" :class="['label label-danger']">{{ all_errors.ruc[0] }}</span>
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
    name: 'Empresa-Form',
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
			ruc: ''
		},
		displayStatus: '',
        isDisabled: false,
		record_id: '',
		all_errors: [],
        breadcrumb: [
          { text: 'Inicio', href: this.url },
          { text: 'Empresas', href: this.url + '/empresas' },
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
				this.form.ruc = this.record.ruc
	    	},
	    	onGuardarNuevo(){
	    		var request = { method: 'POST', url: this.url + '/empresas', data: this.form }
	    		var mssgOnFail = 'Existen campos inválidos, veríficalos antes de guardar.'
	    		this.onSubmit(request, mssgOnFail)
	    	},
	    	onGuardarModificar(){
	    		var request = { method: 'PUT', url: this.url + '/empresas/'+ this.record_id, data: this.form }
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
						var request = { method: 'DELETE', url: this.url + '/empresas/' + this.record_id, data: this.form }
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
								self.toastFunctionRedirect('Éxito', 'La empresa ha sido creada correctamente.', 'success')
							}else if( response.data.success == 'updated' ){
								self.toastFunction('La empresa ha sido modificada correctamente.', 'success')
								self.afterSuccessGuardar()
							}else if (response.data.success = 'deleted' ){
								self.form.is_active = !self.form.is_active
								self.toastFunctionRedirect('Éxito', 'La empresa ha sido eliminada correctamente.', 'success')
							}
						}else if (response.data.error){
							if( response.data.error == 'cantDeleted'){
								self.toastFunction('La empresa está relacionada a tratamientos activos por lo tanto no se puede eliminar.', 'error')
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
				this.record.ruc = this.form.ruc
	    	},
			cleanErrosMessage(){
				this.all_errors = []
			},
			setEmptyPasswordFields(){
				this.form.password = ''
				this.form.confirm_password = ''
			},
			redireccionarToIndex(){ //Btn Regresar
				window.location.href = this.url + '/empresas'
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
						confirmButtonClass: ['my-alert', 'confirm-alert'],
		  			backdrop: `rgba(0, 0, 0, 0.6)`
				}).then(() => {
					window.location.href = this.url + '/empresas'
				})
			}
    }
  }

</script>
