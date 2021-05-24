<?php
require_once 'dbconfig.php';
session_start();
$conn = mysqli_connect($dbconfig["host"], $dbconfig["user"], $dbconfig["password"], $dbconfig["name"]) or die(mysqli_error($conn));

if (empty($_SESSION["username"])) {
    echo json_encode("Eseguire l'accesso per visualizzare il contenuto");
    return;
}


?>