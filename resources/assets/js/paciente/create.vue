<template>	
	<b-container class="pb-4">				
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Dashboard" :items="breadcrumb" />				
			</b-col>
			<b-col cols="12" class="pt-3">				
				<PanelCard>
					<span slot="heading">Crear Pacientes </span>
					<div slot="body" class="pt-2 pb-2 pl-3 pr-3">
						<b-form id="form-create" @submit="onSubmit">
							<div class="text-center">
								<b-button type="submit" variant="success"><i class="fas fa-save"></i>&nbsp; Guardar</b-button>
								<b-button href="url + '/pacientes'" variant="danger"><i class="fas fa-times"></i>&nbsp;Cancelar</b-button>
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
										    <b-form-group label="<span class='required-red'>*</span> Nombres" label-for="nombres">
											    <b-form-input id="nombres" type="text" name="nombres" placeholder="Nombres" required />
										    </b-form-group>
										    <b-form-group label="<span class='required-red'>*</span> Apellidos" label-for="apellidos">
												<b-form-input id="apellidos" type="text" name="apellidos" placeholder="Apellidos" required />
										    </b-form-group>
										    <b-form-group label="<span class='required-red'>*</span> DNI" label-for="dni">
											    <b-form-input id="dni" type="text" name="dni" placeholder="DNI" maxlength="8" required />
										    </b-form-group>
										    <b-form-group label="Email" label-for="email">
												<b-form-input id="email" type="email" name="email" placeholder="Email" />
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
											    <b-form-input id="fechanacimiento" type="date" name="fechanacimiento" :value="myDate && myDate.toISOString().split('T')[0]" />
										    </b-form-group>
										    <b-form-group label="Género" label-for="genero">
										    	<b-form-select id="genero" name="genero" :options="genero.options" value="Masculino" />
										    </b-form-group>
										    <b-form-group label="Estado Civil" label-for="estado">
										     	<b-form-select id="estado" name="estado" :options="estadoCivil.options" value="Soltero" />
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
											<b-form-group label="<span class='required-red'>*</span> Dirección" label-for="direccion">
											    <b-form-input id="direccion" type="text" name="direccion" placeholder="Dirección" required />
										    </b-form-group>									    
										    <b-form-group label="Teléfono" label-for="telefono">
											    <b-form-input id="telefono" type="text" name="telefono" placeholder="Teléfono" />
										    </b-form-group>
										    <b-form-group label="Teléfono Alternativo" label-for="fax">
											    <b-form-input id="fax" type="text" name="fax" placeholder="Teléfono Alternativo" />
										    </b-form-group>
										    <b-form-group label="Celular" label-for="celular">
											    <b-form-input id="celular" type="text" name="celular" placeholder="Celular" />
										    </b-form-group>
										    <b-form-group label="Celular Alternativo" label-for="celular_aux">
											    <b-form-input id="celular_aux" type="text" name="celular_aux" placeholder="Celular Alternativo" />
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
										     	<b-form-select id="empresa_id" name="empresa_id" :options=empresas :value="1" />
										    </b-form-group>
										    <b-form-group label="Vínculo:" label-for="seguro_ind">
										     	<b-form-select id="seguro_ind" name="seguro_ind" :options=vinculo.options :value=null />
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
									    		<b-form-input id="nombre_apoderado" type="text" name="nombre_apoderado" placeholder="Nombre de Apoderado" />
									      	</b-form-group>
									      	<b-form-group label="Celular de Apoderado:" label-for="celular_apoderado">
									    		<b-form-input id="celular_apoderado" type="text" name="celular_apoderado" placeholder="Celular de Apoderado" />
									      	</b-form-group>
										</b-col>
									</b-row>							
							</div>
							<div class="text-center">
								<b-button type="submit" variant="success"><i class="fas fa-save"></i>&nbsp; Guardar</b-button>
								<b-button href="url + '/pacientes'" variant="danger"><i class="fas fa-times"></i>&nbsp;Cancelar</b-button>
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
	
	export default{
		mounted(){
			console.log('Paciente Created Mounted')
		},
		components:{
			TitleComponent,
			PanelCard
		},
		props: [
			'items',
			'url',
			'empresas'
		],
		methods:{
			onSubmit (evt) {
		      evt.preventDefault();
		      //Validaciones
		      //Validar apoderado obligatorio
		      //Crear nuevo paciente
		      console.log(JSON.stringify(this.form));
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
				breadcrumb: [
			    	{ text: 'Dashboard', href: this.url },
			    	{ text: 'Pacientes', href: this.url + '/pacientes' },
			    	{ text: 'Crear', active: true }
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