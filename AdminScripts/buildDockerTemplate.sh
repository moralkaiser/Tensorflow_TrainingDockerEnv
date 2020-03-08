cd ..
cd Resources/TrainingDockerContainer

docker build -t tf_trainingcontainer_student:latest .

cd ..
cd TestContainer

docker build -t workloadmanagement:latest .
