<template>
  <b-container id="container-template">
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Ingresos" :items="breadcrumb" />
			</div>
      <div class="col-md-12">
        <PanelCard>
          <span slot="heading">{{panel_title}}</span>
          <div slot="body" class="pt-3 pb-3 pl-3 pr-3">
 
						<b-form>
							<!--input type="hidden" name="_token" :value="csrf"-->
							<div class="text-center">
								<div v-if="this.display != 'show'">								
									<b-button v-if="this.display != 'show'" type="submit" variant="success" v-on:click.prevent="onSubmit">
										<i class="fas fa-save"></i>&nbsp; Guardar
									</b-button>
									<b-button v-if="this.display != 'show'" :href="url + '/ingresos'" variant="warning">
										<i class="fas fa-times-circle"></i>&nbsp;Cancelar
									</b-button>
								</div>

								<div v-if="this.display == 'show'">
									<b-button variant="primary" v-on:click="enableForm">
										<i class="fas fa-edit"></i>&nbsp; Modificar
									</b-button>
									<b-button variant="danger" v-on:click.prevent="onDelete()">
									<i class="fas fa-trash-alt"></i>&nbsp;Eliminar
									</b-button>
									<b-button variant="warning" :href="url + '/ingresos'">
										<i class="fas fa-chevron-circle-left"></i>&nbsp;Regresar
									</b-button>
								</div>
							</div>

							<div class="pt-4 pb-2">
									<b-row>
										<b-col cols="6" class="pt-3 pb-4">
											<div class="form-title">
												<i class="fas fa-hand-holding-usd"></i>
												<div class="d-inline"> Información General </div>
											</div>
											<p class="form-description fz-3 pt-3 pr-4">
												On sait depuis longtemps que travailler avec du texte lisible et contenant du sens est source de distractions.
											</p>
											<br/>
											<p class="form-description fz-3 pt-3 pr-4">
												<span class="help-required"> &nbsp; Campos obligatorios. </span>												
											</p>
										</b-col>
										<b-col cols="6" class="pt-3 pb-4">
										    <b-form-group label="Fecha" label-for="fecha">
											    <b-form-input id="fecha" type="date" v-model="form.fecha"  :disabled="this.display == 'show'" class="required" />
											    <span v-if="all_errors.fecha" :class="['label label-danger']">{{ all_errors.fecha[0] }}</span>
										    </b-form-group>
												
										    <b-form-group label="Paciente" label-for="pacientes">
												<b-input-group>
											      	<b-form-input id="pacientes" type="text" v-model="form.paciente"  :disabled="this.display == 'show'" class="required" placeholder="Ningun Paciente Seleccionado" disabled />
											      	<b-input-group-append>
												    	<b-btn class="pl-3 pr-3" variant="success" 
												    		   v-b-modal.exampleModal  :disabled="this.display == 'show'" >
												    		<i class="fas fa-search"></i>
												    	</b-btn>
												    </b-input-group-append>
										    	</b-input-group>
										    	<span v-if="all_errors.paciente" :class="['label label-danger']">{{ all_errors.paciente[0] }}</span>
											</b-form-group>

											<b-form-group label="Doctor">
												<b-form-select v-model="form.doctor"  :disabled="this.display == 'show'" class="required">
													<option :value="null">Ningun Doctor Seleccionado</option>
													<option v-for="(doctor, index) in doctores" :key="index" :value="doctor.id">
														{{ doctor.nombres }} {{ doctor.apellidos}}
													</option>
												</b-form-select>
												<span v-if="all_errors.doctor" :class="['label label-danger']">{{ all_errors.doctor[0] }}</span>
											</b-form-group>
										</b-col>
									</b-row>
							</div>

							<div class="text-center">
								<div v-if="this.display != 'show'">								
									<b-button v-if="this.display != 'show'" type="submit" variant="success" v-on:click.prevent="onSubmit">
										<i class="fas fa-save"></i>&nbsp; Guardar
									</b-button>
									<b-button v-if="this.display != 'show'" :href="url + '/ingresos'" variant="warning">
										<i class="fas fa-times-circle"></i>&nbsp;Cancelar
									</b-button>
								</div>

								<div v-if="this.display == 'show'">
									<b-button variant="primary" v-on:click="enableForm">
										<i class="fas fa-edit"></i>&nbsp; Modificar
									</b-button>
									<b-button variant="danger" v-on:click="onDelete()">
									<i class="fas fa-trash-alt"></i>&nbsp;Eliminar
									</b-button>
									<b-button variant="warning" :href="url + '/pacientes'">
										<i class="fas fa-chevron-circle-left"></i>&nbsp;Regresar
									</b-button>
								</div>
							</div>

						</b-form>

          </div>
        </PanelCard>

			</div>
		</b-row>
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
									<b-table show-empty :items="pacientes" :fields="fields" :current-page="currentPage" :per-page="perPage" :filter="filter" :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" 
										:sort-direction="sortDirection"
							             @filtered="onFiltered">
										<template slot="nombres" slot-scope="row">							    	
									    		{{ row.value }} {{ row.item.apellidos }}							    	
									    </template>
									    <template slot="actions" slot-scope="row" class="md-2">
									        <div class="actions-table" style="color: #d1d1d1">						        	
									        	<a v-on:click="agregarPaciente(row.item.id, row.item.nombres, row.item.apellidos)" href="#" class="action">Seleccionar</a>
									        </div>
									    </template>
									</b-table>
								</b-col>
								<b-col cols="12" class="text-center">
									<b-pagination :total-rows="totalRows" :per-page="perPage" v-model="currentPage" class="d-inline-flex" />
								</b-col>
							</b-row>
							<b-button slot="modal-footer" variant="primary" size="sm" @click="hideModal">Cerrar</b-button>
		</b-modal>

  </b-container>
</template>

<script>
  	import PanelCard from '../widgets/panel/panel-component.vue'
	import TitleComponent from '../widgets/titulo/index.vue'
	import axios from 'axios'

  	export default{
    	mounted() { 
      		console.log('Egresos mounted')      		
			if(this.view_mode != 'new'){
				this.fillForm()	
			} 
			this.display = this.view_mode
			this.panel_title = this.title
		},
	    name: 'Ingresos-Form',
	    components: {
	      	PanelCard,
	      	TitleComponent
	    },
	    props:[
	      	'title',
	      	'url',
			'record',
			'view_mode',
			'pacientes',
			'doctores'
	    ],
	    data(){
	      return{
	      	myDate: new Date(),
	        form: {
				fecha: this.getMyDate(),
				idPaciente: '',
				paciente: '',
				doctor: null
			},
			display: '',
			record_id: '',
			panel_title: '',
			all_errors: [],
	        breadcrumb: [
	          { text: 'Home', href: '/' },
	          { text: 'Ingresos', href: this.url+'/ingresos' },
	          { text: this.title, active: true },
					],
			toast_config: {
				position: 'top-center',
				className: 'toast-danger',
				duration: 3500,
				containerClass: 'container-template'
			},
			fields: [				    				    
				    { key: 'id', label: 'Nro', class: 'text-center' }, 				    
				    { key: 'nombres', label: 'Nombre de Paciente', sortable: true, sortDirection: 'desc' },
				    { key: 'actions', label: '', sortable: false },				    
			    ],
			    currentPage: 1,
			   	perPage: 10,
			    totalRows: 0,
			    pageOptions: [ 5, 10, 15 ],
			    sortBy: null,
			    sortDesc: false,
			    sortDirection: 'asc',
			    filter: '',
			    isDelete: false,
			    display: ''
	      }	      
	    },
	    methods:{
	    		onDelete(){
	    			this.isDelete = true
	    			this.onSubmit()
	    		},
				onSubmit () {					
					var request
					var mssgOnFail = 'Existen campos inválidos. Por favor verificalos.'
										
					if (this.display == 'edit' && !this.isDelete) {
						request = { method: 'PUT', url: this.url + '/ingresos/' + this.record_id, data: this.form }
					}else if (this.display == 'new' && !this.isDelete) {
						request = { method: 'POST', url: this.url + '/ingresos', data: this.form }						
					}else if (this.display == 'show' && this.isDelete ) {
						if( confirm('¿Está seguro de eliminar este registro?') ){
							request = { method: 'DELETE', url: this.url + '/ingresos/'  + this.record_id  }
							mssgOnFail = 'El registro no ha podido ser eliminado.'
						}
					}

					if(request){											
						axios(request).then((response) => {
							console.log(response.data)
							if(response.data.success){
								console.log('Response:: OK')
								window.location.href = this.url + '/ingresos'
							}
							else if (response.data.error){
								console.log('Response:: FAIL');
								this.all_errors = response.data.error
								console.log(JSON.stringify(this.all_errors))
								this.$toasted.show( ( mssgOnFail ),this.toast_config)
							}
						}).catch(function (error) {
							console.log(error);
						});
					}
				},
				fillForm(){
					this.record_id = this.record.id
					this.form.fecha = this.record.fecha
					this.form.idPaciente = this.record.hc
					this.form.paciente = this.record.nombrePaciente
					this.form.doctor = this.record.idDoctor
				},
				enableForm(){
					this.display = 'edit'
					this.panel_title = 'Modificar Ingreso'
				},
			    setMyDateToToday() {
			      this.myDate = new Date();		      
			    },
			    addADayToMyDate() {
			      	if (this.myDate){ // as myDate can be null		        
				    	this.myDate = new Date(this.myDate.setDate(this.myDate.getDate() + 1));
				    }
			    },
			    getMyDate(){
			    	this.setMyDateToToday()
			    	this.addADayToMyDate()
			    	return this.myDate && this.myDate.toISOString().split('T')[0]			    	
			    },
				hideModal(){
					this.$refs.myModalRef.hide()
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
			    }

	    }
    }

</script>