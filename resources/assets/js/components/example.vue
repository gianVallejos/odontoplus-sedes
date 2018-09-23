<template>
	<div>
		User: {{ currentUser }}
	</div>
</template>
<script>
	export default{
		props: ['currentUser'],
	    mounted () {
	        // Do something useful with the data in the template
	        console.dir(this.currentUser)
	    }
	}
</script>