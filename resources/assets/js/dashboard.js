import Vue from 'vue'
import BootstrapVue from "bootstrap-vue"
import Toasted from 'vue-toasted'

Vue.use(BootstrapVue)
Vue.use(Toasted, {position: 'bottom-right', theme: 'primary', duration: 1000})

Vue.component('container-general', require('./container-general/index.vue'));

const app = new Vue({
    el: '#app'
});
