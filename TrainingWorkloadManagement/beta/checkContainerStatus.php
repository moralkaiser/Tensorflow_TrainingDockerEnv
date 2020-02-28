<?php

if (($handle = fopen("../volumeDir/userhandle.csv", "r")) !== FALSE) 
{
	$data = fgetcsv($handle, 1000, ",");
	$userhandle = $data[1];
	fclose($handle);
}

$userhandleFound = 0;
$containerStatus = "";

if (($handle = fopen("containerList.csv", "r")) !== FALSE) 
{
    while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) 
    {
	if($data[0] == $userhandle . "_container")
	{
		$userhandleFound = 1;
		$containerStatus = $data[1] == 1 ? "enabled" : "disabled";
	}
    }
    
    fclose($handle);
}

if ($userhandleFound == 1)
{
	echo $userhandle . "_container" . " is " . $containerStatus . "\n";
}
else
{
	echo "Userhandle not Found! \n";
}
?>
