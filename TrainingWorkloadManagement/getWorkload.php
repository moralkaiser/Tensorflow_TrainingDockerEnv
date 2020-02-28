<?php
$dataFromCSV = array();

if (($handle = fopen("runningContainerList.csv", "r")) !== FALSE) 
{
    while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) 
    {
		$gpuData = $data[0];
		$userhandleData = $data[1];
		$trainingStatusData = $data[2];
		
		$dataToPush = array( 'gpu' => $gpuData , 'userhandle' => $userhandleData , 'status' => $trainingStatusData );
		
		array_push($dataFromCSV, $dataToPush); 
    }
    
    fclose($handle);
}

echo json_encode($dataFromCSV);
?>
