cd ..
cd ..
#userhandleRAW="`cat userhandle.csv`"
#userhandle=$(echo "$userhandleRAW" | cut -d ',' -f 2)
#echo "tf_trainingcontainer_$userhandle"

userhandleRAW="`cat config.csv`"
userhandle=$(echo "$userhandleRAW" | cut -d ',' -f 2)
SAVEIFS=$IFS   # Save current IFS
IFS=$'\n'      # Change IFS to new line
userhandle=($userhandle) # split to array $names
IFS=$SAVEIFS   # Restore IFS
#for i in "${userhandle[@]}"; do echo "$i"; echo next; done

docker kill "tf_trainingcontainer_$userhandle"
docker run --network=tf_containerlink_${userhandle[0]} --runtime=nvidia -p ${userhandle[1]}:8888 -v /home/teder/testArchiv/Mustererkennung_Job/UserContainerVolumes/${userhandle[0]}:/tensorflow/models/research/volume -itd --rm --name "tf_trainingcontainer_${userhandle[0]}" tf_trainingcontainer_student:latest
#docker exec -it --user=root -e PYTHONPATH=$PYTHONPATH:/tensorflow/models/research:/tensorflow/models/research/slim -w /tensorflow/models/research/volume/scripts/bash "tf_trainingcontainer_$userhandle" bash ./startDatabuildAndTraining.sh

