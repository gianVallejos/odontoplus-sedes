<template>
	<b-container>
		<SpinnerContainer :url="url" ref="spinnerContainerRef" />
		<b-row class="pb-2" style="margin-top: -20px;">
			<b-col cols="4" class="text-left" >
				<div class="pr-logo-layout">
					<div class="pr-logo">
						<img :src="logoUrl" alt="Logo Empresa" @error="setDefaultImagenLogo" />
					</div>
					<div class="pr-descripcion-logo">
						<span v-if="paciente_sede.direccion != null">
							{{ paciente_sede.direccion }} {{ paciente_sede.ciudad }} - Perú <br />
						</span>
						<span v-if="paciente_sede.email != ''">
							{{ paciente_sede.email }} <br />
						</span>
						<span v-if="paciente_sede.telefono != ''">
							{{ paciente_sede.telefono }} <br />
						</span>
	    			<span v-if="paciente_sede.celular != ''">
							{{ paciente_sede.celular }} <span v-if="paciente_sede.celular_aux != ''"> - </span> {{ paciente_sede.celular_aux }}
						</span>
						<span v-if="paciente_sede.celular != ''">
							{{ paciente_sede.celular }} <span v-if="paciente_sede.celular_aux != ''"> - </span> {{ paciente_sede.celular_aux }}
						</span>
					</div>
				</div>
			</b-col>
			<b-col cols="8" class="text-right">
				<div class="d-inline-block text-left">
					<div class="text-center pb-2">
						<h5>PRESUPUESTO NRO {{ pgeneral.id }} | {{ pgeneral.codigo }}</h5>
					</div>
					<table class="data-general" border=1 cellspacing="0" cellpadding="0" >
							<tr>
								<td class="pr-title">FECHA: </td>
								<td>{{ pgeneral.fecha }}</td>
							</tr>
							<tr>
								<td class="pr-title">PACIENTE: </td>
								<td>{{ pgeneral.nombrePaciente }}</td>
							</tr>
							<tr>
								<td class="pr-title">EMPRESA: </td>
								<td>{{ pgeneral.empresa }}</td>
							</tr>
							<tr>
								<td class="pr-title">SEDE: </td>
								<td>{{ pgeneral.nombreSede }}</td>
							</tr>
							<tr>
								<td class="pr-title">DOCTOR: </td>
								<td>{{ pgeneral.nombreDoctor }}</td>
							</tr>
							<tr>
								<td class="pr-title">VENCE: </td>
								<td>{{ pgeneral.valido_hasta }}</td>
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
				<b-button variant="danger" v-on:click.prevent="onEliminar(
											  'A continuación eliminará el registro actual y no podrá ser recuperado.' +
							   				  '<br /><br />¿Seguro que desea eliminar este registro?')"
							   				  v-if="curUser.rolid == 1" >
					<i class="fas fa-trash-alt"></i>&nbsp;Eliminar
				</b-button>
				<b-button variant="warning" v-on:click.prevent="cerrarVenta()">
					<i class="fas fa-times"></i> &nbsp;Cerrar
				</b-button>
				<b-button variant="secondary" :href="url + '/ingresos/line-item/' + pgeneral.ingresosId">
					<i class="fas fa-money-check-alt"></i> &nbsp;Ver Ingresos
				</b-button>
			</b-col>
		</b-row>
		<b-row class="d-print-none" v-if="isMultipleOption">
			<b-col cols="6" class="pr-0 pl-0 pt-4">
				<button class="btn opcion-btn" v-on:click="cambiarOpcion(1)" v-bind:class="{ active: this.opc1 }">Odontograma #1</button>
			</b-col>
			<b-col cols="6" class="pl-0 pr-0 pt-4">
				<button class="btn opcion-btn" v-on:click="cambiarOpcion(2)" v-bind:class="{ active: !this.opc1 }">Odontograma #2</button>
			</b-col>
		</b-row>
		<b-row>
			<b-col cols="12" class="pl-0 pr-0 pt-4 pb-4">
				<div class="pr-section-title">
					<div class="pr-seccion-title-text">
						<i class="fas fa-tooth"></i> &nbsp;ODONTOGRAMA <span v-if="isMultipleOption">NRO {{ (this.opc1) ? '1' : '2' }}</span>
					</div>
				</div>
			</b-col>
		</b-row>

		<!-- ODONTOGRAMA -->
		<section id="odontograma">
			<b-row class="pt-4 pb-4">
							<b-col cols="6" class="text-right pl-0 od-right-border">
								<div class="d-inline-block text-center" v-for="i in range(18, 11)" >
									<span class="od-modal" v-bind:class="{noEditable : !isEditable}" >{{ i }}</span>
									<Diente :ref="'pz'+i" :pieza=i :isEditable="false" />
								</div>
							</b-col>
							<b-col cols="6" class="text-left pr-0">
								<div class="d-inline-block text-center" v-for="i in range(21, 28)" >
									<span class="od-modal" v-bind:class="{noEditable : !isEditable}" >{{ i }}</span>
									<Diente :ref="'pz'+i" :pieza=i :isEditable="false" />
								</div>
							</b-col>
							<b-col cols="6" class="text-right pl-0 od-right-border">
								<div class="d-inline-block text-center" v-for="i in range(55, 51)" >
									<Diente :ref="'pz'+i" :pieza=i :isEditable="false" />
									<span class="od-modal" v-bind:class="{noEditable : !isEditable}" >{{ i }}</span>
								</div>
							</b-col>
							<b-col cols="6" class="text-left pr-0">
								<div class="d-inline-block text-center" v-for="i in range(61, 65)" >
									<Diente :ref="'pz'+i" :pieza=i :isEditable="false" />
									<span class="od-modal" v-bind:class="{noEditable : !isEditable}" >{{ i }}</span>
								</div>
							</b-col>
							<b-col cols="12">
								<hr>
							</b-col>
							<b-col cols="6" class="text-right pl-0 od-right-border">
								<div class="d-inline-block text-center" v-for="i in range(85, 81)" >
									<span class="od-modal" v-bind:class="{noEditable : !isEditable}" >{{ i }}</span>
									<Diente :ref="'pz'+i" :pieza=i :isEditable="false" />
								</div>
							</b-col>
							<b-col cols="6" class="text-left pr-0">
								<div class="d-inline-block text-center" v-for="i in range(71, 75)" >
									<span class="od-modal" v-bind:class="{noEditable : !isEditable}" >{{ i }}</span>
									<Diente :ref="'pz'+i" :pieza=i :isEditable="false" />
								</div>
							</b-col>
							<b-col cols="6" class="text-right pl-0 od-right-border">
								<div class="d-inline-block text-center" v-for="i in range(48, 41)" >
									<Diente :ref="'pz'+i" :pieza=i :isEditable="false" />
									<span class="od-modal" v-bind:class="{noEditable : !isEditable}" >{{ i }}</span>
								</div>
							</b-col>
							<b-col cols="6" class="text-left pr-0">
								<div class="d-inline-block text-center" v-for="i in range(31, 38)" >
									<Diente :ref="'pz'+i" :pieza=i :isEditable="false" />
									<span class="od-modal" v-bind:class="{noEditable : !isEditable}" >{{ i }}</span>
								</div>
							</b-col>
			</b-row>
		</section>
		<section>
			<b-row class="pt-4 pb-3">
							<b-col cols="12">
								<b-table show-empty :items=tratamientos_tabla :fields="fields" empty-text="No existen campos para mostrar">
									<template slot="pieza" slot-scope="row">
								    	{{ row.value }}
								    </template>
								    <template slot="tratamiento" slot-scope="row">
								    	{{ row.value }}
								    </template>
								    <template slot="deductible" slot-scope="row">
								    	{{ row.value }}
								    </template>
								    <template slot="monto" slot-scope="row">
								    	S/ {{ row.value }}
								    </template>
								    <template slot="total" slot-scope="row">
								    	S/ {{ row.value }}
								    </template>
								</b-table>
							</b-col>
			</b-row>
			<b-row class="pt-0 pb-3">
				<b-col cols="12" class="text-right pr-4 pt-3" v-if="isDescuento">
					<div class="subtotal-layout">
						<div class="sub d-inline-block">Subtotal: </div>
						<div class="d-inline-block presupuesto-sub text-left">
							<span>S/ {{ sub_total }}</span>
						</div>
					</div>
				</b-col>
				<b-col cols="12" class="text-right pr-4" v-if="isDescuento">
					<div class="subtotal-layout">
						<div class="sub d-inline-block">Descuento: </div>
						<b-form-select v-model="descuento" :options="options_descuento" class="presupuesto-form" v-on:input="aplicarDescuento()" disabled />
					</div>
				</b-col>
				<b-col cols="12" class="text-right pr-4">
					<div class="subtotal-layout">
						<div class="sub d-inline-block">Total: </div>
						<div class="d-inline-block presupuesto-sub text-left">
							<span>S/ {{ total }}</span>
						</div>
					</div>
				</b-col>
			</b-row>
			<b-row class="d-print-none">
				<b-col cols="12" class="pt-1 pb-2 text-center">
					<b-button variant="success" v-on:click.prevent="imprimirPagina()">
						<i class="fas fa-print"></i> &nbsp;Imprimir
					</b-button>
					<b-button variant="danger" v-on:click.prevent="onEliminar(
											  'A continuación eliminará el registro actual y no podrá ser recuperado.' +
							   				  '<br /><br />¿Seguro que desea eliminar este registro?')"
							   				  v-if="curUser.rolid == 1" >
						<i class="fas fa-trash-alt"></i>&nbsp;Eliminar
					</b-button>
					<b-button variant="warning" v-on:click.prevent="cerrarVenta()">
						<i class="fas fa-times"></i> &nbsp;Cerrar
					</b-button>
					<b-button variant="secondary" :href="url + '/ingresos/line-item/' + pgeneral.ingresosId">
						<i class="fas fa-money-check-alt"></i> &nbsp;Ver Ingresos
					</b-button>
				</b-col>
			</b-row>
		</section>

	</b-container>
</template>
<script>
	import Diente from './diente/diente.vue'
	import SpinnerContainer from '../widgets/spinner/spinner-container.vue'
	import axios from 'axios'

	export default{
		mounted(){
			this.setLogotipo()

			this.record_id = this.pgeneral.id
			this.tratamientos = this.pdetalle
			this.descuento = this.pgeneral.descuento
			this.isMultipleOptions()
			this.haveDescuento()
			this.restartMainDientes()
		},
		components: {
			Diente,
			SpinnerContainer
		},
		props: [
			'url',
			'curUser',
			'pgeneral',
			'pdetalle',
			'precios',
			'paciente_sede'
		],
		data(){
			return{
				logoUrl: '',
				pieza_actual: '',
			    tratamiento_actual: '',
			    opcion: 1,
			    todos: ['', 'center', 'top', 'right', 'left', 'bottom', 'ionomero'],
			    tratamientos: [],
			    tratamientos_tabla: [],
			    fields: [
				    { key: 'pieza', label: 'Pieza', class: 'text-center'},
				    { key: 'tratamiento', label: 'Tratamiento'},
				    { key: 'deductible', label: 'Deductible', class: 'text-center'},
				    { key: 'monto', label: 'Monto', class: 'text-center' },
				    { key: 'total', label: 'Total', class: 'text-center'},
				    { key: 'action', label: '', class: 'text-center'}
			    ],
			    currentPage: 1,
			   	perPage: 10,
			    totalRows: 0,
			    pageOptions: [ 5, 10, 15 ],
			    sortBy: null,
			    sortDesc: false,
			    sortDirection: 'asc',
			    filter: '',
			    actual_pieza: null,
			    fromBtn: null,
			    opc1: true,
			    trat_string: ['', 'center', 'top', 'right', 'left', 'bottom', 'ionomero'],
			    sub_total: this.redondearADos(0),
			    total: this.redondearADos(0),
			    descuento: 0,
			    options_descuento: [
			    	{ value: 0, text: '0%' },
			    	{ value: 5, text: '5%' },
			    	{ value: 10, text: '10%' }
			    ],
				isEditable: false,
				opc1: true,
				isMultipleOption: false,
				isDescuento: false,
				record_id: ''
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
			isMultipleOptions(){
				for( var i = 0; i < this.tratamientos.length; i++ ){
					if( this.tratamientos[i].opcion == 2 ){
						this.isMultipleOption = true
						return true;
					}
				}
				return false;
			},
			haveDescuento(){
				if( this.descuento > 0 ){
					this.isDescuento = true
					this.matchDescuento()
					return true
				}
				return false
			},
			matchDescuento(){
				if( this.descuento == 1 ){
					this.descuento = 5
				}else if(this.descuento == 2){
					this.descuento = 10
				}
			},
			range(min,max){
				var array = [],
				j = 0;
				if( min <= max ){
					for(var i = min; i <= max; i++){
						array[j] = i;
						j++;
					}
				}else{
					for( var i = min; i >= max; i-- ){
						array[j] = i;
						j++;
					}
				}
				return array;
			},
			onFiltered (filteredItems) {
		      this.totalRows = filteredItems.length
		      this.currentPage = 1
		    },
		    redondearADos(total){
	        	return parseFloat(Math.round(total * 100) / 100).toFixed(2)
	        },
	        cambiarOpcion(opc){
	        	this.opcion = opc
	        	this.changeOpcionBoton(opc)
	        	this.restartMainDientes()
	        },
	        restartMainDientes(){ //Principal
				this.restartAllPintadoDientes()
				this.pintarAllSeccionesDePiezas()
				this.mostrarTratamientosEnTabla()
	        },
	        restartAllPintadoDientes(){
	        	for( var i = 0; i < this.tratamientos.length; i++ ){
	        		if( this.tratamientos[i].pieza != 0 ){
		        		this.despintarSeccionDiente(2, this.tratamientos[i].pieza)
		        		this.despintarSeccionDiente(3, this.tratamientos[i].pieza)
		        		this.despintarSeccionDiente(4, this.tratamientos[i].pieza)
		        		this.despintarSeccionDiente(5, this.tratamientos[i].pieza)
		        		this.despintarSeccionDiente(6, this.tratamientos[i].pieza)
		        		this.despintarSeccionDiente(7, this.tratamientos[i].pieza)
		        		this.despintarSeccionDiente(this.tratamientos[i].seccion, this.tratamientos[i].pieza)
		        	}
	        	}
	        },
	        pintarAllSeccionesDePiezas(){
	        	for( var i = 0; i < this.tratamientos.length; i++ ){
	        		if( this.tratamientos[i].opcion == this.opcion ){
		        		var pieza = this.tratamientos[i].pieza
						var sec = this.tratamientos[i].seccion
						var secUno = this.tratamientos[i].secUno
						var secDos = this.tratamientos[i].secDos

						if( pieza != 0 ){
							if( sec <= 7 ){ //Resina
							    this.pintarResina(pieza, sec)
							    this.pintarResinaCompuesta(pieza, secUno)
							    this.pintarResinaCompuesta(pieza, secDos)
							}else{
							    this.pintarOtroTratamiento(sec, pieza) //pintarNoResinas
							}
						}
					}
	        	}
	        },
	        menorAMayor(a, b) {
	        	return a.pieza - b.pieza
	            /*
	            if (a[0] === b[0]) {
	                return 0;
	            }
	            else {
	                return (a[0] < b[0]) ? -1 : 1;
	            }
	            */
	        },
	        mostrarTratamientosEnTabla(){
	        	this.tratamientos_tabla = []
	        	this.sub_total = 0
	        	this.tratamientos.sort(this.menorAMayor)
	        	var monto_total = 0
	        	for( var i = 0; i < this.tratamientos.length; i++ ){
	                if( this.tratamientos[i].opcion == this.opcion ){
	                    var pz = this.tratamientos[i].pieza
	                    var sec = this.tratamientos[i].seccion
	                    var monto = this.tratamientos[i].monto
	                    var ind_sec_tabla = null
	                    //Puede ser Mejor
	                    if( this.tratamientos[i].secUno == 0 && this.tratamientos[i].secDos == 0 ){
	                    	ind_sec_tabla = this.getIndiceTratamientoPorSeccion(sec)
	                    	monto_total += parseFloat(monto)
	                        this.agregarDatosATabla(i, pz, this.precios[ind_sec_tabla].detalle, monto);
	                    }else if( this.tratamientos[i].secUno != 0 && this.tratamientos[i].secDos == 0 ){
	                        sec = 29;
	                        ind_sec_tabla = this.getIndiceTratamientoPorSeccion(sec)
	                        monto_total += parseFloat(monto)
	                        this.agregarDatosATabla(i, pz, this.precios[ind_sec_tabla].detalle, monto);
	                    }else if( this.tratamientos[i].secUno != 0 && this.tratamientos[i].secDos != 0 ){
	                        sec = 30;
	                        ind_sec_tabla = this.getIndiceTratamientoPorSeccion(sec)
	                        monto_total += parseFloat(monto)
	                        this.agregarDatosATabla(i, pz, this.precios[ind_sec_tabla].detalle, monto);
	                    }
	                }
	            }
	            this.sub_total = this.redondearADos(monto_total)
	            this.total = this.calcularDescuento()
	        },
	        calcularDescuento(){
	        	return this.redondearADos(this.sub_total - (this.sub_total * (parseFloat(this.descuento)/100)))
	        },
	        despintarSeccionDiente(seccion, pieza){
	        	var sec = 'pz' + pieza
	        	if( seccion == '7' ){
					this.$refs[sec][0].isMiddle = false//!this.isMiddle
	        	}else if( this.trat_string[seccion] == 'top' ){
					this.$refs[sec][0].isTop = false//!this.isTop
	        	}else if( this.trat_string[seccion] == 'right' ){
					this.$refs[sec][0].isRight = false//!this.isRight
	        	}else if( this.trat_string[seccion] == 'left' ){
					this.$refs[sec][0].isLeft = false//!this.isLeft
	        	}else if( this.trat_string[seccion] == 'bottom' ){
					this.$refs[sec][0].isBottom = false//!this.isBottom
	        	}else if( this.trat_string[seccion] == 'ionomero' ){
					this.$refs[sec][0].isIonomero = false//!this.isIonomero
	        	}else if( seccion >= 8 && seccion <= 11 ){
	        		this.$refs[sec][0].isCorona = false
	        	}else if( seccion >= 8 && seccion <= 23 ){
	        		this.$refs[sec][0].extra_trat = ''
	        	}else if( seccion >= 26 && seccion <= 28 ){
	        		this.$refs[sec][0].extra_trat = ''
	        	}else if( seccion == 31 ){
	        		this.$refs[sec][0].extra_trat = ''
	        	}
	        },
	        pintarOtroTratamiento(seccion, pieza){
	        	var sec = 'pz' + pieza
	        	if( seccion >= 8 && seccion <= 11 ){
	        		this.$refs[sec][0].isCorona = true
	        	}else if( seccion >=12 && seccion <= 14 ){
	        		this.$refs[sec][0].extra_trat = 'exodoncia'
	        	}else if( seccion >= 15 && seccion <= 17 || seccion >= 20 && seccion <= 21 ){
	        		this.$refs[sec][0].extra_trat = 'palito'
	        	}else if( seccion >= 18 && seccion <= 19 ){
	        		this.$refs[sec][0].extra_trat = 'carilla'
	        	}else if( seccion >= 22 && seccion <= 23 ){
	        		this.$refs[sec][0].extra_trat = 'perno'
	        	}else if( seccion >= 26 && seccion <= 28 ){
	        		this.$refs[sec][0].extra_trat = 'incrustracion'
	        	}else if( seccion == 31 ){
	        		this.$refs[sec][0].extra_trat = 'sellante'
	        	}
	        },
	        pintarResinaCompuesta(piezaDiente, auxSeccion){
	            if( auxSeccion != 0 ){
	                this.pintarResina(piezaDiente, auxSeccion);
	            }
	        },
	        pintarResina(pieza, seccion){
	            var sec = 'pz' + pieza
	        	if( seccion == '7' ){
					this.$refs[sec][0].isMiddle = true//!this.isMiddle
	        	}else if( this.trat_string[seccion] == 'top' ){
					this.$refs[sec][0].isTop = true//!this.isTop
	        	}else if( this.trat_string[seccion] == 'right' ){
					this.$refs[sec][0].isRight = true//!this.isRight
	        	}else if( this.trat_string[seccion] == 'left' ){
					this.$refs[sec][0].isLeft = true//!this.isLeft
	        	}else if( this.trat_string[seccion] == 'bottom' ){
					this.$refs[sec][0].isBottom = true//!this.isBottom
	        	}else if( this.trat_string[seccion] == 'ionomero' )
					this.$refs[sec][0].isIonomero = true//!this.isIonomero
	        },
	        getIndiceTratamientoPorSeccion(sec){
	        	for( var i = 0; i < this.precios.length; i++ ){
	        		if( this.precios[i].id == sec ){
	        			return i
	        		}
	        	}
	        },
	        agregarDatosATabla(ind, pieza, tratamiento, monto){	 //Puede ser mejor
	        	if( pieza == 0 ){
	        		pieza = ' '
	        	}
		    	this.tratamientos_tabla.push({id: ind, pieza, tratamiento, deductible: 0, monto, total: monto})
		    	//this.calcularTotalesMonto(monto)
	        },
	        changeOpcionBoton(opc){
	        	if( opc == 2 ){
	        		this.opc1 = false
	        	}else{
	        		this.opc1 = true
	        	}
	        },
	    	onEliminar(msg){
	    		this.$swal({
							title: '<span style="#fff; font-size: 1em" class="pt-2">Atención</span>',
							html:  '<span style="font-size: 1em">' + msg +
								   '</span>',
							animation: false,
							showConfirmButton: true,
							showCancelButton: true,
							confirmButtonText: 'Aceptar',
							confirmButtonClass: ['my-alert', 'confirm-alert'],
							cancelButtonText: 'Cancelar',
							cancelButtonClass: ['my-alert', 'cancel-alert'],
							showCloseButton: true
				}).then((result) => {
					if( result.value ){
						var request = { method: 'DELETE', url: this.url + '/presupuestos/' + this.record_id, data: this.form }
		    			var mssgOnFail = 'Ha ocurrido un error al eliminar este registro.'
		    			this.onSubmit(request, mssgOnFail)
					}
				})
	    	},
			onSubmit(request, error_msg) {
				self = this
				if(request){
					self.$refs.spinnerContainerRef.showSpinner()
					axios(request).then((response) => {
						if(response.data.success){
							self.$refs.spinnerContainerRef.hideSpinner()
							if (response.data.success = 'deleted' ){
								self.toastFunctionRedirect('Éxito', 'El presupuesto ha sido eliminado correctamente.', 'success')
							}
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
						type: type,
						title: title,
						html: msg,
						toast: false,
						position: 'center',
						confirmButtonClass: ['my-alert', 'confirm-alert'],
		  			backdrop: `rgba(0, 0, 0, 0.6)`
				}).then(() => {
						window.close()
						window.opener.location.reload()
						window.opener.external.comeback()
						//window.location.href = this.url + '/presupuestos'
				})
			},
			cerrarVenta(){
					window.close()
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

	@media screen {
	  div.divFooter {
	    display: none;
	  }
	}
	@media print {
	  div.divFooter {
	  	display: none;
	    position: fixed;
	    top: 0;
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

</style>
