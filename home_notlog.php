<?php
require_once 'dbconfig.php';

$conn = mysqli_connect($dbconfig["host"], $dbconfig["user"], $dbconfig["password"], $dbconfig["name"]) or die(mysqli_error($conn));
$news = [
    [
    'day' => 'Lunedì 29',
    'descrizione' => 'New Apple Contract'
        ],
    [
    'day' => 'Mercoledì 31',
    'descrizione' => 'Avvio campagna vaccinale'
    ],
    [
    'day' => 'Venerdì 2',
    'descrizione' => 'Sintesi incontro aziendale'
    ]
];

$data[] = $news;
//nel db dovremmo avere sempre l'elenco dei target di ogni reparto per ogni turno (M-P-N)
// quindi $yesterday avrà sempre risultati per la data di ieri
$yesterday = date("Y-m-d", mktime(0, 0, 0, date("m"), date("d")-1, date("Y")));
//questa però per semplicità viene sostituita con una data che contiene già molti risultati
$yesterday = "2020-06-24";

$query_ach = "SELECT r. nome, s.target from reparto r join storico_ach s on s.id_reparto = r.id where s.data = '$yesterday'";
$query_ach_res = mysqli_query($conn, $query_ach);
    if ($query_ach_res or die(mysqli_error($conn))) {
        while ($row = mysqli_fetch_assoc($query_ach_res)) {
            $ach[] = $row;
        }
        mysqli_free_result($query_ach_res);
        mysqli_close($conn);
    }
$data[] = $ach;
echo json_encode($data);
?>