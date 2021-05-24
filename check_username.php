<?php
require_once 'dbconfig.php';

$conn = mysqli_connect($dbconfig["host"], $dbconfig["user"], $dbconfig["password"], $dbconfig["name"]) or die(mysqli_error($conn));
if (!empty($_GET["firstName"]) && !empty($_GET["lastName"]) && !empty($_GET["department"])) {
    if((!preg_match("/^[A-Za-z]+$/", $_GET["firstName"])) || (!preg_match("/^[A-Za-z]+$/", $_GET["lastName"]))) {
        echo json_encode("Nome o cognome non valido");
        exit;
    }
} else {
    echo json_encode("Errore compilazione");
    exit;
}

$department = $_GET['department'];
$first_name = mysqli_real_escape_string($conn, $_GET['firstName']);
$last_name = mysqli_real_escape_string($conn, $_GET['lastName']);
$username = substr(strtolower($first_name), 0, 4).$department.substr(strtolower($last_name), 0, 4);
$query_username = "SELECT username FROM impiegato WHERE username = '$username'";
$query_username_res = mysqli_query($conn, $query_username);
        
if (mysqli_num_rows($query_username_res) > 0) {
    echo json_encode("Utente già registrato");
    exit;
}

echo json_encode($username);
mysqli_free_result($query_username_res);
mysqli_close($conn);

?>

