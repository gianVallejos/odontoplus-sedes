<template>	
	<b-container id="test" class="pb-4">				
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Dashboard" :items="breadcrumb" />				
			</b-col>
			<b-col cols="12" class="pt-3">				
				<PanelCard>
					<span slot="heading">Crear Paciente </span>
					<div slot="body" class="pt-2 pb-2 pl-3 pr-3">
						<b-form>
							<input type="hidden" name="_token" :value="csrf">

							<div class="text-center">
								<b-button type="submit" variant="success" v-on:click="onSubmit">
									<i class="fas fa-save"></i>&nbsp; Guardar
								</b-button>
								<b-button :href="url + '/pacientes'" variant="danger">
									<i class="fas fa-times"></i>&nbsp;Cancelar
								</b-button>
							</div>
							<div class="pt-4 pb-2">							
									<b-row>
										<b-col cols="6" class="pt-3 pb-4">
											<div class="form-title">
												<i class="fas fa-child"></i> 
												<div class="d-inline"> Información General </div>
											</div>
											<p class="form-description fz-3 pt-3 pr-4">
												On sait depuis longtemps que travailler avec du texte lisible et contenant du sens est source de distractions, et empêche de se concentrer sur la mise en page elle-même. 
											</p>
										</b-col>
										<b-col cols="6" class="pt-3 pb-4">										
										    <b-form-group label="Nombres" label-for="nombres">
											    <b-form-input id="nombres" type="text" v-model="form.nombres" placeholder="Nombres" class="required" :disabled=isDisabled required  />
											    <span v-if="allerros.nombres" :class="['label label-danger']">{{ allerros.nombres[0] }}</span>
										    </b-form-group>
										    <b-form-group label="Apellidos" label-for="apellidos">
												<b-form-input id="apellidos" type="text" v-model="form.apellidos" placeholder="Apellidos" class="required" :disabled=isDisabled required />
												<span v-if="allerros.apellidos" :class="['label label-danger']">{{ allerros.apellidos[0] }}</span>
										    </b-form-group>
										    <b-form-group label="DNI" label-for="dni">
											    <b-form-input id="dni" type="text" v-model="form.dni" placeholder="DNI" maxlength="8" class="required" :disabled=isDisabled required />
											    <span v-if="allerros.dni" :class="['label label-danger']">{{ allerros.dni[0] }}</span>
										    </b-form-group>
										    <b-form-group label="Email" label-for="email">
												<b-form-input id="email" type="email" v-model="form.email" placeholder="Email" :disabled=isDisabled />
												<span v-if="allerros.email" :class="['label label-danger']">{{ allerros.email[0] }}</span>
										    </b-form-group>									    
										</b-col>

										<b-col cols="6" class="pt-3 pb-4">
											<div class="form-title">
												<i class="fas fa-briefcase-medical"></i>
												<div class="d-inline"> Información del Paciente </div>
											</div>
											<p class="form-description fz-3 pt-3 pr-4">
												On sait depuis longtemps que travailler avec du texte lisible et contenant du sens est source de distractions, et empêche de se concentrer sur la mise en page elle-même. 
											</p>
										</b-col>
										<b-col cols="6" class="pt-3 pb-4">										
										    <b-form-group label="Fecha de Nacimiento" label-for="fechanacimiento">
											    <b-form-input id="fechanacimiento" type="date" v-model="form.fechanacimiento" 
											    			  :value="myDate && myDate.toISOString().split('T')[0]" :disabled=isDisabled />
											    <span v-if="allerros.fechanacimiento" :class="['label label-danger']">{{ allerros.fechanacimiento[0] }}</span>
										    </b-form-group>
										    <b-form-group label="Género" label-for="genero">
										    	<b-form-select id="genero" v-model="form.genero" :options="genero.options" :disabled=isDisabled />
										    	<span v-if="allerros.genero" :class="['label label-danger']">{{ allerros.genero[0] }}</span>
										    </b-form-group>
										    <b-form-group label="Estado Civil" label-for="estado">
										     	<b-form-select id="estado" v-model="form.estado" :options="estadoCivil.options" :disabled=isDisabled />
										     	<span v-if="allerros.estado" :class="['label label-danger']">{{ allerros.estado[0] }}</span>
										    </b-form-group>
										</b-col>

										<b-col cols="6">
											<div class="form-title">
												<i class="fas fa-file-signature"></i> 
												<div class="d-inline"> Información de Contacto </div>
											</div>
											<p class="form-description fz-3 pt-3 pr-4">
												On sait depuis longtemps que travailler avec du texte lisible et contenant du sens est source de distractions, et empêche de se concentrer sur la mise en page elle-même. 
											</p>
										</b-col>

										<b-col cols="6" class="pt-3 pb-4">
											<b-form-group label="Dirección" label-for="direccion">
											    <b-form-input id="direccion" type="text" v-model="form.direccion" placeholder="Dirección" class="required" :disabled=isDisabled  />
											    <span v-if="allerros.direccion" :class="['label label-danger']">{{ allerros.direccion[0] }}</span>
										    </b-form-group>									    
										    <b-form-group label="Teléfono" label-for="telefono">
											    <b-form-input id="telefono" type="text" v-model="form.telefono" placeholder="Teléfono" :disabled=isDisabled />
											    <span v-if="allerros.telefono" :class="['label label-danger']">{{ allerros.telefono[0] }}</span>
										    </b-form-group>
										    <b-form-group label="Teléfono Alternativo" label-for="fax">
											    <b-form-input id="fax" type="text" v-model="form.fax" placeholder="Teléfono Alternativo" :disabled=isDisabled />
											    <span v-if="allerros.fax" :class="['label label-danger']">{{ allerros.fax[0] }}</span>
										    </b-form-group>
										    <b-form-group label="Celular" label-for="celular">
											    <b-form-input id="celular" type="text" v-model="form.celular" placeholder="Celular" :disabled=isDisabled />
											    <span v-if="allerros.celular" :class="['label label-danger']">{{ allerros.celular[0] }}</span>
										    </b-form-group>
										    <b-form-group label="Celular Alternativo" label-for="celular_aux">
											    <b-form-input id="celular_aux" type="text" v-model="form.celular_aux" placeholder="Celular Alternativo" :disabled=isDisabled />
											    <span v-if="allerros.celular_aux" :class="['label label-danger']">{{ allerros.celular_aux[0] }}</span>
										    </b-form-group>
										</b-col>

										<b-col cols="6">
											<div class="form-title">
												<i class="fas fa-building"></i> 
												<div class="d-inline"> Información Externa </div>
											</div>
											<p class="form-description fz-3 pt-3 pr-4">
												On sait depuis longtemps que travailler avec du texte lisible et contenant du sens est source de distractions, et empêche de se concentrer sur la mise en page elle-même. 
											</p>
										</b-col>
										<b-col cols="6" class="pt-3 pb-4">
											<b-form-group label="Empresa:" label-for="empresa_id">
										     	<b-form-select id="empresa_id" v-model="form.empresa_id" :options=empresas :value="1" :disabled=isDisabled />
										     	<span v-if="allerros.empresa_id" :class="['label label-danger']">{{ allerros.empresa_id[0] }}</span>
										    </b-form-group>
										    <b-form-group label="Vínculo:" label-for="seguro_ind">
										     	<b-form-select id="seguro_ind" v-model="form.seguro_ind" :options=vinculo.options :value=null :disabled=isDisabled />
										     	<span v-if="allerros.seguro_ind" :class="['label label-danger']">{{ allerros.seguro_ind[0] }}</span>
										    </b-form-group>
										</b-col>

										<b-col cols="6">
											<div class="form-title">
												<i class="fas fa-address-card"></i> 
												<div class="d-inline"> Información de Apoderado </div>
											</div>
											<p class="form-description fz-3 pt-3 pr-4">
												On sait depuis longtemps que travailler avec du texte lisible et contenant du sens est source de distractions, et empêche de se concentrer sur la mise en page elle-même. 
											</p>
										</b-col>
										<b-col cols="6" class="pt-3 pb-4">
											<b-form-group label="Nombre de Apoderado:" label-for="nombre_apoderado">
									    		<b-form-input id="nombre_apoderado" type="text" v-model="form.nombre_apoderado" placeholder="Nombre de Apoderado" :disabled=isDisabled />
									    		<span v-if="allerros.nombre_apoderado" :class="['label label-danger']">{{ allerros.nombre_apoderado[0] }}</span>
									      	</b-form-group>
									      	<b-form-group label="Celular de Apoderado:" label-for="celular_apoderado">
									    		<b-form-input id="celular_apoderado" type="text" v-model="form.celular_apoderado" placeholder="Celular de Apoderado" :disabled=isDisabled />
									    		<span v-if="allerros.celular_apoderado" :class="['label label-danger']">{{ allerros.celular_apoderado[0] }}</span>
									      	</b-form-group>
										</b-col>
									</b-row>							
							</div>
							<div class="text-center">
								<b-button type="submit" variant="success" v-on:click="onSubmit">
									<i class="fas fa-save"></i>&nbsp; Guardar
								</b-button>
								<b-button :href="url + '/pacientes'" variant="danger">
									<i class="fas fa-times"></i>&nbsp;Cancelar
								</b-button>
							</div>
						</b-form>
					</div>
				</PanelCard>
			</b-col>
		</b-row>
	</b-container>
</template>
<script>
	import TitleComponent from '../widgets/titulo/index.vue'
	import PanelCard from '../widgets/panel/panel-component.vue'	
	import axios from 'axios'
	
	export default{
		mounted(){
			this.isDisabled = false
			console.log('Paciente Created Mounted')			
		},
		components:{
			TitleComponent,
			PanelCard
		},
		props: [
			'url',
			'empresas'
		],
		methods:{
			onSubmit (e) {
				e.preventDefault()
				axios.post(this.url + '/api-v1/op-crear-paciente', 
							this.form).then( (request) => {			
					if( request.data.success == 'success' ){
						console.log(request.data)						
						this.success = true						
					}else{
						console.log(request.data)						
                        this.success = false						
					}

					if( !this.success ){
						this.allerros = request.data.error
						this.$toasted.show('Existen campos inválidos. Por favor verificalos.', 
											{ 
												position: 'top-center',
												className: 'toast-danger',
												duration: 3500,
												containerClass: 'test'
											})
					}else{
						this.allerros = []
						this.$toasted.show('Campo agregado correctamente.', 
											{ 
												position: 'top-center',
												className: 'toast-success',
												duration: 3500,
												containerClass: 'test'
											})
						this.isDisabled = true
						setTimeout(function () {
						    window.location.href = this.url + '/pacientes'
						}.bind(this), 3500)
					}
				}).catch((error) => {
                    this.$toasted.show('Ha ocurrido un error crítico, por favor comunicarse con Odontoplus.pe', 
										{ 
												position: 'top-center',
												className: 'toast-danger',
												duration: 3500,
												containerClass: 'test'
										})
                   	this.success = false
                   	setTimeout(function () {
					    window.location.href = this.url + '/pacientes'
					}.bind(this), 3500)
                })
		    },
		    setMyDateToToday() {
		      this.myDate = new Date();		      
		    },
		    addADayToMyDate() {
		      if (this.myDate) // as myDate can be null		        
		        this.myDate = new Date(this.myDate.setDate(this.myDate.getDate() + 1));
		    }
		},
		data(){
			return{
				myDate: new Date(),
				csrf: document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
				form: {
					nombres: '',
					apellidos: '',
					dni: '',
					email: '',
					fechanacimiento: '',
					genero: 'Masculino',
					estado: 'Soltero',
					direccion: '',
					telefono: '',
					fax: '',
					celular: '',
					celular_aux: '',
					empresa_id: '1',
					seguro_ind: null,
					nombre_apoderado: '',
					celular_apoderado: ''
				},
				isDisabled: false,
				allerros: [],
				success : false,
				breadcrumb: [
			    	{ text: 'Dashboard', href: this.url },
			    	{ text: 'Pacientes', href: this.url + '/pacientes' },
			    	{ text: 'Crear Paciente', active: true }
			    ],
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
						{ value: null, text: "Ningún vínculo seleccionado" },
						{ value: 1, text: "Trabajador" },
						{ value: 2, text: "Hijo/Hija" },
						{ value: 3, text: "Padre" },
						{ value: 4, text: "Otro" }
					]
				}
			}
		}
	}
</script>