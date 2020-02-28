<?php

$counterEnabled = 0;
$maxNumOfRunningContainers = 0;
if (($handle = fopen("config.csv", "r")) !== FALSE) 
{
    while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) 
    {
		if($data[0] == "maxNumOfRunningContainers")
		{
			$maxNumOfRunningContainers = $data[1];
		}
	}
}

if (($handle = fopen("containerList.csv", "r")) !== FALSE) {
    while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) 
    {
		if($data[1] == 1)
		{
			$counterEnabled++;
		}
    }

	if($counterEnabled < $maxNumOfRunningContainers)
	{
		echo "Free Space \n";
	}
    	else
	{
		echo "No Space available \n";
	}
    fclose($handle);
}
?>
