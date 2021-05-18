const loginForm = document.getElementById("loginForm");
loginForm.addEventListener('submit', e => {
    e.preventDefault();
    const email = loginForm["email"].value;
    const password = loginForm["password"].value;
    //console.log(email, password);
    auth.signInWithEmailAndPassword(email, password).then(() => {
        console.log("passed");
        location="main.html"
    }).catch(err => {
        alert(err);
        
    })
})