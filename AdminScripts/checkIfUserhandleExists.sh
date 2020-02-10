# This script checks, if a given userhandle exists

if [ ! -z $1 ]; then
	
	cd ..
	cd UserContainerVolumes

	arrayUserhandles=($(ls -d *))

	for i in "${arrayUserhandles[@]}"
	do
		if [ $i == $1 ]; then
			# Userhandle Found
			exit 1
		fi
	done
	# Userhandle not Found
	exit 0
else
	RED='\033[0;31m'
	NC='\033[0m' # No Color
	echo -e "$0 :: ${RED}Error${NC} : Insert Userhandle to check!"
	
	exit 2
fi
