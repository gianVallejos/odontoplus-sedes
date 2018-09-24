<template>
	<div class="dashbox" :class="color" v:on-click="say('hi')" >
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
			'url'
		],
		methods: {
			say: function (message) {
		      alert(message)
		    }
		}
	}
</script>