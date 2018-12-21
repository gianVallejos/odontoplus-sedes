<template>
	<b-container class="pb-4">
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Ingresos" :items="breadcrumb" />
			</b-col>
			<b-col cols="12" class="pt-1">
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
						<b-row>
							<b-col cols="12" class="pt-3 text-center">
								<div v-for="(item, i) in presupuestosByIngreso" class="d-inline presupesto-btn-padding">
									<b-btn :href="url + '/presupuestos/reporte/' + item.id" target="_blank" variant="secondary">
										<i class="fas fa-calculator"></i>&nbsp;&nbsp;Ver Presupuesto {{ (presupuestosByIngreso.length > 1 ) ? i + 1 : '' }}
									</b-btn>
								</div>
							</b-col>
						</b-row>
					</div>
				</PanelCard>
			</b-col>
			<line-item-detalle :record="recordDetail" :ingreso="record" :tratamientos="tratamientos" :presupuesto_id="record.presupuestoId" :id="ingreso_id"
												 :url="url" :cur-user="curUser" :doctores="doctores" :sedes="sedes" v-on:calcular-total="actualizarTotal" />
		</b-row>

	</b-container>
</template>
<script>
	import TitleComponent from '../widgets/titulo/index.vue'
	import PanelCard from '../widgets/panel/panel-component.vue'
	import LineItemDetalle from './line-item-detalle.vue'
	import axios from 'axios'

	export default{
		props: [
			'url',
			'title',
			'record',
			'curUser',
			'record-detail',
			'tratamientos',
			'doctores',
			'sedes',
			'presupuestosByIngreso'
		],
		components:{
			TitleComponent,
			PanelCard,
			LineItemDetalle
		},
		data(){
			return{
				breadcrumb: [
			    	{ text: 'Inicio', href: this.url },
			    	{ text: 'Ingresos', href: this.url + '/ingresos' },
			    	{ text: 'Detalle de Ingreso', active: true}
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
<style lang="stylus">
	.presupesto-btn-padding
		padding-right: 10px
		&:last-of-type
			padding-right: 0px
</style>
