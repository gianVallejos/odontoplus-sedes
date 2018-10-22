<template>
	<b-container class="pb-4">				
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Ingresos" :items="breadcrumb" />				
			</b-col>
			<b-col cols="12" class="pt-3">				
				<PanelCard>
					<span slot="heading">Detalle de Ingreso</span>
					<div slot="body" class="pt-3 pb-3 pl-3 pr-3">	

						<b-row>
							<b-col cols="12" class="col-sm-12 col-md-12 col-lg-6">
								<span class="title-sec">Nro Historia:</span>
								<div class="d-inline-block texto"> {{ record.hc }}</div>
							</b-col>
							<b-col cols="12" class="col-sm-12 col-md-12 col-lg-6">								
								<span class="title-sec">Creado en:</span>
								<div class="d-inline-block texto"> {{ record.fecha }}</div>
							</b-col>							
							<b-col cols="12" class="col-sm-12 col-md-12 col-lg-6">
								<span class="title-sec">Paciente:</span>
								<div class="d-inline-block texto"> {{ record.nombrePaciente }}</div>
							</b-col>
							<b-col cols="12" class="col-sm-12 col-md-12 col-lg-6">
								<span class="title-sec">Total:</span>
								<div class="d-inline-block texto"> S/ {{ mydata.monto_total }}</div>
							</b-col>							
						</b-row>
					</div>
				</PanelCard>
			</b-col>
			<line-item-detalle :record="recordDetail" :tratamientos="tratamientos" :id="ingreso_id" :url="url" :cur-user="curUser" :doctores="doctores" v-on:calcular-total="actualizarTotal" />
		</b-row>
	</b-container>
</template>
<script>
	import TitleComponent from '../widgets/titulo/index.vue'
	import PanelCard from '../widgets/panel/panel-component.vue'
	import LineItemDetalle from './line-item-detalle.vue'
	import axios from 'axios'

	export default{
		mounted(){
			console.log('Ingreso Line Item Mounted')	
		},
		props: [
			'url',
			'title',
			'record',
			'curUser',
			'record-detail',
			'tratamientos',
			'doctores'
		],
		components:{
			TitleComponent,
			PanelCard,
			LineItemDetalle
		},
		data(){
			return{
				breadcrumb: [
			    	{ text: 'Dashboard', href: this.url },
			    	{ text: 'Ingresos', href: this.url + '/ingresos' },
			    	{ text: 'Detalle de Ingresos', active: true}
			    ],
			    ingreso_id: this.record.id,
			    mydata: {
			    	monto_total: this.record.monto_total
			    }
			}
		},
		methods: {
			actualizarTotal(total){
				this.mydata.monto_total = total
			}
		}

	}
</script>