<template>
	<b-container v-if="curUser.rolid == 1" style="margin-top: -30px">
		<b-row>
			<b-col cols="4" class="text-left" >
				<div class="pr-logo">
					<img :src="this.url + '/images/empresa/logotipo_pdf.png'" alt="Logo Empresa" />
					<span>Jr. Silva Santisteban #507, Cajamarca - Perú</span>
					<span>citas@sonrisacore.com</span>
					<span>(076) 284095 (Citas) </span>
    				<span>991 981911 - 966 704974 (Emergencias)</span>
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
					<template slot="doctor_nombre" slot-scope="row">
						{{ row.item.nombres }} {{ row.item.apellidos }}
					</template>
					<template slot="monto" slot-scope="row" class="hide-print">
						S/. {{ row.item.monto }}
					</template>
					<template slot="total" slot-scope="row">
						S/. {{ row.item.total }}
					</template>

					<template slot="doctor" slot-scope="row">
						S/. {{ row.item.doctor }}
					</template>
          <template slot="ganancia" slot-scope="row">
						S/. {{ redondearADos(row.item.total - row.item.doctor)  }}
					</template>
				</b-table>
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
</template>
<script>
	import axios from 'axios'
	export default{
		mounted(){
			console.log('Pagos Mounted')
		},
		name: 'Reporte-Ingreso',
		props: [
			'url',
			'igeneral',
			'ingresos',
			'curUser',
			'view_mode'
		],
		data(){
			return{
				fields: [				    
					{ key: 'index', label: '#' },
					{ key: 'fecha', label: 'Fecha', sortable: true, sortDirection: 'desc' },
					{ key: 'doctor_nombre', label: 'Doctor', sortable: true, sortDirection: 'desc' },
				    { key: 'tratamiento', label: 'Tratamiento', sortable: true, sortDirection: 'desc' },
				    { key: 'cantidad', label: 'Cantidad', sortable: true, sortDirection: 'desc', class: 'text-center' },
				    { key: 'monto', label: 'Monto', sortable: true, sortDirection: 'desc', class: 'text-center' },
				    { key: 'total', label: 'Total', sortable: true, sortDirection: 'desc', class: 'text-center' },			        
				    { key: 'ganancia', label: 'Ganancia', sortable: true, sortDirection: 'desc', class: 'text-center'}			        
				],
			}
		},
		methods: {
			imprimirPagina(){
				window.print()
			},
			onSubmit(request, error_msg) {
				self = this
				if(request){
					axios(request).then((response) => {
						if(response.data.success){
							if( response.data.success == 'created' ){	
								this.onDisplayDetalle()		
								self.toastFunction('El pago a sido guradado correctamente', 'success')				
							}
						}else if (response.data.error){
								console.log('Response:: FAIL');
								self.all_errors = response.data.error
								self.toastFunction(error_msg, 'error')
						}
					}).catch(function (error) {
						self.toastFunction('Ha ocurrido un error crítico, por favor comunicarse con Odontoplus.pe.', 'error')
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
							timer: 3000
				})
			},
			onCerrar(){
				window.close()
				window.opener.external.comeback()
			}
		}
	}
</script>
<style>
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

	.pr-logo{
		position: relative; 
		height: 100%; 
		padding-top: 20px;
		width: 265px;
	}

	.pr-logo span{
		display: block;
		font-size: .8em;		
		text-align: center;
	}

	.pr-logo img{
		object-fit: cover;
		width: 100%;
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
	@media print {
		.hide-print{
			display: none
		}
	}
	@page{ 
	    size: auto;
	    margin: auto;  
	}
</style>