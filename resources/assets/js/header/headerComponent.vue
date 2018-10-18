<template>
	<div class="header">
		<div class="container">
			<a :href="url + '/'">
				<img :src=logoUrl class="logoHeaderComponent" alt="Logo de Empresa">
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
					    		<a :href="url + '/users/' + user.id">
					    			<i class="fas fa-user"></i>Ver Perfil
					    		</a>
					    	</li>
					    	<li v-if="user.rolid == 1">
					    		<a :href="url + '/users'">
					          		<i class="fas fa-users"></i>Usuarios
					          	</a>
					    	</li>
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
		mounted(){
			console.log('Header Mounted')
			console.log('url' + this.logoUrl);
		},
		data() {
			return {
				logoUrl: this.url + '/images/empresa/logotipo.png',
				perfilUrl: this.url + '/images/sistema/perfil-default.png',
				csrf: document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
				rol: [
					{id: 1, nombre: 'Administrador' },
					{id: 2, nombre: 'Colaborador' }
				]
			}
		},
		props: [
			'user',
			'logoutRoute',
			'url'
		],
		methods: {
			logout (evt) {
		      evt.preventDefault()
		      document.getElementById('logout-form').submit()
		    }			
		}
	}
</script>