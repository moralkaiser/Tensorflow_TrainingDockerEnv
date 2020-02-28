<?php

$gpu = $_GET["gpu"];
$userhandle = $_GET["userhandle"];
$status = $_GET["status"];

$lineToAdd = array( $gpu, $userhandle, $status);

$userList = array ();

if (($handle = fopen("runningContainerList.csv", "r")) !== FALSE) 
{
    while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) 
    {
		$userLine = array($data[0], $data[1],$data[2]);
		array_push($userList, $userLine);
    }
    
    fclose($handle);
}

$file = fopen("runningContainerList.csv","w");

foreach ($userList as $line) 
{
	fputcsv($file, $line);
}

fputcsv($file, $lineToAdd);
fclose($file);

?>
