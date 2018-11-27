<template lang="pug">
  .spinnerLayout
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
      spinnerActive: true
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
  .spinnerLayout
    height: 100%
    width: 100%
    position: relative
    text-align: center

  #spinner
    /* position: fixed */
    position: absolute
    top: 50%
    left: 50%
    transform: translate(-50%,-50%)
    z-index: 999
    display: none
    &.active
      display: inline-block
</style>
