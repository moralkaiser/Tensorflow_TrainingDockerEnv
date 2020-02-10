if [ ! -z $1 ]; then
	cd ..
        cd Resources
        cp ./JupyterModelTesting/test_model.ipynb "../UserContainerVolumes/$1"
else
        RED='\033[0;31m'
        NC='\033[0m' # No Color
        echo -e "$0 :: ${RED}Error${NC} : Insert Userhandle!"
fi
