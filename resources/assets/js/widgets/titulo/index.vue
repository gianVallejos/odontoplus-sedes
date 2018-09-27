<template>

	<b-row align-h="between">
		<b-col align-self="start">
			<h4>{{ titulo }}</h4>
	  </b-col>
		<b-col cols="auto">
			<b-breadcrumb :items="items"/>
		</b-col>
	</b-row>

</template>

<script>
	export default{
		props: [
			'titulo',
			'items'
		]
	}
</script>