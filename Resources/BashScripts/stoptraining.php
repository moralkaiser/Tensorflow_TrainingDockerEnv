<?php
$gpu = $_GET['gpu'];
shell_exec("bash ./stopTrainingAndExportModel.sh $gpu");
?>

