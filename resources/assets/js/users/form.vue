<template>
  <b-container>
		<b-row>
			<div class="col-md-12">
				<TitleComponent :titulo="title" :items="breadcrumb" />
			</div>
      <div class="col-md-12">
        <PanelCard>
          <span slot="heading">{{title}}</span>
          <div slot="body" class="pt-3 pb-3 pl-3 pr-3">
 
						<b-form>
							<!--input type="hidden" name="_token" :value="csrf"-->

							<div class="text-center">
								<b-button type="submit" variant="success" v-on:click="onSubmit">
									<i class="fas fa-save"></i>&nbsp; Guardar
								</b-button>
								<b-button :href="url + '/users'" variant="danger">
									<i class="fas fa-times"></i>&nbsp;Cancelar
								</b-button>
							</div>
							<div class="pt-4 pb-2">							
									<b-row>
										<b-col cols="6" class="pt-3 pb-4">
											<div class="form-title">
												<i class="fas fa-user"></i>
												<div class="d-inline"> Informació de Usuario </div>
											</div>
											<p class="form-description fz-3 pt-3 pr-4">
												On sait depuis longtemps que travailler avec du texte lisible et contenant du sens est source de distractions.
											</p>
											<p class="form-description fz-3 pt-3 pr-4">
												<span class='required-red'>*</span> Campos obligatorios.
											</p>
										</b-col>
										<b-col cols="6" class="pt-3 pb-4">										
										    <b-form-group label="<span class='required-red'>*</span> Nombres" label-for="nombres">
											    <b-form-input id="nombres" type="text" v-model="form.name" placeholder="Nombres" required autocomplete="off"/>
										    </b-form-group>
												<b-form-group label="<span class='required-red'>*</span>  Email" label-for="email">
													<b-form-input id="email" type="email" v-model="form.email" placeholder="Email" required autocomplete="off"/>
										    </b-form-group>		
										    <b-form-group label="<span class='required-red'>*</span> Contraseña" label-for="password">
												<b-form-input id="password" type="password" v-model="form.password" placeholder="Contraseña" required autocomplete="off" maxlength="20"  />
										    </b-form-group>
										    <b-form-group label="<span class='required-red'>*</span> Confirmar Contraseña" label-for="confirm_password">
											    <b-form-input id="confirm_password" type="password" v-model="form.confirm_password" placeholder="Confirmar Contraseña" required autocomplete="off" maxlength="20"  />
										    </b-form-group>
							    
										</b-col>
									</b-row>							
							</div>
							<div class="text-center">
								<b-button type="submit" variant="success" v-on:click="onSubmit">
									<i class="fas fa-save"></i>&nbsp; Guardar
								</b-button>
								<b-button :href="url + '/users'" variant="danger"><i class="fas fa-times"></i>&nbsp;Cancelar</b-button>
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
    },
    name: 'User-Form',
    components: {
      PanelCard,
      TitleComponent
    },
    props:[
      'title',
      'url'
    ],
    data(){
      return{
        form: {
						name: '',
						email: '',
						password: '',
						confirm_password: ''		        
        },
        breadcrumb: [
          { text: 'Home', href: '/' },
          { text: 'Usuarios', href: this.url+'/users' },
          { text: this.title, active: true },
        ]
      }
    },
    methods:{
			onSubmit (evt) {
		      evt.preventDefault();
					console.log(JSON.stringify(this.form))
					
					axios.post( this.url+'/users', this.form)
					.then(function (response) {
						console.log(response);
					})
					.catch(function (error) {
						console.log(error);
					});
		  }
    }
  }

</script>