<?php
    session_start();
    session_destroy();
    header('Location: '.$_GET["send"].'.php');
?>