# Bioinfo-tasks

## Counting genes in each chromosomes
Find the number of genes in each chromosome using gene annotation file. The genes are to be further filtered based on their gene type.
<details>
<summary><strong> Workflow </summary></strong>

### Download gene annotation file
The gene annotation file cam be found in GENECODE website. The corresponding GFF/GTF file can be downloaded and uncompressed through:

```
wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_49/gencode.v49.annotation.gtf.gz
gunzip gencode.v49.annotation.gtf.gz
```

### Check the file details
The content of the file can be assessed (first 10 lines):

```
head -n 10 gencode.v49.annotation.gtf

##description: evidence-based annotation of the human genome (GRCh38), version 49 (Ensembl 115)
##provider: GENCODE
##contact: gencode-help@ebi.ac.uk
##format: gtf
##date: 2025-07-08
chr1    HAVANA  gene    11121   24894   .       +       .       gene_id "ENSG00000290825.2"; gene_type "lncRNA"; gene_name "DDX11L16"; level 2; tag "overlaps_pseudogene";
```

From this column 1 represent the **chromosome number** and column 3 represent the **feature** information.
> **Note:** The gene annotation file can also be downloaded via NCBI website, but the content arrangement would be different

## Counting genes
From the gene annotation file, we filter from chromosome 17 from column 1 and for gene from column 3 features using the `awk` command. The filtered info is then stored to an output file "chr17_gene.gtf" :

```
awk '$1 == "chr17" && $3 == "gene"' gencode.v49.annotation.gtf > chr17_gene.gtf
```

The filtered files contain only genes in chromosome 17 and gene number can be found by counting lines in the file

```
wc -l < "chr17_gene.gtf"
```

The number of genes was found to be 3780 genes. This includes protein-coding genes, lncRNA, pseudo genes and other functional categories. Therefore, we can further filter gene type-wise:

```
awk '$1 == "chr17" && $3 == "gene" && $0 ~ /gene_type "protein_coding"/' gencode.v49.annotation.gtf > chr17_genetype.gtf

wc -l < "chr17_genetype.gtf"

1187
```
## Consolidated script
A bash script with input as gtf file, chromosome and type(optional) can be found at [`scripts/gene_counts.sh`](scripts/gene_counts.sh)

### Gene count for chromosome 17
```
./gene_count.sh -gtf "gencode.v49.annotation.gtf" -chr "chr17"
```

### Protein-coding gene counts in chromosome 17
```
/gene_count.sh -gtf "gencode.v49.annotation.gtf" -chr "chr17" -type "protein_coding"
```
</details>
