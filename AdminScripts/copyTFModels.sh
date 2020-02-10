# This script copies the necessary TF Model and config File from the Resurces Folder in the corresponding userDir

if [ ! -z $1 ]; then
	
	cd ..
	cd Resources
	cp ./PretrainedModel/ssd_inception_v2_coco_2018_01_28.tar.gz "../UserContainerVolumes/$1/pre-trained-model"
	cp ./PretrainedModel/config/* "../UserContainerVolumes/$1/training"
	
	cd ../UserContainerVolumes/$1/pre-trained-model
	modelTarPath=$( echo $( ls ) )
	pretrainedModelDirPath=$( echo $( ls | cut -f1 -d"." ) )
	echo "$modelTarPath"
	tar -zxvf "$modelTarPath"
	cp -r $pretrainedModelDirPath/* .
	rm -rf $pretrainedModelDirPath
	
else
	RED='\033[0;31m'
	NC='\033[0m' # No Color
	echo -e "$0 :: ${RED}Error${NC} : Insert Userhandle!"
fi
