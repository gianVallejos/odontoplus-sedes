<template>
		
		<div class="diente">			
			<div :id="pieza+'-6'" class="ionomero" v-on:click="accionDiente(6)" v-bind:class="[ { active: isIonomero }, { noEditable: !isEditable } ]"></div>	
			<div :id="pieza+'-2'" class="diente-section top" v-on:click="accionDiente(2)" v-bind:class="[ { active: isTop }, { noEditable: !isEditable } ]"></div>
			<div :id="pieza+'-3'" class="diente-section right" v-on:click="accionDiente(3)" v-bind:class="[ { active: isRight }, { noEditable: !isEditable } ]"></div>
			<div :id="pieza+'-5'" class="diente-section bottom" v-on:click="accionDiente(5)" v-bind:class="[ { active: isBottom }, { noEditable: !isEditable } ]"></div>
			<div :id="pieza+'-4'" class="diente-section left" v-on:click="accionDiente(4)" v-bind:class="[ { active: isLeft }, { noEditable: !isEditable } ]"></div>		
			<div :id="pieza+'-7'" class="middle" v-on:click="accionDiente(7)" v-bind:class="[ {active: isMiddle}, {corona: isCorona}, { noEditable: !isEditable }, extra_trat ]"></div>		
		</div>
	
</template>
<script>
	import PresupuestoNuevo from '../nuevo.vue'
	export default{		
		components: {
			PresupuestoNuevo
		},
		props: [
			'pieza',
			'isEditable'
		],
		data() {
			return {
				isTop: false,
				isLeft: false,
				isBottom: false,
				isRight: false,
				isMiddle: false,
				isIonomero: false,
				isCorona: false,
				trat_string: ['', 'center', 'top', 'right', 'left', 'bottom', 'ionomero'],
				nro_resinas: 0,
				extra_trat: ''		
			}
		},
		methods: {
			accionDiente(seccion){
				if( this.isEditable ){
					this.pintarDienteSeleccionado(seccion)
					this.$emit('click', seccion, this.pieza)
				}
			},
			pintarDienteSeleccionado(seccion){												
				if( seccion == '7' && !this.esCuartaResina() )
					this.isMiddle = true//!this.isMiddle
				
				if( this.trat_string[seccion] == 'top' && !this.esCuartaResina() )
					this.isTop = true//!this.isTop

				if( this.trat_string[seccion] == 'right' && !this.esCuartaResina() )
					this.isRight = true//!this.isRight

				if( this.trat_string[seccion] == 'left' && !this.esCuartaResina() )
					this.isLeft = true//!this.isLeft

				if( this.trat_string[seccion] == 'bottom' && !this.esCuartaResina() )
					this.isBottom = true//!this.isBottom

				if( this.trat_string[seccion] == 'ionomero' && !this.esCuartaResina() )
					this.isIonomero = true//!this.isIonomero

				if( seccion >= 8 && seccion <= 11 ){
					this.isCorona = true
				}
			},
			esCuartaResina(){
				this.nro_resinas = 0
				if( this.isMiddle ) {
					this.nro_resinas++
				}
				if( this.isTop ){
					this.nro_resinas++
				}
				if( this.isRight ){
					this.nro_resinas++
				}
				if( this.isLeft ){
					this.nro_resinas++
				}
				if( this.isBottom ){
					this.nro_resinas++
				}
				return this.nro_resinas >= 3
			}
		}
	}
</script>
