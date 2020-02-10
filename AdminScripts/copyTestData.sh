# This script copies the test Data from the Resurces Folder in the corresponding userDir

if [ ! -z $1 ]; then
	
	cd ..
	cd Resources
	cp ./TestData/images/* "../UserContainerVolumes/$1/images"
	cp ./TestData/annotations/* "../UserContainerVolumes/$1/annotations/csv"
	
else
	RED='\033[0;31m'
	NC='\033[0m' # No Color
	echo -e "$0 :: ${RED}Error${NC} : Insert Userhandle!"
fi
