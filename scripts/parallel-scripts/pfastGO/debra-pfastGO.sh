#!/bin/bash
set -e  # abort script upon nonzero exit status
set -u  # abort script if variable's value is unset
#set -o pipefail # abort script if any error in pipe (illegal in BioLinux??)

cd ../../../analysis/proteins/debra

for file in *.faa
do tag=${file%.*.*.*.faa}

sh /home/manager/pfastGO-master/pfastGO.sh "$file" "$tag" 2

# for testing purposes
#echo "tag: $tag"
#echo "file: $file"
done
