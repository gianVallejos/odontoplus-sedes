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
										<span>Fecha:</span><div class="d-inline-block texto">01/10/2018</div>
									</b-col>
									<b-col cols="6 pb-2">
										<span>Nro Historia:</span><div class="d-inline-block texto">000035</div>
									</b-col>
									<b-col cols="6 pb-2">
										<span>Empresa:</span><div class="d-inline-block texto">CORE</div>
									</b-col>
									<b-col cols="6 pb-2">
										<span>Sede:</span><div class="d-inline-block texto">Cajamarca</div>
									</b-col>
									<b-col cols="6 pb-2">
										<span>Doctor:</span><div class="d-inline-block texto">Nombre del Doctor</div>
									</b-col>
									<b-col cols="6 pb-2">
										<span>Paciente:</span><div class="d-inline-block texto">Nombre de Paciente</div>
									</b-col>							
							</b-row>
						</div>
						<b-row class="pb-3">
							<b-col cols="6" class="pr-0 pl-0 pt-4">
								<b-button variant="primary" class="opcion-btn active">Odontograma #1</b-button>
							</b-col>
							<b-col cols="6" class="pl-0 pr-0 pt-4">
								<b-button variant="warning" class="opcion-btn">Odontograma #2</b-button>
							</b-col>
						</b-row>
						<b-row>
							<b-col cols="12" class="text-center pt-4 pb-4">
								<b-button type="submit" variant="success" v-on:click="onSubmitSave">
									<i class="fas fa-save"></i>&nbsp; Guardar
								</b-button>								
								<b-button  variant="danger" v-on:click="onEliminar">
									<i class="fas fa-trash-alt"></i>&nbsp;Eliminar
								</b-button>
								<b-button variant="warning" v-on:click="onLimpiar">
									<i class="fas fa-eraser"></i>&nbsp; Limpiar
								</b-button>
							</b-col>
						</b-row>
						<b-row class="pt-4 pb-4">
							<b-col cols="6" class="text-right pl-0 od-right-border">												
								<div class="d-inline-block text-center" v-for="i in range(18, 11)" >
									<span class="od-modal" v-on:click="openModal(i)">{{ i }}</span>
									<Diente @click="agregarTratamiento" :pieza=i />
								</div>				
							</b-col>
							<b-col cols="6" class="text-left pr-0">
								<div class="d-inline-block text-center" v-for="i in range(21, 28)" >
									<span class="od-modal" v-on:click="openModal(i)">{{ i }}</span> 
									<Diente @click="agregarTratamiento" :pieza=i />
								</div>				
							</b-col>
							<b-col cols="6" class="text-right pl-0 od-right-border">												
								<div class="d-inline-block text-center" v-for="i in range(55, 51)" >									
									<Diente @click="agregarTratamiento" :pieza=i />
									<span class="od-modal" v-on:click="openModal(i)">{{ i }}</span> 
								</div>				
							</b-col>
							<b-col cols="6" class="text-left pr-0">
								<div class="d-inline-block text-center" v-for="i in range(61, 65)" >									
									<Diente @click="agregarTratamiento" :pieza=i />
									<span class="od-modal" v-on:click="openModal(i)">{{ i }}</span> 
								</div>				
							</b-col>
							<b-col cols="12">
								<hr>	
							</b-col>							
							<b-col cols="6" class="text-right pl-0 od-right-border">												
								<div class="d-inline-block text-center" v-for="i in range(85, 81)" >
									<span class="od-modal" v-on:click="openModal(i)">{{ i }}</span>
									<Diente @click="agregarTratamiento" :pieza=i />
								</div>				
							</b-col>
							<b-col cols="6" class="text-left pr-0">
								<div class="d-inline-block text-center" v-for="i in range(71, 75)" >
									<span class="od-modal" v-on:click="openModal(i)">{{ i }}</span>
									<Diente @click="agregarTratamiento" :pieza=i />
								</div>				
							</b-col>
							<b-col cols="6" class="text-right pl-0 od-right-border">												
								<div class="d-inline-block text-center" v-for="i in range(48, 41)" >									
									<Diente @click="agregarTratamiento" :pieza=i />
									<span class="od-modal" v-on:click="openModal(i)">{{ i }}</span>
								</div>				
							</b-col>
							<b-col cols="6" class="text-left pr-0">
								<div class="d-inline-block text-center" v-for="i in range(31, 38)" >									
									<Diente @click="agregarTratamiento" :pieza=i />
									<span class="od-modal" v-on:click="openModal(i)">{{ i }}</span>
								</div>				
							</b-col>
						</b-row>						
						<b-row class="pt-4">
							<b-col cols="6" class="text-left">
								<b-button v-on:click=test >Agregar Tratamiento Extra</b-button>
							</b-col>
							<b-col cols="6" class="text-right">		
								<div class="subtotal-layout">
									<div class="sub d-inline-block">Subtotal (S/): </div><span>00000.00</span>
								</div>						
							</b-col>
						</b-row>
						<b-row class="pt-4">
							<b-col cols="12">
								<b-table show-empty :items=tratamientos :fields="fields">
									<template slot="pieza" slot-scope="row">								    	
								    	{{ row.value }}
								    </template>
								    <template slot="seccion" slot-scope="row">								    	
								    	{{ row.value }}
								    </template>
								    <template slot="secUno" slot-scope="row">								    	
								    	{{ row.value }}
								    </template>
								    <template slot="secDos" slot-scope="row">								    	
								    	{{ row.value }}
								    </template>
								    <template slot="opcion" slot-scope="row">								    	
								    	{{ row.value }}
								    </template>
								</b-table>
							</b-col>
						</b-row>

					</div>
				</PanelCard>				
			</b-col>
		</b-row>		
		<b-modal ref="tratamientosModalRef" id="modal1" title="Bootstrap-Vue">
    		<p class="my-4">Hello from modal!</p>
  		</b-modal>
	</b-container>
</template>
<script>
	import TitleComponent from '../widgets/titulo/index.vue'
	import PanelCard from '../widgets/panel/panel-component.vue'
	import Diente from './diente/diente.vue'

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
			'nro'
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
			    fields: [				    				    				    
				    { key: 'pieza', label: 'Pieza'},
				    { key: 'seccion', label: 'Sección'},
				    { key: 'secUno', label: 'Sec Uno'},
				    { key: 'secDos', label: 'Sec Dos' },
				    { key: 'opcion', label: 'Opcion'}
			    ],
			    modalTratamientos: false
			}
		},
		methods: {
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
			openModal(i){				
				this.$refs.tratamientosModalRef.show()
			},
			onSubmitSave(){

			},
			onEliminar(){

			},
			onLimpiar(){

			},
			agregarTratamiento(idPieza, seccion){	
				this.pieza_actual = idPieza
				this.tratamiento_actual = seccion
				this.tratamientos.push({pieza: idPieza, seccion: seccion, secUno: null, secDos: null, opcion: this.opcion})
				//console.log(this.tratamientos.length)				
			},
			esResina(value){
	            if( value <= 5 ) return true;
	            if( value == 7 ) return true;
	            return false;
	        },
	        test(){
	        	console.log(this.existeResina(12))
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
	               // alert( tratamientos[i][0] + '-' + pieza + ', ' + tratamientos[i][1] + '-' + seccion + ', ' + tratamientos[i][4] + '-' + opc_actual )
	                if( this.tratamientos[i].pieza == pieza && this.tratamientos[i].seccion == seccion && this.tratamientos[i].opcion == this.opcion ) return true;
	            }
	            return false;
	        },
	        agregarPiezaSeccionATratamientos(seccion, pieza){	            
	            if( !this.existeTratamiento(seccion, pieza) ){
	                var ind = this.existeResina(pieza);
	                var flag = 0;
	                if( ind != -1 && this.esResina(seccion) ){
	                    if( tratamientos[ind].seccion == undefined && tratamientos[ind].secUno == undefined && tratamientos[ind].opcion == this.opcion){
	                        tratamientos[ind].seccion = seccion;    flag = 1;
	                    }else if( tratamientos[ind].seccion != undefined && tratamientos[ind].secUno == undefined && tratamientos[ind].opcion == this.opcion){
	                        tratamientos[ind].secDos = seccion;    flag = 1;
	                    }else if( tratamientos[ind].seccion != undefined && tratamientos[ind].seccion != undefined && tratamientos[ind].opcion == this.opcion){
	                        alert('Advertencia', 'Sólo se admiten tres resinas por pieza');   flag = 1;
	                    }else{
	                        flag = 0;
	                    }
	                }
	            }
	        }

		}
	}
</script>