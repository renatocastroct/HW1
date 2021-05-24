<?php
require_once 'dbconfig.php';
session_start();

$conn = mysqli_connect($dbconfig["host"], $dbconfig["user"], $dbconfig["password"], $dbconfig["name"]) or die(mysqli_error($conn));
if (!empty($_SESSION["username"])) {
    $username = $_SESSION["username"];

    $query_info = "SELECT m.*, IFNULL(l.serie, '-') AS serie, IFNULL(l.step, '-') AS step FROM reparto r 
        JOIN impiegato i ON r.id = i.direzione JOIN macchinario m ON m.collocazione = r.nome LEFT JOIN lav_lotto l ON l.id_macchinario = m.id 
        WHERE i.username = '$username'";
    $query_info_res = mysqli_query($conn, $query_info);
    if ($query_info_res) {
        while ($row = mysqli_fetch_assoc($query_info_res)) {
            $data[] = $row;
        }
        mysqli_free_result($query_info_res);
        mysqli_close($conn);
    } else {
        $data = mysqli_error($conn);
    }
} else {
    $data = "Eseguire l'accesso per visualizzare il contenuto";
}

echo json_encode($data);
?>