<template>
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<h3>Botones: </h3>		
				<div class="botonesLayout pt-3">
					<ButtonComponent url="#" name="General" tipo="info"/>
					<ButtonComponent url="#" name="Guardar" tipo="guardar"/>
					<ButtonComponent url="#" name="Nuevo" tipo="nuevo"/>
					<ButtonComponent url="#" name="Modificar" tipo="modificar"/>
					<ButtonComponent url="#" name="Cancelar" tipo="cancelar"/>
				</div>
				
				<div class="panelLayout pt-4">
					<h3>Panel: </h3>
					<PanelCard>
						<span slot="heading">Últimos Pacientes</span>
						<table class="table" slot="body">
						    <thead>
						      <tr>
						        <th>Firstname</th>
						        <th>Lastname</th>
						        <th>Email</th>
						      </tr>
						    </thead>
						    <tbody>
						      <tr>
						        <td>John</td>
						        <td>Doe</td>
						        <td>john@example.com</td>
						      </tr>
						      <tr>
						        <td>Mary</td>
						        <td>Moe</td>
						        <td>mary@example.com</td>
						      </tr>
						      <tr>
						        <td>July</td>
						        <td>Dooley</td>
						        <td>july@example.com</td>
						      </tr>
						    </tbody>
						</table>
						<ButtonComponent slot="footer" url="#" name="Ver Pacientes" tipo="info"/>
					</PanelCard>
				</div>
			</div>
			<div class="col-md-6">
				<h3>Dashbox: </h3>
				<div class="dashboxLayout">
					<Dashbox iconUrl="fas fa-calculator" name="Presupuestos" color="info" url="/home" />
					<Dashbox iconUrl="fas fa-user-md" name="Pacientes" color="nuevo" url="/home" />
					<Dashbox iconUrl="fab fa-accessible-icon" name="Doctores" color="modificar" url="/home" />
					<Dashbox iconUrl="fas fa-tooth" name="Tratamientos" color="guardar" url="/home" />
					<Dashbox iconUrl="fas fa-dollar-sign" name="Precios" color="info" url="/home" />
					<Dashbox iconUrl="fas fa-building" name="Empresas" color="nuevo" url="/home" />
					<Dashbox iconUrl="fas fa-money-check-alt" name="Ingresos" color="modificar" url="/home" />
					<Dashbox iconUrl="fas fa-money-bill" name="Egresos" color="guardar" url="/home" />
				</div>
			</div>
			<div class="col-md-6">
				
			</div>
			<div class="col-md-6">
				
			</div>
		</div>
		
	</div>
</template>

<script>
	import ButtonComponent from '../button/button-component.vue'
	import Dashbox from '../dashbox/dashbox-component.vue'
	import PanelCard from '../panel/panel-component.vue'
	export default{
		name: 'Container-General',
		components:{
			ButtonComponent,
			Dashbox,
			PanelCard
		}
	}
</script>