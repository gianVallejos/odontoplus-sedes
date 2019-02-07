<template>
<div>
	<b-container v-if="curUser.rolid == 1 || curUser.rolid == 3" style="margin-top: -30px">
		<SpinnerContainer :url="url" ref="spinnerContainerRef" />
		<b-row>
			<b-col cols="4" class="text-left pl-0" >
				<div class="pr-logo-layout">
					<div class="pr-logo">
						<img :src="logoUrl" alt="Logo Empresa" @error="setDefaultImagenLogo" />
					</div>
					<div class="pr-descripcion-logo">
						<span v-if="cliente.direccion != null">
							{{ cliente.direccion }} {{ cliente.ciudad }} - Perú <br />
						</span>
						<span v-if="cliente.email != null">
							{{ cliente.email }} <br />
						</span>
						<span v-if="cliente.telefono != null">
							{{ cliente.telefono }} <br />
						</span>
	    			<span v-if="cliente.celular != null">
							{{ cliente.celular }} <span v-if="cliente.celular_aux != null"> - </span> {{ cliente.celular_aux }}
						</span>
					</div>
				</div>
			</b-col>
			<b-col cols="8" class="text-right mt-4 pt-3">
				<div class="d-inline-block text-left">
					<div class="text-center pb-2">
						<h5> REPORTE DE GANANCIAS </h5>
					</div>
					<table class="data-general" border=1 cellspacing="0" cellpadding="0" >
						<tr>
							<td class="pr-title">DESDE:</td>
							<td>{{ igeneral.fechaInicial }} </td>
							<td class="pr-title">HASTA:</td>
							<td>{{igeneral.fechaFinal}}</td>
						</tr>
						<tr>
							<td class="pr-title">GANANCIAS: </td>
							<td colspan="3">S/ {{ igeneral.totales.total_ganancia }}</td>
						</tr>
						<tr>
							<td class="pr-title">DOCTOR: </td>
							<td colspan="3">S/ {{ igeneral.totales.total_doctor }}</td>
						</tr>
						<tr>
							<td class="pr-title">IGV: </td>
							<td colspan="3">S/ {{ igeneral.totales.total_igv }}</td>
						</tr>
						<tr>
							<td class="pr-title">TOTAL: </td>
							<td colspan="3">S/ {{ igeneral.totales.total }}</td>
						</tr>
					</table>
				</div>
			</b-col>
		</b-row>
		<b-row class="d-print-none">
			<b-col cols="12" class="pt-4 pb-0 text-center">
				<b-button variant="success" v-on:click.prevent="imprimirPagina()">
					<i class="fas fa-print"></i> &nbsp;Imprimir
				</b-button>
				<b-button variant="warning" v-on:click.prevent="onCerrar()">
					<i class="fas fa-times-circle"></i>&nbsp; Cerrar
				</b-button>
			</b-col>
		</b-row>
	</b-container>
	<b-container fluid>
		<b-row>
			<b-col cols="12" class="pl-0 pr-0 pt-4 pb-4">
				<div class="pr-section-title">
					<div class="pr-seccion-title-text">
						<i class="fas fa-file-invoice-dollar"></i> &nbsp;Detalle de Ganancias
					</div>
				</div>
			</b-col>
		</b-row>
		<b-row>
			<b-col cols="12">
				<b-table 	show-empty
							:items="ingresos"
							:fields="fields"
					        empty-text="No existen campos para mostrar"
					        :foot-clone=false >
					<template slot="index" slot-scope="row">
						{{ row.index + 1 }}
					</template>
					<template slot="historia" slot-scope="row">
						{{ row.value }}
					</template>
					<template slot="doctor_nombre" slot-scope="row">
						{{ row.item.apellidos }}
					</template>
					<template slot="codigo" slot-scope="row">
						{{ row.item.codigo }}
					</template>
					<template slot="tratamiento" slot-scope="row">
						{{ row.item.tratamiento }}
					</template>
					<template slot="cantidad" slot-scope="row">
						{{ row.item.cantidad }}
					</template>
					<template slot="monto" slot-scope="row" class="hide-print">
						S/. {{ row.value }}
					</template>
					<template slot="total" slot-scope="row">
						S/. {{ row.value }}
					</template>					
					<template slot="costo_variable" slot-scope="row">
						S/. {{ row.item.costo_variable }}
					</template>
					<template slot="igv" slot-scope="row">
						S/. {{ row.value }}
					</template>
					<template slot="doctor" slot-scope="row">
						S/. {{ row.item.doctor }}
					</template>
          			<template slot="total_empresa" slot-scope="row">
						S/. {{ row.item.total_empresa  }}
					</template>
				</b-table>
			</b-col>
			<b-col cols="12" class="text-right monto-class hide-print">
				<div class="d-inline-block" style="width: 75px">
					<span>Ganacias: </span>
				</div>
				<div class="d-inline-block" style="width: 150px">
					S/ {{ igeneral.totales.total_ganancia }}
				</div>
			</b-col>
			<b-col cols="12" class="text-right monto-class hide-print">
				<div class="d-inline-block" style="width: 75px">
					<span>Doctor: </span>
				</div>
				<div class="d-inline-block" style="width: 150px">
					S/ {{ igeneral.totales.total_doctor }}
				</div>
			</b-col>
			<b-col cols="12" class="text-right monto-class hide-print">
				<div class="d-inline-block" style="width: 75px">
					<span>IGV: </span>
				</div>
				<div class="d-inline-block" style="width: 150px">
					S/ {{ igeneral.totales.total_igv }}
				</div>
			</b-col>
			<b-col cols="12" class="text-right monto-class hide-print">
				<div class="d-inline-block" style="width: 75px">
					<span>Total: </span>
				</div>
				<div class="d-inline-block" style="width: 150px">
					S/ {{ igeneral.totales.total }}
				</div>
			</b-col>
		</b-row>

		<b-row class="d-print-none">
			<b-col cols="12" class="pt-4 pb-0 text-center">
				<b-button variant="success" v-on:click.prevent="imprimirPagina()">
					<i class="fas fa-print"></i> &nbsp;Imprimir
				</b-button>
				<b-button variant="warning" v-on:click.prevent="onCerrar()">
					<i class="fas fa-times-circle"></i>&nbsp; Cerrar
				</b-button>
			</b-col>
		</b-row>

	</b-container>
</div>
</template>
<script>
	import axios from 'axios'
	import SpinnerContainer from '../widgets/spinner/spinner-container.vue'
	export default{
		mounted(){
			this.setLogotipo()
		},
		components: {
			SpinnerContainer
		},
		name: 'Reporte-Ingreso',
		props: [
			'url',
			'igeneral',
			'ingresos',
			'curUser',
			'view_mode',
			'cliente'
		],
		data(){
			return{
				logoUrl: '',
				fields: [
					{ key: 'index', label: '#' },
					{ key: 'fecha', label: 'Fecha', sortable: true, sortDirection: 'desc' },
					{ key: 'historia', label: 'HC', sortable: true, sortDirection: 'desc', class: 'text-center' },
					{ key: 'doctor_nombre', label: 'Doctor', sortable: true, sortDirection: 'desc' },
					{ key: 'codigo', label: 'Código', sortable: true, sortDirection: 'desc' },
					{ key: 'tratamiento', label: 'Tratamiento', sortable: true, sortDirection: 'desc', class: 'td-trat-width' },
					{ key: 'cantidad', label: 'Cantidad', sortable: true, sortDirection: 'desc', class: 'text-center' },
					{ key: 'monto', label: 'Monto', sortable: true, sortDirection: 'desc', class: 'text-center' },
					{ key: 'total', label: 'Total', sortable: true, sortDirection: 'desc', class: 'text-center' },
          			{ key: 'costo_variable', label: 'C.V.', sortable: true, 'class': 'text-center' },
          			{ key: 'igv', label: 'IGV', sortable: true, 'class': 'text-center' },
          			{ key: 'doctor', label: 'DR', sortable: true, 'class': 'text-center' },
					{ key: 'total_empresa', label: 'Ganancia', sortable: true, sortDirection: 'desc', class: 'text-center'}
				],
			}
		},
		methods: {
			setLogotipo(){
				this.logoUrl = this.url + '/images/logotipos/' + this.curUser.schema + '_BG_WHITE.png'
			},
			setDefaultImagenLogo(){
				this.logoUrl = this.url + '/images/logotipos/1_ODONTOPLUS_CAJ_BG_WHITE.png'
			},
			imprimirPagina(){
				window.print()
			},
			onSubmit(request, error_msg) {
				self = this
				if(request){
					self.$refs.spinnerContainerRef.showSpinner()
					alert('!')
					axios(request).then((response) => {
						if(response.data.success){
							if( response.data.success == 'created' ){
								this.onDisplayDetalle()
								self.toastFunction('El pago a sido guradado correctamente', 'success')
							}
							self.$refs.spinnerContainerRef.hideSpinner()
						}else if (response.data.error){
								self.all_errors = response.data.error
								self.toastFunction(error_msg, 'error')
								self.$refs.spinnerContainerRef.hideSpinner()
						}
					}).catch(function (error) {
							self.toastFunction('Ha ocurrido un error crítico, por favor comunicarse con Odontoplus.pe.', 'error')
							self.$refs.spinnerContainerRef.hideSpinner()
					});
				}
			},
	        redondearADos(total){
	        	return parseFloat(Math.round(total * 100) / 100).toFixed(2)
	        },
			toastFunction(msg, type){
				this.$swal({
						type: type,
						title: msg,
						toast: true,
						position: 'top',
						showConfirmButton: false,
							timer: 4000
				})
			},
			onCerrar(){
				window.close()
				window.opener.external.comeback()
			}
		}
	}
</script>
<style lang="stylus">
	table.data-general{
		width: 520px;
		font-size: 1.15em;
		font-family: 'Rubik', sans-serif;
		border: 2px solid #f3f3f3;
	}
	table.data-general tr td{
		height: 40px;
		padding-left: 10px;
	}
	.pr-title{
		width: 24%;
		font-weight: bold;
		font-family: 'Open Sans', sans-serif;
		background: #f3f3f3;
		-webkit-print-color-adjust: exact;
	}
	.pr-content{
		width: 80%;
	}
	h1, h2, h3, h4, h5{
		padding: 0px;
		margin: 0px;
	}

	h5{
		font-weight: bold;
		font-family: 'Open Sans', sans-serif;
	}

	.pr-logo-layout{
		margin-top: 22px;
	}

	.pr-logo{
		position: relative;
		padding-top: 20px;
		width: 265px;
		padding-left: 6px;
	}

	.pr-descripcion-logo{
		display: block;
		font-size: .8em;
		text-align: center;
		width: 265px;
		margin-top: 8px;
	}



	/* .pr-logo img{
		object-fit: cover;
		width: 100%;
	} */

	.pr-section-title{
		background: #f3f3f3;
		padding: 8px 14px;
		-webkit-print-color-adjust: exact;
	}

	.pr-seccion-title-text{
		font-weight: bold;
		font-family: 'Open Sans', sans-serif;
		font-size: 1.3em;
	}

	.monto-class{
		font-size: 1.4em;
	}

	.monto-class span{
		text-align: left;
		font-weight: bold;
		width: 140px;
		display: inline-block;
	}
	@media print {
		.hide-print{
			display: none
		}
	}
	@page{
	    size: auto;
	    margin: auto;
	}

	.td-doc-width{
		width: 150px;
	}

	.td-trat-width{
		width: 185px;
	}

	@media (max-width: 992px)
		table
			&.data-general
				width: 330px;
				font-size: 1.15em;
				font-family: 'Rubik', sans-serif;
				border: 2px solid #f3f3f3;
				tr
					td
						font-size: .8em
		.pr-title
			font-size: .8em
</style>
