<?php
require_once 'dbconfig.php';
session_start();
$conn = mysqli_connect($dbconfig["host"], $dbconfig["user"], $dbconfig["password"], $dbconfig["name"]) or die(mysqli_error($conn));

if (empty($_SESSION["username"])) {
    echo json_encode("Eseguire l'accesso per visualizzare il contenuto");
    return;
}

$data_init[] = array('init');
if ($_GET["init"]) {
    echo json_encode($data_init);
    return; 
}
// Ternary Operator (condition) ? statementTrue : statementFalse

$lot = (empty($_GET["lot"])
? 1
: sprintf (" serie LIKE '%%%s%%'", $_GET["lot"]) );

$prod = (empty($_GET["product"])
? 1
: sprintf ("prodotto = '%s'", $_GET["product"]) );
 
$flag = (empty($_GET["flag"])
? 1
: sprintf ("flag = '%s'", $_GET["flag"]) );

$queryLots = empty($_GET["lot"]) && empty($_GET["product"]) && empty($_GET["flag"])
? "SELECT * FROM lotto"
: "SELECT * FROM lotto WHERE $lot AND $prod AND $flag";

$queryLotsRes = mysqli_query($conn, $queryLots);

if ($queryLotsRes) {
    while ($row = mysqli_fetch_assoc($queryLotsRes)) {
        $data[] = $row;
    }
    mysqli_free_result($queryLotsRes);
    mysqli_close($conn);
} else {
    $data = mysqli_error($conn);
}

echo json_encode($data);
?>

