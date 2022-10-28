#! /bin/bash

#Variable setup
prismaPath="./../src/services/prisma/"
schemaName="schema.prisma"
schemaPath="$prismaPath$schemaName"

#Path to the files to concatenate
collectionPath="../schemas/"

#Check if the necessary directories exist and if there is at least 1 file to concatenate
if ! [[ -d "$prismaPath" ]]
then
	echo "The directory $prismaPath doesn't exist!"
	exit 0
elif ! [[ -d "$collectionPath" ]]
then
	echo "The directory $collectionPath doesn't exist!"
	exit 0
elif ! [[ $(ls ./$collectionPath | wc -l) > 0 ]]
then
	echo "The directory $collectionPath is empty!"
	exit 0
fi	

#Remove the old schema if it exists
rm -f $schemaPath

#Create empty schema file
touch $schemaPath

#Concatenate all the files together
for file in $collectionPath*
do
	cat $file >> $schemaPath
	echo "" >> $schemaPath
done

echo "Concatenation of schema files finished."
exit 0