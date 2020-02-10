volumeDir=/tensorflow/models/research/volume

rm -rf /tensorflow/models/research/volume/frozen-graph/saved_model
mkdir /tensorflow/models/research/volume/frozen-graph/saved_model
chmod -R 777 /tensorflow/models/research/volume/frozen-graph/
chmod -R 777 /tensorflow/models/research/volume/frozen-graph/saved_model
#chmod -R 777 /tensorflow/models/research/volume/frozen-graph/saved_model/variables

cd $volumeDir
python3 export_inference_graph.py \
    --input_type=image_tensor \
    --pipeline_config_path=training/ssd_inception_v2_coco.config \
    --trained_checkpoint_prefix=./training/model.ckpt-$1 \
    --output_directory=frozen-graph/

cd $volumeDir/trained-model/

#getHighestExportVerisonNum
array_Filenames=($(echo */))
array_ModelVersionNum=()

for i in "${array_Filenames[@]}"
do
    SUBSTRING=$(echo $i | cut -d'/' -f 1)
    array_ModelVersionNum+=( "$SUBSTRING" )
done

maxVersion=0

for i in "${array_ModelVersionNum[@]}"
do
    maxVersion=$( (( $maxVersion < $i )) && echo "$i" || echo "$maxVersion" )
done

mkdir $((maxVersion+1))
chmod -R 777 ./$((maxVersion+1))

cd ./$((maxVersion+1))
cp $volumeDir/frozen-graph/saved_model/saved_model.pb saved_model.pb
cp -rf $volumeDir/frozen-graph/saved_model/variables .

chmod -R 777 /tensorflow/models/research/volume/frozen-graph/saved_model/variables
