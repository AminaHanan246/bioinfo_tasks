#!/bin/bash

gtf_file=""
chr=""
type=""

while [[ $# -gt 0 ]]; do
case "$1" in 
-gtf)
gtf_file="$2"
shift 2
;;
-chr)
chr="$2"
shift 2
;;
-type)
type="$2"
shift 2
;;
*)
echo "-gtf_file and -chr input must be specified"
exit 1
;;
esac
done

# Ensuring both the inputs are given
if [[ -z "$gtf_file" || -z "$chr" ]]; then
echo "error: Both values are needed"
exit 1
fi


if [[ -z "$type" ]]; then
#Filter GTF file for all genes.
file="${chr}_gene.gtf"
awk -v chr="$chr" '$1 == chr && $3 == "gene"' "$gtf_file"  > "$file"

else
#Filter genes according to type
file="${chr}_gene_${type}.gtf"
awk -v chr="$chr" -v type="$type" '$1 == chr && $3 == "gene" && $0 ~ "gene_type \"" type "\""' "$gtf_file"  > "$file"
fi

#Count the number of lines
gene_count=$(wc -l < "$file")
echo "The number of genes in ${chr} is ${gene_count}"
