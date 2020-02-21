<?php
$gpu = $_GET['gpu'];
//exec("./runJupyter.sh $gpu");
shell_exec("bash -c './runJupyter.sh $gpu'");
?>


