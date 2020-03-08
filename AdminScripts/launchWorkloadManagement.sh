if [ ! "$(docker ps -q -f name=workloadmanagementContainer)" ]; then
	cd ../TrainingWorkloadManagement
	docker run -v $(pwd):/volume --network=tf_containerlink -itd --rm --name=workloadmanagementContainer workloadmanagement:latest
	docker exec -d -w /volume workloadmanagementContainer bash ./startPhpApi.sh 800
	docker exec -d -w /volume workloadmanagementContainer bash ./startPhpApi.sh 801
	docker exec -d -w /volume workloadmanagementContainer bash ./startPhpApi.sh 803
	docker exec -d -w /volume workloadmanagementContainer bash ./startPhpApi.sh 804
	docker exec -d -w /volume workloadmanagementContainer bash ./startPhpApi.sh 805
fi
