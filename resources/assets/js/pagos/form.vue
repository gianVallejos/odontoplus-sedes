<template>
	<b-container class="pb-4">				
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Pagos" :items="breadcrumb" />				
			</b-col>
			<b-col cols="12">				
				<PanelCard>
					<span slot="heading">Nuevo Pago </span>
					<div slot="body" class="pt-3 pb-3 pl-3 pr-3">						
						<b-row>
							<b-col cols="6" class="pt-1 pb-4">
								<div class="form-title">
									<i class="fas fa-file-invoice-dollar"></i> 
									<div class="d-inline"> Nuevo Pago </div>
								</div>
								<p class="form-description fz-3 pt-3 pr-4">
									Para crear un Pago debe seleccionar el doctor y las fechas del periodo a pagar. 
									<br /><br />Al seleccionar "nuevo pago", aparecerá la lista de ingresos del doctor seleccionado en el periodo ingresado. 
								</p>
								<p class="form-description fz-3 pt-3 pr-4">
									<span class="help-required"> &nbsp; Campos obligatorios. </span>												
								</p>
							</b-col>
							<b-col cols="6" class="pt-1 pb-4">	
								<b-form>			
                   <b-form-row>
                    <b-col cols="6">
                      <b-form-group label="Fecha de Inicio" label-for="fechainicio">
                        <b-form-input id="fechainicio" type="date" class="required" v-model="form.fechaInicio" />
                        <span v-if="all_errors.fechaInicio" :class="['label label-danger']">{{ all_errors.fechaInicio[0] }}</span>
                      </b-form-group>
                    </b-col>
                    <b-col cols="6">
                      <b-form-group label="Fecha Final" label-for="fechafin">
                        <b-form-input id="fechainicio" type="date" class="required" v-model="form.fechaFin" />
                        <span v-if="all_errors.fechaFin" :class="['label label-danger']">{{ all_errors.fechaFin[0] }}</span>
                      </b-form-group>
                    </b-col>
                  </b-form-row>						
									<b-form-group label="Seleccionar Doctor" label-for="apellidos">
										<b-form-select v-model="form.doctorSelected">
											<option :value="null">Ningun Doctor Seleccionado</option>
											<option v-for="(doctor, index) in doctores" :key="index" :value="doctor.id">
												{{ doctor.nombres }} {{ doctor.apellidos}}
											</option>
										</b-form-select>
										<span v-if="all_errors.doctorSelected" :class="['label label-danger']">{{ all_errors.doctorSelected[0] }}</span>
									</b-form-group>
								</b-form>								
							</b-col>
							<b-col cols="12">
								<div class="text-center">
									<b-button type="submit" variant="warning" v-on:click="onSubmit">
										<i class="fas fa-plus"></i>&nbsp; Nuevo Pago
									</b-button>
									<b-button :href="url + '/pagos'" variant="danger">
										<i class="fas fa-times-circle"></i>&nbsp;Cancelar
									</b-button>
								</div>
							</b-col>
						</b-row>
					</div>
				</PanelCard>
			</b-col>
		</b-row>
	</b-container>
</template>

<script>
	import TitleComponent from '../widgets/titulo/index.vue'
	import PanelCard from '../widgets/panel/panel-component.vue'

	export default{
		mounted(){
			console.log('Create')
		},
		components:{
			TitleComponent,
			PanelCard
		},
		props: [
			'url',
			'pacientes',
			'doctores'
		],
		data(){
			return {
				myDate: new Date(),
				breadcrumb: [
			    	{ text: 'Inicio', href: this.url + '/' },
			    	{ text: 'Pagos', href: this.url + '/pagos' },
			    	{ text: 'Nuevo Pago', active: true }
			    ],		
			    isDisabled: false,
			    form: {
						doctorSelected: null,
            fechaInicio: this.getMyDate(),
            fechaFin: this.getMyDate()
					},
			    all_errors: [],
			    fields: [				    				    
				    { key: 'id', label: 'Nro Historia', class: 'text-center' }, 				    
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
			    filter: ''
			}
		},
		methods: {
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
			onSubmit () {
				if( this.validForm() ){
					window.open(this.url + '/pagos/nuevo/' + this.form.doctorSelected + '/' + this.form.fechaInicio + '/' + this.form.fechaFin, '_blank')
					window.location.href = this.url + '/pagos'
				}
				else{
					this.toastFunction('Existen campos inválidos. Verifícalos antes de guardar', 'error')
				}
			},
			cleanErrors(){
				this.all_errors = []
			},
			validForm(){
				this.cleanErrors()
				if( this.form.doctorSelected == null ){
					this.all_errors.doctorSelected = ['Para crear un Pago debe seleccionar un Doctor']
				}
				if( this.form.fechaInicio == '' ){
					this.all_errors.fechaInicio = ['Fecha inválida']
				}
				if( this.form.fechaFin == '' ){
					this.all_errors.fechaFin = ['Fecha inválida']
				}
				if( this.form.fechaInicio != '' && this.form.fechaFin != '' && this.form.fechaInicio > this.form.fechaFin){
					this.all_errors.fechaFin = ['Rango de fechas inválido']
					this.all_errors.fechaInicio = ['Rango de fechas inválido']
				}
				return Object.keys(this.all_errors).length === 0
			},
			onFiltered (filteredItems) {
		      this.totalRows = filteredItems.length
		      this.currentPage = 1
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
			}
		}
	}
</script>