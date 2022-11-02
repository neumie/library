#!/bin/bash

#Variable setup
directory="./src"

#getopts is a built-in bash feature
while getopts ':d:' OPTION; do
    case $OPTION in
        d)
        directory=$OPTARG
        ;;
        ?)
        echo "script usage: $0 [-d <directory to search files in>]" >&2
        exit 0
        ;;
    esac
done

if [ $(cat package.json | jq '.prisma | has("schema")') == "true" ]
then
    schemaPath=$(cat package.json | jq -r '.prisma.schema')
else
    schemaPath="./prisma/schema.prisma"
fi

#Remove preexisting schema
rm -f $schemaPath
touch $schemaPath

#Look for all .prisma files and concatenate them into the main file
for file in `find $directory -type f -name "*.prisma"`; do
    cat $file >> $schemaPath
	echo "" >> $schemaPath
done

exit 0