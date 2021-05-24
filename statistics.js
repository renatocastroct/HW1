const mh_quotes = {
    exchange: 'XNAS',
    open: '57.2',
    close: '69.1'
}
const quotes_key = '8a1927d9f8acb0935b759d98c21627ea';
const quotes_request = 'http://api.marketstack.com/v1/tickers?access_key=' + quotes_key + '&exchange=' + mh_quotes.exchange + '&limit=10';
var day_close_request = 'http://api.marketstack.com/v1/eod/latest?access_key=' + quotes_key + '&limit=10&symbols=';


var menu = document.querySelector("#menu div");
menu.addEventListener("click", windowTitle);

function windowTitle(event) {
    var menuSelected = document.querySelector(".menu_selected");
    if (menuSelected) {
        menuSelected.classList.remove("menu_selected");
    }

    event.target.classList.add("menu_selected");
    var table = document.querySelector("table");
    if (table) {
        table.classList.add("off");
    }
    var new_title = document.createElement("h1");
    new_title.textContent = event.target.textContent;
    var manage_div = document.querySelector("#title_window");
    if (manage_div) {
        manage_div.innerHTML = "";
    }
    manage_div.appendChild(new_title);
    windowMenu(new_title.textContent);
}

function windowMenu(title) {
    switch(title) {
        case "Stock Comparison":
            fetch(quotes_request).then(onResponse).then(onCompany);
            break;
        case "Stock Market":
            workInProgress();
            break;
        case "Market Share":
            workInProgress();
            break;
        case "Historical":
            workInProgress();
            break;
      }
}

function workInProgress() { 
    let notice = document.querySelector(".work");
    var manage = document.querySelector(".manage");
    if (!notice) {
        let notice = document.createElement("h3");
        notice.classList.add("work");
        notice.textContent = "Stiamo lavorando per voi";
        manage.appendChild(notice);
    } else {
        notice.classList.remove("off");
        notice.classList.add("work");
        }
    
    let image = document.querySelector(".manage img");
    if (!image) {
        let image = document.createElement("img");
        image.src = "workInProgress.jpeg";
        manage.appendChild(image);
    } else {
        image.classList.remove("off");
        }
}

var company_list = [];
function onCompany(json) {
    company_list = json.data;
    for (let company of company_list) {
        day_close_request += company.symbol + ',';
    }
    day_close_request = day_close_request.substring(0,day_close_request.length-1);
    fetch(day_close_request).then(onResponse).then(onQuotes);
}

function onQuotes (json) {
    document.querySelector("table").classList.remove("off");
    console.log(json);
    var company_quotes = json.data;
    var t_body = document.querySelector("tbody");
    var new_row = document.createElement("tr");
    var new_column = document.createElement("td");
    new_column.classList.add("mh_td");
    new_column.textContent = "M&H";
    new_row.appendChild(new_column);
    var new_column = document.createElement("td");
    new_column.classList.add("mh_td");
    new_column.textContent = mh_quotes.open;
    new_row.appendChild(new_column);
    var new_column = document.createElement("td");
    new_column.classList.add("mh_td");
    new_column.textContent = mh_quotes.close;
    new_row.appendChild(new_column);
    t_body.appendChild(new_row);

    for (i = 0; i < company_list.length; i++) {
        n = 0;
        while (n !== -1) {
            if (company_quotes[n].symbol == company_list[i].symbol) {
                var new_row = document.createElement("tr");
                var new_column = document.createElement("td");
                new_column.textContent = company_list[i].name;
                new_row.appendChild(new_column);
                var new_column = document.createElement("td");
                new_column.textContent = company_quotes[n].open;
                new_row.appendChild(new_column);
                var new_column = document.createElement("td");
                new_column.textContent = company_quotes[n].close;
                new_row.appendChild(new_column);
                new_row.appendChild(new_column);
                new_row.appendChild(new_column);
                t_body.appendChild(new_row);
                n = -2;
            }
            n++
        }
    }
    var rows = document.querySelectorAll('tbody tr');
    var i = 0;
    for (let row of rows) {
        if (i %2 == 0) {
            row.classList.add('even');
        }
        i++;
}
}

function onResponse(response) {
    return response.json();
}


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


function onInfoUser(json) {
    var div_user = document.querySelector("#user");
    var new_name = document.createElement("h1");
    new_name.textContent = json["nome"] + " " + json["cognome"];
    var new_username = document.createElement("h4");
    new_username.textContent = "Username: " + json["username"];
    var new_direzione = document.createElement("h4");
    new_direzione.textContent = "Director of: " + json["direzione"];
    var new_livello = document.createElement("h4");
    new_livello.textContent = "Contract level: " + json["livello"];
    var new_logout = document.createElement("a");
    new_logout.textContent = "Logout";
    new_logout.href = "logout.php?send=statistics";
    div_user.appendChild(new_name);
    div_user.appendChild(new_username);
    div_user.appendChild(new_direzione);
    div_user.appendChild(new_livello);
    div_user.appendChild(new_logout);
}

var form_login = document.forms["login"];

if (!form_login) {
    fetch("http://localhost/HW1/home_user.php").then(onResponse).then(onInfoUser)
} else {
    form_login.addEventListener("submit", fetch("http://localhost/HW1/home_user.php").then(onResponse).then(onInfoUser));
}