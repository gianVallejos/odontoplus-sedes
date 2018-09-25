<template>
	<div class="row">
		<div class="col-md-8 pt-3">
			<h4>{{ titulo }}</h4>
		</div>
		<div class="col-md-4">
			<b-breadcrumb :items="items"/>
		</div>
	</div>
</template>

<script>
	export default{
		props: [
			'titulo',
			'items'
		]
	}
</script>