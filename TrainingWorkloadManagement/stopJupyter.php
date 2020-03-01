<?php
function getGPUCount(){
	$GPUCount = 0;
	if (($handle = fopen("config.csv", "r")) !== FALSE) 
	{
		while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) 
		{
			if($data[0] == "maxGPU")
			{
				$GPUCount = $data[1];
			}
		}
	}
	echo $GPUCount;
	return $GPUCount;
}

function initFreeGPUArray($GPUCount){
	$freeGPUs = array();
	
	for ($i = 0; $i < $GPUCount; $i++) 
	{
		array_push($freeGPUs,$i);
	}
	return $freeGPUs;
}

function unregisterUser($userhandle){

	$userList = array ();

	if (($handle = fopen("runningContainerList.csv", "r")) !== FALSE) 
	{
		while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) 
		{
			if($data[1] != $userhandle)
			{
				$userLine = array($data[0], $data[1],$data[2]);
				array_push($userList, $userLine);
			}
			
		}
    
		fclose($handle);
	}

	$file = fopen("runningContainerList.csv","w");

	foreach ($userList as $line) 
	{
		fputcsv($file, $line);
	}

	fclose($file);
}

function getFreeGPU(){
	$freeGPUs = initFreeGPUArray(getGPUCount());

	if (($handle = fopen("runningContainerList.csv", "r")) !== FALSE) 
	{
		while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) 
		{
			$gpuData = $data[0];
			unset($freeGPUs[$gpuData]);
		}
    
		fclose($handle);
	}

	return $freeGPUs;
}

function userhandleAlreadyWorks($userhandle){
	$userhandleFound = 0;
	
	if (($handle = fopen("runningContainerList.csv", "r")) !== FALSE) 
	{
		while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) 
		{
			if($data[1] == $userhandle)
			{
				$userhandleFound = 1;
			}
		}
    
		fclose($handle);
	}
	
	return $userhandleFound;
}

function getUserData($userhandle){
	$userdata = array();
	
	if (($handle = fopen("runningContainerList.csv", "r")) !== FALSE) 
	{
		while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) 
		{
			if($data[1] == $userhandle)
			{
				array_push($userdata,$data[0],$data[1],$data[2]);
			}
		}
    
		fclose($handle);
	}
	
	return $userdata;
}

function makeCurlToTrainingContainer($userhandle,$gpu){
        $url = "http://tf_trainingcontainer_" .$userhandle .  ":803/stopjupyter.php?gpu=" . $gpu;
        $handle = curl_init();
        curl_setopt($handle, CURLOPT_URL, $url);
        curl_setopt($handle,CURLOPT_TIMEOUT,1);
        $data = curl_exec($handle);
        curl_close($handle);
}

$userhandle = $_GET["userhandle"];
if(userhandleAlreadyWorks($userhandle))
{
	$gpu = getUserData($userhandle)[0];

	makeCurlToTrainingContainer($userhandle,$gpu);
	unregisterUser($userhandle);
}
?>
