<template>

  <div :class="'alert-'+JSalert.type">
    <div class="container">
      <b-alert :show="dismissCountDown" dismissible :variant="JSalert.type" 
            @dismissed="dismissCountDown=0" @dismiss-count-down="countDownChanged">
      <p> {{ JSalert.msg }} </p>
      </b-alert>
    </div>
  </div>

</template>

<script>

  export default{
    mounted() {
      if(this.alert != null){
        var alert = JSON.parse(this.alert)
        this.showAlert(alert.type, alert.msg)
      }
    },
    name: 'flash-alert',
    props:[
      'alert'
    ],
    data(){
      return{
        dismissSecs: 5,
        dismissCountDown: 0,
        showDismissibleAlert: false,
        JSalert: {"type": '', "msg" : ''}
      }
    },
    methods: {
      countDownChanged (dismissCountDown) {
        this.dismissCountDown = dismissCountDown
      },
      showAlert (type, msg) {
        this.JSalert.type = type
        this.JSalert.msg = msg
        this.dismissCountDown = this.dismissSecs
      }
    }
  }

</script>