PYTHONPATH=$PYTHONPATH:/tensorflow/models/research:/tensorflow/models/research/slim 
#cd PythonScripts
scriptdir=/tensorflow/models/research/volume/scripts
annotdir=/tensorflow/models/research/volume/annotations
imgdir=/tensorflow/models/research/volume/images
#trainingdir=/tensorflow/models/research/volume/
python "$scriptdir/python/generate_train_eval.py" "$annotdir/csv/labels.csv"
mv $annotdir/csv/labels_eval.csv $annotdir/csv/test
mv $annotdir/csv/labels_train.csv $annotdir/csv/train
python3 "$scriptdir/python/generate_pbtxt.py" csv "$annotdir/csv/labels.csv" "$annotdir/label_map.pbtxt"
python3 "$scriptdir/python/generate_tfrecord.py" "$annotdir/csv/train/labels_train.csv" "$annotdir/label_map.pbtxt" "$imgdir" "$annotdir/train.record"
python3 "$scriptdir/python/generate_tfrecord.py" "$annotdir/csv/test/labels_eval.csv" "$annotdir/label_map.pbtxt" "$imgdir" "$annotdir/test.record"

#cp "$annotdir/tf_ready/train.record" "$annotdir"
#cp "$annotdir/tf_ready/test.record" "$annotdir"
#cp "$annotdir/tf_ready/label_map.pbtxt" "$annotdir"
#cp "$annotdir/tf_ready/label_map.pbtxt" "$annotdir"
