<template>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<b-alert show>Default Alert</b-alert>
			</div>
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
						<FormBuscar slot="body" />
						<div class="table mt-3 mb-4" slot="body">
						    <TableComponent :fields="ultimosPacientes" />
						</div>
						<ButtonComponent slot="footer" url="#" name="Ver Pacientes" tipo="info"/>
					</PanelCard>
				</div>

				<div class="panelLayout pt-4">
					<h3>Charts</h3>
					<PanelCard>
						<GChart type="LineChart" :data="chartData" :options="chartOptions" slot="body" />
					</PanelCard>
				</div>
			</div>
			<div class="col-md-6">
				<h3>Dashbox: </h3>
				<div class="dashboxLayout">
					<Dashbox iconUrl="fas fa-calculator" name="Presupuestos" color="info" url="/home2" />
					<Dashbox iconUrl="fas fa-user-md" name="Pacientes" color="nuevo" url="/home" />
					<Dashbox iconUrl="fab fa-accessible-icon" name="Doctores" color="modificar" url="/home" />
					<Dashbox iconUrl="fas fa-tooth" name="Tratamientos" color="guardar" url="/home" />
					<Dashbox iconUrl="fas fa-dollar-sign" name="Precios" color="info" url="/home" />
					<Dashbox iconUrl="fas fa-building" name="Empresas" color="nuevo" url="/home" />
					<Dashbox iconUrl="fas fa-money-check-alt" name="Ingresos" color="modificar" url="/home" />
					<Dashbox iconUrl="fas fa-money-bill" name="Egresos" color="guardar" url="/home" />
				</div>

				<div class="panelLayout pt-4">
					<h3>Tabla: </h3>
					<PanelCard>						
						<TableComponent :fields="items" slot="body" />
					</PanelCard>
				</div>
			</div>
		</div>		
	</div>
</template>

<script>
	import ButtonComponent from '../button/button-component.vue'
	import Dashbox from '../dashbox/dashbox-component.vue'
	import PanelCard from '../panel/panel-component.vue'
	import FormBuscar from '../form/form-buscar-component.vue'
	import TableComponent from '../table/table-component.vue'
	import { GChart } from 'vue-google-charts'

	export default{
		name: 'Container-General',
		components:{
			ButtonComponent,
			Dashbox,
			PanelCard,
			FormBuscar,
			TableComponent,
			GChart
		},
		data(){
			return{
				ultimosPacientes: [
				  { 'Nro Historia': 10, Nombre: 'Lorem Ipsum' },
				  { 'Nro Historia': 30, Nombre: 'Lorem Ipsum' },
				  { 'Nro Historia': 45, Nombre: 'Lorem Ipsum' },
				  { 'Nro Historia': 20, Nombre: 'Lorem Ipsum'  }
				],
				items: [
				  	{ isActive: true, age: 40, first_name: 'Dickerson', last_name: 'Macdonald' },
  					{ isActive: false, age: 21, first_name: 'Larsen', last_name: 'Shaw' },
  					{ isActive: false, age: 89, first_name: 'Geneva', last_name: 'Wilson' },
  					{ isActive: true, age: 38, first_name: 'Jami', last_name: 'Carney' }
				],
				chartData: [
			        ['Year', 'Sales', 'Expenses', 'Profit'],
			        ['2014', 1000, 400, 200],
			        ['2015', 1170, 460, 250],
			        ['2016', 660, 1120, 300],
			        ['2017', 1030, 540, 350]
			    ],
			    chartOptions: {
			        chart: {
			          title: 'Company Performance',
			          subtitle: 'Sales, Expenses, and Profit: 2014-2017',
			        }
			    }
			}
		}
	}
</script>