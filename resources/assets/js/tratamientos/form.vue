<template>
  <b-container id="container-template">
    <SpinnerContainer :url="url" ref="spinnerContainerRef" />
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Tratamientos" :items="breadcrumb" />
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
							   				  v-if="curUser.rolid == 1 && canDeleteTratamiento()">
										<i class="fas fa-trash-alt"></i>&nbsp;Eliminar
									</b-button>
									<b-button variant="warning" v-on:click.prevent="onRegresar">
										<i class="fas fa-chevron-circle-left"></i>&nbsp;Regresar
									</b-button>
								</div>
							</div>

              <p class="form-description fz-3 pt-3 pr-0">
                <span class="help-required"> &nbsp; Campos obligatorios. </span>
              </p>
							<div class="pt-3 pb-2">
									<b-row>
										<b-col cols="12" class="pt-0 pb-1 d-none d-lg-block">
											<div class="form-title">
												<i class="fas fa-tooth"></i>
												<div class="d-inline"> Información de Tratamiento</div>
											</div>
										</b-col>
										<b-col cols="12" class="pt-0 pt-lg-2 pb-0 pb-lg-4">
                      <b-form-row>
                       <b-col cols="8" lg="6">
										    <b-form-group label="Nombre de Tratamiento" label-for="detalle">
											    <b-form-input id="detalle" type="text" class="required" v-model="form.detalle"
											    			  :disabled=isDisabled placeholder="Nombre de Tratamiento" autocomplete="off"/>
													<span v-if="all_errors.detalle" :class="['label label-danger']">{{ all_errors.detalle[0] }}</span>
										    </b-form-group>
                      </b-col>
                      <b-col cols="2" lg="3">
										    <b-form-group label="Precio Estándar" label-for="precio_estandar" v-if="displayStatus == 'new'">
											    <b-form-input id="precio_estandar" type="number" step="0.1" class="required" v-model="form.precio_estandar"
											    			  :disabled=isDisabled placeholder="Precio Estandar" autocomplete="off"/>
													<span v-if="all_errors.precio_estandar" :class="['label label-danger']">{{ all_errors.precio_estandar[0] }}</span>
										    </b-form-group>
                      </b-col>
                      <b-col cols="2" lg="3">
                        <b-form-group label="Costo Variable" label-for="costo_variable" v-if="displayStatus == 'new'">
											    <b-form-input id="costo_variable" type="number" step="0.1" class="required" v-model="form.costo_variable"
											    			  :disabled=isDisabled placeholder="Costo Variable" autocomplete="off"/>
													<span v-if="all_errors.costo_variable" :class="['label label-danger']">{{ all_errors.costo_variable[0] }}</span>
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
							   				  v-if="curUser.rolid == 1 && canDeleteTratamiento()">
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
  import SpinnerContainer from '../widgets/spinner/spinner-container.vue'
	import axios from 'axios'

  export default{
    mounted() {
    	this.initActualView()
    },
    name: 'Tratamiento-Form',
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
				detalle: '',
				precio_estandar: 0.00,
        costo_variable: 0.00
		},
		record_id: '',
		all_errors: [],
        breadcrumb: [
          { text: 'Inicio', href: this.url },
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
          self.$refs.spinnerContainerRef.showSpinner()
					axios(request).then((response) => {
						if(response.data.success){
              self.$refs.spinnerContainerRef.hideSpinner()
							if( response.data.success == 'created' ){
								self.setDisableForm()
								self.toastFunctionRedirect('Éxito', 'El tratamiento ha sido creado correctamente.', 'success')
							}else if( response.data.success == 'updated' ){
								self.toastFunction('El tratamiento ha sido modificado correctamente.', 'success')
								self.afterSuccessGuardar()
							}else if (response.data.success = 'deleted' ){
								self.form.is_active = !self.form.is_active
								self.toastFunctionRedirect('Éxito', 'El tratamiento ha sido eliminado correctamente.', 'success')
							}
						}else if (response.data.error){
							if( response.data.error == 'cantDeleted'){
								self.toastFunction('El tratamiento está relacionado a presupuestos activos por lo tanto no se puede eliminar.', 'error')
							}else if(response.data.error == 'commitFailed'){
								self.toastFunction('Ha ocurrido un error al insertar el tratamiento o sus precios')
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
					window.location.href = this.url + '/tratamientos'
				})
			},
			canDeleteTratamiento(){
				if( this.record_id == null ) return false
				if( this.record_id <= 31 ) return false
				return true
			}
    }
  }

</script>
