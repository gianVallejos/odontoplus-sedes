<template>
  <b-container id="container-template">
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Proveedores & Laboratorios" :items="breadcrumb" />
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
									<b-button v-if="this.display != 'show'" :href="url + '/proveedores'" variant="warning">
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
									<b-button variant="warning" :href="url + '/proveedores'">
										<i class="fas fa-chevron-circle-left"></i>&nbsp;Regresar
									</b-button>
								</div>
							</div>

							<div class="pt-4 pb-2">
									<b-row>
										<b-col cols="6" class="pt-3 pb-4">
											<div class="form-title">
												<i class="fas fa-ambulance"></i>
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
										    <b-form-group label="Nombre" label-for="nombre">
											    <b-form-input id="nombre" type="text" class="required" v-model="form.nombres" :disabled="this.display == 'show'" placeholder="Nombre" required autocomplete="off"/>
													<span v-if="all_errors.nombres" :class="['label label-danger']">{{ all_errors.nombres[0] }}</span>
										    </b-form-group>

												<b-form-group label="DNI" label-for="dni">
													<b-form-input id="dni" type="text" v-model="form.dni" :disabled="this.display == 'show'" pattern="[0-9]{8}" placeholder="Nro. DNI" autocomplete="off"/>
													<span v-if="all_errors.dni" :class="['label label-danger']">{{ all_errors.dni[0] }}</span>
												</b-form-group>

												<b-form-group label="Empresa" label-for="empresa">
											    <b-form-input id="empresa" type="text" v-model="form.empresa" :disabled="this.display == 'show'" placeholder="Empresa" autocomplete="off"/>
													<span v-if="all_errors.empresa" :class="['label label-danger']">{{ all_errors.empresa[0] }}</span>
										    </b-form-group>

												<b-form-group label="RUC" label-for="ruc">
													<b-form-input id="ruc" type="text" v-model="form.ruc" :disabled="this.display == 'show'" pattern="[0-9]{11}" placeholder="Nro. RUC" autocomplete="off"/>
													<span v-if="all_errors.ruc" :class="['label label-danger']">{{ all_errors.ruc[0] }}</span>
												</b-form-group>

												<b-form-group label="Ciudad" label-for="ciudad">
											    <b-form-input id="ciudad" type="text" v-model="form.ciudad" :disabled="this.display == 'show'" placeholder="Ciuidad" autocomplete="off"/>
													<span v-if="all_errors.ciudad" :class="['label label-danger']">{{ all_errors.ciudad[0] }}</span>
										    </b-form-group>

												<b-form-group label="Tipo" label-for="tipo_id">
													<b-form-select id="tipo_id" class="required" v-model="form.tipo_id" :options="tipo_id_options" :disabled="this.display == 'show'" />
													<span v-if="all_errors.tipo_id" :class="['label label-danger']">{{ all_errors.tipo_id[0] }}</span>
												</b-form-group>

												<b-form-group label="Insumo" label-for="insumo_id">
													<b-form-select id="insumo_id" class="required" v-model="form.insumo_id" :options="insumo_id_options" :disabled="this.display == 'show'" />
													<span v-if="all_errors.insumo_id" :class="['label label-danger']">{{ all_errors.insumo_id[0] }}</span>
												</b-form-group>
										</b-col>
									</b-row>
							</div>

							<div class="pt-4 pb-2">
									<b-row>
										<b-col cols="6" class="pt-3 pb-4">
											<div class="form-title">
												<i class="far fa-address-card"></i>
												<div class="d-inline"> Información de Contacto </div>
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
											    <b-form-input id="direccion" type="text" v-model="form.direccion" :disabled="this.display == 'show'" placeholder="Dirección" autocomplete="off"/>
													<span v-if="all_errors.direccion" :class="['label label-danger']">{{ all_errors.direccion[0] }}</span>
										    </b-form-group>

										    <b-form-group label="Email" label-for="email">
											    <b-form-input id="email" type="text" v-model="form.email" :disabled="this.display == 'show'" placeholder="Email" autocomplete="off"/>
													<span v-if="all_errors.email" :class="['label label-danger']">{{ all_errors.email[0] }}</span>
										    </b-form-group>

										    <b-form-group label="Teléfono" label-for="telefono">
											    <b-form-input id="telefono" type="text" v-model="form.telefono" :disabled="this.display == 'show'" placeholder="Teléfono" autocomplete="off"/>
													<span v-if="all_errors.telefono" :class="['label label-danger']">{{ all_errors.telefono[0] }}</span>
										    </b-form-group>

										    <b-form-group label="Celular" label-for="celular">
											    <b-form-input id="celular" type="text" v-model="form.celular" :disabled="this.display == 'show'" placeholder="Celular" autocomplete="off"/>
													<span v-if="all_errors.celular" :class="['label label-danger']">{{ all_errors.celular[0] }}</span>
										    </b-form-group>
										</b-col>
									</b-row>
							</div>

							<div class="pt-4 pb-2">
									<b-row>
										<b-col cols="6" class="pt-3 pb-4">
											<div class="form-title">
												<i class="far fa-credit-card"></i>
												<div class="d-inline"> Información Bancaria </div>
											</div>
											<p class="form-description fz-3 pt-3 pr-4">
												On sait depuis longtemps que travailler avec du texte lisible et contenant du sens est source de distractions.
											</p>
											<br/>
										</b-col>
										<b-col cols="6" class="pt-3 pb-4">
										    <b-form-group label="Banco" label-for="banco">
											    <b-form-input id="banco" type="text" v-model="form.banco" :disabled="this.display == 'show'" placeholder="Banco" autocomplete="off"/>
													<span v-if="all_errors.banco" :class="['label label-danger']">{{ all_errors.banco[0] }}</span>
										    </b-form-group>
										    <b-form-group label="Nro. de Cuenta" label-for="nrocuenta">
											    <b-form-input id="nrocuenta" type="text" v-model="form.nrocuenta" :disabled="this.display == 'show'" placeholder="Nro. de Cuenta" autocomplete="off"/>
													<span v-if="all_errors.nrocuenta" :class="['label label-danger']">{{ all_errors.nrocuenta[0] }}</span>
										    </b-form-group>
										</b-col>
									</b-row>
							</div>

							<div class="text-center">
								<div v-if="this.display != 'show'">								
									<b-button v-if="this.display != 'show'" type="submit" variant="success" v-on:click="onSubmit">
										<i class="fas fa-save"></i>&nbsp;Guardar
									</b-button>
									<b-button v-if="this.display != 'show'" :href="url + '/proveedores'" variant="warning">
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
      console.log('proveedores mounted')
			if(this.view_mode != 'new') this.fillForm()
			this.display = this.view_mode
			this.panel_title = this.title
    },
    name: 'Empresa-Form',
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
          email: '',
          direccion: '',
          dni: '',
          telefono: '',
          celular: '',
          empresa: '',
          ciudad: '',
          ruc: '',
          banco: '',
          nrocuenta: '',
          insumo_id: '',
          tipo_id: ''
				},
				display: '',
				record_id: '',
				panel_title: '',
				all_errors: [],
				tipo_id_options: [
					{ value: 1, text: "op one one" },
					{ value: 2, text: "op two" },
					{ value: 3, text: "op three" },
					{ value: 4, text: "op four" },
				],
				insumo_id_options: [
					{ value: 1, text: "op one" },
					{ value: 2, text: "op two" },
					{ value: 3, text: "op three" },
					{ value: 4, text: "op four" },
				],
        breadcrumb: [
          { text: 'Home', href: '/' },
          { text: 'Proveedores & Laboratorios', href: this.url+'/proveedores' },
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
					request = { method: 'PUT', url: '/proveedores/'+ this.record_id, data: this.form }
				} 
				else if (this.display == 'new') {
					request = { method: 'POST', url: '/proveedores/'+ this.record_id, data: this.form }
				}
				else if (this.display == 'show' && action == 'delete' && confirm('¿Está seguro de eliminar este registro?')) {
					request = { method: 'DELETE', url: '/proveedores/'+ this.record_id,  }
					mssgOnFail = 'El registro no ha podido ser eliminado.'
				}

				if(request){
					axios(request).then((response) => {
						if(response.data.success){
							window.location.href = this.url + '/proveedores'
						}
						else if (response.data.error){
							this.all_errors = response.data.error
							this.$toasted.show( ( mssgOnFail ),this.toast_config)
						}
					}).catch(function (error) {
						console.log(error);
					});
				}

			},
			fillForm(){
				var p = JSON.parse(this.record)
				this.record_id = p.id
        this.form.nombres = p.nombres
        this.form.email = p.email
        this.form.direccion = p.direccion
        this.form.dni = p.dni
        this.form.telefono = p.telefono
        this.form.celular = p.celular
        this.form.empresa = p.empresa
        this.form.ciudad = p.ciudad
        this.form.ruc = p.ruc
        this.form.banco = p.banco
        this.form.nrocuenta = p.nrocuenta
        this.form.insumo_id = p.insumo_id
        this.form.tipo_id = p.tipo_id
			},
			enableForm(){
				this.display = 'edit'
				this.panel_title = 'Modificar Proveedor/Laboratorio'
			}
    }
  }

</script>