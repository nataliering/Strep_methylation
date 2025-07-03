#! /bin/bash

## SCRIPT ASSUMES YOU HAVE INSTALLED OUR CONDA ENVIRONMENT FROM "basecalling_to_motif.yml" AND HAVE YOUR OWN VERSION OF DORADO INSTALLED ##

# Change this to wherever your conda.sh initialization file is
source /path/to/profile.d/conda.sh

# Change this to the name of the folder that has your pod5s in it. Script assumes your pod5 folder only has one sample/barcode in it
POD5_FOLDER="name_of_input_folder"

# Change this to wherever you untarred Dorado (change the version number to whatever you have).
DORADO_PATH="/path/to/dorado-x.x.x-linux-x64/bin/"

# Change this to whatever you want all your output files to be prefixed with
OUTPUT="output_prefix"

# Run basecalling with Dorado. Will check if you have a GPU, otherwise will default to CPU.
$DORADO_PATH/dorado basecaller sup,6mA,4mC_5mC $POD5_FOLDER --device auto --recursive --kit-name SQK-RBK114-24  > $OUTPUT.bam

conda activate basecalling_to_motif

# Convert bam to fastq
samtools fastq $OUTPUT.bam > $OUTPUT.fastq

# Assemble genome (change genome size if appropriate)
flye --nano-hq $OUTPUT.fastq --out-dir $OUTPUT.flye --genome-size 2m --threads 64
cp $OUTPUT.flye/assembly.fasta $OUTPUT.flye.fasta


MODCALLS="$OUTPUT.bam"
ASSEMBLY="$OUTPUT.flye.fasta"
MAPPING="$OUTPUT.mapping.bam"
PILEUP="$OUTPUT.pileup.bed"

# Map bam reads to Flye assembly then sort and index 
samtools fastq -T MM,ML $MODCALLS | minimap2 -ax map-ont -y $ASSEMBLY - | samtools view -bS | samtools sort -o $MAPPING
samtools index $MAPPING

# Create modification pileup .bed file
modkit pileup --only-tabs $MAPPING $PILEUP

# Create contig_bin table (not really relevant when we're only working with a monoculture with a closed genome assembly, but necessary for nanomotif to run)
echo "contig_1	bin_1" > contig_bin.tsv

CONTIG_BIN="contig_bin.tsv"
NANOMOTIF_OUT="$OUTPUT.nanomotif"

# Discover motifs with nanomotif! Motifs will be in $NANOMOTIF_OUT.bin_motifs.tsv
nanomotif motif_discovery $ASSEMBLY $PILEUP $CONTIG_BIN --out $NANOMOTIF_OUT
