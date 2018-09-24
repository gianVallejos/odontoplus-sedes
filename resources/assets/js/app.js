//require('./bootstrap');

window.Vue = require('vue');

Vue.component('header-component', require('./header/headerComponent.vue'));
Vue.component('nav-component', require('./header/navComponent.vue'));
Vue.component('footer-component', require('./footer/footerComponent.vue'));

Vue.component('container-general', require('./container-general/index.vue'));

const app = new Vue({
    el: '#app'
});
