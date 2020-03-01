# This script removes the user Container with the set handle from UserDir and Workload Management
# Insert UserHandle

function removeUserHandle()
{
	resetFlags $1
	
	search=$1"_container,2";
	replace=""
	sed -i "s/${search}/${replace}/g" containerList.csv
}

function resetFlags()
{
	#Reset for Flag=0
	search=$1"_container,0";
	replace=$1"_container,2"
	sed -i "s/${search}/${replace}/g" containerList.csv
    	#Reset for Flag=1
	search=$1"_container,1";
    	replace=$1"_container,2"
    	sed -i "s/${search}/${replace}/g" containerList.csv
}


userHandleExists=0

if [ ! -z $1 ]; then
        cd ..
        cd TrainingWorkloadManagement
        file="./containerList.csv"
	while IFS= read line
	do
        	# check if user handle exists
        	lineUserHandle=$(echo "$line"|cut -f1 -d"_")
		if [ $1 == $lineUserHandle ]; then
			userHandleExists=1
		fi
	done <"$file"

	if [ $userHandleExists == 1 ]; then
		removeUserHandle $1
		sed -i '/^$/d' containerList.csv
		cd ..
		cd UserContainerVolumes
		rm -rf $1
		
		GREEN='\e[32m'
		NC='\033[0m' # No Color
		echo -e "$0 :: ${GREEN}Done removing $1 Container${NC}"
	else
		RED='\033[0;31m'
		NC='\033[0m' # No Color
		echo -e "$0 :: ${RED}Error${NC} : Userhandle not found!"
	fi

else
        RED='\033[0;31m'
		NC='\033[0m' # No Color
		echo -e "$0 :: ${RED}Error${NC} : Insert Userhandle!"
fi

