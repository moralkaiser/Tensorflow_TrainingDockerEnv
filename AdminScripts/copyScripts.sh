# This script copies the necessary Scripts from the Resurces Folder in the corresponding userDir

if [ ! -z $1 ]; then
	
	cd ..
	cd Resources
	cp ./BashScripts/* "../UserContainerVolumes/$1/scripts/bash"
	cp ./PythonScripts/FormatConverting/* "../UserContainerVolumes/$1/scripts/python"
	cp ./PythonScripts/* "../UserContainerVolumes/$1/"
	
else
	RED='\033[0;31m'
	NC='\033[0m' # No Color
	echo -e "$0 :: ${RED}Error${NC} : Insert Userhandle!"
fi
