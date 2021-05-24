<?php
require_once 'dbconfig.php';
$conn = mysqli_connect($dbconfig["host"], $dbconfig["user"], $dbconfig["password"], $dbconfig["name"]) or die(mysqli_error($conn));


$queryLots = sprintf("INSERT INTO lotto (serie, prodotto, n_wfs, flag) VALUES ('%s', '%s', '%d', NULL)",
    $_GET["lot"],
    $_GET["product"],
    $_GET["nWfs"]
);

$queryLotsRes = mysqli_query($conn, $queryLots);

if ($queryLotsRes) {
    $data = "Lotto inserito correttamente";
    mysqli_close($conn);
} else {
    $data = "Lotto già presente";
}

echo json_encode($data);
?>
