<template>
	<b-container class="pb-4">				
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Pagos" :items="breadcrumb" />				
			</b-col>
			<b-col cols="12" class="pt-3">				
				<PanelCard>
					<span slot="heading">Crear Pago </span>
					<div slot="body" class="pt-3 pb-3 pl-3 pr-3">						
						<b-row>
							<b-col cols="6" class="pt-1 pb-4">
								<div class="form-title">
									<i class="fas fa-file-invoice-dollar"></i> 
									<div class="d-inline"> Crear Pago </div>
								</div>
								<p class="form-description fz-3 pt-3 pr-4">
									Para crear un Pago debe seleccionar el doctor y las fechas del periodo a pagar. 
									<br /><br />Al seleccionar "nuevo pago", aparecerá la lista de ingresos del doctor seleccionado en el periodo ingresado. 
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
									</b-form-group>
								</b-form>								
							</b-col>
							<b-col cols="12">
								<div class="text-center">
									<b-button type="submit" variant="warning" v-on:click="onSubmit">
										<i class="fas fa-plus"></i>&nbsp; Nuevo Pago
									</b-button>
									<b-button :href="url + '/presupuestos'" variant="danger">
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
				breadcrumb: [
			    	{ text: 'Dashboard', href: this.url },
			    	{ text: 'Pagos', href: this.url + '/presupuestos' },
			    	{ text: 'Crear Pago', active: true }
			    ],		
			    isDisabled: false,
			    form: {
            doctorSelected: null,
            fechaInicio:'',
            fechaFin:''
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
			onSubmit () {
				if( this.form.doctorSelected == null ){
					this.toastFunction('Para crear un Pago debe seleccionar un Doctor', 'error')
				}else if( this.form.doctorSelected == null ){
					this.toastFunction('Para crear un Pago debe ingresar rango de fechas', 'error')
				}else{
					window.location.href = this.url + '/presupuestos/nuevo/' + this.form.idPacienteSelected + '/' + this.form.doctorSelected
				}
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