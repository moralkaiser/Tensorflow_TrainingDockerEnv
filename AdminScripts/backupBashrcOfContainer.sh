if [ ! -z $1 ]; then
 docker exec -d -w /tensorflow/models/research/volume/scripts/bash tf_trainingcontainer_$1 bash ./backupBashrc.sh
else
        RED='\033[0;31m'
        NC='\033[0m' # No Color
        echo -e "$0 :: ${RED}Error${NC} : Insert Userhandle!"
fi

