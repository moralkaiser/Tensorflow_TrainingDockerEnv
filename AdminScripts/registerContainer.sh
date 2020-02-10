# This script sets an entry in the TrainingWorkloadManagement/containerList.csv

cd ..
cd TrainingWorkloadManagement
if [ ! -z $1 ]; then
	echo "$1_container,0" >> containerList.csv
else
	RED='\033[0;31m'
	NC='\033[0m' # No Color
	echo -e "$0 :: ${RED}Error${NC} : Insert Userhandle!"
fi
