#!/bin/bash

prismaPath="./prisma/"
schemaName="schema.prisma"
directory="./src"

#getopts is a built-in bash feature
while getopts ':p:n:d:' OPTION; do
    case $OPTION in
        p)
        prismaPath=$OPTARG
        ;;
        n)
        schemaName=$OPTARG
        ;;
        d)
        directory=$OPTARG
        ;;
        ?)
        echo "script usage: $0 [-p <path to prisma>] [-n <schema name>] [-d <directory to search files in>]" >&2
        exit 0
        ;;
    esac
done

schemaPath=$prismaPath$schemaName

#Remove preexisting schema
rm -f $schemaPath

#Look for all .prisma files and concatenate them into the main file
for file in `find ./src -type f -name "*.prisma"`; do
    cat $file >> $schemaPath
	echo "" >> $schemaPath
done

exit 0