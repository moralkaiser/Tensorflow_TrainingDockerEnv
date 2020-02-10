# This script resets the Userdir and removes every usercontainer

read  -n 1 -p "This script delete All Container and All User Files. Proceed? (Y/N):" dialogInput

        if [ $dialogInput == "y" ] || [ $dialogInput == "Y" ]; then
            
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
                
			else
                echo -e "\nRemoval of $1 Container was aborted"
		fi
