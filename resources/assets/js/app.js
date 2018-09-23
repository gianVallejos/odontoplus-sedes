//require('./bootstrap');

window.Vue = require('vue');

Vue.component('header-component', require('./components/headerComponent.vue'));
Vue.component('nav-component', require('./components/navComponent.vue'));
Vue.component('footer-component', require('./components/footerComponent.vue'));

const app = new Vue({
    el: '#app'
});
