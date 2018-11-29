<template>
	<div class="header">
		<div class="container">
			<a :href="url + '/'">
				<img :src=logoUrl class="logoHeaderComponent" alt="Logo de Empresa" @error="setDefaultImagenLogo">
			</a>
			<div class="head-right">
				<ul>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							<div class="profileImage">
						  		<span class="perfil-img">
						  			<img :src=perfilUrl alt="Imagen de Perfil">
						  		</span>
						  		<div class="user-name">
						  			<p>{{ user.name }} </p>
						  			<span>{{ rol[user.rolid-1].nombre }}</span>
						  		</div>
						  		<i class="fa fa-angle-down lnr"></i>
						  		<div class="clearfix"></div>
						  	</div>
						</a>
						<ul class="dropdown-menu">
							<li>
					    		<a :href="url + '/'" v-bind:class="[(whoIsActiveDetail == 'inicio') ? 'active' : '']">
					    			<i class="fas fa-home"></i>Inicio
					    		</a>
					    	</li>
					    	<li>
					    		<a :href="url + '/users/' + user.id" v-bind:class="[(whoIsActiveDetail == 'users') ? 'active' : '']">
					    			<i class="fas fa-user"></i>Ver Perfil
					    		</a>
					    	</li>
					    	<!-- <li v-if="user.rolid == 1">
					    		<a :href="url + '/users'">
					          		<i class="fas fa-users"></i>Usuarios
					          	</a>
					    	</li> -->
					    	<li>
					    		<a :href="logoutRoute" v-on:click="logout" >
					    			<i class="fas fa-power-off"></i>Cerrar Sesión
					    		</a>
					    		<form id="logout-form" :action="logoutRoute" method="POST" style="display: none;">
		                            <input type="hidden" name="_token" :value="csrf">
		                        </form>
					    	</li>
					  	</ul>
					</li>
				</ul>
			</div>
		</div>
	</div>
</template>
<script>
	export default{
		created(){
				this.checkActiveButton()
				this.setLogotipo()
		},
		data() {
			return {
				logoUrl: '',
				perfilUrl: this.url + '/images/sistema/perfil-default.png',
				csrf: document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
				rol: [
					{id: 1, nombre: 'Administrador' },
					{id: 2, nombre: 'Colaborador' }
				],
				whoIsActiveDetail: ''
			}
		},
		props: [
			'user',
			'logoutRoute',
			'url',
			'curUrl',
			'nameLogotipo'
		],
		methods: {
			setLogotipo(){
				this.logoUrl = this.url + '/images/logotipos/' + this.user.schema + '_BG_DARK.png'
			},
			setDefaultImagenLogo(){
				this.logoUrl = this.url + '/images/logotipos/1_ODONTOPLUS_CAJ_BG_DARK.png'
			},
			checkActiveButton(){
					if( this.curUrl.includes('users') ){
							this.whoIsActiveDetail = 'users'
					}else if( !this.curUrl.includes('doctores') || !this.curUrl.includes('pacientes') ||
										!this.curUrl.includes('presupuestos') || !this.curUrl.includes('ingresos') ||
										!this.curUrl.includes('egresos') || !this.curUrl.includes('pagos') ||
										!this.curUrl.includes('ganancias') || !this.curUrl.includes('reportes') ||
										!this.curUrl.includes('tratamientos') || !this.curUrl.includes('precios') ||
										!this.curUrl.includes('empresas')
									){
											this.whoIsActiveDetail = 'inicio'
									}
			},
			logout (evt) {
		      evt.preventDefault()
		      document.getElementById('logout-form').submit()
		    }
		}
	}
</script>
