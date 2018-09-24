<template>
	<a :href="url" class="odBtn" :class="tipo">{{ name }}</a>
</template>

<script>
	export default{
		mounted(){
			console.log('Button '+ this.name +' Mounted')
		},
		props: [
			'url',
			'name', 
			'tipo',
		]
	}
</script>