<template>
	<div class="barra">
		<div class="container">			
			<ul class="barra-list">
		      <li class="item" v-bind:class="[(whoIsActive == 'dashboard') ? 'active' : '']">
		      	<a :href="url">
		      		<i class="fas fa-home"></i>Inicio
		      	</a>
		      </li>
		      <li class="item" v-bind:class="[(whoIsActive == 'presupuestos') ? 'active' : '']">
		      	<a :href="url + '/presupuestos'">
		      		<i class="fas fa-calculator"></i>Presupuestos
		      	</a>
		      </li>
		      <li class="item dropdown" v-bind:class="[(whoIsActive == 'personas') ? 'active' : '']">
		        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
		        	<i class="fas fa-people-carry"></i>Personas
		        	<i class="fa fa-angle-down lnr"></i>
		    	</a>
		        <ul class="dropdown-menu">
		          <li class="li-dropdown">
		          	<a :href="url + '/pacientes'">
		          		<i class="fas fa-child"></i>Pacientes
		          	</a>
		          </li>
		          <li class="li-dropdown">
		          	<a :href="url + '/doctores'">
		          		<i class="fas fa-user-md"></i>Doctores
		          	</a>
		          </li>
		        </ul>
		      </li>		      		      
		      <li class="item dropdown" v-bind:class="[(whoIsActive == 'finanzas') ? 'active' : '']">
		        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
		        	<i class="fas fa-file-invoice-dollar"></i>Finanzas
		        	<i class="fa fa-angle-down lnr"></i>
		    	</a>
		        <ul class="dropdown-menu">
		          <li class="li-dropdown">
		          	<a :href="url + '/ingresos'">
		          		<i class="fas fa-money-check-alt"></i>Ingresos
		          	</a>
		          </li>
		          <li class="li-dropdown">
		          	<a :href="url + '/egresos'">
		          		<i class="fas fa-money-bill"></i>Egresos
		          	</a>
		          </li>
		          <li class="li-dropdown" v-if="user.rolid == 1">
		          	<a :href="url + '/pagos'">
		          		<i class="fas fa-credit-card"></i>Pagos
		          	</a>
		          </li>
		          <li class="li-dropdown" v-if="user.rolid == 1">
		          	<a :href="url + '/reportes'">
		          		<i class="fas fa-chart-line"></i>Reportes
		          	</a>
		          </li>
		          
		        </ul>
		      </li>
		      <li class="item dropdown"  v-bind:class="[(whoIsActive == 'otros') ? 'active' : '']">
		        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
		        	<i class="fas fa-plus"></i>Otros
		        	<i class="fa fa-angle-down lnr"></i>
		    	</a>
		        <ul class="dropdown-menu">
		          	<li class="li-dropdown">
		          		<a :href="url + '/tratamientos'">
		          			<i class="fas fa-tooth"></i>Tratamientos
		          		</a>
		          	</li>
		          	<li class="li-dropdown">
		          		<a :href="url + '/precios'">
		          			<i class="fas fa-dollar-sign"></i>Precios
		          		</a>
		          	</li>
		          	<li class="li-dropdown">
			          	<a :href="url + '/empresas'">
			          		<i class="fas fa-building"></i>Empresas
			          	</a>
		        	</li>
		        	<!--li class="li-dropdown">
			          	<a :href="url + '/proveedores'">
			          		<i class="fas fa-flask"></i>Proveedores
			          	</a>
		        	</li-->
					<li class="li-dropdown" v-if="user.rolid == 1">
		        	  	<a :href="url + '/users'">
		          			<i class="fas fa-users"></i>Usuarios
		          		</a>
		          	</li>
		        </ul>
		      </li>
		    </ul>
		</div>
	</div>
</template>
<script>
	export default{
		mounted(){
			this.checkActiveButton()
			console.log('Navbar Mounted')
			console.log(this.whoIsActive)
		},
		props: [
			'url',
			'user',
			'curUrl'
		],
		data(){
			return{
				whoIsActive: ''
			}
		},
		methods: {
			checkActiveButton(){
				if( this.curUrl.includes('presupuestos') ){
					this.whoIsActive = 'presupuestos'
				}else if( this.curUrl.includes('pacientes') || this.curUrl.includes('doctores') ){
					this.whoIsActive = 'personas'
				}else if( this.curUrl.includes('ingresos') || this.curUrl.includes('egresos') || 
						  this.curUrl.includes('reportes') ){
					this.whoIsActive = 'finanzas'
				}else if( this.curUrl.includes('tratamientos') || this.curUrl.includes('precios') || 
						  this.curUrl.includes('empresas') ){
					this.whoIsActive = 'otros'
				}else{
					this.whoIsActive = 'dashboard'
				}
			}
		}
	}
</script>