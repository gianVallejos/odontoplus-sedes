<template>
  <b-container id="container-template">
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Egresos" :items="breadcrumb" />
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
                  <b-button variant="secondary" :href="url + '/pagos'">
										<i class="fas fa-credit-card"></i>&nbsp;Ver Pagos
									</b-button>
								</div>
								<div v-if="displayStatus == 'show'">
									<b-button variant="primary" v-on:click.prevent="onDisplayModificar" v-if="curUser.rolid == 1">
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
                  <b-button variant="secondary" :href="url + '/pagos'">
										<i class="fas fa-credit-card"></i>&nbsp;Ver Pagos
									</b-button>
								</div>
							</div>

							<div class="pt-4 pb-2">
									<b-row>
										<b-col cols="12" class="pt-3 pb-4">
											<b-form-row>
												<b-col>
												    <b-form-group label="Fecha" label-for="fecha">
													    <b-form-input id="fecha" type="date" v-model="form.fecha"  :disabled=isDisabled class="required" />
													    <span v-if="all_errors.fecha" :class="['label label-danger']">{{ all_errors.fecha[0] }}</span>
												    </b-form-group>
												</b-col>
												<b-col cols="4">
													<b-form-group label="Tipo">
														<b-form-select v-model="form.tipo" v-on:input="changeDoctorOption"  :disabled=isDisabled class="required">
															<option v-for="(tipo, index) in tipos" :key="index" :value="tipo.nombre">
																{{ tipo.nombre }}
															</option>
														</b-form-select>
														<span v-if="all_errors.tipo" :class="['label label-danger']">{{ all_errors.tipo[0] }}</span>
													</b-form-group>
												</b-col>
												<b-col cols="5">
													<b-form-group label="Doctor">
														<b-form-select v-model="form.doctor"  :disabled=needDoctor >
															<option :value="null">Ningun Doctor Seleccionado</option>
															<option v-for="(doctor, index) in doctores" :key="index" :value="doctor.id">
																{{ doctor.nombres }} {{ doctor.apellidos}}
															</option>
														</b-form-select>
														<span v-if="all_errors.doctor" :class="['label label-danger']">{{ all_errors.doctor[0] }}</span>
													</b-form-group>
												</b-col>
											</b-form-row>
											<b-form-row>
												<b-col>
												    <b-form-group label="Cantidad" label-for="cantidad">
														<b-form-input v-on:input="calculateTotal" id="cantidad" type="text" v-model="form.cantidad"  placeholder="Cantidad" autocomplete="off" class="required" :disabled=isDisabled  />
														<span v-if="all_errors.cantidad" :class="['label label-danger']">{{ all_errors.cantidad[0] }}</span>
													</b-form-group>
												</b-col>
												<b-col cols="6">
													<b-form-group label="Concepto" label-for="concepto">
														<b-form-input id="concepto" type="text" v-model="form.concepto" placeholder="Concepto" autocomplete="off" class="required" :disabled=isDisabled  />
														<span v-if="all_errors.concepto" :class="['label label-danger']">{{ all_errors.concepto[0] }}</span>
													</b-form-group>
												</b-col>
												<b-col>
													<b-form-group label="Monto" label-for="monto">
														<b-form-input v-on:input="calculateTotal" id="monto" type="text" v-model="form.monto" placeholder="Monto" autocomplete="off" class="required" :disabled=isDisabled />
														<span v-if="all_errors.monto" :class="['label label-danger']">{{ all_errors.monto[0] }}</span>
													</b-form-group>
												</b-col>
												<b-col>
													<b-form-group label="Total" label-for="total">
														<b-form-input id="total" type="text" v-model="form.total" placeholder="Total" autocomplete="off" disabled />
														<span v-if="all_errors.total" :class="['label label-danger']">{{ all_errors.total[0] }}</span>
													</b-form-group>
												</b-col>
											</b-form-row>
											<b-form-row>
												<b-col>
												    <b-form-group label="Nota" label-for="nota">
														<b-form-input id="nota" type="text" v-model="form.nota" placeholder="Nota" autocomplete="off" :disabled=isDisabled />
														<span v-if="all_errors.nota" :class="['label label-danger']">{{ all_errors.nota[0] }}</span>
													</b-form-group>
												</b-col>
											</b-form-row>
										</b-col>
									</b-row>
							</div>

							<div class="text-center">
								<div v-if="displayStatus == 'show'">
									<b-button variant="primary" v-on:click.prevent="onDisplayModificar" v-if="curUser.rolid == 1">
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
                  <b-button variant="secondary" :href="url + '/pagos'">
										<i class="fas fa-credit-card"></i>&nbsp;Ver Pagos
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
                  <b-button variant="secondary" :href="url + '/pagos'">
										<i class="fas fa-credit-card"></i>&nbsp;Ver Pagos
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

		console.log('Egresos Form Component')
    },
    name: 'Egreso-Form',
    components: {
      	PanelCard,
      	TitleComponent
    },
    props:[
      	'title',
      	'url',
		'doctores',
		'record',
		'curUser',
		'view_mode'
    ],
    data(){
      return{
      	myDate: new Date(),
		form: {
			fecha: this.getMyDate(),
			tipo: 'Empresa',
			doctor: null,
			cantidad: 1,
			concepto: '',
			monto: 0,
			total: 0,
			nota: ''
		},
		displayStatus: '',
        isDisabled: false,
		record_id: '',
		all_errors: [],
        breadcrumb: [
          { text: 'Inicio', href: this.url },
          { text: 'Egresos', href: this.url + '/egresos' },
          { text: this.title, active: true },
		],
		tipos: [
			{ nombre: 'Empresa' },
			{ nombre: 'Pago a Personal' },
			{ nombre: 'Otros' }
		],
		needDoctor: false
      }
    },
    methods:{
    		initActualView(){
				this.displayStatus = this.view_mode
		    	if( this.displayStatus == 'new' ){
		    		this.onDisplayNuevo()
		    	}else if( this.displayStatus == 'show' ){
		    		this.setControllerDataToForms()
		    		this.onDisplayDetalle()
		    	}else if( this.displayStatus == 'edit' ){
		    		this.setControllerDataToForms()
		    		this.onDisplayModificar()
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
	    	},
	    	onDisplayModificar(){
	    		this.displayStatus = 'edit'
	    		this.setEnableForm()
	    	},
	    	setEnableForm(){
	    		this.isDisabled = false
	    		this.setDoctorEnableIfExistDoctor()
	    	},
	    	setDisableForm(){
	    		this.isDisabled = true
	    		this.setDoctorEnableIfExistDoctor()
	    	},
	    	setControllerDataToForms(){
	    		this.record_id = this.record.id
	    		this.form.fecha = this.record.fecha
				this.form.tipo = this.record.tipo
				this.form.doctor = this.record.doctorId
				this.form.cantidad = this.record.cantidad
				this.form.concepto = this.record.concepto
				this.form.monto = this.record.monto
				this.form.total = this.record.total
				this.form.nota = this.record.nota
	    	},
	    	onGuardarNuevo(){
	    		var request = { method: 'POST', url: this.url + '/egresos', data: this.form }
	    		var mssgOnFail = 'Existen campos inválidos, veríficalos antes de guardar.'
	    		this.onSubmit(request, mssgOnFail)
	    	},
	    	onGuardarModificar(){
	    		var request = { method: 'PUT', url: this.url + '/egresos/'+ this.record_id, data: this.form }
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
						var request = { method: 'DELETE', url: this.url + '/egresos/' + this.record_id, data: this.form }
		    			var mssgOnFail = 'Ha ocurrido un error al eliminar este registro.'
		    			this.onSubmit(request, mssgOnFail)
					}
				})
	    	},
			onSubmit(request, error_msg) {
				self = this
				if(request){
					axios(request).then((response) => {
						console.log(JSON.stringify(response.data))
						if(response.data.success){
							console.log('Response:: OK')
							if( response.data.success == 'created' ){
								self.setDisableForm()
								self.toastFunctionRedirect('Éxito', 'El egreso ha sido creado correctamente.', 'success')
							}else if( response.data.success == 'updated' ){
								self.toastFunction('El egreso ha sido modificado correctamente.', 'success')
								self.afterSuccessGuardar()
							}else if (response.data.success = 'deleted' ){
								self.form.is_active = !self.form.is_active
								self.toastFunctionRedirect('Éxito', 'El egreso ha sido eliminado correctamente.', 'success')
							}
						}else if (response.data.error){
							if( response.data.error == 'cantDeleted'){
								self.toastFunction('El egreso está relacionado a presupuestos activos por lo tanto no se puede eliminar.', 'error')
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
				this.record.tipo = this.form.tipo
				this.record.doctorId = this.form.doctor
				this.record.cantidad = this.form.cantidad
				this.record.concepto = this.form.concepto
				this.record.monto = this.form.monto
				this.record.total = this.form.total
				this.record.nota = this.form.nota
	    	},
			cleanErrosMessage(){
				this.all_errors = []
			},
			setEmptyPasswordFields(){
				this.form.password = ''
				this.form.confirm_password = ''
			},
			redireccionarToIndex(){ //Btn Regresar
				window.location.href = this.url + '/egresos'
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
					window.location.href = this.url + '/egresos'
				})
			},
			calculateTotal(){
				this.form.total = parseFloat(this.form.cantidad) * parseFloat(this.form.monto)
			},
			changeDoctorOption(){
				if( this.form.tipo == 'Pago a Personal' && this.displayStatus != 'show' ){
					this.needDoctor = false
				}else{
					this.needDoctor = true
					if( this.displayStatus != 'show' ){
						this.form.doctor = null
					}
				}
			},
			setDoctorEnableIfExistDoctor(){
				if( this.form.doctor != null && this.displayStatus != 'show'){
					this.needDoctor = false
				}else{
					this.needDoctor = true
				}
			}
    }
  }

</script>
