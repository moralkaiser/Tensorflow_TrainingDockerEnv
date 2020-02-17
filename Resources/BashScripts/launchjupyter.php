<?php
$gpu = $_GET['gpu'];
exec("./runJupyter.sh $gpu");
?>


