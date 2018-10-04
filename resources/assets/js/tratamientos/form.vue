<template>
  <b-container id="container-template">
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Tratamientos" :items="breadcrumb" />
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
									<b-button v-if="this.display != 'show'" :href="url + '/tratamientos'" variant="warning">
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
									<b-button variant="warning" :href="url + '/tratamientos'">
										<i class="fas fa-chevron-circle-left"></i>&nbsp;Regresar
									</b-button>
								</div>
							</div>

							<div class="pt-4 pb-2">
									<b-row>
										<b-col cols="6" class="pt-3 pb-4">
											<div class="form-title">
												<i class="fas fa-stethoscope"></i>
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
										    <b-form-group label="Detalle" label-for="detalle">
											    <b-form-input id="detalle" type="text" class="required" v-model="form.detalle" :disabled="this.display == 'show'" placeholder="Detalle" required autocomplete="off"/>
													<span v-if="all_errors.detalle" :class="['label label-danger']">{{ all_errors.detalle[0] }}</span>
										    </b-form-group>
												<b-form-group label="Estado" label-for="is_active">
													<b-form-checkbox id="is_active" v-model="form.is_active" :disabled="display == 'show'">
														Tratamiedo Activado
													</b-form-checkbox>		
										    </b-form-group>		
										</b-col>
									</b-row>

							</div>

							<div class="text-center">
								<div v-if="this.display != 'show'">								
									<b-button v-if="this.display != 'show'" type="submit" variant="success" v-on:click="onSubmit">
										<i class="fas fa-save"></i>&nbsp; Guardar
									</b-button>
									<b-button v-if="this.display != 'show'" :href="url + '/tratamientos'" variant="warning">
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
      console.log('tratamientos mounted')
			if(this.view_mode != 'new') this.fillForm()
			this.display = this.view_mode
			this.panel_title = this.title
    },
    name: 'Tratamiento-Form',
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
					detalle: '',
					is_active: ''
				},
				display: '',
				record_id: '',
				panel_title: '',
				all_errors: [],
        breadcrumb: [
          { text: 'Home', href: '/' },
          { text: 'Tratamientos', href: this.url+'/tratamientos' },
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
					request = { method: 'PUT', url: '/tratamientos/'+ this.record_id, data: this.form }
				} 
				else if (this.display == 'new') {
					request = { method: 'POST', url: '/tratamientos/'+ this.record_id, data: this.form }
				}
				else if (this.display == 'show' && action == 'delete' && confirm('¿Está seguro de eliminar este registro?')) {
					request = { method: 'DELETE', url: '/tratamientos/'+ this.record_id,  }
					mssgOnFail = 'El registro no ha podido ser eliminado.'
				}

				if(request){
					axios(request).then((response) => {
						if(response.data.success){
							console.log('Response:: OK')
							window.location.href = this.url + '/tratamientos'
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
				console.log(this.record)
				var tr = JSON.parse(this.record)
				this.record_id = tr.id
				this.form.detalle = tr.detalle
				this.form.is_active = tr.is_active == '1'
			},
			enableForm(){
				this.display = 'edit'
				this.panel_title = 'Modificar Tratamiento'
			}
    }
  }

</script>