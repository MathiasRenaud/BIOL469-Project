#!/bin/bash
set -e  # abort script upon nonzero exit status
set -u  # abort script if variable's value is unset
set -o pipefail # abort script if any error in pipe

for file in ../data/seqs/*.fa
do tag=${file%.fa}
echo "tag: $tag"
done
