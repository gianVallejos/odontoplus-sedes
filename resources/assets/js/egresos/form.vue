<template>
  <b-container id="container-template">
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Egresos" :items="breadcrumb" />
			</div>
      <div class="col-md-12">
        <PanelCard>
          <span slot="heading">{{panel_title}}</span>
          <div slot="body" class="pt-3 pb-3 pl-3 pr-3">
 
						<b-form>
							<!--input type="hidden" name="_token" :value="csrf"-->
							<div class="text-center">
								<div v-if="this.display != 'show'">		
									<b-button v-if="this.display == 'edit'" type="submit" variant="success" v-on:click.prevent="onModificar">
										<i class="fas fa-save"></i>&nbsp; Guardar
									</b-button>						
									<b-button v-if="this.display == 'new'" type="submit" variant="success" v-on:click.prevent="onGuardar">
										<i class="fas fa-save"></i>&nbsp; Guardar
									</b-button>
									<b-button v-if="this.display != 'show'" v-on:click="esCancelar" variant="warning">
										<i class="fas fa-times-circle"></i>&nbsp;Cancelar
									</b-button>
								</div>

								<div v-if="this.display == 'show'">
									<b-button variant="primary" v-on:click="enableForm">
										<i class="fas fa-edit"></i>&nbsp; Modificar
									</b-button>
									<b-button variant="danger" v-on:click="onEliminar">
									<i class="fas fa-trash-alt"></i>&nbsp;Eliminar
									</b-button>
									<b-button variant="warning" :href="url + '/egresos'">
										<i class="fas fa-chevron-circle-left"></i>&nbsp;Regresar
									</b-button>
								</div>
							</div>

							<div class="pt-4 pb-2">
									<b-row>
										<b-col cols="12" class="pt-3 pb-4">
											<b-form-row>
												<b-col>
												    <b-form-group label="Fecha" label-for="fecha">
													    <b-form-input id="fecha" type="date" v-model="form.fecha"  :disabled="this.display == 'show'" class="required" />
													    <span v-if="all_errors.fecha" :class="['label label-danger']">{{ all_errors.fecha[0] }}</span>
												    </b-form-group>
												</b-col>
												<b-col cols="4">
													<b-form-group label="Tipo">
														<b-form-select v-model="form.tipo"  :disabled="this.display == 'show'" class="required">
															<option v-for="(tipo, index) in tipos" :key="index" :value="tipo.nombre">
																{{ tipo.nombre }}
															</option>
														</b-form-select>
														<span v-if="all_errors.tipo" :class="['label label-danger']">{{ all_errors.tipo[0] }}</span>
													</b-form-group>
												</b-col>
												<b-col cols="5">
													<b-form-group label="Doctor">
														<b-form-select v-model="form.doctor"  :disabled="this.display == 'show'" >
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
														<b-form-input v-on:input="calculateTotal" id="cantidad" type="text" v-model="form.cantidad"  placeholder="Cantidad" autocomplete="off" class="required" :disabled="this.display == 'show'" required  />
														<span v-if="all_errors.cantidad" :class="['label label-danger']">{{ all_errors.cantidad[0] }}</span>
													</b-form-group>
												</b-col>
												<b-col cols="6">
													<b-form-group label="Concepto" label-for="concepto">
														<b-form-input id="concepto" type="text" v-model="form.concepto" placeholder="Concepto" autocomplete="off" class="required" :disabled="this.display == 'show'" required />
														<span v-if="all_errors.concepto" :class="['label label-danger']">{{ all_errors.concepto[0] }}</span>
													</b-form-group>
												</b-col>
												<b-col>
													<b-form-group label="Monto" label-for="monto">
														<b-form-input v-on:input="calculateTotal" id="monto" type="text" v-model="form.monto" placeholder="Monto" autocomplete="off" class="required" :disabled="this.display == 'show'" required />
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
														<b-form-input id="nota" type="text" v-model="form.nota" placeholder="Nota" autocomplete="off" :disabled="this.display == 'show'" />
														<span v-if="all_errors.nota" :class="['label label-danger']">{{ all_errors.nota[0] }}</span>
													</b-form-group>
												</b-col>
											</b-form-row>
										</b-col>
									</b-row>
							</div>

							<div class="text-center">
								<div v-if="this.display != 'show'">								
									<b-button v-if="this.display == 'edit'" type="submit" variant="success" v-on:click.prevent="onModificar">
										<i class="fas fa-save"></i>&nbsp; Guardar
									</b-button>						
									<b-button v-if="this.display == 'new'" type="submit" variant="success" v-on:click.prevent="onGuardar">
										<i class="fas fa-save"></i>&nbsp; Guardar
									</b-button>
									<b-button v-if="this.display != 'show'"  v-on:click="esCancelar" variant="warning">
										<i class="fas fa-times-circle"></i>&nbsp;Cancelar
									</b-button>
								</div>

								<div v-if="this.display == 'show'">
									<b-button variant="primary" v-on:click="enableForm">
										<i class="fas fa-edit"></i>&nbsp; Modificar
									</b-button>
									<b-button variant="danger" v-on:click="onEliminar">
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
  </b-container>
</template>

<script>
  	import PanelCard from '../widgets/panel/panel-component.vue'
	import TitleComponent from '../widgets/titulo/index.vue'
	import axios from 'axios'

  export default{
    mounted() { 
      	console.log('Egresos mounted')
		if(this.view_mode != 'new') this.fillForm()
		this.display = this.view_mode
		this.panel_title = this.title
    },
    name: 'Egreso-Form',
    components: {
      	PanelCard,
      	TitleComponent
    },
    props:[
      	'title',
      	'url',
		'record',
		'view_mode',
		'doctores'
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
		isDisabled: false,
		display: '',
		record_id: '',
		panel_title: '',
		all_errors: [ ],
        breadcrumb: [
          { text: 'Home', href: '/' },
          { text: 'Egresos', href: this.url+'/egresos' },
          { text: this.title, active: true },
				],
		toast_config: {
			position: 'top-center',
			className: 'toast-danger',
			duration: 3500,
			containerClass: 'container-template'
		},
		tipos: [
			{ nombre: 'Empresa' },
			{ nombre: 'Pago a Personal' },
			{ nombre: 'Otros' }
		]
      }
    },
    methods:{
    		onGuardar(){
    			var request = { method: 'POST', url: this.url + '/egresos', data: this.form }
    			var mssgOnFail = 'Existen campos inválidos. Por favor verificalos.'
    			this.onSubmit(request, mssgOnFail)    															
    		},
    		onModificar(){
    			var request = { method: 'PUT', url: this.url + '/egresos/'+ this.record_id, data: this.form }
    			var mssgOnFail = 'Existen campos inválidos. Por favor verificalos.'
    			this.onSubmit(request, mssgOnFail)
    		},
    		onEliminar(){
    			if( confirm('¿Está seguro que desea eliminar este registro?') ){
    				var request = { method: 'DELETE', url: this.url + '/egresos/'+ this.record_id,  }    				
					var mssgOnFail = 'El registro no ha podido ser eliminado.'
					this.onSubmit(request, mssgOnFail)
    			}
    		},
			onSubmit (request) {												
				if(request){
					axios(request).then((response) => {
						console.log(response)
						if(response.data.success){
							console.log('Response:: OK')
							window.location.href = this.url + '/egresos'
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
				this.form.fecha = this.record.fecha,
				this.form.tipo = this.record.tipo,
				this.form.doctor = this.record.doctorId,
				this.form.cantidad = this.record.cantidad,
				this.form.concepto = this.record.concepto,
				this.form.monto = this.record.monto,
				this.form.total = this.record.total,
				this.form.nota = this.record.nota
			},
			enableForm(){
				this.display = 'edit'
				this.panel_title = 'Modificar Egreso'
			},
			esCancelar(){
				if( this.display == 'new' ){
					window.location.href = this.url + '/egresos'
				}else{
					this.disableForm()
				}
			},
			disableForm(){
				this.display = 'show'
				this.panel_title = 'Detalle Egresos'
				this.fillForm()
			},
			calculateTotal(){				
				this.form.total = parseFloat(this.form.cantidad) * parseFloat(this.form.monto)				
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
			}
    }
  }

</script>