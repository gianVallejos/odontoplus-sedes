<template>
	<div class="dashbox-med" :class="color" v-on:click="say" v-if="for_admin == false || user.rolid == 1" >
		<b-container>
			<b-row>
				<b-col cols="3" class="icono pr-0 pl-0">
					<i :class="iconUrl"></i>
				</b-col>
				<b-col cols="9" class="text-left pl-4 pr-0 pt-1">
					<div class="title-dashbox-med">
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

	.dashbox-med{
    color: #f3f3f3;
    margin: 0.3em;
    text-align: center;
    font-family: 'Rubik', sans-serif;
    cursor: pointer;
    margin-bottom: 25px;
  }
  .dashbox-med:hover{
    opacity: .9;
  }
  .dashbox-med.info{
    background: #305f94;
  }
  .dashbox-med.guardar{
    background: #0aab8a;
  }
  .dashbox-med.nuevo{
    background: #464d5c;
  }
  .dashbox-med.modificar{
    background: #858ea7;
  }

	.subtitle-dashbox-med
		font-family: 'Open Sans', sans-serif
		font-size: .9em

	.title-dashbox-med{
		font-size: .9em
		font-family: 'Open Sans', sans-serif
    line-height: 50px
	  vertical-align: middle
    text-transform: uppercase
  }

	.dashbox-med .icono{
	  line-height: 50px
	  vertical-align: middle
    border-right: 1px solid #f3f3f3
  }

</style>
