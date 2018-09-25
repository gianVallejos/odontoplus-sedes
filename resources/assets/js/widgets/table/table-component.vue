<template>
  <b-table :items="fields"></b-table>
</template>

<script>


export default {
	props: [
		'fields'
	]
}
</script>