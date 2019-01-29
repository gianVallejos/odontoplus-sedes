<template>
	<b-container v-if="curUser.rolid == 1">
		<SpinnerContainer :url="url" ref="spinnerContainerRef" />
		<b-row class="pb-2 mt-0">
			<b-col cols="6" lg="4" class="text-left" >
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
			<b-col cols="6" lg="8" class="text-right">
				<div class="d-inline-block text-left">
					<div class="text-center pb-2">
						<h5>RECIBO DE PAGO</h5>
						<!-- <h5>RECIBO DE PAGO NRO {{ igeneral.ultimoPago.pagos }} </h5> -->
					</div>
					<table class="data-general" border=1 cellspacing="0" cellpadding="0" >
							<tr>
								<td class="pr-title">DOCTOR: </td>
								<td colspan="3">{{ igeneral.doctor.nombres }} {{ igeneral.doctor.apellidos }}</td>
							</tr>
							<tr>
								<td class="pr-title">DESDE:</td>
								<td>{{ igeneral.fechaInicial }} </td>
								<td class="pr-title">HASTA:</td>
								<td>{{igeneral.fechaFinal}}</td>
							</tr>
							<tr>
								<td class="pr-title">TOTAL DR: </td>
								<td colspan="3">S/ {{ igeneral.totales.total_doctor }}</td>
							</tr>
							<tr class="hide-print">
								<td class="pr-title">TOTAL EMP: </td>
								<td colspan="3">S/ {{ igeneral.totales.total_ganancia }}</td>
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
				<b-button v-if="displayStatus == 'new'" variant="primary" v-on:click.prevent="onGuardarNuevo()">
					<i class="fas fa-save"></i>&nbsp; Guardar
				</b-button>
				<b-button variant="warning" v-on:click.prevent="onCerrar()">
					<i class="fas fa-times-circle"></i>&nbsp; Cerrar
				</b-button>
				<b-button variant="secondary" :href="url + '/egresos/create'">
					<i class="fas fa-money-bill"></i>&nbsp; Nuevo Egreso
				</b-button>
			</b-col>
		</b-row>
		<b-row>
			<b-col cols="12" class="pl-0 pr-0 pt-4 pb-4">
				<div class="pr-section-title">
					<div class="pr-seccion-title-text">
						<i class="fas fa-file-invoice-dollar"></i> &nbsp;Detalle de Pago
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
					<template slot="doctor_nombre" slot-scope="row">
						{{ row.item.apellidos }}
					</template>
					<template slot="codigo" slot-scope="row">
						{{ row.item.codigo }}
					</template>
					<template slot="monto" slot-scope="row" class="hide-print">
						S/. {{ row.item.monto }}
					</template>				
					<template slot="total" slot-scope="row">
						S/. {{ row.item.total }}
					</template>
					<template slot="costo_variable" slot-scope="row" class="hide-print">
						S/. {{ row.item.costo_variable }}
					</template>
					<template slot="igv" slot-scope="row" class="hide-print">
						S/. {{ row.item.igv }}
					</template>
					<template slot="empresa" slot-scope="row">
						S/. {{ calculateEmpresaAmount(row.item.total_empresa, row.item.doctor)}}
					</template>
					<template slot="doctor" slot-scope="row">
						S/. {{ row.item.doctor }}
					</template>
					<template slot="total_empresa" slot-scope="row">
						S/. {{ row.value }}
					</template>					
				</b-table>
			</b-col>
			<b-col cols="12" class='text-right monto-class'>
				<div class="d-inline-block" >
					<span>Total Dr: </span>
				</div>
				<div class="d-inline-block" style="width: 150px">
					S/ {{ igeneral.totales.total_doctor }}
				</div>
			</b-col>
			<b-col cols="12" class="text-right monto-class hide-print">
				<div class="d-inline-block" >
					<span>Total Emp: </span>
				</div>
				<div class="d-inline-block" style="width: 150px">
					S/ {{ igeneral.totales.total_ganancia }}
				</div>
			</b-col>
		</b-row>

		<b-row class="d-print-none">
			<b-col cols="12" class="pt-4 pb-0 text-center">
				<b-button variant="success" v-on:click.prevent="imprimirPagina()">
					<i class="fas fa-print"></i> &nbsp;Imprimir
				</b-button>
				<b-button v-if="displayStatus == 'new'" variant="primary" v-on:click.prevent="onGuardarNuevo()">
					<i class="fas fa-save"></i>&nbsp; Guardar
				</b-button>
				<b-button variant="warning" v-on:click.prevent="onCerrar()">
					<i class="fas fa-times-circle"></i>&nbsp; Cerrar
				</b-button>
				<b-button variant="secondary" :href="url + '/egresos/create'">
					<i class="fas fa-money-bill"></i>&nbsp; Nuevo Egreso
				</b-button>
			</b-col>
		</b-row>

	</b-container>
</template>
<script>
	import SpinnerContainer from '../widgets/spinner/spinner-container.vue'
	import axios from 'axios'
	export default{
		mounted(){
			this.setLogotipo()
			this.initActualView()
		},
		components: {
			SpinnerContainer
		},
		name: 'Reporte-Pago',
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
					{ key: 'cantidad', label: 'Cant', sortable: true, 'class': 'text-center', sortDirection: 'desc' },
					{ key: 'monto', label: 'Monto', sortable: true, sortDirection: 'desc', class: 'hide-print text-center'},
					{ key: 'total', label: 'Total', sortable: true, sortDirection: 'desc', class: 'hide-print text-center' },
					{ key: 'costo_variable', label: 'C.V.', sortable: true, sortDirection: 'desc', class: 'hide-print text-center'},
					{ key: 'igv', label: 'IGV', sortable: true, sortDirection: 'desc', class: 'hide-print text-center'},
					{ key: 'doctor', label: 'Total Dr.', sortable: true, sortDirection: 'desc', class: 'text-center'},
					{ key: 'total_empresa', label: 'Total Emp.', sortable: true, sortDirection: 'desc', class: 'text-center'}
				],
				displayStatus: ''
			}
		},
		methods: {
			setLogotipo(){
				this.logoUrl = this.url + '/images/logotipos/' + this.curUser.schema + '_BG_WHITE.png'
			},
			setDefaultImagenLogo(){
				this.logoUrl = this.url + '/images/logotipos/1_ODONTOPLUS_CAJ_BG_WHITE.png'
			},
			initActualView(){
				this.displayStatus = this.view_mode
		    if( this.displayStatus == 'new' ){
		    	this.onDisplayNuevo()
		    }else if( this.displayStatus == 'show' ){
		    	this.onDisplayDetalle()
		    }
			},
			onDisplayNuevo(){
    		this.displayStatus = 'new'
			},
			onDisplayDetalle(){
				this.displayStatus = 'show'
			},
			onGuardarNuevo(){
				if( this.igeneral.totales.total != '0.00' ){
					var body = {	idDoctor: this.igeneral.doctor.id,
									fecha_inicio: this.igeneral.fechaInicial,
									fecha_fin: this.igeneral.fechaFinal }
					var request = { method: 'POST', url: this.url + '/pagos', data: body }
	    			var mssgOnFail = 'EL pago no puede ser registrado, por favor, vuelva a generarlo nuvamente.'

					this.onSubmit(request, mssgOnFail)
				}else{
					this.toastFunction('El pago no puede ser registrado por que el total es cero', 'error')
				}
			},
			imprimirPagina(){
				window.print()
			},
			onSubmit(request, error_msg) {
				self = this
				if(request){
					self.$refs.spinnerContainerRef.showSpinner()
					axios(request).then((response) => {
						if(response.data.success){
							if( response.data.success == 'created' ){
								this.onDisplayDetalle()
								self.toastFunctionRedirect('Éxito', 'El pago ha sido guardado correctamente pero debe registrarlo como egreso manualmente.<br /> ¿Desea agregar un nuevo egreso?', 'success')
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
			toastFunctionRedirect(title, msg, type){
				this.$swal({
						title: title,
						html:  msg,
						type: type,
						showConfirmButton: true,
						showCancelButton: true,
						confirmButtonText: '<i class="fas fa-money-bill"></i> Nuevo Egreso',
						confirmButtonClass: ['my-alert', 'nuevo-alert'],
						cancelButtonText: '<i class="fas fa-times-circle"></i> Cerrar',
						cancelButtonClass: ['my-alert', 'cerrar-alert'],
						showCloseButton: true
				}).then((result) => {
					if( result.value ){
						window.location = this.url + '/egresos/create'
					}
				})
			},
			onCerrar(){
				window.close()
				window.opener.location.reload()
				window.opener.external.comeback()
			},
			calculateEmpresaAmount(total, monto_doctor){
				return (total -monto_doctor).toFixed(2)
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
		/* margin-top: 22px; */
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
	}

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
	@media screen {
	  div.divFooter {
	    display: none;
	  }
	}
	@media print {
	  div.divFooter {
	    position: fixed;
	    bottom: 0;
	    left: 0;
	    padding: 7px 0px 7px 0px;
	    text-align: center;
	    width: 100%;
	    font-size: .85em;
	  }
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
		width: 200px;
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
