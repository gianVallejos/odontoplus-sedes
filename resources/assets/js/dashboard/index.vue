<template>
	<b-container>
		<b-row>
			<b-col cols="12">
				<TitleComponent titulo="Dashboard" :items="breadcrumb" />
			</b-col>
			<b-col cols="12" class="pt-3">
				Content
			</b-col>
		</b-row>
	</b-container>
</template>

<script>
	import TitleComponent from '../widgets/titulo/index.vue'

	export default{
		mounted(){
			console.log('Dashboard Mounted')
		},
		components:{
			TitleComponent
		},
		data(){
			return{
				breadcrumb: [
			    	{ text: 'Dashboard', href: '/' }
			    ]
			}
		}
	}
</script>