# This script resets the Userdir and removes every usercontainer

function deleteAll(){
	cd ..
	cd UserContainerVolumes

        arrayUserhandles=($(ls -d *))

        cd ..
        cd AdminScripts

        for i in "${arrayUserhandles[@]}"
        do
        	./removeUserContainer.sh $i
                ./killDockerContainer.sh $i
        done
}

if  [ $1 == "-y" ]; then
	deleteAll
else
	read  -n 1 -p "This script delete All Container and All User Files. Proceed? (Y/N):" dialogInput

	if [ $dialogInput == "y" ] || [ $dialogInput == "Y" ]; then
		deleteAll
	else
		echo -e "\nRemoval of $1 Container was aborted"
	fi
fi
