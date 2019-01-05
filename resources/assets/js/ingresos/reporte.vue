<template>
	<b-container>
		<b-row class="pb-2 mt-4">
			<b-col cols="4" class="text-left" >
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
	    			<span v-if="paciente_sede.celular != null">
							{{ paciente_sede.celular }} <span v-if="paciente_sede.celular_aux != ''"> - </span> {{ paciente_sede.celular_aux }}
						</span>
					</div>
				</div>
			</b-col>
			<b-col cols="8" class="text-right">
				<div class="d-inline-block text-left">
					<div class="text-center pb-2">
						<h5>Nro de Historia {{ igeneral.hc }}</h5>
					</div>
					<table class="data-general" border=1 cellspacing="0" cellpadding="0" >
							<tr>
								<td class="pr-title">FECHA: </td>
								<td colspan="3">{{ igeneral.fecha }}</td>
							</tr>
							<tr>
								<td class="pr-title">PACIENTE: </td>
								<td colspan="3">{{ igeneral.nombrePaciente }}</td>
							</tr>
							<tr>
								<td class="pr-title" >TOTAL: </td>
								<td colspan="3">S/ {{ igeneral.monto_total }}</td>
							</tr>
					</table>
				</div>
			</b-col>
		</b-row>
		<b-row class="d-print-none">
			<b-col cols="12" class="pt-4 pb-0 text-center">
				<b-button variant="success" v-on:click.prevent="imprimirPagina()">
					<i class="fas fa-print"></i> Imprimir
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
						<i class="fas fa-file-invoice-dollar"></i>&nbsp; Detalle de Ingreso
					</div>
				</div>
			</b-col>
		</b-row>
		<b-row>
			<b-col cols="12">
				<b-table 	show-empty
							:items="idetalle"
							:fields="fields"
					        empty-text="No existen campos para mostrar"
					        :foot-clone=false >
					<template slot="index" slot-scope="row">
						{{ row.index + 1 }}
					</template>
					<template slot="tratamiento" slot-scope="row">
						{{ row.value }}
					</template>
					<template slot="cantidad" slot-scope="row">
						{{ row.value }}
					</template>
					<template slot="monto" slot-scope="row">
						S/ {{ row.value }}
					</template>
					<template slot="total" slot-scope="row">
						S/ {{ row.value }}
					</template>
					<template slot="FOOT_tratamiento" slot-scope="row">
						{{ row.value }}
					</template>
				</b-table>
			</b-col>
			<b-col cols="12" class="text-right monto-class">
				<span>Monto Total: </span>S/ {{ igeneral.monto_total }}
			</b-col>
		</b-row>


		<b-row class="d-print-none">
			<b-col cols="12" class="pt-1 pb-2 text-center">
				<b-button variant="success" v-on:click.prevent="imprimirPagina()">
					<i class="fas fa-print"></i> Imprimir
				</b-button>
				<b-button variant="warning" v-on:click.prevent="onCerrar()">
					<i class="fas fa-times-circle"></i>&nbsp; Cerrar
				</b-button>
			</b-col>
		</b-row>

	</b-container>
</template>
<script>
	export default{
		mounted(){
			this.setLogotipo()
		},
		name: 'Reporte-Ingreso',
		props: [
			'url',
			'igeneral',
			'idetalle',
			'curUser',
			'cliente'
		],
		data(){
			return{
				logoUrl: '',
				fields: [
					{ key: 'index', label: '#' },
				    { key: 'fecha', label: 'Fecha', sortable: true, sortDirection: 'desc' },
				    { key: 'nombreDoctor', label: 'Doctor', sortable: true, sortDirection: 'desc', class: 'td-doc-width' },
				    { key: 'tratamiento', label: 'Tratamiento', sortable: true, sortDirection: 'desc', class: 'td-trat-width' },
				    { key: 'cantidad', label: 'Cantidad', 'class': 'text-center', sortable: true, sortDirection: 'desc' },
				    { key: 'monto', label: 'Monto', 'class': 'text-center', sortable: true, sortDirection: 'desc' },
				    { key: 'total', label: 'Total', 'class': 'text-center', sortable: true, sortDirection: 'desc' }
			    ]
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
		/* margin-top: 8px; */
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
	}

	@page{
	    size: auto;
	    margin: auto;
	}

	.td-doc-width{
		width: 225px;
	}

	.td-trat-width{
		width: 260px;
	}

</style>
