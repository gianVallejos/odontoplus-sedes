<template>
	<div class="header">
		<div class="container">
			<a href="/">
				<img :src=logoUrl class="logoHeaderComponent" alt="Logo">
			</a>
			<div class="head-right">
				<ul>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							<div class="profileImage">
						  		<span class="perfil-img">
						  			<img :src=perfilUrl alt="Perfil">	
						  		</span>
						  		<div class="user-name">
						  			<p>{{ userName }} </p>
						  			<span>Administrador</span>
						  		</div>
						  		<i class="fa fa-angle-down lnr"></i>
						  		<div class="clearfix"></div>
						  	</div>
						</a>
						<ul class="dropdown-menu">
					    	<li>
					    		<a href="#">
					    			<i class="fas fa-user"></i>Ver Perfil
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
				logoUrl: 'images/empresa/logotipo.png',
				perfilUrl: 'images/sistema/perfil-default.png',
				csrf: document.querySelector('meta[name="csrf-token"]').getAttribute('content')
			}
		},
		props: [
			'userName',
			'logoutRoute'
		],
		methods: {
			logout (evt) {
		      evt.preventDefault()
		      document.getElementById('logout-form').submit()
		    }			
		}
	}
</script>