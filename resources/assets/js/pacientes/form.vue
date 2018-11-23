<template>
  <b-container id="container-template">    
    <SpinnerContainer :url="url" ref="spinnerContainerRef" />
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Pacientes" :items="breadcrumb" />
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
							   				  v-if="curUser.rolid == 1">
										<i class="fas fa-trash-alt"></i>&nbsp;Eliminar
									</b-button>
									<b-button variant="warning" v-on:click.prevent="onRegresar">
										<i class="fas fa-chevron-circle-left"></i>&nbsp;Regresar
									</b-button>
                  <b-button type="submit" variant="secondary" :href="url + '/presupuestos/create'">
										<i class="fas fa-plus"></i>&nbsp; Nuevo presupuesto
									</b-button>
								</div>
							</div>

							<div class="pt-4 pb-2">
									<b-row>
										<b-col cols="6" class="pt-3 pb-4">
											<div class="form-title">
												<i class="fas fa-child"></i>
												<div class="d-inline"> Información General </div>
											</div>
											<p class="form-description fz-3 pt-3 pr-4">
												La información general de paciente nos sirve para poder identificarlo a lo largo del sistema.
											</p>
											<p class="form-description fz-3 pt-3 pr-4">
												<span class="help-required"> &nbsp; Campos obligatorios. </span>
											</p>
										</b-col>
										<b-col cols="6" class="pt-3 pb-4">
										    <b-form-group label="Nombres" label-for="nombres">
											    <b-form-input id="nombres" type="text" v-model="form.nombres" placeholder="Nombres" class="required" :disabled=isDisabled autocomplete="off"   />
											    <span v-if="all_errors.nombres" :class="['label label-danger']">{{ all_errors.nombres[0] }}</span>
										    </b-form-group>
										    <b-form-group label="Apellidos" label-for="apellidos">
												<b-form-input id="apellidos" type="text" v-model="form.apellidos" placeholder="Apellidos" class="required" :disabled=isDisabled autocomplete="off"  />
												<span v-if="all_errors.apellidos" :class="['label label-danger']">{{ all_errors.apellidos[0] }}</span>
										    </b-form-group>
										    <b-form-group label="DNI" label-for="dni">
											    <b-form-input id="dni" type="text" v-model="form.dni" placeholder="DNI" maxlength="8" class="required" :disabled=isDisabled autocomplete="off"  />
											    <span v-if="all_errors.dni" :class="['label label-danger']">{{ all_errors.dni[0] }}</span>
										    </b-form-group>
										</b-col>

										<b-col cols="6" class="pt-3 pb-4">
											<div class="form-title">
												<i class="fas fa-briefcase-medical"></i>
												<div class="d-inline"> Información del Paciente </div>
											</div>
											<p class="form-description fz-3 pt-3 pr-4">
												La información del paciente nos brinda datos útiles para poder monitorear a nuestro paciente según su fecha de nacimiento, sexo y estado civil.
											</p>
											<p class="form-description fz-3 pt-3 pr-4">
												<span class="help-required"> &nbsp; Campos obligatorios. </span>
											</p>
										</b-col>
										<b-col cols="6" class="pt-3 pb-4">
                        <b-form-row>
                          <b-col cols="9">
    										    <b-form-group label="Fecha de Nacimiento" label-for="fechanacimiento">
    											    <b-form-input id="fechanacimiento" type="date" v-model="form.fechanacimiento" class="required"
    											    			  :disabled=isDisabled />
    											    <span v-if="all_errors.fechanacimiento" :class="['label label-danger']">{{ all_errors.fechanacimiento[0] }}</span>
    										    </b-form-group>
                          </b-col>
                          <b-col cols="3">
                            <b-form-group label="Edad" label-for="edad">
      												<b-form-input id="edad" type="text" v-model="calcularEdad" disabled />
      										  </b-form-group>
                          </b-col>
                        </b-form-row>
										    <b-form-row>
										    	<b-col cols="6">
												    <b-form-group label="Género" label-for="genero">
												    	<b-form-select id="genero" v-model="form.genero" :options="genero.options" :disabled=isDisabled />
												    	<span v-if="all_errors.genero" :class="['label label-danger']">{{ all_errors.genero[0] }}</span>
												    </b-form-group>
										    	</b-col>
											    <b-col cols="6">
												    <b-form-group label="Estado Civil" label-for="estado">
												     	<b-form-select id="estado" v-model="form.estado" :options="estadoCivil.options" :disabled=isDisabled />
												     	<span v-if="all_errors.estado" :class="['label label-danger']">{{ all_errors.estado[0] }}</span>
												    </b-form-group>
												</b-col>
											</b-form-row>
										</b-col>

										<b-col cols="6">
											<div class="form-title">
												<i class="fas fa-address-book"></i>
												<div class="d-inline"> Información de Contacto </div>
											</div>
											<p class="form-description fz-3 pt-3 pr-4">
												La información de contacto del paciente es una colección de datos importantes para poder relacionarse con el paciente según su evolución con el negocio.
												<br /><br />Es recomendable almacenar el celular y mail del paciente en caso de alguna emergencia o para mantener un contacto frecuente con él.
											</p>
											<p class="form-description fz-3 pt-3 pr-4">
												<span class="help-required"> &nbsp; Campos obligatorios. </span>
											</p>
										</b-col>

										<b-col cols="6" class="pt-3 pb-4">
											<b-form-group label="Email" label-for="email">
												<b-form-input id="email" type="email" v-model="form.email" placeholder="Email" :disabled=isDisabled autocomplete="off" />
												<span v-if="all_errors.email" :class="['label label-danger']">{{ all_errors.email[0] }}</span>
										  </b-form-group>
											<b-form-group label="Dirección" label-for="direccion">
											    <b-form-input id="direccion" type="text" v-model="form.direccion" placeholder="Dirección" class="required" :disabled=isDisabled autocomplete="off"  />
											    <span v-if="all_errors.direccion" :class="['label label-danger']">{{ all_errors.direccion[0] }}</span>
										    </b-form-group>
										    <b-form-row>
											    <b-col cols="6">
												    <b-form-group label="Teléfono" label-for="telefono">
													    <b-form-input id="telefono" type="text" v-model="form.telefono" placeholder="Teléfono" :disabled=isDisabled autocomplete="off" />
													    <span v-if="all_errors.telefono" :class="['label label-danger']">{{ all_errors.telefono[0] }}</span>
												    </b-form-group>
												</b-col>
											    <b-col cols="6">
												    <b-form-group label="Teléfono Alternativo" label-for="fax">
													    <b-form-input id="fax" type="text" v-model="form.fax" placeholder="Teléfono Alternativo" :disabled=isDisabled autocomplete="off" />
													    <span v-if="all_errors.fax" :class="['label label-danger']">{{ all_errors.fax[0] }}</span>
												    </b-form-group>
												</b-col>
											</b-form-row>
											<b-form-row>
												<b-col cols="6">
												    <b-form-group label="Celular" label-for="celular">
													    <b-form-input id="celular" type="text" v-model="form.celular" placeholder="Celular" :disabled=isDisabled autocomplete="off" />
													    <span v-if="all_errors.celular" :class="['label label-danger']">{{ all_errors.celular[0] }}</span>
												    </b-form-group>
												</b-col>
											    <b-col cols="6">
												    <b-form-group label="Celular Alternativo" label-for="celular_aux">
													    <b-form-input id="celular_aux" type="text" v-model="form.celular_aux" placeholder="Celular Alternativo" :disabled=isDisabled autocomplete="off" />
													    <span v-if="all_errors.celular_aux" :class="['label label-danger']">{{ all_errors.celular_aux[0] }}</span>
												    </b-form-group>
												</b-col>
											</b-form-row>
										</b-col>

										<b-col cols="6">
											<div class="form-title">
												<i class="fas fa-building"></i>
												<div class="d-inline"> Información Externa </div>
											</div>
											<p class="form-description fz-3 pt-3 pr-4">
												La información externa del paciente esta relacionada a los beneficios institucionales de la empresa.
												<br /><br/>Se debe tener en cuenta que los presupuestos utilizarán los precios según la empresa a la que pertenece el paciente.
											</p>
											<p class="form-description fz-3 pt-3 pr-4">
												<span class="help-required"> &nbsp; Campos obligatorios. </span>
											</p>
										</b-col>
										<b-col cols="6" class="pt-3 pb-4">
											  <b-form-group label="Empresa:" label-for="empresa_id">
										     	<b-form-select v-model="form.empresa_id" :disabled=isDisabled>
  													<option v-for="(empresa, index) in empresas" :key="index" :value="empresa.id">
  														{{ empresa.nombre }}
  													</option>
												  </b-form-select>
										     	<span v-if="all_errors.empresa_id" :class="['label label-danger']">{{ all_errors.empresa_id[0] }}</span>
										    </b-form-group>
										    <b-form-group label="Vínculo:" label-for="seguro_ind">
										    	<b-form-select v-model="form.seguro_ind" :disabled=isDisabled>
  													<option :value="0">Ningún vínculo seleccionado</option>
  													<option v-for="(vnc, index) in vinculo.options" :key="index" :value="vnc.id">
  														{{ vnc.text }}
  													</option>
  												</b-form-select>
										     	<span v-if="all_errors.seguro_ind" :class="['label label-danger']">{{ all_errors.seguro_ind[0] }}</span>
										    </b-form-group>
                        <b-form-group label="Referencia:" label-for="referencia_id">
										     	<b-form-select v-model="form.referencia_id" :disabled=isDisabled>
    													<option v-for="(referencia, index) in referencias" :key="index" :value="referencia.id">
    														{{ referencia.nombre }}
    													</option>
												  </b-form-select>
										     	<span v-if="all_errors.referencia_id" :class="['label label-danger']">{{ all_errors.referencia_id[0] }}</span>
										    </b-form-group>
										</b-col>

										<b-col cols="6">
											<div class="form-title">
												<i class="fas fa-address-card"></i>
												<div class="d-inline"> Información de Apoderado </div>
											</div>
											<p class="form-description fz-3 pt-3 pr-4">
												La información de apoderado es obligatoria únicamente cuando el paciente es menor de edad según la fecha de nacimiento previamente seleccionada.
											</p>
											<p class="form-description fz-3 pt-3 pr-4">
												<span class="help-required"> &nbsp; Campos obligatorios. </span>
											</p>
										</b-col>
										<b-col cols="6" class="pt-3 pb-4">
											<b-form-group label="Nombre de Apoderado:" label-for="nombre_apoderado">
									    		<b-form-input id="nombre_apoderado" type="text" v-model="form.nombre_apoderado" placeholder="Nombre de Apoderado" :disabled=isDisabled autocomplete="off" />
									    		<span v-if="all_errors.nombre_apoderado" :class="['label label-danger']">{{ all_errors.nombre_apoderado[0] }}</span>
									      	</b-form-group>
									      	<b-form-group label="Celular de Apoderado:" label-for="celular_apoderado">
									    		<b-form-input id="celular_apoderado" type="text" v-model="form.celular_apoderado" placeholder="Celular de Apoderado" :disabled=isDisabled autocomplete="off" />
									    		<span v-if="all_errors.celular_apoderado" :class="['label label-danger']">{{ all_errors.celular_apoderado[0] }}</span>
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
                  <b-button type="submit" variant="secondary" :href="url + '/presupuestos/create'">
										<i class="fas fa-plus"></i>&nbsp; Nuevo presupuesto
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
    name: 'Paciente-Form',
    components: {
      PanelCard,
      TitleComponent,
      SpinnerContainer
    },
    props:[
      	'title',
      	'url',
      	'empresas',
        'referencias',
    		'paciente',
    		'curUser',
    		'view_mode'
    ],
    computed: {
      calcularEdad() {
        return this.calcularEdadPorFecha(this.form.fechanacimiento)
      }
    },
    data(){
      return{
      	myDate: new Date(),
        form: {
  				nombres: '',
  				apellidos: '',
  				dni: '',
  				email: '',
  				fechanacimiento: this.getMyDate(),
  				genero: 'Masculino',
  				estado: 'Soltero',
  				direccion: '',
  				telefono: '',
  				fax: '',
  				celular: '',
  				celular_aux: '',
  				empresa_id: '1',
  				seguro_ind: 0,
          referencia_id: '1',
  				nombre_apoderado: '',
  				celular_apoderado: ''
    		},
    		record_id: '',
    		all_errors: [],
        breadcrumb: [
              { text: 'Inicio', href: this.url },
              { text: 'Pacientes', href: this.url + '/pacientes' },
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
    		estadoCivil: {
    			options: [
    				{ value: "Soltero", text: "Soltero" },
    				{ value: "Casado", text: "Casado" },
    				{ value: "Viudo", text: "Viudo" },
    				{ value: "Divorciado", text: "Divorciado" },
    			]
    		},
    		vinculo: {
    			options: [
    				{ id: 1, text: "Trabajador" },
    				{ id: 2, text: "Hijo/Hija" },
    				{ id: 3, text: "Padre" },
    				{ id: 4, text: "Otro" }
    			]
    		}
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
      calcularEdadPorFecha(dateString){
        var today = new Date()
        var birthDate = new Date(dateString)
        var age = today.getFullYear() - birthDate.getFullYear()
        var m = today.getMonth() - birthDate.getMonth()
        if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
            age--
        }
        return (age >= 0 ) ? age : 0
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
    		this.record_id = this.paciente.id
    		this.form.nombres  = this.paciente.nombres
  			this.form.apellidos  = this.paciente.apellidos
  			this.form.dni  = this.paciente.dni
  			this.form.email  = this.paciente.email
  			this.form.fechanacimiento  = this.paciente.fechanacimiento
  			this.form.genero = this.paciente.genero
  			this.form.estado = this.paciente.estado
  			this.form.direccion  = this.paciente.direccion
  			this.form.telefono  = this.paciente.telefono
  			this.form.fax  = this.paciente.fax
  			this.form.celular  = this.paciente.celular
  			this.form.celular_aux  = this.paciente.celular_aux
  			this.form.empresa_id = this.paciente.empresa_id
  			this.form.seguro_ind = this.paciente.seguro_ind
        this.form.referencia_id = this.paciente.referencia_id
  			this.form.nombre_apoderado  = this.paciente.nombre_apoderado
  			this.form.celular_apoderado = this.paciente.celular_apoderado
    	},
    	onGuardarNuevo(){
    		var request = { method: 'POST', url: this.url + '/pacientes', data: this.form }
    		var mssgOnFail = 'Existen campos inválidos, veríficalos antes de guardar.'
    		this.onSubmit(request, mssgOnFail)
    	},
    	onGuardarModificar(){
    		var request = { method: 'PUT', url: this.url + '/pacientes/'+ this.record_id, data: this.form }
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
  					var request = { method: 'DELETE', url: this.url + '/pacientes/' + this.record_id, data: this.form }
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
  						console.log('Response:: OK')
              self.$refs.spinnerContainerRef.hideSpinner()
  						if( response.data.success == 'created' ){
  							self.setDisableForm()
                self.$swal({
        						type: 'success',
        						title: 'Éxito',
        						html: 'El paciente ha sido creado correctamente.',
        						toast: false,
        						position: 'center',
        						confirmButtonClass: ['my-alert', 'confirm-alert'],
        		  			backdrop: `rgba(0, 0, 0, 0.6)`
        				}).then(() => {
        					window.location.href = self.url + '/pacientes/' + response.data.id_created
        				})

  						}else if( response.data.success == 'updated' ){
  							self.toastFunction('El paciente ha sido modificado correctamente.', 'success')
  							self.afterSuccessGuardar()
  						}else if (response.data.success = 'deleted' ){
  							self.form.is_active = !self.form.is_active
  							self.toastFunctionRedirect('Éxito', 'El paciente ha sido eliminado correctamente.', 'success')
  						}
  					}else if (response.data.error){
  						if( response.data.error == 'cantDeleted'){
  							self.toastFunction('El paciente está relacionado a presupuestos o ingresos activos por lo tanto no se puede eliminar.', 'error')
  						}else{
  							console.log('Response:: FAIL');
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
    		this.paciente.id = this.record_id
    		this.paciente.nombres = this.form.nombres
  			this.paciente.apellidos = this.form.apellidos
  			this.paciente.dni = this.form.dni
  			this.paciente.email = this.form.email
  			this.paciente.fechanacimiento = this.form.fechanacimiento
  			this.paciente.genero = this.form.genero
  			this.paciente.estado = this.form.estado
  			this.paciente.direccion = this.form.direccion
  			this.paciente.telefono = this.form.telefono
  			this.paciente.fax = this.form.fax
  			this.paciente.celular = this.form.celular
  			this.paciente.celular_aux = this.form.celular_aux
  			this.paciente.empresa_id = this.form.empresa_id
  			this.paciente.seguro_ind = this.form.seguro_ind
        this.paciente.referencia_id = this.form.referencia_id
  			this.paciente.nombre_apoderado = this.form.nombre_apoderado
  			this.paciente.celular_apoderado	 = this.form.celular_apoderado
    	},
  		cleanErrosMessage(){
  			this.all_errors = []
  		},
  		setEmptyPasswordFields(){
  			this.form.password = ''
  			this.form.confirm_password = ''
  		},
  		redireccionarToIndex(){ //Btn Regresar
  			window.location.href = this.url + '/pacientes'
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
					window.location.href = this.url + '/pacientes'
				})
			}
    }
  }

</script>
