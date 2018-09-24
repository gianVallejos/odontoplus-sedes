<template>
	<input v-model="message"  @keyup.enter="greet()" placeholder="Buscar..." type="text" class="odInput">
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
				alert('hello world')				
			}
		}

	}
</script>