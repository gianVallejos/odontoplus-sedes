<template>
	<div id="flash-message">
    <div :class="'alert alert-flash toast-' + JSalert.type">
      <div class="container">
        {{JSalert.msg}}
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
      </div>
    </div>
  </div>
</template>

<script>

  export default{
    mounted() {
      console.log(this.alert)
      setTimeout(function () {
        $("#flash-message").remove();
			}.bind(this), 6000)

    },
    name: 'flash-alert',
    props:[
      'alert'
    ],
    data(){
      return{
        JSalert: JSON.parse(this.alert)
      }
    }
  }

</script>