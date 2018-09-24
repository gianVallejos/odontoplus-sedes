<template>
	<input v-model="message" placeholder="greet()" type="text" class="odInput">
</template>

<script>
	export default{
		mounted(){
			console.log('Form Buscar Mounted')
			console.log(this.message)
		},
		data:{			
			message: ''			
		},
		methods:{
			greet: function() {
				return 'Hi'
			}
		}

	}
</script>