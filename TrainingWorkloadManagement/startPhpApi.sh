
if [ ! -z $1 ]; then
	nohup php -S workloadmanagementContainer:$1 
else
        RED='\033[0;31m'
        NC='\033[0m' # No Color
        echo -e "$0 :: ${RED}Error${NC} : Insert Port to Open!"
fi

