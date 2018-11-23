<template>
	<b-breadcrumb :items="items"/>
</template>

<script>
	export default{
		props: [
			'titulo',
			'items',
			'icono'
		]
	}
</script>
<style lang="stylus">
	.titulo-content
		padding-top: 8px
		color: #305f94
		i
			font-size: 1.8em
		h4
			padding-left: 10px

</style>
