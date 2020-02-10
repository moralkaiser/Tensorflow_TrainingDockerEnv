
if [ ! -z $1 ]; then
	cd /tensorflow/models/research/volume/
	userhandleRAW="`cat config.csv`"
	userhandle=$(echo "$userhandleRAW" | cut -d ',' -f 2)
	SAVEIFS=$IFS   # Save current IFS
	IFS=$'\n'      # Change IFS to new line
	userhandle=($userhandle) # split to array $names
	IFS=$SAVEIFS   # Restore IFS
	#for i in "${userhandle[@]}"; do echo "$i"; echo next; done

        cd /tensorflow/models/research/volume/scripts/bash
	#nohup php -S tf_trainingcontainer_$userhandle:$1
	#nohup php -S tf_trainingcontainer_$userhandle:$1 -t foo/ bar.php > phpd.log 2>&1 &
	nohup php -S tf_trainingcontainer_${userhandle[0]}:$1 
else
        RED='\033[0;31m'
        NC='\033[0m' # No Color
        echo -e "$0 :: ${RED}Error${NC} : Insert Port to Open!"
fi

