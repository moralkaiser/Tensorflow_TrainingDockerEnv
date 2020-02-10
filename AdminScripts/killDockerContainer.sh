# This script kills the Docker-Container with the given UserHandle

if [ ! -z $1 ]; then
	docker kill "tf_trainingcontainer_$1"
	docker network remove tf_containerlink_$1
else
    RED='\033[0;31m'
	NC='\033[0m' # No Color
	echo -e "$0 :: ${RED}Error${NC} : Insert Userhandle!"
fi

