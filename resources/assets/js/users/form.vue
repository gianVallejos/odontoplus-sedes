<template>
  <b-container id="container-template">
		<b-row>
			<div class="col-md-12">
				<TitleComponent titulo="Usuarios" :items="breadcrumb" />
			</div>
      <div class="col-md-12">
        <PanelCard>
          <span slot="heading">{{title}}</span>
          <div slot="body" class="pt-3 pb-3 pl-3 pr-3">
 
						<b-form>
							<!--input type="hidden" name="_token" :value="csrf"-->
							<div class="text-center">
								<div v-if="display != 'show'">								
									<b-button v-if="display != 'show'" type="submit" variant="success" v-on:click="onSubmit">
										<i class="fas fa-save"></i>&nbsp; Guardar
									</b-button>
									<b-button v-if="display != 'show'" :href="url + '/users'" variant="warning">
										<i class="fas fa-times-circle"></i>&nbsp;Cancelar
									</b-button>
								</div>

								<div v-if="display == 'show'">
									<b-button variant="primary" v-on:click="enableForm">
										<i class="fas fa-edit"></i>&nbsp; Modificar
									</b-button>
									<b-button variant="danger" v-on:click="onDelete">
									<i class="fas fa-trash-alt"></i>&nbsp;Eliminar
									</b-button>
									<b-button variant="warning" :href="url + '/users'">
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
											    <b-form-input id="nombres" type="text" class="required" v-model="form.name" :disabled="display == 'show'" placeholder="Nombres" required autocomplete="off"/>
													<span v-if="all_errors.name" :class="['label label-danger']">{{ all_errors.name[0] }}</span>
										    </b-form-group>
												<b-form-group label="Email" label-for="email">
													<b-form-input id="email" type="email" class="required" v-model="form.email" :disabled="display == 'show'" placeholder="Email" required autocomplete="off"/>
													<span v-if="all_errors.email" :class="['label label-danger']">{{ all_errors.email[0] }}</span>
										    </b-form-group>		
										    <b-form-group label="Contraseña" label-for="password">
													<b-form-input id="password" type="password" class="required" v-model="form.password" :disabled="display == 'show'" placeholder="Contraseña" required autocomplete="off" maxlength="20"/>
													<span v-if="all_errors.password" :class="['label label-danger']">{{ all_errors.password[0] }}</span>
										    </b-form-group>
										    <b-form-group label="Confirmar Contraseña" label-for="confirm_password">
											    <b-form-input id="confirm_password" type="password" class="required" v-model="form.confirm_password" :disabled="display == 'show'" placeholder="Confirmar Contraseña" required autocomplete="off" maxlength="20"/>
													<span v-if="all_errors.confirm_password" :class="['label label-danger']">{{ all_errors.confirm_password[0] }}</span>
										    </b-form-group>
										</b-col>
									</b-row>

									<b-row>
										<b-col cols="6" class="pt-3 pb-4">
											<div class="form-title">
												<i class="fas fa-shield-alt"></i>
												<div class="d-inline">Seguridad</div>
											</div>
											<p class="form-description fz-3 pt-3 pr-4">
												On sait depuis longtemps que travailler avec du texte lisible et contenant du sens est source de distractions.
											</p>
										</b-col>
										<b-col cols="6" class="pt-3 pb-4">										
												<b-form-group label="Rol">
													<b-form-radio-group id="rol_id" v-model="form.rolid" :disabled="display == 'show'" name="radioSubComponent">
														<b-form-radio value=2>Colaborador</b-form-radio>
														<b-form-radio value=1>Administrador</b-form-radio>
													</b-form-radio-group>
												</b-form-group>
												<b-form-group label="Estado" label-for="is_active">
													<b-form-checkbox id="is_active" v-model="form.is_active" :disabled="display == 'show'">
														Usuario Activado
													</b-form-checkbox>		
										    </b-form-group>
										</b-col>
									</b-row>

							</div>

							<div class="text-center">
								<div v-if="display != 'show'">								
									<b-button v-if="display != 'show'" type="submit" variant="success" v-on:click="onSubmit">
										<i class="fas fa-save"></i>&nbsp; Guardar
									</b-button>
									<b-button v-if="display != 'show'" :href="url + '/users'" variant="warning">
										<i class="fas fa-times-circle"></i>&nbsp;Cancelar
									</b-button>
								</div>

								<div v-if="display == 'show'">
									<b-button variant="primary" v-on:click="enableForm">
										<i class="fas fa-edit"></i>&nbsp; Modificar
									</b-button>
									<b-button variant="danger" v-on:click="onDelete">
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
      console.log('Users mounted')
			if(this.display != 'new'){
				this.fillForm()
			}
    },
    name: 'User-Form',
    components: {
      PanelCard,
      TitleComponent
    },
    props:[
      'title',
      'url',
			'user',
			'display'
    ],
    data(){
      return{
        form: {
						name: '',
						email: '',
						password: '',
						confirm_password: '',
						rolid:2,
						is_active:true
				},
				user_id: '',
				all_errors: [],
        breadcrumb: [
          { text: 'Home', href: '/' },
          { text: 'Usuarios', href: this.url+'/users' },
          { text: this.title, active: true },
        ]
      }
    },
    methods:{
			onSubmit (e) {
				e.preventDefault();
				var method
				var url = '/users'
				if (this.display == 'edit') {
					method = 'PUT'
					url += '/'+ this.user_id
				} 
				else if (this.display == 'new'){
					method = 'POST'
				} 

				if(method){
					axios({ method: method, url: url, data: this.form }).then((response) => {
						if(response.data.success){

							console.log('Response:: OK')
							window.location.href = this.url + '/users'

						}
						else if (response.data.error){

							console.log('Response:: FAIL');
							this.all_errors = response.data.error
							this.$toasted.show('Existen campos inválidos. Por favor verificalos.',{
								position: 'top-center',
								className: 'toast-danger',
								duration: 3500,
								containerClass: 'container-template'
							})

						}

					}).catch(function (error) {
						console.log(error);
					});
				}

			},
			onDelete(e){
				e.preventDefault();
				if( confirm('¿Esta seguro de eliminar este Usuario?') ){
					axios.delete(this.url + '/users/' + this.user_id).then( (response) => {			
						console.log(response)

						if(response.data.success){

							console.log('Response:: OK')
							window.location.href = this.url + '/users'

						}
						else if (response.data.error){

							console.log('Response:: FAIL');
							this.all_errors = response.data.error
							this.$toasted.show('El usuario no podido ser eliminado.',{
								position: 'top-center',
								className: 'toast-danger',
								duration: 1003500,
								containerClass: 'container-template'
							})
						}
					}).catch((error) => {
						console.log(error)
						this.$toasted.show('Ha ocurrido un error crítico, por favor comunicarse con Odontoplus.pe. Redireccionando...', 
						{ 
							position: 'top-center',
							className: 'toast-danger',
							duration: 102500,
							containerClass: 'test'
						})
						this.success = false
						this.isModificar = false
						setTimeout(function () {
									//window.location.href = this.url + '/users'
						}.bind(this), 2500)
					})
				}
		  },
			fillForm(){
				var user = JSON.parse(this.user)
				this.user_id = user.id
				this.form.name = user.name
				this.form.email = user.email
				this.form.rolid = user.rolid
				this.form.is_active = user.is_active == '1'
			},
			enableForm(){
				this.display = 'edit'
			}
    }
  }

</script>