<template>
	<b-container>
		<b-row class="pb-2 mt-4">
			<b-col cols="4" class="text-left" >
				<div class="pr-logo">
					<img :src="this.url + '/images/empresa/logotipo_pdf.png'" />
					<span>Jr. Silva Santisteban #507, Cajamarca - Perú</span>
					<span>citas@sonrisacore.com</span>
					<span>(076) 284095 (Citas) </span>
    				<span>991 981911 - 966 704974 (Emergencias)</span>
				</div>
			</b-col>
			<b-col cols="8" class="text-right">
				<div class="d-inline-block text-left">
					<div class="text-center pb-2">
						<h5>PRESUPUESTO NRO {{ pgeneral.id }} - {{ pgeneral.idPaciente }}</h5>
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
								<td class="pr-title">DOCTOR: </td>
								<td>{{ pgeneral.nombreDoctor }}</td>
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
				</b-col>			
			</b-row>
		</section>
		
	</b-container>
</template>
<script>
	import Diente from './diente/diente.vue'

	export default{
		mounted(){			
			this.tratamientos = this.pdetalle
			this.descuento = this.pgeneral.descuento
			this.isMultipleOptions()
			this.haveDescuento()
			this.restartMainDientes()
		},
		components: {
			Diente
		},
		props: [
			'url',
			'pgeneral',
			'pdetalle',
			'precios'
		],
		data(){
			return{
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
				isDescuento: false
			}
		},
		methods: {
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
					return true
				}
				return false
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
	        	console.log('ok')	
				this.restartAllPintadoDientes()	
				console.log('ok')	
				this.pintarAllSeccionesDePiezas()            
				console.log('ok')	
				this.mostrarTratamientosEnTabla()
				console.log('ok')	            
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
	        		console.log(this.tratamientos[i].opcion )
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
	        mostrarTratamientosEnTabla(){
	        	this.tratamientos_tabla = []	
	        	this.sub_total = 0
	        	this.tratamientos.sort(this.menorAMayor)
	        	var monto = 0    	
	        	for( var i = 0; i < this.tratamientos.length; i++ ){
	        		console.log('!!!' + this.tratamientos[i].opcion)
	                if( this.tratamientos[i].opcion == this.opcion ){
	                    var pz = this.tratamientos[i].pieza
	                    var sec = this.tratamientos[i].seccion
	                    var ind_sec_tabla
	                    //Puede ser Mejor
	                    if( this.tratamientos[i].secUno == 0 && this.tratamientos[i].secDos == 0 ){
	                    	ind_sec_tabla = this.getIndiceTratamientoPorSeccion(sec)
	                    	monto += parseFloat(this.precios[ind_sec_tabla].monto)
	                        this.agregarDatosATabla(i, pz, this.precios[ind_sec_tabla].detalle, this.precios[ind_sec_tabla].monto);	                        
	                    }else if( this.tratamientos[i].secUno != 0 && this.tratamientos[i].secDos == 0 ){
	                        sec = 29;
	                        ind_sec_tabla = this.getIndiceTratamientoPorSeccion(sec)
	                        monto += parseFloat(this.precios[ind_sec_tabla].monto)
	                        this.agregarDatosATabla(i, pz, this.precios[ind_sec_tabla].detalle, this.precios[ind_sec_tabla].monto);
	                    }else if( this.tratamientos[i].secUno != 0 && this.tratamientos[i].secDos != 0 ){
	                        sec = 30;
	                        ind_sec_tabla = this.getIndiceTratamientoPorSeccion(sec)
	                        monto += parseFloat(this.precios[ind_sec_tabla].monto)
	                        this.agregarDatosATabla(i, pz, this.precios[ind_sec_tabla].detalle, this.precios[ind_sec_tabla].monto);
	                    }
	                }
	            }   
	            this.sub_total = this.redondearADos(monto)	            
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
	        	}else if( seccion >= 31 ){
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
</style>