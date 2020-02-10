# This script creates Volumes for the Docker Container and registers them in the Workload Management

if [ ! -z $1 ]; then
if [ ! -z $2 ]; then
	./createUserDir.sh $1 $2
	./copyJupyterModelTesting.sh $1
	./registerContainer.sh $1

	./copyScripts.sh $1
	./copyTFModels.sh $1
	./launchDockerContainer.sh $1
	./startContainerPhpApi.sh $1
	
	GREEN='\e[32m'
	NC='\033[0m' # No Color
	echo -e "$0 :: ${GREEN}$1 Container created${NC}"
else
	RED='\033[0;31m'
        NC='\033[0m' # No Color
        echo -e "$0 :: ${RED}Error${NC} : Insert Port for JupyterNotebook!"

fi
else
    	RED='\033[0;31m'
	NC='\033[0m' # No Color
	echo -e "$0 :: ${RED}Error${NC} : Insert Userhandle!"
fi

