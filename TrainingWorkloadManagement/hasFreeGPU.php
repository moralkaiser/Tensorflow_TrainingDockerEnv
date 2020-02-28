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

echo !empty($freeGPUs);
?>
