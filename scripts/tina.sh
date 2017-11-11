#!/bin/bash
set -e  # abort script upon nonzero exit status
set -u  # abort script if variable's value is unset
#set -o pipefail # abort script if any error in pipe (illegal in BioLinux??)

# run annotation.sh from /scripts directory on FASTA files in /seqs
cd ../data/seqs/tina

for file in *.fa
do tag=${file%.fa}
# echo "tag: $tag"  # for testing purposes
prokka --prefix "$tag" --locustag "$tag" --cpus 2 --centre C --locustag L --compliant --mincontiglen 200 --outdir ../../../analysis/prokka/"$tag" --force --addgenes "$file"
done
