#!/bin/bash
set -e  # abort script upon nonzero exit status
set -u  # abort script if variable's value is unset
#set -o pipefail # abort script if any error in pipe (illegal in BioLinux??)

# This script is set up to run in the same directory as the *.blast.tab output files from pfastGO analysis.

for file in *.blast.tab; do

upper=$(echo "$file" | tr '[:lower:]' '[:upper:]')
#echo "upper: $upper"

tag=${upper:0:3}
#echo "tag: $tag"

count=$(grep --count "LUX[A-Z]_$tag" $file | cat)
#echo "count: $count"

echo "$file ($tag) - $count"

grep --colour "LUX[A-Z]_$tag" $file | cat > $file.txt

#echo "file: $file"
#echo "tag: $tag"

done
