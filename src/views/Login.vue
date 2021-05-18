<template>
<div class="row">
    <div class="box">
    <div class="col-sm-5 m-auto">
    <div class="text-center mb-4 mt-10">
        <h1 class="title">BLOCK PANDA</h1>
        <br/>
        <strong> <p>로그인</p></strong>
        </div>

        <form @submit.prevent="loginRequest" id="login-form">
                <div class="row text-left">
                    <div class="col-sm-12 form-group">
                        <label for="email">이메일 주소</label>
                        <input type="email" v-model="email" id="email" class="form-control form-control-lg" placeholder="Email@.com">
                    </div>
                    <div class="col-sm-12 form-group">
                        <label for="password">Password</label>
                        <input type="password" v-model="password" id="password" class="form-control form-control-lg" placeholder="Password">
                    </div>
                    <div class="col-sm-12 text-center form-group">
                        <button v-bind:disabled="xhrRequest" v-bind:class="{disabled: xhrRequest}" class="btn btn-lg btn-primary px-4">
                            <span v-if="! xhrRequest">Login</span>
                            <span v-if="xhrRequest">Please Wait...</span>
                        </button>
                        <div v-if="xhrRequest" class="spinner-border text-secondary loader" role="status">
                            <span class="sr-only">Loading...</span>
                        </div>
                    </div>
                    <div class="col-sm-12 text-center form-group mt-5">
                        <p>계정이 없나요?<router-link to="/Signup">구글로 회원가입</router-link></p>
                    </div>
                </div>
            </form>

    </div>


    </div>
</div>
</template>

<script>
import firebase from "firebase";
export default {
    name: "Login",
    data() {
        return {
            email: "",
            password: "",
            xhrRequest: false,
            errorMessage: "",
            successMessage: ""
        }
    },
    methods: {
        loginRequest() {
            this.xhrRequest = true;
            this.errorMessage = "";
            this.successMessage ="";

            firebase.auth().signInWithEmailAndPassword(this.email, this.password).then(
                () => {
                    this.$router.replace('Fileupload')
                    this.xhrRequest = false;
                },
                (error) => {
                    this.errorMessage = error.message;
                    this.xhrRequest = false;
                }
            )
        }
    }
}
</script>

<style lang="scss" scoped>
.title {
text-align: center;
color: lightseagreen;;
font-size: xx-large;
font-family: cursive;
}

.box {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.row{
  display: flex;
  justify-content: center;
}
</style>