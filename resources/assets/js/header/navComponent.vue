<template>
	<div class="barra">
		<div class="container">
			<ul class="barra-list">
		      <li class="item" v-bind:class="[(whoIsActive == 'dashboard') ? 'active' : '']">
		      	<a :href="url">
		      		<i class="fas fa-home"></i>Inicio
		      	</a>
		      </li>
		      <li class="item dropdown" v-bind:class="[(whoIsActive == 'personas') ? 'active' : '']">
		        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
		        	<i class="fas fa-people-carry"></i>Personas
		        	<i class="fa fa-angle-down lnr"></i>
		    	</a>
		        <ul class="dropdown-menu">
		          <li class="li-dropdown">
		          	<a :href="url + '/pacientes'" v-bind:class="[(whoIsActiveDetail == 'pacientes') ? 'active' : '']">
		          		<i class="fas fa-child"></i>Pacientes
		          	</a>
		          </li>
		          <li class="li-dropdown">
		          	<a :href="url + '/doctores'" v-bind:class="[(whoIsActiveDetail == 'doctores') ? 'active' : '']">
		          		<i class="fas fa-user-md"></i>Doctores
		          	</a>
		          </li>
							<li class="li-dropdown" v-if="user.rolid == 1">
								<a :href="url + '/users'" v-bind:class="[(whoIsActiveDetail == 'users') ? 'active' : '']">
			          	<i class="fas fa-users"></i>Usuarios
			          </a>
		          </li>

		        </ul>
		      </li>
		      <li class="item" v-bind:class="[(whoIsActive == 'presupuestos') ? 'active' : '']">
		      	<a :href="url + '/presupuestos'">
		      		<i class="fas fa-calculator"></i>Presupuestos
		      	</a>
		      </li>
					<li class="item dropdown" v-bind:class="[(whoIsActive == 'finanzas') ? 'active' : '']">
		        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
		        	<i class="fas fa-file-invoice-dollar"></i>Finanzas
		        	<i class="fa fa-angle-down lnr"></i>
		    	</a>
		        <ul class="dropdown-menu">
		          <li class="li-dropdown">
		          	<a :href="url + '/ingresos'" v-bind:class="[(whoIsActiveDetail == 'ingresos') ? 'active' : '']">
		          		<i class="fas fa-money-check-alt"></i>Ingresos
		          	</a>
		          </li>
		          <li class="li-dropdown">
		          	<a :href="url + '/egresos'" v-bind:class="[(whoIsActiveDetail == 'egresos') ? 'active' : '']">
		          		<i class="fas fa-money-bill"></i>Egresos
		          	</a>
		          </li>
							<li class="li-dropdown" style="width: 152px;" v-if="user.rolid == 1">
							 <a :href="url + '/pagos'" v-bind:class="[(whoIsActiveDetail == 'pagos') ? 'active' : '']">
								 <i class="fas fa-credit-card"></i>Pagos a Doctores
							 </a>
						 </li>
		        </ul>
		      </li>
					<li class="item dropdown"  v-if="user.rolid == 1" v-bind:class="[(whoIsActive == 'informes') ? 'active' : '']">
		        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
		        	<i class="fas fa-file-alt"></i>Informes
		        	<i class="fa fa-angle-down lnr"></i>
		    	</a>
		        <ul class="dropdown-menu">
							<li class="li-dropdown" v-if="user.rolid == 1">
	 								<a :href="url + '/reportes'" v-bind:class="[(whoIsActiveDetail == 'reportes') ? 'active' : '']">
	 									<i class="fas fa-chart-line"></i>Estadísticas
	 							 	</a>
	 						</li>
							<li class="li-dropdown" style="width: 132px;" v-if="user.rolid == 1">
									<a :href="url + '/reportes/ganancias'" v-bind:class="[(whoIsActiveDetail == 'ganancias') ? 'active' : '']">
										<i class="fas fa-hand-holding-usd"></i>Ganancias Totales
									</a>
							</li>

		        </ul>
		      </li>
		      <li class="item dropdown"  v-bind:class="[(whoIsActive == 'tratamientos') ? 'active' : '']">
		        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
		        	<i class="fas fa-tooth"></i>Tratamientos
		        	<i class="fa fa-angle-down lnr"></i>
			    	</a>
		        <ul class="dropdown-menu">
		          	<li class="li-dropdown" style="width: 160px;" >
		          		<a :href="url + '/tratamientos'" v-bind:class="[(whoIsActiveDetail == 'tratamientos') ? 'active' : '']">
		          			<i class="fas fa-list-ul"></i>Lista de Tratamientos
		          		</a>
		          	</li>
		          	<li class="li-dropdown" style="width: 160px;" >
		          		<a :href="url + '/precios'" v-bind:class="[(whoIsActiveDetail == 'precios') ? 'active' : '']">
		          			<i class="fas fa-dollar-sign"></i>Precio de Tratamientos
		          		</a>
		          	</li>
		          	<li class="li-dropdown" v-if="this.$root.autorizadoVerEmpresa(user.schema, user.rolid)">
			          	<a :href="url + '/empresas'" v-bind:class="[(whoIsActiveDetail == 'empresas') ? 'active' : '']">
			          		<i class="fas fa-building"></i>Empresas
			          	</a>
		        	</li>
		        	<!--li class="li-dropdown">
			          	<a :href="url + '/proveedores'">
			          		<i class="fas fa-flask"></i>Proveedores
			          	</a>
		        	</li-->
		        </ul>
		      </li>

		    </ul>
		</div>
	</div>
</template>
<script>
	export default{
		created(){
			this.checkActiveButton()
		},
		props: [
			'url',
			'user',
			'curUrl'
		],
		data(){
			return{
				whoIsActive: '',
				whoIsActiveDetail: ''
			}
		},
		methods: {
			checkActiveButton(){
				if( this.curUrl.includes('pacientes') ){
						this.whoIsActive = 'personas'
						this.whoIsActiveDetail = 'pacientes'
				}else if( this.curUrl.includes('doctores') ){
						this.whoIsActive = 'personas'
						this.whoIsActiveDetail = 'doctores'
				}else if( this.curUrl.includes('users') ){
					 	if( this.user.rolid == 1 ){
								this.whoIsActive = 'personas'
						}
						this.whoIsActiveDetail = 'users'
				}else if( this.curUrl.includes('presupuestos') ){
						this.whoIsActive = 'presupuestos'
				}else if( this.curUrl.includes('ingresos') ){
						this.whoIsActive = 'finanzas'
						this.whoIsActiveDetail = 'ingresos'
				}else if( this.curUrl.includes('egresos') ){
						this.whoIsActive = 'finanzas'
						this.whoIsActiveDetail = 'egresos'
				}else if( this.curUrl.includes('pagos') ){
						this.whoIsActive = 'finanzas'
						this.whoIsActiveDetail = 'pagos'
				}else if( this.curUrl.includes('ganancias') ){
						this.whoIsActive = 'informes'
						this.whoIsActiveDetail = 'ganancias'
				}else if( this.curUrl.includes('reportes') ){
						this.whoIsActive = 'informes'
						this.whoIsActiveDetail = 'reportes'
				}else if( this.curUrl.includes('tratamientos') ){
						this.whoIsActive = 'tratamientos'
						this.whoIsActiveDetail = 'tratamientos'
				}else if( this.curUrl.includes('precios') ){
						this.whoIsActive = 'tratamientos'
						this.whoIsActiveDetail = 'precios'
				}else if( this.curUrl.includes('empresas') ){
						this.whoIsActive = 'tratamientos'
						this.whoIsActiveDetail = 'empresas'
				}else{
					this.whoIsActive = 'dashboard'
					this.whoIsActiveDetail = ''
				}
			}
		}
	}
</script>
