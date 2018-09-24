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
			</div>
			<div class="col-md-6">
				<div class="dashboxLayout">
					<Dashbox iconUrl="fas fa-calculator" name="Presupuestos" color="info" url="/home" />
					<Dashbox iconUrl="fas fa-user-md" name="Pacientes" color="nuevo" url="/home" />
					<Dashbox iconUrl="fab fa-accessible-icon" name="Doctores" color="modificar" url="/home" />
					<Dashbox iconUrl="fas fa-calculator" name="Tratamientos" color="guardar" url="/home" />
					<Dashbox iconUrl="fas fa-calculator" name="Precios" color="info" url="/home" />
					<Dashbox iconUrl="fas fa-calculator" name="Empresas" color="nuevo" url="/home" />
					<Dashbox iconUrl="fas fa-calculator" name="Ingresos" color="nuevo" url="/home" />
					<Dashbox iconUrl="fas fa-calculator" name="Egresos" color="nuevo" url="/home" />
				</div>
			</div>
		</div>
		
	</div>
</template>

<script>
	import ButtonComponent from '../button/button-component.vue'
	import Dashbox from '../dashbox/dashbox-component.vue'
	export default{
		name: 'Container-General',
		components:{
			ButtonComponent,
			Dashbox
		}
	}
</script>