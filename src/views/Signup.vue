<template>
<div class="row">
    <div class="box">
    <div class="col-sm-5 m-auto">
        <div class="text-center mb-4 mt-10">
        <h1 class="title">BLOCK PANDA</h1>
        <br />
        <strong><p>회원가입</p></strong>

        </div>

        <form @submit.prevent="signupRequest" id="signup-form">
        <div class="row text-left">
            <div class="col-sm-12 form-gruop">
            <label for="email">이메일 주소</label>
            <input type="email" v-model="email" id="email" class="form-control form-control-lg" placeholder="Gmail@.com">


            </div>
            <div class="col-sm-12 form-group">
            <label for="password">Password</label>
            <input type="password" v-model="password" id="password" class="form-control form-control-lg" placeholder="Password">


            </div>
            <div class="col-sm-12 text-center form-group">
            <button v-bind:disabled="xhrRequest" v-bind:class="{disabled: xhrRequest}" class="btn btn-lg btn-primary px-4">
                <span v-if="! xhrRequest">회원 가입</span>
                <span v-if="xhrRequest">Please Wait....</span>
            </button>
            <div v-if="xhrRequest" class="spinner-border text-secondary loader" role="status">
                <span class="sr-only">Loading...</span>
            </div>
            </div>
            <div class="col-sm-12 text-center form-group mt-5">
            <p>가입이 완료 되었나요?<router-link to="/Login">로그인 페이지로 이동</router-link></p>

            </div>

        </div>
        </form>

    </div>

    </div>
</div>

</template>

<script>
import firebase from 'firebase'
export default {
    data() {
        return {
            email: '',
            password: '',
            xhrRequest: false,
            errorMessage: "",
            successMessage: ""
        }
    },

    methods: {
        signupRequest() {
            firebase.auth().createUserWithEmailAndPassword(this.email, this.password).then(
                () => {
                    alert("회원가입 완료");
                    this.$router.push('/Login');

                })
                .catch(
                    (error) => {
                        alert(`에러 - ${error.message}`);
                    
                })
                

        }
    }
}
</script>

<style lang="scss" scoped>
.title {
text-align: center;
color: lightseagreen;
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