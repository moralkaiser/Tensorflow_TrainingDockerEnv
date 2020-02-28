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

function hasFreeGPU(){
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

	return !empty($freeGPUs);
}

function registerUser($gpu,$userhandle,$status){
	
	$lineToAdd = array( $gpu, $userhandle, $status);

	$userList = array ();

	if (($handle = fopen("runningContainerList.csv", "r")) !== FALSE) 
	{
		while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) 
		{
			if($data[0] != "" && $data[1] != "" && $data[2] != "")
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

	fputcsv($file, $lineToAdd);
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

function userhandleAlreadyExists($userhandle){
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

function makeCurlToTrainingContainer($userhandle,$gpu){
    	$url = "http://tf_trainingcontainer_" .$userhandle .  ":800/starttraining.php?gpu=" . $gpu;
    	$handle = curl_init();
    	curl_setopt($handle, CURLOPT_URL, $url);
	curl_setopt($handle,CURLOPT_TIMEOUT,1);
    	$data = curl_exec($handle);
    	curl_close($handle);
}

$userhandle = $_GET["userhandle"];
if(hasFreeGPU() && !userhandleAlreadyExists($userhandle))
{
	$gpu = array_rand(getFreeGPU(),1);
	registerUser($gpu, $userhandle, "training");
	makeCurlToTrainingContainer($userhandle,$gpu);
}
?>
