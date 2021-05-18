const signupForm = document.getElementById("signup-form");

signupForm.addEventListener('submit', e => {
    e.preventDefault();
    const email = signupForm["sign-email"].value;
    const password = signupForm["sign-password"].value;
    //console.log(email, password);
    signupForm.reset();
    auth.createUserWithEmailAndPassword(email, password).then((cred) => {
        return db.collection('users').doc(cred.user.uid).set({
            Email: emali,
            Password: password
        }).then(() => {
            location = "login.html";
        }).catch(err => {
            alert(err.message);
        })
    }).catch(err => {
        alert(err.message);
    })
})