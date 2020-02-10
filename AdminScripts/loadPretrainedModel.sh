# This Script loads the pretrained model ssd_mobilenet_v2_coco from Tensorflow Object Detection Model Zoo and unpacks it
# Src = https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/detection_model_zoo.md

if [ ! -z $1 ]; then
	cd ..
	cd UserContainerVolumes
	cd $1
	cd pre-trained-model
	rm -rfv ./*
	wget "http://download.tensorflow.org/models/object_detection/ssd_inception_v2_coco_2018_01_28.tar.gz"
	modelTarPath=$( echo $( ls ) )
	pretrainedModelDirPath=$( echo $( ls | cut -f1 -d"." ) )
	echo "$modelTarPath"
	tar -zxvf "$modelTarPath"
	cp -r $pretrainedModelDirPath/* .
	rm -rf $pretrainedModelDirPath
	
	cd ..
	cd ..
	cd ..
	cd Resources
	cd PretrainedModelConfig
	cp ./ssd_inception_v2_coco.config ../UserContainerVolumes/$1/training
else
	RED='\033[0;31m'
	NC='\033[0m' # No Color
	echo -e "$0 :: ${RED}Error${NC} : Insert Userhandle!"
fi
