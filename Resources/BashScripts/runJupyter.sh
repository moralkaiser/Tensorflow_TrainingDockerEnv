./setGpuToUse.sh $1
export GPUTOUSE=$1
cp /tensorflow/models/research/volume/test_model.ipynb /tensorflow/models/research/object_detection

cd /tensorflow/models/research/volume

userhandleRAW="`cat config.csv`"
userhandle=$(echo "$userhandleRAW" | cut -d ',' -f 2)
SAVEIFS=$IFS   # Save current IFS
IFS=$'\n'      # Change IFS to new line
userhandle=($userhandle) # split to array $names
IFS=$SAVEIFS   # Restore IFS
#for i in "${userhandle[@]}"; do echo "$i"; echo next; done

mkdir /root/.jupyter
rm -rf /root/.jupyter/jupyter_notebook_config.json
echo '{
  "NotebookApp": {
    "token": "'"${userhandle[0]}"'"
  }
}' >> /root/.jupyter/jupyter_notebook_config.json

cd /tensorflow/models/research
jupyter-notebook --ip="0.0.0.0" --no-browser --allow-root --notebook-dir=./object_detection
