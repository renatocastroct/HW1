<?php
require_once 'dbconfig.php';
$conn = mysqli_connect($dbconfig["host"], $dbconfig["user"], $dbconfig["password"], $dbconfig["name"]) or die(mysqli_error($conn));


$queryLots = sprintf("DELETE FROM lotto WHERE serie = '%s'",
    $_GET["lot"]
);

$queryLotsRes = mysqli_query($conn, $queryLots);

if ($queryLotsRes) {
    $data = "Lotto eliminato correttamente";
    mysqli_close($conn);
} else {
    $data = mysqli_error($conn);
}

echo json_encode($data);
?>