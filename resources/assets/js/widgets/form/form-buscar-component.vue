<template>
	<div class="input-group">
		<span class="icon-input">
	    	<i class="fas fa-search" aria-hidden="true"></i>
	    </span>
		<input v-model="message"  @keyup.enter="greet()" placeholder="Buscar..." type="text" class="odInput">
	</div>
</template>

<script>
	export default{
		mounted(){
			console.log('Form Buscar Mounted')
			console.log(this.message)
		},
		data(){
			return{
				message: ''
			}
		},
		methods:{
			greet: function(e){
				this.$toasted.info(this.message)				
			}
		}

	}
</script>