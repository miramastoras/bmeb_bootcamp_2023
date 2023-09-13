#!/bin/bash
​
#SBATCH --partition=Instruction         # Partition/queue to run on
#SBATCH --time=04:00:00                 # Max time for job to run (4 hours)
#SBATCH --job-name=bootcamp2023_lkarim         # Name for job (shows when running squeue)
#SBATCH --mail-type=ALL                 # Mail events(NONE,BEGIN,END,FAIL,ALL)
#SBATCH --mail-user=lkarim@ucsc.edu   # Where to send mail
#SBATCH --ntasks=1                      # Number of tasks to run
#SBATCH --cpus-per-task=2               # Number of CPU cores to use per task
#SBATCH --mem=4G                        # Ammount of RAM to allocate for the task
#SBATCH --output=myR_%j.out             # Standard output and error log
#SBATCH --error=myR_%j.err              # Standard output and error log
​
​
# Load modules to use them
module load miniconda3.9
conda create -n quast -c conda-forge -c bioconda quast
conda activate quast
conda install joblib
mkdir quast 
​
time quast flye/assembly.fasta --nanopore Wwil_fastq/merged.rmdup.fastq.gz -t 1 -o quast --circos --k-mer-stats --glimmer --conserved-genes-finding --rna-finding --est-ref-size 1200000
