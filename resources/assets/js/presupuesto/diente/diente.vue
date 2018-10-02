<template>
		
		<div class="diente" ref="referencia">			
			<div :id="pieza+'-6'" class="ionomero" v-on:click="accionDiente(6)" v-bind:class="{ active: isIonomero }"></div>	
			<div :id="pieza+'-2'" class="diente-section top" v-on:click="accionDiente(2)" v-bind:class="{ active: isTop }"></div>
			<div :id="pieza+'-3'" class="diente-section right" v-on:click="accionDiente(3)" v-bind:class="{ active: isRight }"></div>
			<div :id="pieza+'-5'" class="diente-section bottom" v-on:click="accionDiente(5)" v-bind:class="{ active: isBottom }"></div>
			<div :id="pieza+'-4'" class="diente-section left" v-on:click="accionDiente(4)" v-bind:class="{ active: isLeft }"></div>		
			<div :id="pieza+'-1'" class="middle" v-on:click="accionDiente(1)" v-bind:class="{ active: isMiddle }"></div>		
		</div>
	
</template>
<script>
	import PresupuestoNuevo from '../nuevo.vue'
	export default{		
		components: {
			PresupuestoNuevo
		},
		props: [
			'pieza'
		],
		data() {
			return {
				isTop: false,
				isLeft: false,
				isBottom: false,
				isRight: false,
				isMiddle: false,
				isIonomero: false,
				trat_string: ['', 'center', 'top', 'right', 'left', 'bottom', 'ionomero']
			}
		},
		methods: {
			accionDiente(seccion){
				//Validación multi tratamiento
				this.pintarDienteSeleccionado(seccion)
				this.$emit('click', this.pieza, seccion)
			},
			pintarDienteSeleccionado(seccion){				
				if( this.trat_string[seccion] == 'center' )
					this.isMiddle = !this.isMiddle
				
				if( this.trat_string[seccion] == 'top' )
					this.isTop = !this.isTop

				if( this.trat_string[seccion] == 'right' )
					this.isRight = !this.isRight

				if( this.trat_string[seccion] == 'left' )
					this.isLeft = !this.isLeft

				if( this.trat_string[seccion] == 'bottom' )
					this.isBottom = !this.isBottom

				if( this.trat_string[seccion] == 'ionomero' )
					this.isIonomero = !this.isIonomero
			}
		}
	}
</script>