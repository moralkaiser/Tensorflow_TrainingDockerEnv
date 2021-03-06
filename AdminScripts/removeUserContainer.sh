# This script removes the user Container with the set handle from UserDir and Workload Management
# Insert UserHandle

userHandleExists=0
replace=""

if [ ! -z $1 ]; then
        cd ..
        cd TrainingWorkloadManagement
        file="./containerList.csv"
	while IFS= read line
	do
        	# check if user handle exists
        	lineUserHandle=$(echo "$line"|cut -f1 -d",")
		if [ $1 == $lineUserHandle ]; then
			userHandleExists=1
			sed -i "s/$line/${replace}/g" containerList.csv
		fi
	done <"$file"

	sed -i '/^[[:space:]]*$/d' containerList.csv

	if [ $userHandleExists == 1 ]; then
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

