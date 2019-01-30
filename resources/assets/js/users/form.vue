<template>
  <b-container id="container-template">
    <SpinnerContainer :url="url" ref="spinnerContainerRef" />
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Usuarios" :items="breadcrumb" />
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
									<b-button variant="danger" v-on:click.prevent="onDesactivar(
											  'Al desactivar este registro no podrá iniciar sesión ni usar el usuario en el sistema.' +
							   				  '<br /><br />¿Seguro que desea desactivar este usuario?')"
							   				  v-if="curUser.rolid == 1 && form.is_active ">
										<i class="fas fa-user-slash"></i>&nbsp;Desactivar
									</b-button>
									<b-button variant="success" v-on:click.prevent="onDesactivar('¿Esta seguro que desea activar este usuario?.')"
											  v-if="curUser.rolid == 1 && !form.is_active ">
										<i class="fas fa-user-slash"></i>&nbsp;Activar
									</b-button>
									<b-button variant="warning" v-on:click.prevent="onRegresar" >
										<i class="fas fa-chevron-circle-left"></i>&nbsp;Regresar
									</b-button>
								</div>
							</div>
              <p class="form-description fz-3 pt-3 pr-4 ">
                <span class="help-required"> &nbsp; Campos obligatorios. </span>
              </p>
							<div class="pt-2 pb-2">
									<b-row>
										<b-col cols="12" class="pt-2 pb-2 d-none d-lg-block">
											<div class="form-title">
												<i class="fas fa-user"></i>
												<div class="d-inline"> Información General </div>
											</div>

										</b-col>
										<b-col cols="12" >
                      <b-form-row>
                        <b-col cols="12" lg="6">
										    <b-form-group label="Nombres" label-for="nombres">
											    <b-form-input id="nombres" type="text" class="required" v-model="form.name" :disabled=isDisabled placeholder="Nombres" required autocomplete="off"/>
													<span v-if="all_errors.name" :class="['label label-danger']">{{ all_errors.name[0] }}</span>
										    </b-form-group>
                      </b-col>
                      <b-col cols="12" lg="6">
												<b-form-group label="Email" label-for="email">
													<b-form-input id="email" type="email" class="required" v-model="form.email" :disabled=isDisabled placeholder="Email" required autocomplete="off"/>
													<span v-if="all_errors.email" :class="['label label-danger']">{{ all_errors.email[0] }}</span>
										    </b-form-group>
                      </b-col>
                      <b-col cols="12" lg="6">
                        <b-form-group label="Sede:" label-for="sede_id">
                          <b-form-select v-model="form.sede_id" :disabled=isDisabled >
                            <option v-for="(sede, index) in sedes" :key="index" :value="sede.id">
                              {{ sede.nombre }}
                            </option>
                          </b-form-select>
                          <span v-if="all_errors.sede_id" :class="['label label-danger']">{{ all_errors.sede_id[0] }}</span>
                        </b-form-group>
                      </b-col>
                      <b-col cols="12" lg="3">
										    <b-form-group :label="displayStatus == 'edit' ? 'Nueva contraseña' : 'Contraseña'" label-for="password" >
													<b-form-input id="password" type="password" class="required" v-model="form.password" :disabled=isDisabled placeholder="********" required autocomplete="off" maxlength="20"/>
													<span v-if="all_errors.password" :class="['label label-danger']">{{ all_errors.password[0] }}</span>
										    </b-form-group>
                      </b-col>
                      <b-col cols="12" lg="3">
										    <b-form-group :label="displayStatus == 'edit' ? 'Confirmar nueva contraseña' : 'Confirmar contraseña'" label-for="confirm_password" >
											    <b-form-input id="confirm_password" type="password" class="required" v-model="form.confirm_password" :disabled=isDisabled placeholder="********" required autocomplete="off" maxlength="20"/>
													<span v-if="all_errors.confirm_password" :class="['label label-danger']">{{ all_errors.confirm_password[0] }}</span>
										    </b-form-group>
                      </b-col>

                      </b-form-row>
										</b-col>
									</b-row>

									<b-row v-if="curUser.rolid == 1">
										<b-col cols="12" class="pt-2 pb-2 d-none d-lg-block">
											<div class="form-title">
												<i class="fas fa-shield-alt"></i>
												<div class="d-inline">Privilegios de Usuario</div>
											</div>
										</b-col>
										<b-col cols="12" md="6" >
												<b-form-group label="Rol">
													<b-form-radio-group id="rol_id" v-model="form.rolid" :disabled=isDisabled name="radioSubComponent">
														<b-form-radio value=2>Colaborador</b-form-radio>
														<b-form-radio value=1>Administrador</b-form-radio>
													</b-form-radio-group>
												</b-form-group>
												<b-form-group label="Estado" label-for="is_active">
													<b-form-checkbox id="is_active" v-model="form.is_active" :disabled=isDisabled>
														Usuario Activado
													</b-form-checkbox>
										    </b-form-group>
										</b-col>
									</b-row>

							</div>

							<div class="text-center">
								<div v-if="displayStatus == 'show'">
									<b-button variant="primary" v-on:click.prevent="onDisplayModificar">
										<i class="fas fa-edit"></i>&nbsp; Modificar
									</b-button>
									<b-button variant="danger" v-on:click.prevent="onDesactivar(
											  'Al desactivar este registro no podrá iniciar sesión ni usar el usuario en el sistema.' +
							   				  '<br /><br />¿Seguro que desea desactivar este usuario?')"
							   				  v-if="curUser.rolid == 1 && form.is_active ">
										<i class="fas fa-user-slash"></i>&nbsp;Desactivar
									</b-button>
									<b-button variant="success" v-on:click.prevent="onDesactivar('¿Esta seguro que desea activar este usuario?.')" v-if="curUser.rolid == 1 && !form.is_active ">
										<i class="fas fa-user-slash"></i>&nbsp;Activar
									</b-button>
									<b-button variant="warning" v-on:click.prevent="onRegresar">
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
    name: 'User-Form',
    components: {
      PanelCard,
      TitleComponent,
      SpinnerContainer
    },
    props:[
      	'title',
      	'url',
    		'user',
        'sedes',
    		'curUser',
    		'view_mode'
    ],
    data(){
      return{
        form: {
    			name: '',
    			email: '',
          sede_id: 1,
    			password: '',
    			confirm_password: '',
    			rolid: 2,
    			is_active: true
    		},
  		record_id: '',
  		all_errors: [],
          breadcrumb: [
            { text: 'Inicio', href: '/' },
            { text: 'Usuarios', href: this.url + '/users' },
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
    		this.record_id = this.user.id
			this.form.name = this.user.name
			this.form.email = this.user.email
      this.form.sede_id = this.user.sede_id
			this.form.rolid = this.user.rolid
			this.form.is_active = (this.user.is_active == '1' ? true : false)
    	},
    	onGuardarNuevo(){
    		var request = { method: 'POST', url: this.url + '/users', data: this.form }
    		var mssgOnFail = 'Existen campos inválidos, veríficalos antes de guardar.'
    		this.onSubmit(request, mssgOnFail)
    	},
    	onGuardarModificar(){
    		var request = { method: 'PUT', url: this.url + '/users/'+ this.record_id, data: this.form }
    		var mssgOnFail = 'Existen campos inválidos, veríficalos antes de guardar.'
    		this.onSubmit(request, mssgOnFail)
    	},
    	onDesactivar(msg){
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
					var request = { method: 'DELETE', url: this.url + '/users/' + this.record_id, data: this.form }
	    			var mssgOnFail = 'Ha ocurrido un error al desactivar este usuario.'
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
							self.toastFunctionRedirect('Éxito', 'El usuario ha sido creado correctamente.', 'success')
						}else if( response.data.success == 'updated' ){
							self.toastFunction('El usuario ha sido modificado correctamente.', 'success')
							self.afterSuccessGuardar()
						}else if (response.data.success = 'deleted' ){
							self.form.is_active = !self.form.is_active
							self.afterSuccessGuardar('Usuario actualizado correctamente')
						}
					}else if (response.data.error){
						self.all_errors = response.data.error
						self.toastFunction(error_msg, 'error')
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
			this.user.name = this.form.name
			this.user.email = this.form.email
      this.user.sede_id = this.form.sede_id
			this.user.rolid = this.form.rolid
			this.user.is_active = this.form.is_active
    	},
		cleanErrosMessage(){
			this.all_errors = []
		},
		setEmptyPasswordFields(){
			this.form.password = ''
			this.form.confirm_password = ''
		},
		redireccionarToIndex(){ //Btn Regresar
			window.location.href = this.url + '/users'
		},
    	onRegresar(){
    		if( this.curUser.rolid != 1){
    			window.location.href = this.url + '/'
    		}else{
	    		this.redireccionarToIndex()
	    	}
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
          window.location.href = this.url + '/users'
      })
    }
    }
  }

</script>
