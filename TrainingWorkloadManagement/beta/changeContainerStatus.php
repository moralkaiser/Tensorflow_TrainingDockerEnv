<?php

if (($handle = fopen("../volumeDir/userhandle.csv", "r")) !== FALSE) 
{
        $data = fgetcsv($handle, 1000, ",");
        $userhandle = $data[1];
        fclose($handle);
}

$status = $_GET['status'];

$userhandleFound = 0;

$userList = array ();

$userHandleLine = array("$userhandle" . "_container", "0");
$userHandleLineDefault = array("$userhandle" . "_container", "0");

if (($handle = fopen("containerList.csv", "r")) !== FALSE) 
{
    while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) 
    {
		if($data[0] == $userhandle . "_container")
		{
			$userhandleFound = 1;
			$userHandleLineDefault = array($data[0], $data[1]);
		}
		else
		{
			$otherUserLine = array($data[0], $data[1]);
			array_push($userList, $otherUserLine);
		}
    }
    
    fclose($handle);
}

if($userhandleFound == 1)
{
	
	$file = fopen("containerList.csv","w");

	foreach ($userList as $line) 
	{
		fputcsv($file, $line);
	}
	
	if($status == "enabled")
	{
		$userHandleLine = array($userhandle . "_container", "1");
	}
	else if ($status == "disabled")
	{
		$userHandleLine = array($userhandle . "_container", "0");
	}
	else
	{
		$userHandleLine = $userHandleLineDefault;
		
		echo "Unkown status $status \n";
	}
	
	fputcsv($file, $userHandleLine);

	fclose($file);
}
else
{
	echo "UserHandle not found \n";
}


?>
