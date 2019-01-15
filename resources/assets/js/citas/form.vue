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
                  <b-button variant="secondary" v-on:click.prevent="onRegresar">
										<i class="fas fa-calendar-alt"></i>&nbsp;Ver Calendario
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
                  <b-button variant="warning" v-on:click.prevent="onRegresar" >
										<i class="fas fa-chevron-circle-left"></i>&nbsp;Regresar
									</b-button>
									<b-button variant="secondary" v-on:click.prevent="onRegresar">
										<i class="fas fa-calendar-alt"></i>&nbsp;Ver Calendario
									</b-button>
								</div>
							</div>

							<div class="pt-4 pb-2">
									<b-row>
										<b-col cols="12" class="pt-3 pb-4">
                      <b-form-row>
                        <b-col cols="4">
                          <b-form-group label="Seleccionar Paciente" label-for="pacientes">
                            <b-input-group>
                                  <b-form-input id="pacientes" type="text" v-model="form.paciente" placeholder="Ningun Paciente Seleccionado" disabled />
                                  <b-input-group-append>
                                  <b-btn class="pl-3 pr-3" variant="success" v-b-modal.exampleModal v-if="displayStatus != 'show'">
                                    <i class="fas fa-search"></i>
                                  </b-btn>
                                </b-input-group-append>
                            </b-input-group>
                            <span v-if="all_errors.paciente" :class="['label label-danger']">{{ all_errors.paciente[0] }}</span>
                          </b-form-group>
                        </b-col>
                        <b-col cols="4">
                          <b-form-group label="Seleccionar Doctor">
        										<b-form-select v-model="form.idDoctor" class="required" :disabled=isDisabled>
        											<option :value="null">Ningun Doctor Seleccionado</option>
        											<option v-for="(doctor, index) in doctores" :key="index" :value="doctor.id">
        												{{ doctor.nombres }} {{ doctor.apellidos}}
        											</option>
        										</b-form-select>
                            <span v-if="all_errors.idDoctor" :class="['label label-danger']">{{ all_errors.idDoctor[0] }}</span>
        									</b-form-group>
                        </b-col>
												<b-col cols="4">
													<b-form-group label="Seleccionar Sede" label-for="sede">
		    										<b-form-select v-model="form.sede" class="required" :disabled=isDisabled >
		    											<option v-for="(sede, index) in sedes" :key="index" :value="sede.id">
		    												{{ sede.nombre }}
		    											</option>
		    										</b-form-select>
														<span v-if="all_errors.sede" :class="['label label-danger']">{{ all_errors.sede[0] }}</span>
		    									</b-form-group>
												</b-col>
                      </b-form-row>
                      <b-form-row>
                        <b-col cols="6">
                          <b-form-group label="Tratamiento" label-for="tratamiento">
  											    <b-form-input id="tratamiento" type="text" v-model="form.tratamiento" placeholder="Tratamiento" class="required" :disabled=isDisabled autocomplete="off"  />
  											    <span v-if="all_errors.tratamiento" :class="['label label-danger']">{{ all_errors.tratamiento[0] }}</span>
  										    </b-form-group>
                        </b-col>
                        <b-col cols="6">
                          <b-form-group label="Seleccionar Sillón" label-for="apellidos">
        										<b-form-select v-model="form.sillon" class="required" :disabled=isDisabled>
        											<option v-for="(sillon, index) in sillons" :key="index" :value="sillon.id">
        												{{ sillon.nombre }}
        											</option>
        										</b-form-select>
                            <span v-if="all_errors.sillon" :class="['label label-danger']">{{ all_errors.sillon[0] }}</span>
        									</b-form-group>
                        </b-col>
                        <b-col cols="6">
                          <b-form-group label="Nota" label-for="nota">
                            <b-form-input id="nota" type="text" v-model="form.nota" placeholder="Nota" :disabled=isDisabled autocomplete="off"  />
                            <span v-if="all_errors.nota" :class="['label label-danger']">{{ all_errors.nota[0] }}</span>
                          </b-form-group>
                        </b-col>
                        <b-col cols="2">
                          <b-form-group label="Fecha:">
                            <b-form-input type="date" v-model="form.fecha" class="required" :disabled=isDisabled />
                            <span v-if="all_errors.fecha" :class="['label label-danger']">{{ all_errors.fecha[0] }}</span>
                          </b-form-group>
												</b-col>
												<b-col cols="2">
                          <b-form-group label="Desde:" label-for="desde">
                            <b-form-input type="time" v-model="form.desde" class="required"
                                    :disabled=isDisabled />
                            <span v-if="all_errors.desde" :class="['label label-danger']">{{ all_errors.desde[0] }}</span>
                          </b-form-group>
												</b-col>
											    <b-col cols="2">
                            <b-form-group label="Hasta:" label-for="hasta">
    											    <b-form-input type="time" v-model="form.hasta" class="required"
    											    			  :disabled=isDisabled />
    											    <span v-if="all_errors.hasta" :class="['label label-danger']">{{ all_errors.hasta[0] }}</span>
    										    </b-form-group>
												</b-col>
											</b-form-row>
                      <b-form-row>
                        <b-col cols="12">
    											<b-form-group label-for="enviar_email">
    												<b-form-checkbox id="enviar_email" v-model="form.enviarEmail" :disabled=isDisabled>
    													Enviar email de notificación a paciente.
    												</b-form-checkbox>
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
									<b-button variant="secondary" v-on:click.prevent="onRegresar" >
										<i class="fas fa-calendar-alt"></i>&nbsp;Ver Calendario
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
                  <b-button variant="secondary" v-on:click.prevent="onRegresar" >
										<i class="fas fa-calendar-alt"></i>&nbsp;Ver Calendario
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
                <template slot="codigo" slot-scope="row">
                    <a v-on:click.prevent="agregarPaciente(row.item.id, row.item.nombres, row.item.apellidos)" href="#" class="link-color">
                      {{ row.value }}
                    </a>
                </template>
                <template slot="nombres" slot-scope="row">
                    <a v-on:click.prevent="agregarPaciente(row.item.id, row.item.nombres, row.item.apellidos)" href="#" class="link-color">
                      {{ row.value }} {{ row.item.apellidos }}
                    </a>
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
      SpinnerContainer,
    },
    props:[
      	'title',
      	'url',
    		'record',
    		'curUser',
    		'view_mode',
        'pacientes',
        'doctores',
				'sedes',
        'sillons'
    ],
    data(){
      return{
      	myDate: new Date(),
        form: {
            idPaciente: '',
            paciente: '',
            tratamiento: '',
            sillon: 1,
            fecha: this.getMyDate(),
    				desde: '09:00',
            hasta: '10:00',
            idDoctor: null,
						sede: 1,
						enviarEmail: false,
            nota: ''
    		},
        global_date: this.getMyDate(),
    		record_id: '',
    		all_errors: [],
            breadcrumb: [
              { text: 'Inicio', href: this.url },
              { text: 'Citas', href: this.url+'/citas' },
              { text: this.title, active: true },
    		],
    		displayStatus: '',
        isDisabled: false,
        fields: [
          { key: 'codigo', label: 'Nro Historia', class: 'text-center' },
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
    fechaSeleccionada(){
      var fullDate = new Date(this.global_date)
      var day = fullDate.getDate()
      var month = fullDate.getMonth() + 1
      var year = fullDate.getFullYear()
      this.form.fecha = year + '/' + month + '/' + day
      // alert(day + ' ' + month + ' ' + year)
      // alert(this.form.fecha )
    },
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
        console.log('fecha: ' + this.record.fecha)
    		this.record_id = this.record.idEvent
        this.form.idPaciente =  this.record.idPaciente
        this.form.paciente =  this.record.title
        this.form.fecha =  this.record.fecha
        this.form.desde =  this.record.start
        this.form.hasta =  this.record.end
        this.form.idDoctor =  this.record.idDoctor
        this.form.tratamiento =  this.record.tratamiento
        this.form.sillon =  this.record.idSillon
				this.form.sede =  this.record.idSede
        this.form.nota =  this.record.nota
    	},
    	onGuardarNuevo(){
    		var request = { method: 'POST', url: this.url + '/citas', data: this.form }
    		var mssgOnFail = 'Existen campos inválidos, veríficalos antes de guardar.'
    		this.onSubmit(request, mssgOnFail)
    	},
    	onGuardarModificar(){
    		var request = { method: 'PUT', url: this.url + '/citas/'+ this.record_id, data: this.form }
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
					var request = { method: 'DELETE', url: this.url + '/citas/' + this.record_id }
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
							self.toastFunctionRedirect('Éxito', 'La cita ha sido creada correctamente.', 'success')
						}else if( response.data.success == 'updated' ){
							self.toastFunction('La cita ha sido modificada correctamente.', 'success')
							self.afterSuccessGuardar()
						}else if (response.data.success = 'no_valido' ){
							self.toastFunction('Ya existe una cita que interfiere con la fecha, horarios y sillón de esta nueva cita.', 'warning')
						}else if (response.data.success = 'deleted' ){
							self.form.is_active = !self.form.is_active
							self.toastFunctionRedirect('Éxito', 'La cita ha sido eliminada correctamente.', 'success')
						}
            self.$refs.spinnerContainerRef.hideSpinner()
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
			this.setFormDataToRecord()
			this.cleanErrosMessage()
			this.setEmptyPasswordFields()
		},
		setFormDataToRecord(){
    	this.record_id = this.record_id
			this.record.idPaciente = this.form.idPaciente
			this.record.title = this.form.paciente
			this.record.fecha = this.form.fecha
			this.record.start = this.form.desde
			this.record.end = this.form.hasta
			this.record.idDoctor = this.form.idDoctor
			this.record.idSede = this.form.sede
			this.record.idSillon = this.form.sillon
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
			window.location.href = this.url + '/citas'
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
        this.form.idPaciente = id
        this.form.paciente = nombres + ' ' + apellidos
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
        window.location.href = this.url + '/citas'
      })
    }

    }
  }

</script>
