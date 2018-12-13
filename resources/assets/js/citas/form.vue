<template>
  <b-container id="container-template">
    <SpinnerContainer :url="url" ref="spinnerContainerRef" />
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Citas" :items="breadcrumb" />
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
								</div>
							</div>

							<div class="pt-4 pb-2">
									<b-row>
										<b-col cols="6" class="pt-3 pb-4">
											<div class="form-title">
												<i class="fas fa-user"></i>
												<div class="d-inline"> Información de Cita</div>
											</div>
											<p class="form-description fz-3 pt-3 pr-4">
												La información siguiente es útil para agendar una cita con un paciente.
											</p>
											<br/>
											<p class="form-description fz-3 pt-3 pr-4">
												<span class="help-required"> &nbsp; Campos obligatorios. </span>
											</p>
										</b-col>
										<b-col cols="6" class="pt-3 pb-4">
                      <b-form-group label="Seleccionar Paciente" label-for="pacientes">
                        <b-input-group>
                              <b-form-input id="pacientes" type="text" v-model="form.pacienteSelected" placeholder="Ningun Paciente Seleccionado" disabled />
                              <b-input-group-append>
                              <b-btn class="pl-3 pr-3" variant="success" v-b-modal.exampleModal >
                                <i class="fas fa-search"></i>
                              </b-btn>
                            </b-input-group-append>
                          </b-input-group>
                      </b-form-group>
                      <b-form-group label="Seleccionar Doctor" label-for="apellidos">
    										<b-form-select v-model="form.doctorSelected">
    											<option :value="null">Ningun Doctor Seleccionado</option>
    											<option v-for="(doctor, index) in doctores" :key="index" :value="doctor.id">
    												{{ doctor.nombres }} {{ doctor.apellidos}}
    											</option>
    										</b-form-select>
    									</b-form-group>
                      <b-form-row>
                        <b-col cols="12">
                          <b-form-group label="Desde:" label-for="desde">
                            <b-form-input type="date" v-model="form.desde" class="required"
                                    :disabled=isDisabled />
                            <span v-if="all_errors.fechanacimiento" :class="['label label-danger']">{{ all_errors.fechanacimiento[0] }}</span>
                          </b-form-group>
												</b-col>
												<b-col cols="6">
                          <b-form-group label="Desde:" label-for="desde">
                            <b-form-input type="date" v-model="form.desde" class="required"
                                    :disabled=isDisabled />
                            <span v-if="all_errors.fechanacimiento" :class="['label label-danger']">{{ all_errors.fechanacimiento[0] }}</span>
                          </b-form-group>
												</b-col>
											    <b-col cols="6">
                            <b-form-group label="Hasta:" label-for="hasta">
    											    <b-form-input type="date" v-model="form.hasta" class="required"
    											    			  :disabled=isDisabled />
    											    <span v-if="all_errors.fechanacimiento" :class="['label label-danger']">{{ all_errors.fechanacimiento[0] }}</span>
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
      <b-modal ref="myModalRef" id="exampleModal" size="md" title="Lista de Pacientes">
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
            <b-table 	show-empty
                      :items="pacientes"
                      :fields="fields"
                      :current-page="currentPage"
                      :per-page="perPage"
                      :filter="filter"
                      :sort-by.sync="sortBy"
                      :sort-desc.sync="sortDesc"
                      :sort-direction="sortDirection"
                      @filtered="onFiltered"
                      empty-text="No existen campos para mostrar"
                      empty-filtered-text="No existen pacientes que coincidan con la búsqueda">
              <template slot="nombres" slot-scope="row">
                    {{ row.value }} {{ row.item.apellidos }}
                </template>
                <template slot="actions" slot-scope="row" class="md-2">
                    <div class="actions-table" style="color: #d1d1d1">
                      <a v-on:click.prevent="agregarPaciente(row.item.id, row.item.nombres, row.item.apellidos)" href="#" class="action">Seleccionar</a>
                    </div>
                </template>
            </b-table>
          </b-col>
          <b-col cols="12" class="text-center">
            <b-pagination :total-rows="totalRows" :per-page="perPage" v-model="currentPage" class="d-inline-flex" />
          </b-col>
        </b-row>
        <div slot="modal-footer">
          <b-button  variant="secondary" size="sm" :href="url + '/pacientes/create'">
            <i class="fas fa-plus"></i>&nbsp; Nuevo Paciente
          </b-button>
          <b-button variant="primary" size="sm" @click="hideModal">
            <i class="fas fa-times"></i>&nbsp; Cerrar
          </b-button>
        </div>
      </b-modal>
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
    name: 'Doctor-Form',
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
    		'view_mode',
        'pacientes',
        'doctores'
    ],
    data(){
      return{
      	myDate: new Date(),
        form: {
            idPacienteSelected: '',
            pacienteSelected: '',
    				desde: this.getMyDate(),
            hasta: this.getMyDate(),
            doctorSelected: null
    		},
    		record_id: '',
    		all_errors: [],
            breadcrumb: [
              { text: 'Inicio', href: this.url },
              { text: 'Citas', href: this.url+'/doctores' },
              { text: this.title, active: true },
    		],
    		displayStatus: '',
        isDisabled: false,
        fields: [
          { key: 'id', label: 'Nro Historia', class: 'text-center' },
          { key: 'nombres', label: 'Nombre de Paciente', sortable: true, sortDirection: 'desc' },
          { key: 'actions', label: '', sortable: false },
        ],
        currentPage: 1,
        perPage: 7,
        totalRows: 0,
        pageOptions: [ 5, 10, 15 ],
        sortBy: null,
        sortDesc: false,
        sortDirection: 'asc',
        filter: ''
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
      getMyDate(){
  			this.setMyDateToToday()
  			this.addADayToMyDate()
  			return this.myDate && this.myDate.toISOString().split('T')[0]
  		},
      setMyDateToToday() {
  			this.myDate = new Date();
  		},
  		addADayToMyDate() {
  			if (this.myDate){ // as myDate can be null
  				this.myDate = new Date(this.myDate.setDate(this.myDate.getDate()));
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
        self.$refs.spinnerContainerRef.showSpinner()
				axios(request).then((response) => {
					if(response.data.success){
						if( response.data.success == 'created' ){
							self.setDisableForm()
							self.toastFunctionRedirect('Éxito', 'El doctor ha sido creado correctamente.', 'success')
						}else if( response.data.success == 'updated' ){
							self.toastFunction('El doctor ha sido modificado correctamente.', 'success')
							self.afterSuccessGuardar()
						}else if (response.data.success = 'deleted' ){
							self.form.is_active = !self.form.is_active
							self.toastFunctionRedirect('Éxito', 'El doctor ha sido eliminado correctamente.', 'success')
						}
            self.$refs.spinnerContainerRef.hideSpinner()
					}else if (response.data.error){
						if( response.data.error == 'cantDeleted'){
							self.toastFunction('El doctor está relacionado a presupuestos activos por lo tanto no se puede eliminar.', 'error')
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
			hideModal(){
				this.$refs.myModalRef.hide()
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
    onFiltered (filteredItems) {
        this.totalRows = filteredItems.length
        this.currentPage = 1
      },
      agregarPaciente(id, nombres, apellidos){
        //alert(id)
        this.form.idPacienteSelected = id
        this.form.pacienteSelected = nombres + ' ' + apellidos
        this.$refs.myModalRef.hide()
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
        window.location.href = this.url + '/doctores'
      })
    }

    }
  }

</script>
