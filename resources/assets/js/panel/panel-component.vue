<template>
	<div class="card">
		<div class="card-heading">
			<slot name="heading"></slot>
		</div>
		<div class="card-body">
			<slot name="body"></slot>
		</div>
		<div class="card-footer">
			<slot name="footer"></slot>
		</div>
	</div>
</template>

<script>
	export default{
		mounted(){
			console.log('Card Mounted')
		}
	}
</script>