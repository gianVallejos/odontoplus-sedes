<template lang="pug">
  #spinner( v-bind:class="{ active: spinnerActive }" )
    img(:src="url + '/images/spinner.gif'", width="75", alt="Cargando...")
</template>

<script>

export default {  
  props: [
    'url'
  ],
  data(){
    return {
      spinnerActive: false
    }
  },
  methods:{
    showSpinner(){
      this.spinnerActive = true
    },
    hideSpinner(){
      this.spinnerActive = false
    }    
  }
}
</script>

<style lang="stylus">

  #spinner
    position: fixed
    top: 50%
    left: 50%
    transform: translate(-50%,-50%)    
    z-index: 999
    display: none
    &.active
      display: inline-block
</style>
