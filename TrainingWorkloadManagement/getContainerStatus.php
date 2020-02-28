<?php

$userhandle = $_GET["userhandle"];
$userhandleData = array();
$userhandleFound = 0;

if (($handle = fopen("runningContainerList.csv", "r")) !== FALSE) 
{
    while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) 
    {
		if($data[1] == $userhandle)
		{
			$userhandleFound = 1;
			$userhandleData = array($data[0],$data[1],$data[2]);
		}
    }
    
    fclose($handle);
}

if ($userhandleFound == 0)
{
	$userhandleData = array(-1,$userhandle,'no task running');
}

echo json_encode($userhandleData);
?>
