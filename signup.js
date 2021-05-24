var login = document.querySelector("#login");
login.addEventListener("click", viewLogin);

var div_user = document.querySelector("#user");

function viewLogin() {
    if (div_user.classList.contains("off")) {
        div_user.classList.remove("off");
        div_user.classList.add("login");
    } else {
        div_user.classList.remove("login");
        div_user.classList.add("off");
    }
    document.addEventListener("click", hiddenLogin);
}

function hiddenLogin(event) {
    if ((div_user !== event.target) && !div_user.contains(event.target) && (login !== event.target) && !login.contains(event.target) ) {
        div_user.classList.remove("login");
        div_user.classList.add("off");
    }
}

const formRegistration = document.forms["registration"];

var data = {};

if (formRegistration) {
    formRegistration.addEventListener("submit", checkForm);
}

function checkForm(event) {
    let newFormRegistration = new FormData(formRegistration);
    i = 0;
    for (let value of newFormRegistration.values()) {
        if (value) {
            i++;
        }
    }
    if (i !== 7) { 
        alert("Compila tutti i campi");
    } else if ((newFormRegistration.get('password').length < 8) || (newFormRegistration.get('password').length > 15)) {
        alert("Lunghezza password non valida");
    } else {
        fetch("http://localhost/HW1/check_username.php?firstName=" + encodeURIComponent(newFormRegistration.get('firstName')) + 
        "&lastName=" + encodeURIComponent(newFormRegistration.get('lastName')) + 
        "&department=" + newFormRegistration.get('department')).then(onResponse).then(checkUsername);
        }
    event.preventDefault();
}


function checkUsername(json) {
    if (json.length !== 9) {
        alert(json);
        return;
    }
    let newFormRegistration = new FormData(formRegistration);
    newFormRegistration.append("username", json);
    fetch('http://localhost/HW1/signup_validation.php', {
        method: 'POST',
        body: newFormRegistration
    }).then(onResponse).then(confirmRegistration);
}


function confirmRegistration(json) {
    if (typeof json == "string") {
        alert(json);
        return;
    } else {
        let buttons = document.querySelector("#confirmButtons");
        let buttonsDiv = document.querySelector("div");
        buttonsDiv.classList.remove("off");
        buttonsDiv.classList.add("alert");
        buttons.addEventListener("click", redirectHome);
    }
}

function redirectHome() {
    let buttonsDiv = document.querySelector("div");
    buttonsDiv.classList.remove("alert");
    buttonsDiv.classList.add("off");
    location.href = "home.php";
}

function onResponse(response) {
    return response.json();
}