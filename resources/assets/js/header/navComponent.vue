<template>
	<div class="barra">
		<div class="container">
			<ul class="barra-list">
		      <li class="item active">
		      	<a :href="url">
		      		<i class="fas fa-home"></i>Dashboard
		      	</a>
		      </li>
		      <li class="item">
		      	<a href="#">
		      		<i class="fas fa-calculator"></i>Presupuestos
		      	</a>
		      </li>
		      <li class="item dropdown">
		        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
		        	<i class="fas fa-users"></i>Personas
		        	<i class="fa fa-angle-down lnr"></i>
		    	</a>
		        <ul class="dropdown-menu">
		          <li class="li-dropdown">
		          	<a :href="url + '/pacientes'">
		          		<i class="fas fa-child"></i>Pacientes
		          	</a>
		          </li>
		          <li class="li-dropdown">
		          	<a href="#">
		          		<i class="fas fa-user-md"></i>Doctores
		          	</a>
		          </li>
		        </ul>
		      </li>		      		      
		      <li class="item dropdown">
		        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
		        	<i class="fas fa-file-invoice-dollar"></i>Finanzas
		        	<i class="fa fa-angle-down lnr"></i>
		    	</a>
		        <ul class="dropdown-menu">
		          <li class="li-dropdown">
		          	<a href="#">
		          		<i class="fas fa-money-check-alt"></i>Ingresos
		          	</a>
		          </li>
		          <li class="li-dropdown">
		          	<a href="#">
		          		<i class="fas fa-money-bill"></i>Egresos
		          	</a>
		          </li>
		          <li class="li-dropdown">
		          	<a href="#">
		          		<i class="fas fa-chart-line"></i>Reportes
		          	</a>
		          </li>
		        </ul>
		      </li>
		      <li class="item dropdown">
		        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
		        	<i class="fas fa-plus"></i>Otros
		        	<i class="fa fa-angle-down lnr"></i>
		    	</a>
		        <ul class="dropdown-menu">
		          <li class="li-dropdown">
		          	<a href="#">
		          		<i class="fas fa-tooth"></i>Tratamientos
		          	</a>
		          </li>
		          <li class="li-dropdown">
		          	<a href="#">
		          		<i class="fas fa-dollar-sign"></i>Precios
		          	</a>
		          </li>
		          <li class="li-dropdown">
		          	<a href="#">
		          		<i class="fas fa-building"></i>Empresas
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
			console.log('Navbar Mounted')
		},
		props: [
			'url'
		]
	}
</script>