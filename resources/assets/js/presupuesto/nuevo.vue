<template>
	<b-container class="pb-4">				
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Presupuestos" :items="breadcrumb" />				
			</b-col>
			<b-col cols="12" class="pt-3">				
				<PanelCard>
					<span slot="heading">Presupuesto Nro {{ nro }} </span>
					<div slot="body" class="pt-3 pb-3 pl-3 pr-3">												
						<div class="presupuesto-top">
							<b-row>							
									<b-col cols="6 pb-2">										
										<span>Fecha:</span>
										<div class="d-inline-block texto">
											{{ fechahora }}
										</div>										
									</b-col>
									<b-col cols="6 pb-2">
										<span>Nro Historia:</span><div class="d-inline-block texto">{{ paciente.id }}</div>										
									</b-col>
									<b-col cols="6 pb-2">
										<span>Paciente:</span><div class="d-inline-block texto">{{ paciente.nombres }} {{ paciente.apellidos }}</div>
									</b-col>
									<b-col cols="6 pb-2">
										<span>Doctor:</span><div class="d-inline-block texto">{{ doctor.nombres }} {{ doctor.apellidos }}</div>
									</b-col>
									<b-col cols="6 pb-2">
										<span>Empresa:</span><div class="d-inline-block texto">{{ paciente.empresa }}</div>
									</b-col>
									<b-col cols="6 pb-2">
										<span>Sede:</span><div class="d-inline-block texto">Cajamarca</div>					
									</b-col>							
							</b-row>
						</div>
						<b-row class="pb-3">
							<b-col cols="6" class="pr-0 pl-0 pt-4">
								<button class="btn opcion-btn" v-on:click="cambiarOpcion(1)" v-bind:class="{ active: this.opc1 }">Odontograma #1</button>
							</b-col>
							<b-col cols="6" class="pl-0 pr-0 pt-4">
								<button class="btn opcion-btn" v-on:click="cambiarOpcion(2)" v-bind:class="{ active: !this.opc1 }">Odontograma #2</button>
							</b-col>
						</b-row>
						<b-row v-if="!isSuccess" >
							<b-col cols="12" class="text-center pt-4 pb-4">
								<b-button type="submit" variant="success" v-on:click="onSubmitSave">
									<i class="fas fa-save"></i>&nbsp; Guardar
								</b-button>								
								<b-button :href="url + '/presupuestos'" variant="danger">
									<i class="fas fa-times"></i>&nbsp;Cancelar
								</b-button>
							</b-col>
						</b-row>
						<b-row class="pt-4 pb-4">
							<b-col cols="6" class="text-right pl-0 od-right-border">												
								<div class="d-inline-block text-center" v-for="i in range(18, 11)" >
									<span class="od-modal" v-on:click="abrirModalDesdePieza(i)">{{ i }}</span>
									<Diente :ref="'pz'+i" @click="middlewareTratamientoResina" :pieza=i />
								</div>				
							</b-col>
							<b-col cols="6" class="text-left pr-0">
								<div class="d-inline-block text-center" v-for="i in range(21, 28)" >
									<span class="od-modal" v-on:click="abrirModalDesdePieza(i)">{{ i }}</span> 
									<Diente :ref="'pz'+i" @click="middlewareTratamientoResina" :pieza=i />
								</div>				
							</b-col>
							<b-col cols="6" class="text-right pl-0 od-right-border">												
								<div class="d-inline-block text-center" v-for="i in range(55, 51)" >									
									<Diente :ref="'pz'+i" @click="middlewareTratamientoResina" :pieza=i />
									<span class="od-modal" v-on:click="abrirModalDesdePieza(i)">{{ i }}</span> 
								</div>				
							</b-col>
							<b-col cols="6" class="text-left pr-0">
								<div class="d-inline-block text-center" v-for="i in range(61, 65)" >									
									<Diente :ref="'pz'+i" @click="middlewareTratamientoResina" :pieza=i />
									<span class="od-modal" v-on:click="abrirModalDesdePieza(i)">{{ i }}</span> 
								</div>				
							</b-col>
							<b-col cols="12">
								<hr>	
							</b-col>							
							<b-col cols="6" class="text-right pl-0 od-right-border">												
								<div class="d-inline-block text-center" v-for="i in range(85, 81)" >
									<span class="od-modal" v-on:click="abrirModalDesdePieza(i)">{{ i }}</span>
									<Diente :ref="'pz'+i" @click="middlewareTratamientoResina" :pieza=i />
								</div>				
							</b-col>
							<b-col cols="6" class="text-left pr-0">
								<div class="d-inline-block text-center" v-for="i in range(71, 75)" >
									<span class="od-modal" v-on:click="abrirModalDesdePieza(i)">{{ i }}</span>
									<Diente :ref="'pz'+i" @click="middlewareTratamientoResina" :pieza=i />
								</div>				
							</b-col>
							<b-col cols="6" class="text-right pl-0 od-right-border">												
								<div class="d-inline-block text-center" v-for="i in range(48, 41)" >									
									<Diente :ref="'pz'+i" @click="middlewareTratamientoResina" :pieza=i />
									<span class="od-modal" v-on:click="abrirModalDesdePieza(i)">{{ i }}</span>
								</div>				
							</b-col>
							<b-col cols="6" class="text-left pr-0">
								<div class="d-inline-block text-center" v-for="i in range(31, 38)" >									
									<Diente :ref="'pz'+i" @click="middlewareTratamientoResina" :pieza=i />
									<span class="od-modal" v-on:click="abrirModalDesdePieza(i)">{{ i }}</span>
								</div>				
							</b-col>
						</b-row>						
						<b-row class="pt-4">
							<b-col cols="6" class="text-left">
								<b-button v-on:click=abrirModalDesdeBtn >Agregar Tratamiento Extra</b-button>
							</b-col>
							<b-col cols="6" class="text-right pr-4">		
								<div class="subtotal-layout pt-1" >
									<div class="sub d-inline-block">Subtotal: </div>
									<div class="d-inline-block presupuesto-sub text-left">
										<span>S/ {{ sub_total }}</span>
									</div>
								</div>						
							</b-col>
						</b-row>
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
								    <template slot="action" slot-scope="row">								    	
								    	<a href="#" v-on:click.prevent="eliminarTratamiento(row.item.id)" class="tratamiento-delete">
								    		Eliminar
								    	</a>
								    </template>
								</b-table>											
							</b-col>
						</b-row>
						<b-row class="pt-4 pb-3">
							<b-col cols="12" class="text-right pr-4">			
								<div class="subtotal-layout">							
									<div class="sub d-inline-block">Subtotal: </div>
									<div class="d-inline-block presupuesto-sub text-left">
										<span>S/ {{ sub_total }}</span>
									</div>
								</div>
							</b-col>
							<b-col cols="12" class="text-right pr-4">
								<div class="subtotal-layout">							
									<div class="sub d-inline-block">Descuento: </div>
									<b-form-select v-model="descuento" :options="options_descuento" class="presupuesto-form" v-on:input="aplicarDescuento()" />									
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
						<b-row v-if="!isSuccess" >
							<b-col cols="12" class="text-center pt-4 pb-4">
								<b-button type="submit" variant="success" v-on:click="onSubmitSave">
									<i class="fas fa-save"></i>&nbsp; Guardar
								</b-button>								
								<b-button :href="url + '/presupuestos'" variant="danger">
									<i class="fas fa-times"></i>&nbsp;Cancelar
								</b-button>
							</b-col>
						</b-row>

					</div>
				</PanelCard>				
			</b-col>
		</b-row>				
		<b-modal ref="tratamientosModalRef" id="modal1" title="Lista de Tratamientos" size="lg" no-fade hide-footer>
			<b-row>
				<b-col cols="12">
					<b-input-group>
						<div class="input-group-append">
							<span class="icon-input">
				    			<i class="fas fa-search" aria-hidden="true"></i>
				    		</span>
				    	</div>
			    		<input v-model="filter" placeholder="Buscar..." type="text" class="odInput">
					</b-input-group>
				</b-col>
				<b-col cols="12">
					<b-table show-empty :items="precios_table" :fields="fieldsPrecios" 
								:current-page="currentPage" :per-page="perPage" :filter="filter" 
								:sort-by.sync="sortBy" :sort-desc.sync="sortDesc" 
								:sort-direction="sortDirection" @filtered="onFiltered">						
						<template slot="id" slot-scope="row" >								    	
							{{ row.value }}
						</template>
						<template slot="detalle" slot-scope="row">								    	
							{{ row.value }}
						</template>
						<template slot="monto" slot-scope="row">								    	
							S/ {{ row.value }}
						</template>
						<template slot="action" slot-scope="row">								    	
							<a href="#" @click.prevent="middlewareTratamientoResinaFromModal(row.item.id, actual_pieza)">
								Agregar
							</a>
						</template>	
					</b-table>					
				</b-col>
				<b-col cols="12" class="text-center">
					<b-pagination :total-rows="totalRows" :per-page="perPage" v-model="currentPage" class="d-inline-flex" />
				</b-col>
			</b-row>
  		</b-modal>
	</b-container>
</template>
<script>
	import TitleComponent from '../widgets/titulo/index.vue'
	import PanelCard from '../widgets/panel/panel-component.vue'
	import Diente from './diente/diente.vue'
	import axios from 'axios'

	export default{
		created(){									
			console.log('Nuevo presupuesto mounted')
		},
		components:{
			TitleComponent,
			PanelCard,
			Diente
		},
		props: [
			'url',
			'nro',
			'doctor',
			'paciente', 
			'act_empresa',
			'precios',
			'precios_table',
			'fechahora'
		],
		data(){
			return {
				breadcrumb: [
			    	{ text: 'Dashboard', href: this.url },
			    	{ text: 'Presupuestos', href: this.url + '/presupuestos' },
			    	{ text: 'Crear Presupuesto', active: true }
			    ],
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
			    fieldsPrecios: [
			    	{ key: 'id', label: 'Nro', class: 'text-center'},
			    	{ key: 'detalle', label: 'Tratamiento', sortable: true, sortDirection: 'desc'},
			    	{ key: 'monto', label: 'Precio (S/)', class: 'text-center'},
			    	{ key: 'action', label: '' }
			    ],			    
			    modalTratamientos: false,
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
			    isSuccess: false
			}
		},
		methods: {
			onFiltered (filteredItems) {
		      this.totalRows = filteredItems.length
		      this.currentPage = 1
		    },
		    aplicarDescuento(){
		    	this.total = this.calcularDescuento()
		    },
		    eliminarTratamiento(ind){
		    	alert(ind)
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
			/*	
			agregarTratamientoDesdeModal(seccion){	
				if( !this.existeTratamiento(seccion, this.actual_pieza) ){
					this.tratamientos.push({pieza: this.actual_pieza, seccion: seccion, secUno: null, secDos: null, opcion: this.opcion})				
					this.closeModal()
					this.mostrarTratamientosEnTabla()
				}else{
					this.$toasted.show('No puede agregar el mismo tratamiento en la misma pieza.', 
											{ 
												position: 'top-center',
												className: 'toast-danger',
												duration: 3500,
												containerClass: 'test'
											})
				}
			},*/
			esNumero(value){
				return Number.isInteger(value)
			},
			closeModal(){
				this.$refs.tratamientosModalRef.hide()
				//this.actual_pieza = null
				this.filter = ''
			},			
			onSubmitSave(){
				if( this.tratamientos.length != 0 ){
						this.$swal({ 
							 title: '<span style="#fff; font-size: 1em">Atención</span>', 
							 html: '<span style="font-size: 1em">' +
							 		'A continuación se guardará el actual presupuesto y no podrá ser modificado.' + 
							 		'<br /><br />¿Seguro que deseas guardar este presupuesto?' +
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
									this.guardarTratamiento()
								}	
							})
				}else{
					this.$swal({ 
							 title: '<span style="#fff; font-size: 1em">Alerta</span>', 
							 html: 'Debe agregar por lo menos un tratamiento',								 
							 showConfirmButton: false, 
							 showCancelButton: false,
							 showCloseButton: false,							 
							 type: 'warning',
							 toast: true,
							 position: 'top',
							 timer: 3000
							})
				}
			},
			guardarTratamiento(){
				axios.post(this.url + '/api-v1/save-nuevo-presupuesto', {
					pacienteId: this.paciente.id,
					doctorId: this.doctor.id,
					nroPresupuesto: this.nro,
					descuento: this.descuento,
					tratamientos: this.tratamientos
				}).then( (request) => {	
						if( request.data == "ok" ){
							this.isSuccess = true
							this.$swal({ 
								title: '<span style="#fff; font-size: 1em">Éxito</span>',	
								html: 'Presupuesto guardado correctamente',								 
							 	showConfirmButton: false, 
							 	showCancelButton: false,
							 	showCloseButton: false,							 
							 	type: 'success',
							 	toast: true,
							 	position: 'top',
							 	timer: 3000						 	
							}).then(() => {
								window.location.href = this.url + '/presupuestos'
							})
						}
							/*
					if( request.data.success == 'success' ){
						console.log(request.data)						
						this.success = true						
					}else{
						console.log(request.data)						
                        this.success = false						
					}

					if( !this.success ){
						this.allerros = request.data.error
						this.$toasted.show('Existen campos inválidos. Por favor verificalos.', 
											{ 
												position: 'top-center',
												className: 'toast-danger',
												duration: 3500,
												containerClass: 'test'
											})
					}else{
						this.allerros = []
						this.$toasted.show('Campo agregado correctamente.', 
											{ 
												position: 'top-center',
												className: 'toast-success',
												duration: 3500,
												containerClass: 'test'
											})
						this.isDisabled = true
						setTimeout(function () {
						    window.location.href = this.url + '/pacientes'
						}.bind(this), 3500)
					}*/
				}).catch((error) => {
					console.log(error)
                    this.$toasted.show('Ha ocurrido un error crítico, por favor comunicarse con Odontoplus.pe', 
										{ 
												position: 'top-center',
												className: 'toast-danger',
												duration: 3500,
												containerClass: 'test'
									})                   	                   	
                })
			},
			/*
			agregarTratamiento(seccion, idPieza){					
				if( seccion <= 7 ){
					this.agregarPiezaSeccionATratamientos(seccion, idPieza)
				}else{
					this.pieza_actual = idPieza
					this.tratamiento_actual = seccion
					this.tratamientos.push({pieza: idPieza, seccion: seccion, secUno: null, secDos: null, opcion: this.opcion})							
					this.mostrarTratamientosEnTabla()
				}
			},*/
			esResina(value){
	            if( value <= 5 ) return true;
	            if( value == 7 ) return true;
	            return false;
	        },
	        existeResina(pieza){
	            for( var i = 0; i < this.tratamientos.length; i++ ){	            	
	                if( this.tratamientos[i].pieza == pieza && this.esResina(this.tratamientos[i].seccion) && this.tratamientos[i].opcion == this.opcion ){ //Es caries
	                    return i;
	                }
	            }
	            return -1;
	        },
	        existeTratamiento(seccion, pieza){
	            for( var i = 0; i < this.tratamientos.length; i++ ){
	                if( this.tratamientos[i].pieza == pieza && this.tratamientos[i].seccion == seccion && this.tratamientos[i].opcion == this.opcion ) return true;
	            }
	            return false;
	        },/*	        
	        agregarPiezaSeccionATratamientos(seccion, pieza){	    //Puede ser mejor        
	            if( !this.existeTratamiento(seccion, pieza) ){
	                var ind = this.existeResina(pieza)
	                var flag = 0
	                if( ind != -1 && this.esResina(seccion) ){
	                    if( this.tratamientos[ind].secUno == null && this.tratamientos[ind].secDos == null && this.tratamientos[ind].opcion == this.opcion){
	                        this.tratamientos[ind].secUno = seccion;    flag = 1
	                    }else if( this.tratamientos[ind].secUno != null && this.tratamientos[ind].secDos == null && this.tratamientos[ind].opcion == this.opcion){
	                        this.tratamientos[ind].secDos = seccion;    flag = 1
	                    }else if( this.tratamientos[ind].secUno != null && this.tratamientos[ind].secDos != null && this.tratamientos[ind].opcion == this.opcion){
	                        this.$toasted.show('No puede agregar más de tres resinas en una sola pieza.', {
												position: 'top-center', className: 'toast-danger', duration: 3500, containerClass: 'test'
											})
	                        flag = 1	    
	                    }else{
	                        flag = 0
	                    }
	                }
	                if( flag == 0 ){
	                    this.tratamientos.push({pieza, seccion, secUno: null, secDos: null, opcion: this.opcion})	                    
	                }		                
	                this.mostrarTratamientosEnTabla()
	            }else{
	            	this.$toasted.show('No puede agregar el mismo tratamiento en la misma pieza.', 
											{ 
												position: 'top-center',
												className: 'toast-danger',
												duration: 3500,
												containerClass: 'test'
											})	            	
	            }
	        },*/	        
	        /*
	        calcularTotalesMonto(monto){
	        	this.sub_total = this.redondearADos(parseFloat(this.sub_total) + parseFloat(monto))
	        	this.total = this.sub_total //this.redondearADos(this.sub_total - (this.sub_total * (this.getDescuentoActual()/100)))
	        	//this.calcularMontosPorDescuento()
	        },
	        /*
	        calcularMontosPorDescuento(){
	        	//console.log(this.getDescuentoActual())
				this.total = this.redondearADos(this.sub_total - (this.sub_total * (this.getDescuentoActual()/100)))
	        },*/
	        agregarDatosATabla(ind, pieza, tratamiento, monto){	 //Puede ser mejor       	
		    	this.tratamientos_tabla.push({id: ind, pieza, tratamiento, deductible: 0, monto, total: monto})
		    	//this.calcularTotalesMonto(monto)		    	
	        },
	        redondearADos(total){
	        	return parseFloat(Math.round(total * 100) / 100).toFixed(2)
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
	        	var monto = 0    	
	        	for( var i = 0; i < this.tratamientos.length; i++ ){
	                if( this.tratamientos[i].opcion == this.opcion ){
	                    var pz = this.tratamientos[i].pieza
	                    var sec = this.tratamientos[i].seccion
	                    var ind_sec_tabla
	                    //Puede ser Mejor
	                    if( this.tratamientos[i].secUno == null && this.tratamientos[i].secDos == null ){
	                    	ind_sec_tabla = this.getIndiceTratamientoPorSeccion(sec)
	                    	monto += parseFloat(this.precios[ind_sec_tabla].monto)
	                        this.agregarDatosATabla(i, pz, this.precios[ind_sec_tabla].detalle, this.precios[ind_sec_tabla].monto);	                        
	                    }else if( this.tratamientos[i].secUno != null && this.tratamientos[i].secDos == null ){
	                        sec = 29;
	                        ind_sec_tabla = this.getIndiceTratamientoPorSeccion(sec)
	                        monto += parseFloat(this.precios[ind_sec_tabla].monto)
	                        this.agregarDatosATabla(i, pz, this.precios[ind_sec_tabla].detalle, this.precios[ind_sec_tabla].monto);
	                    }else if( this.tratamientos[i].secUno != null && this.tratamientos[i].secDos != null ){
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
	        getIndiceTratamientoPorSeccion(sec){
	        	for( var i = 0; i < this.precios.length; i++ ){
	        		if( this.precios[i].id == sec ){
	        			return i
	        		}
	        	}
	        },
	        abrirModalDesdePieza(idPieza){
	        	this.actual_pieza = idPieza
			    this.fromBtn = false
			    this.$refs.tratamientosModalRef.show()
	        },
	        abrirModalDesdeBtn(){
	        	this.actual_pieza = null
			    this.fromBtn = true
			    this.$refs.tratamientosModalRef.show()
	        },
	        middlewareTratamientoResina(seccion, pieza){
	        	this.actual_pieza = null
	        	this.fromBtn = false
	        	this.agregarTratamiento(seccion, pieza)
	        },
	        middlewareTratamientoResinaFromModal(seccion, pieza){		        	
	        	if( this.actual_pieza == null && !this.fromBtn ) return 0

	        	if( this.fromBtn ){
					this.agregarTratamiento(seccion, null)
					this.fromBtn = false
				}else{
					this.agregarTratamiento(seccion, this.actual_pieza)
					this.pintarOtroTratamiento(seccion, this.actual_pieza)
					this.actual_pieza = null
				}
				this.closeModal()
	        },
	        agregarTratamiento(seccion, pieza){	        	
	        	var addPieza = true
	        	if( pieza != null ){
					if( !this.existeTratamiento(seccion, pieza) ){
					   if( this.esResina(seccion) ){
					   		var ind = this.existeResina(pieza)
							if( ind != -1 ){
								if( this.tratamientos[ind].secUno == null && this.tratamientos[ind].secDos == null && this.tratamientos[ind].opcion == this.opcion){
			                        this.tratamientos[ind].secUno = seccion;    addPieza = false
			                        this.mostrarTratamientosEnTabla()
			                    }else if( this.tratamientos[ind].secUno != null && this.tratamientos[ind].secDos == null && this.tratamientos[ind].opcion == this.opcion){
			                        this.tratamientos[ind].secDos = seccion;    addPieza = false
			                        this.mostrarTratamientosEnTabla()
			                    }else if( this.tratamientos[ind].secUno != null && this.tratamientos[ind].secDos != null && this.tratamientos[ind].opcion == this.opcion){
			                        this.$toasted.show('No puede agregar más de tres resinas en una sola pieza.', {
														position: 'top-center', className: 'toast-danger', duration: 3500, containerClass: 'test'
													})
			                        addPieza = false	    
			                    }
							}
					   	}
					}else{
				   		this.$toasted.show('No puede agregar el mismo tratamiento en la misma pieza.', { 
												position: 'top-center', className: 'toast-danger', duration: 3500, containerClass: 'test'
											})
					   addPieza = false
					}
				}
				if( addPieza ){
					this.tratamientos.push({pieza, seccion, secUno: null, secDos: null, opcion: this.opcion})
					this.mostrarTratamientosEnTabla()

				}
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
	        eliminarTratamiento(id){
	            var flag = 0;  
	            if( this.esResina(this.tratamientos[id].seccion) ){ //Eliminar caries
	                if( this.tratamientos[id].secUno != null && this.tratamientos[id].secDos != null ){	
	                	this.despintarSeccionDiente(this.tratamientos[id].secDos, this.tratamientos[id].pieza)
	                    this.tratamientos[id].secDos = null; flag = 1
	                }else if( this.tratamientos[id].secUno != null && this.tratamientos[id].secDos == null ){
	                    this.despintarSeccionDiente(this.tratamientos[id].secUno, this.tratamientos[id].pieza)
	                    this.tratamientos[id].secUno = null; flag = 1
	                }else{
	                    flag = 0
	                }
	            }
	            if( !flag ){
	            	if( this.tratamientos[id].pieza != null ){
	            		this.despintarSeccionDiente(this.tratamientos[id].seccion, this.tratamientos[id].pieza)
	            	}
	                this.tratamientos.splice(id, 1)
	            }	            
	            this.restartMainDientes()
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
	        changeOpcionBoton(opc){
	        	if( opc == 2 ){
	        		this.opc1 = false
	        	}else{
	        		this.opc1 = true
	        	}
	        },
	        restartAllPintadoDientes(){
	        	for( var i = 0; i < this.tratamientos.length; i++ ){
	        		if( this.tratamientos[i].pieza != null ){
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

						if( pieza != null ){
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
	        pintarResinaCompuesta(piezaDiente, auxSeccion){
	            if( auxSeccion != null ){
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
	        }
		}
	}
</script>