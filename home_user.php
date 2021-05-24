<?php
require_once 'dbconfig.php';
session_start();

$conn = mysqli_connect($dbconfig["host"], $dbconfig["user"], $dbconfig["password"], $dbconfig["name"]) or die(mysqli_error($conn));

//se si ha la sessione prendiamo semplicemente l'username, se non c'è prendiamo i dati post inviati dal form di login
if (!empty($_SESSION["username"])) {
    $username = $_SESSION["username"];
} else if (!empty($_POST["username"]) && !empty($_POST["password"])) {
    $username = mysqli_real_escape_string($conn, $_POST["username"]);
    $password = mysqli_real_escape_string($conn, $_POST["password"]);
    } else {
        $error = "Errore nella compilazione dei dati";
        header("Location: ".$_POST["send"].".php");
    }

//selezioniamo sia in uno sia nell'altro caso tutte le info user
//se va in porto la query associamo il risultato 
//se non c'è sessione significa che il risultato ci serve per il primo login tramite dati post, allora validiamo la password e reindirizziamo
//se c'è sessione andiamo direttamente al passaggio del json

$query_info = "SELECT r.nome as direzione, i.nome, i.cognome, i.livello, i.username, i.password
                FROM reparto r join impiegato i on r.id = i.direzione WHERE i.username = '$username'";
$query_info_res = mysqli_query($conn, $query_info);
    if (($query_info_res or die(mysqli_error($conn))) && mysqli_num_rows($query_info_res) > 0) {
        $info_user = mysqli_fetch_assoc($query_info_res);
        if (empty($_SESSION["username"])) {
            if (password_verify($password, $info_user["password"])) {
                session_start();
                $_SESSION["username"] = $info_user["username"];
                $_SESSION["name"] = $info_user["nome"];
                header("Location: ".$_POST["send"].".php");
                mysqli_free_result($query_login_res);
                mysqli_close($conn);
                exit;
            } else {
                $error = "Password errata";
            }
        } 
    } else {
        $error = "Utente non trovato";
    }

//se abbiamo errori memorizzati siamo al passaggio del json perchè non è andata bene la query o la validazione password
//se non abbiamo errori memorizzati siamo al passaggio del json perchè c'era sessione e quindi abbiamo le info utente da passare
if (empty($error))
    {
        $data = $info_user;
        mysqli_free_result($query_info_res);
        mysqli_close($conn);
    } else {
        $data = $error;
    }

echo json_encode($data);
?>