<?php
$gpu = $_GET['gpu'];
exec("./startDatabuildAndTraining.sh $gpu");
?>

