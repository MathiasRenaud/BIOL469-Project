#!/bin/bash
set -e  # abort script upon nonzero exit status
set -u  # abort script if variable's value is unset
#set -o pipefail # abort script if any error in pipe (illegal in BioLinux??)

cd ../analysis/proteins/*/results

for dir in */ ; do

tag=${dir%/}

tar -czvf "$tag".tar.gz /home/manager/BIOL469-Project/analysis/proteins/*/results/"$dir"


# for testing purposes
#echo "file: $file"
done
