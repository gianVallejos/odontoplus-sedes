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
						<div class="text-center">
							<b-button variant="success">Guardar</b-button>
							<b-button variant="danger">Cancelar</b-button>
						</div>
						<div class="pt-4 pb-4">
							<b-form @submit="onSubmit">
								<b-row>
									<b-col cols="6" class="pt-3 pb-4">
										<div class="form-title">
											<i class="fas fa-child"></i> 
											<div class="d-inline"> Información de Paciente </div>
										</div>
										<p class="form-description fz-3 pt-3 pr-4">
											On sait depuis longtemps que travailler avec du texte lisible et contenant du sens est source de distractions, et empêche de se concentrer sur la mise en page elle-même. 
										</p>
									</b-col>
									<b-col cols="6" class="pt-3 pb-4">
										<div v-for="formdata in formdatas">											
											<b-form-group :label="formdata.label" :label-for="formdata.name">
										        <b-form-input id="formdata.name"
										                      :type="formdata.type"
										                      :v-model="formdata.modelo"										                      
										                      :placeholder="formdata.placeholder">
										        </b-form-input>
									     	</b-form-group>
									    </div>
									</b-col>

									<b-col cols="6">
										<div class="form-title">
											<i class="fas fa-child"></i> 
											<div class="d-inline"> Contacto de Paciente </div>
										</div>
										<p class="form-description fz-3 pt-3 pr-4">
											On sait depuis longtemps que travailler avec du texte lisible et contenant du sens est source de distractions, et empêche de se concentrer sur la mise en page elle-même. 
										</p>
									</b-col>
									<b-col cols="6" class="pt-3 pb-4">										
										<b-form-group id="exampleInputGroup1"
								                    label="Email address:"
								                    label-for="exampleInput1"
								                    description="We'll never share your email with anyone else.">
								        	<b-form-input id="exampleInput1"
								                      type="email"
								                      v-model="form.email"
								                      required
								                      placeholder="Enter email">
								        	</b-form-input>
								      	</b-form-group>
									</b-col>

									<b-col cols="6">
										<div class="form-title">
											<i class="fas fa-child"></i> 
											<div class="d-inline"> Datos de Apoderado </div>
										</div>
										<p class="form-description fz-3 pt-3 pr-4">
											On sait depuis longtemps que travailler avec du texte lisible et contenant du sens est source de distractions, et empêche de se concentrer sur la mise en page elle-même. 
										</p>
									</b-col>
									<b-col cols="6">
										<b-form-group id="exampleInputGroup1"
								                    label="Email address:"
								                    label-for="exampleInput1"
								                    description="We'll never share your email with anyone else.">
								        <b-form-input id="exampleInput1"
								                      type="email"
								                      v-model="form.email"
								                      required
								                      placeholder="Enter email">
								        </b-form-input>
								      </b-form-group>
									</b-col>
								</b-row>
							</b-form>
						</div>
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
			'url'
		],
		methods:{
			onSubmit (evt) {
		      evt.preventDefault();
		      console.log(JSON.stringify(this.form));
		    }
		},
		data(){
			return{
				breadcrumb: [
			    	{ text: 'Dashboard', href: this.url },
			    	{ text: 'Pacientes', href: this.url + '/pacientes' },
			    	{ text: 'Crear', active: true }
			    ],
			    formdatas: [
						{ label: "Nombres", type: "text", modelo: "form.nombres", name: "nombres", placeholder: "Nombres", required: true },
						{ label: "Apellidos", type: "text", modelo: "form.apellidos", name: "apellidos",  placeholder: "Apellidos", required: true }						
				],
			    form: {
			    	nombres: '',
			    	apellidos: '',
				    email: '',
			        name: '',
			        food: null,
			        checked: []
			    }
			}
		}
	}
</script>