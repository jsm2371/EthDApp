import Vue from 'vue'
import App from './App.vue'
import router from './router'
import firebase from 'firebase'
Vue.config.productionTip = false

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')


var firebaseConfig = {
    apiKey: "AIzaSyD22rPQawnxmPFTTKPzJny7iqEJMIivMiw",
    authDomain: "vue-login-9e11a.firebaseapp.com",
    projectId: "vue-login-9e11a",
    storageBucket: "vue-login-9e11a.appspot.com",
    messagingSenderId: "961207986313",
    appId: "1:961207986313:web:53ef6d595745bf92003e58"
  };
  // Initialize Firebase
  firebase.initializeApp(firebaseConfig);