<template>
	<div class="dashbox" :class="color" v-on:click="say" v-if="for_admin == false || user.rolid == 1" >
		<div>
			<div class="icono">
				<i :class="iconUrl"></i>
			</div>
			<div class="message pt-2">
				{{ name }}
			</div>
		</div>
	</div>
</template>

<script>
	export default{
		mounted(){
			console.log('Dashbox Mounted')
		},
		props: [
			'iconUrl',
			'name',
			'color',
			'url',
			'user',
			'for_admin'
		],
		methods: {
			say: function () {
		      window.location = this.url
		    }
		}
	}
</script>