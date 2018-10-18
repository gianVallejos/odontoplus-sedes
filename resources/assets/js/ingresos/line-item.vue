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
								<span class="title-sec">Fecha:</span>
								<div class="d-inline-block texto"> {{ record.fecha }}</div>
							</b-col>
							<b-col cols="12" class="col-sm-12 col-md-12 col-lg-6">
								<span class="title-sec">Doctor:</span>
								<div class="d-inline-block texto"> {{ record.nombreDoctor }}</div>
							</b-col>
							<b-col cols="12" class="col-sm-12 col-md-12 col-lg-6">
								<span class="title-sec">Paciente:</span>
								<div class="d-inline-block texto"> {{ record.hc }} - {{ record.nombrePaciente }}</div>
							</b-col>
							<b-col cols="12" class="col-sm-12 col-md-12 col-lg-6">
								<span class="title-sec">Monto Total:</span>
								<div class="d-inline-block texto"> S/ {{ mydata.monto_total }}</div>
							</b-col>
							<b-col cols="12" class="col-sm-12 col-md-12 col-lg-6" v-if="curUser.rolid == 1">
								<span class="title-sec">Margen Doctor:</span>
								<div class="d-inline-block texto"> S/ {{ mydata.mg }}</div>
							</b-col>
							<b-col cols="12" class="col-sm-12 col-md-12 col-lg-6" v-if="curUser.rolid == 1">
								<span class="title-sec">Margen Empresa:</span>
								<div class="d-inline-block texto"> S/ {{ mydata.mg_core }}</div>
							</b-col>
						</b-row>
						<b-row>
							<b-col cols="12" class="text-center pt-4 pb-0">
								<b-button :href="url + '/ingresos/' + ingreso_id" variant="success">
									<i class="fas fa-info-circle"></i>&nbsp; Ver Detalle
								</b-button>
								<b-button :href="url + '/ingresos'" variant="warning">
									<i class="fas fa-chevron-circle-left"></i>&nbsp;Regresar
								</b-button>

							</b-col>							
						</b-row>
					</div>
				</PanelCard>
			</b-col>
			<line-item-detalle :record="recordDetail" :tratamientos="tratamientos" :id="ingreso_id" :url="url" v-on:calcular-total="actualizarTotal" />
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
			'tratamientos'
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
			    	{ text: 'Ingresos por Items', active: true}
			    ],
			    ingreso_id: this.record.id,
			    mydata: {
			    	monto_total: this.record.monto_total,
			    	mg: this.record.mg,
			    	mg_core: this.record.mg_core
			    }
			}
		},
		methods: {
			actualizarTotal(total, mg, mg_core){
				this.mydata.monto_total = total
				this.mydata.mg = mg
				this.mydata.mg_core = mg_core	
			}
		}

	}
</script>