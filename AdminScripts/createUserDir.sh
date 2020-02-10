# This script creates the volumes for the user Container
# Including folders for images, annotations etc.

if [ ! -z $1 ]; then
if [ ! -z $2 ]; then
	cd ..
	cd UserContainerVolumes
	mkdir $1 
	cd $1

	# Ressource for later Docker Opperations

	touch config.csv
	echo "userhandle,$1" >> config.csv
	echo "jupyterport,$2" >> config.csv

	mkdir scripts
	mkdir annotations
	mkdir images
	mkdir trained-model
	mkdir training
	mkdir frozen-graph
	mkdir pre-trained-model
	mkdir testing
	
    mkdir -p scripts/bash
    mkdir -p scripts/python
    mkdir -p annotations/csv
    mkdir -p annotations/csv/test
    mkdir -p annotations/csv/train
    mkdir -p testing/images
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
