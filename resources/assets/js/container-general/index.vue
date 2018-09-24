<template>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h3>Alerts: </h3>
				<b-alert show variant="success">Success Alert</b-alert>
				<b-alert show variant="danger">Error Alert</b-alert>
			</div>
			<div class="col-md-6">
				<h3>Botones: </h3>		
				<div class="botonesLayout pt-3">
					<b-button href="#" variant="primary">General</b-button>
					<b-button href="#" variant="success">Guardar</b-button>
					<b-button href="#" variant="secondary">Nuevo</b-button>
					<b-button href="#" variant="warning">Modificar</b-button>
					<b-button href="#" variant="danger">Cancelar</b-button>
				</div>
				
				<div class="panelLayout pt-4">
					<h3>Panel: </h3>
					<PanelCard>
						<span slot="heading">Últimos Pacientes</span>
						<FormBuscar slot="body" />
						<div class="table mt-3 mb-4" slot="body">
						    <TableComponent :fields="ultimosPacientes" />
						</div>
						<b-button slot="footer" href="#" variant="primary">Ver Pacientes</b-button>
					</PanelCard>
				</div>

				<div class="panelLayout pt-4">
					<h3>Charts</h3>
					<PanelCard>
						<GChart type="LineChart" :data="chartData" :options="chartOptions" slot="body" />

						<GChart type="PieChart" :data="donutData" :options="donutOptions" :width="600" slot="body" />
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

				<div class="panelLayout pt-4">
					<h3>Forms: </h3>					
					<PanelCard>	
						<b-form @submit="onSubmit" slot="body">
							<b-form-group label="Nombre de Campo:">
				        		<b-form-input
				                      type="text"
				                      v-model="form.name"
				                      required
				                      placeholder="Nombre de Campo">
				        		</b-form-input>
				      		</b-form-group>
				      		<b-input-group>
						      	<b-form-input type="text" v-model="form.other" placeholder="Ningun Elemento Seleccionado" disabled></b-form-input>
						      	<b-input-group-append>
							    	<b-btn class="pl-3 pr-3" variant="success">
							    		<i class="fas fa-search"></i>
							    	</b-btn>
							    </b-input-group-append>
						    </b-input-group>
						    <div class="mt-3">
				      			<b-button type="submit" variant="success">Guardar</b-button>
				      			<b-button variant="danger">Cancel</b-button>
				      		</div>
				      	</b-form>
			      	</PanelCard>			      
				</div>

				<div class="panelLayout pt-3">
					<h3>Modal: </h3>
					<div class="pt-1">
						<b-btn v-b-modal.exampleModal variant="primary">Abrir Modal</b-btn>

						<b-modal id="exampleModal" size="lg" title="Lista de Pacientes">
	    					<h5>Test Modal</h5>
	    					<b-button slot="modal-footer" variant="primary" size="sm">Ir a Pacientes</b-button>
	  					</b-modal>
  					</div>
				</div>
			</div>
		</div>		
	</div>

</template>

<script>
	import Dashbox from '../dashbox/dashbox-component.vue'
	import PanelCard from '../panel/panel-component.vue'
	import FormBuscar from '../form/form-buscar-component.vue'
	import TableComponent from '../table/table-component.vue'
	import { GChart } from 'vue-google-charts'

	export default{
		name: 'Container-General',
		components:{
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
			    },
			    donutData: [
		          ['Task', 'Hours per Day'],
		          ['Work',     11],
		          ['Eat',      2],
		          ['Commute',  2],
		          ['Watch TV', 2],
		          ['Sleep',    7]
		        ],
		        donutOptions: {
		        	chart: {
		        		title: 'My Daily Activities',
          				pieHole: 0.4,
		        	}
		        },
		        form: {
			        name: '',
			        other: ''			        
			    },
			}
		},
		methods:{
			onSubmit (evt) {
		      evt.preventDefault();
		      alert(JSON.stringify(this.form));
		    }
		}
	}
</script>