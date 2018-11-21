<template>
	<div class="dashbox" :class="color" v-on:click="say" v-if="for_admin == false || user.rolid == 1" >
		<b-container>
			<b-row>
				<b-col cols="3" class="icono pr-0 pl-0">
					<i :class="iconUrl"></i>
				</b-col>
				<b-col cols="9" class="text-left pl-2 pr-0">
					<div class="subtitle-dashbox">{{ subname }}</div>
					<div class="title-dashbox">
						{{ name }}
					</div>
				</b-col>
			</b-row>
		</b-container>
	</div>
</template>

<script>
	export default{
		mounted(){
			console.log('Dashbox Mounted')
		},
		props: [
			'iconUrl',
			'subname',
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
<style lang="stylus">
	.dashbox
		padding: 1.35em 1.1em
		color: #fff

	.subtitle-dashbox
		font-family: 'Open Sans', sans-serif
		font-size: .9em

	.title-dashbox
		font-size: 20px
		font-family: 'Open Sans', sans-serif

	.icono
		line-height: 50px
		vertical-align: middle

</style>
