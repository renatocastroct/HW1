<?php
require_once 'dbconfig.php';

$conn = mysqli_connect($dbconfig["host"], $dbconfig["user"], $dbconfig["password"], $dbconfig["name"]) or die(mysqli_error($conn));


if (isset($_POST["username"])) {

    if(!preg_match("/^[a-zA-Z0-9_]{8,15}$/", $_POST["password"])) {
        echo json_encode("Password non valida");
        exit;
    } 

    if (strcmp($_POST["password"], $_POST["passwordConfirm"]) != 0) {
        echo json_encode("Le password non coincidono");
        exit;
    }

    $password = mysqli_real_escape_string($conn, $_POST["password"]);
    $password = password_hash($password, PASSWORD_BCRYPT);

    $query_insert = sprintf("INSERT INTO impiegato(nome, cognome, livello, direzione, username, password, gender) 
                    VALUES('%s', '%s', '4', '%d', '%s', '%s', '%s')",
                    $_POST["firstName"],
                    $_POST["lastName"],
                    $_POST["department"],
                    $_POST["username"],
                    $password,
                    $_POST["gender"],
                );        
    if (mysqli_query($conn, $query_insert) or die(mysqli_error($conn))) {
        session_start();
        $_SESSION["username"] = $_POST["username"];
        $_SESSION["name"] = $_POST["firstName"];
        echo json_encode(array("Registrazione effettuata"));
        mysqli_close($conn);
        exit;
    }

} else {
    echo json_encode("Errore compilazione");
}

?>