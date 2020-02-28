cd ..
cd UserContainerVolumes

arrayUserhandles=($(ls -d *))

backupParentFolder=$(date +"%F")

mkdir ../Backups/$backupParentFolder

for i in "${arrayUserhandles[@]}"
do
	mv ./$i ../Backups/$backupParentFolder	
done

