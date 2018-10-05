<template>
  <b-container id="container-template">
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Doctores" :items="breadcrumb" />
			</div>
      <div class="col-md-12">
        <PanelCard>
          <span slot="heading">{{panel_title}}</span>
          <div slot="body" class="pt-3 pb-3 pl-3 pr-3">
 
						<b-form>
							<!--input type="hidden" name="_token" :value="csrf"-->
							<div class="text-center">
								<div v-if="this.display != 'show'">								
									<b-button v-if="this.display != 'show'" type="submit" variant="success" v-on:click="onSubmit">
										<i class="fas fa-save"></i>&nbsp; Guardar
									</b-button>
									<b-button v-if="this.display != 'show'" :href="url + '/doctores'" variant="warning">
										<i class="fas fa-times-circle"></i>&nbsp;Cancelar
									</b-button>
								</div>

								<div v-if="this.display == 'show'">
									<b-button variant="primary" v-on:click="enableForm">
										<i class="fas fa-edit"></i>&nbsp; Modificar
									</b-button>
									<b-button variant="danger" v-on:click="onSubmit($event,'delete')">
									<i class="fas fa-trash-alt"></i>&nbsp;Eliminar
									</b-button>
									<b-button variant="warning" :href="url + '/doctores'">
										<i class="fas fa-chevron-circle-left"></i>&nbsp;Regresar
									</b-button>
								</div>
							</div>

							<div class="pt-4 pb-2">
									<b-row>
										<b-col cols="6" class="pt-3 pb-4">
											<div class="form-title">
												<i class="fas fa-user"></i>
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
										    <b-form-group label="Nombres" label-for="nombres">
											    <b-form-input id="nombres" type="text" class="required" v-model="form.nombres" :disabled="this.display == 'show'" placeholder="Nombres" required autocomplete="off"/>
													<span v-if="all_errors.nombres" :class="['label label-danger']">{{ all_errors.nombres[0] }}</span>
										    </b-form-group>
												<b-form-group label="Apellidos" label-for="apellidos">
													<b-form-input id="apellidos" type="text" class="required" v-model="form.apellidos" :disabled="this.display == 'show'" placeholder="Apellidos" required autocomplete="off"/>
													<span v-if="all_errors.apellidos" :class="['label label-danger']">{{ all_errors.apellidos[0] }}</span>
										    </b-form-group>
												<b-form-group label="DNI" label-for="dni">
													<b-form-input id="dni" type="text" class="required" v-model="form.dni" :disabled="this.display == 'show'" placeholder="DNI" required autocomplete="off"/>
													<span v-if="all_errors.dni" :class="['label label-danger']">{{ all_errors.dni[0] }}</span>
										    </b-form-group>
												<b-form-group label="Margen de Ganancia" label-for="margen_ganancia">
													<b-form-input id="margen_ganancia" type="number" v-model="form.margen_ganancia" :disabled="this.display == 'show'" placeholder="Margen de Ganancia" autocomplete="off" min="1" max="100"/>
													<span v-if="all_errors.margen_ganancia" :class="['label label-danger']">{{ all_errors.margen_ganancia[0] }}</span>
										    </b-form-group>				
										</b-col>
									</b-row>

									<b-row>
										<b-col cols="6" class="pt-3 pb-4">
											<div class="form-title">
												<i class="fas fa-user"></i>
												<div class="d-inline"> Información del Doctor </div>
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
												<b-form-group label="Fecha de Nacimiento" label-for="fechanacimiento">
													<b-form-input id="fechanacimiento" type="date" class="required" v-model="form.fechanacimiento" :disabled="this.display == 'show'" />
													<span v-if="all_errors.fechanacimiento" :class="['label label-danger']">{{ all_errors.fechanacimiento[0] }}</span>
												</b-form-group>

												<b-form-group label="Género">
													<b-form-radio-group id="rol_id" v-model="form.genero" :disabled="this.display == 'show'" name="genero">
														<b-form-radio value='Femenino'>Femenino</b-form-radio>
														<b-form-radio value='Masculino'>Masculino</b-form-radio>
													</b-form-radio-group>
													<span v-if="all_errors.genero" :class="['label label-danger']">{{ all_errors.genero[0] }}</span>
												</b-form-group>

												<b-form-group label="Estado Civil" label-for="estado">
													<b-form-select id="estado" class="required" v-model="form.estado" :options="estado_options" :disabled="this.display == 'show'" />
													<span v-if="all_errors.estado" :class="['label label-danger']">{{ all_errors.estado[0] }}</span>
												</b-form-group>
										</b-col>
									</b-row>

									<b-row>
										<b-col cols="6" class="pt-3 pb-4">
											<div class="form-title">
												<i class="fas fa-shield-alt"></i>
												<div class="d-inline">Información de Contacto</div>
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
												<b-form-group label="Dirección" label-for="direccion">
													<b-form-input id="direccion" type="text" class="required" v-model="form.direccion" :disabled="this.display == 'show'" placeholder="Dirección" required autocomplete="off"/>
													<span v-if="all_errors.direccion" :class="['label label-danger']">{{ all_errors.direccion[0] }}</span>
												</b-form-group>		
												<b-form-group label="Email" label-for="email">
													<b-form-input id="email" type="email" v-model="form.email" :disabled="this.display == 'show'" placeholder="Email" autocomplete="off"/>
													<span v-if="all_errors.email" :class="['label label-danger']">{{ all_errors.email[0] }}</span>
										    </b-form-group>	
												<b-form-group label="Teléfono" label-for="telefono">
											    <b-form-input id="telefono" type="text" v-model="form.telefono" placeholder="Teléfono" :disabled="this.display == 'show'" />
											    <span v-if="all_errors.telefono" :class="['label label-danger']">{{ all_errors.telefono[0] }}</span>
										    </b-form-group>
										    <b-form-group label="Celular" label-for="celular">
											    <b-form-input id="celular" type="text" v-model="form.celular" placeholder="Celular" :disabled="this.display == 'show'" />
											    <span v-if="all_errors.celular" :class="['label label-danger']">{{ all_errors.celular[0] }}</span>
										    </b-form-group>
										    <b-form-group label="Celular Alternativo" label-for="celular_aux">
											    <b-form-input id="celular_aux" type="text" v-model="form.celular_aux" placeholder="Celular Alternativo" :disabled="this.display == 'show'" />
											    <span v-if="all_errors.celular_aux" :class="['label label-danger']">{{ all_errors.celular_aux[0] }}</span>
										    </b-form-group>
										</b-col>
									</b-row>

							</div>

							<div class="text-center">
								<div v-if="this.display != 'show'">								
									<b-button v-if="this.display != 'show'" type="submit" variant="success" v-on:click="onSubmit">
										<i class="fas fa-save"></i>&nbsp; Guardar
									</b-button>
									<b-button v-if="this.display != 'show'" :href="url + '/doctores'" variant="warning">
										<i class="fas fa-times-circle"></i>&nbsp;Cancelar
									</b-button>
								</div>

								<div v-if="this.display == 'show'">
									<b-button variant="primary" v-on:click="enableForm">
										<i class="fas fa-edit"></i>&nbsp; Modificar
									</b-button>
									<b-button variant="danger" v-on:click="onSubmit($event,'delete')">
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
      console.log('doctores mounted')
			if(this.view_mode != 'new') this.fillForm()
			this.display = this.view_mode
			this.panel_title = this.title
    },
    name: 'User-Form',
    components: {
      PanelCard,
      TitleComponent
    },
    props:[
      'title',
      'url',
			'record',
			'view_mode'
    ],
    data(){
      return{
        form: {
					nombres: '',
					apellidos: '',
					dni: '',
					email: '',
					direccion: '',
					telefono: '',
					celular: '',
					margen_ganancia: '',
					genero: '',
					estado: '',
					celular_aux: '',
					fechanacimiento: ''
				},
				display: '',
				record_id: '',
				panel_title: '',
				all_errors: [],
				estado_options: [
					{ value: "Soltero", text: "Soltero" },
					{ value: "Casado", text: "Casado" },
					{ value: "Viudo", text: "Viudo" },
					{ value: "Divorciado", text: "Divorciado" },
				],
        breadcrumb: [
          { text: 'Home', href: '/' },
          { text: 'Doctores', href: this.url+'/doctores' },
          { text: this.title, active: true },
				],
				toast_config: {
					position: 'top-center',
					className: 'toast-danger',
					duration: 3500,
					containerClass: 'container-template'
				}
      }
    },
    methods:{
			onSubmit (e, action) {
				e.preventDefault();
				var request
				var mssgOnFail = 'Existen campos inválidos. Por favor verificalos.'
				
				if (this.display == 'edit') {
					request = { method: 'PUT', url: '/doctores/'+ this.record_id, data: this.form }
				} 
				else if (this.display == 'new') {
					request = { method: 'POST', url: '/doctores/'+ this.record_id, data: this.form }
				}
				else if (this.display == 'show' && action == 'delete' && confirm('¿Está seguro de eliminar este registro?')) {
					request = { method: 'DELETE', url: '/doctores/'+ this.record_id,  }
					mssgOnFail = 'El registro no ha podido ser eliminado.'
				}

				if(request){
					axios(request).then((response) => {
						if(response.data.success){
							console.log('Response:: OK')
							window.location.href = this.url + '/doctores'
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
				var dr = JSON.parse(this.record)
				this.record_id = dr.id
				this.form.nombres = dr.nombres
				this.form.apellidos = dr.apellidos
				this.form.dni = dr.dni
				this.form.email = dr.email
				this.form.direccion = dr.direccion
				this.form.telefono = dr.telefono
				this.form.celular = dr.celular
				this.form.margen_ganancia = dr.margen_ganancia
				this.form.genero = dr.genero
				this.form.estado = dr.estado
				this.form.celular_aux = dr.celular_aux
				this.form.fechanacimiento = dr.fechanacimiento
			},
			enableForm(){
				this.display = 'edit'
				this.panel_title = 'Modificar Doctor'
			}
    }
  }

</script>