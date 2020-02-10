# This script creates the Volume for the UserContainer, sets entry
# in the Workload Mngmt and launches the Docker Container

if [ ! -z $1 ]; then
	cd AdminScripts
	./checkIfUserhandleExists.sh $1
	if [ $? == 0 ]; then
		./createAndLaunchUserContainer.sh $1 $2
	else
		RED='\033[0;31m'
		NC='\033[0m' # No Color
		echo -e "$0 :: ${RED}Error${NC} : Userhandle already in use!"
	fi
else
        RED='\033[0;31m'
		NC='\033[0m' # No Color
		echo -e "$0 :: ${RED}Error${NC} : Insert Userhandle!"
fi

