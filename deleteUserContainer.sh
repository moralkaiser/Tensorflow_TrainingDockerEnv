# This Script removes the user Container and its associated Dirs and 
# entries in the Workload Mngmnt 

function executeDeleteTask() {
	echo -e "\n"
                        cd AdminScripts

                        ./checkIfUserhandleExists.sh $1
                        if [ $? == 1 ]; then
                                ./killDockerContainer.sh $1
                                ./removeUserContainer.sh $1
                        else
                                RED='\033[0;31m'
                                NC='\033[0m' # No Color
                                echo -e "$0 :: ${RED}Error${NC} : Userhandle not Found!"
                        fi

}

if [ ! -z $1 ]; then
	if [ ! -z $2 ] &&  [ $2 == "-y" ]; then
		executeDeleteTask $1	
	else
		read  -n 1 -p "This script deletes the Container and all User Files. Proceed? (Y/N):" dialogInput

       		 if [ $dialogInput == "y" ] || [ $dialogInput == "Y" ]; then
			executeDeleteTask $1
       		 else
                	echo -e "\nRemoval of $1 Container was aborted"
		 fi

	fi
else
        RED='\033[0;31m'
		NC='\033[0m' # No Color
		echo -e "$0 :: ${RED}Error${NC} : Insert Userhandle!"
fi
