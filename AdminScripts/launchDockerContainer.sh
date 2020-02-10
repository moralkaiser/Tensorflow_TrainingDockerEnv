# This script creates and launches the Docker Container with the userHandle

if [ ! -z $1 ]; then
	docker network create tf_containerlink_$1
	cd ..
	cd UserContainerVolumes
	cd $1/scripts/bash
	./bootDocker.sh

	#userDirVolumePath=$(pwd)
	
	#cd ..
	#cd ..
	#cd TrainingWorkloadManagement
	#workloadManagementDirVolumePath=$(pwd)

	#containerName="tf_trainingcontainer_$1"

	#docker run -i -d --rm -v "$userDirVolumePath:/userFiles" -v "$workloadManagementDirVolumePath:/workloadManagement" --name="$containerName" tf_trainingcontainer_student
else
	RED='\033[0;31m'
	NC='\033[0m' # No Color
	echo -e "$0 :: ${RED}Error${NC} : Insert Userhandle!"
fi
