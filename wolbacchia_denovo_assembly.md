# De-novo assembly of a Wolbacchia genome

This document contains instructions for generating a de-novo assembly of a wolbacchia genome for BMEB bootcamp 2023. This is part 1 of the computational portion of the bootcamp.

I recommend that you clone this repository to your local computer, and open up this document in a text editor. That way you can save any changes you make to the code in this tutorial (like file paths)

> The output files for all steps in this tutorial can be found in the [bootcamp dropbox](https://www.dropbox.com/scl/fo/7cdhhpvc0vwxaawr36iff/h?rlkey=2o6mokx3yf5kkb3upymjab5yr&dl=0). If you get stuck and fall behind, feel free to use these files to move ahead.  

## 0. Log onto the hummingbird server and create a project directory

You can access the hummingbird server with your UCSC username and Gold password. Please see the humming bird wiki on ["Getting Started"](https://hummingbird.ucsc.edu/getting-started/) for more details. (Feel free to run this analysis on your local computer if you prefer, but note that we may not be familiar with your operating system if you need help.)

Open your terminal and type:
```
ssh <your_cruzid>@hb.ucsc.edu
```

You should be in your home directory. You can check the directory you are in by typing `pwd`. This stands for "print working directory" Mine looks like this:

```
[mmastora@hb ~]$ pwd
/hb/home/mmastora
```

Create a new folder in your home directory for this analysis. Its good practice to keep your directories well organized.

```
mkdir bootcamp2023
```

Change into this new directory for the rest of the analysis
```
cd bootcamp2023
```

> Note: If you are new to linux commands, please refer to the [provided reference slides](https://docs.google.com/presentation/d/1hjIfozfQkjL4gj1eUtvBqgzpWERAkF8Uw43ToAQSxa8/edit#slide=id.p)


## 1. Download fastq files produced by the Guppy basecaller

The fastq files for our nanopore experiments are [located in this dropbox folder](https://www.dropbox.com/scl/fo/7cdhhpvc0vwxaawr36iff/h?rlkey=2o6mokx3yf5kkb3upymjab5yr&dl=0).

The fastq files are in this file:

Copy the link to this file from the dropbox website. To download the files to hummingbird, go back to your terminal and type:

```
wget -O guppy_fastqs.tar.gz <link from dropbox>

# example
wget -O guppy_fastqs.tar.gz https://www.dropbox.com/scl/fi/2fak6z47pptalsvgwlpmn/guppy_fastqs.tar.gz?rlkey=zgz09zybc3upzqpo0ayd7e890&dl=0
```

Check that the file is in your directory with `ls`. Now, uncompress it with:

```
tar -zxvf guppy_fastqs.tar.gz
```
You should now have a new folder in your current directory titled `guppy_fastqs`. You can confirm that the fastq files are inside of it with:
```
ls guppy_fastqs/
```

## 2. Create a conda environment for assembly.

We need to install the Flye assembler onto hummingbird to run our assembly. We can do this using conda, which is already installed on hummingbird. If you are working on your own computer, you'll need to install conda. You can do this on the command line by downloading the conda installer [here](https://docs.conda.io/en/latest/miniconda.html#latest-miniconda-installer-links), then running `bash <Miniconda_blah_blah.sh>`


First, load conda
```
module load miniconda3.9
```

Now, we create a new conda environment and install the latest flye in it.

```
conda create -n flye_29 -c conda-forge -c bioconda flye=2.9
```
To activate this environment, run
```
conda activate flye_29
```
You'll know you have activated the environment if `(flye_29)` is at the beginning of your command prompt, like this
```
(flye_29) [mmastora@hb progs]$
```
You can test that flye works by running:
```
flye -h
```

## Running Flye assembler

First, we need to combine all our fastq files into one file.
```
cd guppy_fastqs

cat *.fastq.gz > merged.fastq.gz
```

The Flye [manual](https://github.com/fenderglass/Flye/blob/flye/docs/USAGE.md) gives a whole list of all the possible parameters we can give Flye. You can also check these by running `flye -h` Please read through the section in the manual giving descriptions of these parameters [(here)](https://github.com/fenderglass/Flye/blob/flye/docs/USAGE.md#-parameter-descriptions) and make sure you understand why this is the command we need to run:

```
# create output directory
mkdir flye

# run flye assembler
time flye --nano-hq /hb/home/mmastora/bootcamp2023/guppy_fastqs/merged.fastq.gz -t 1 --out-dir /hb/home/mmastora/flye/
```

When flye finishes, you'll notice it output three files: 

## Assembly quality control

We will use two tools to assess the quality of our assembly, Quast and Busco. We need to first install these tools in a new conda environment

```
conda deactivate flye_29

conda create -n asm_eval -c bioconda quast busco
conda activate asm_eval
```


While these tools are running, take some time to research the metrics they produce, and discuss in groups.

- [Quast](https://github.com/ablab/quast)
- [Busco](https://busco.ezlab.org/)

Running Quast:
```
```
Running Busco:
```
```

What do these metrics tell us about the quality and completeness of our assembly?


## Independent project and presentation

For the rest of bootcamp, your task is to find an interesting analysis to do with our Wolbacchia data. This is **purposefully open-ended**, to give you practice with developing your own question or hypothesis, figuring out the research steps necessary to answer it, executing those steps, and presenting your work to others.  

We DO NOT expect everyone to come up with incredible groundbreaking results. The **worst thing you could do** would be to give up and not present anything, just because you couldn't get an analysis to work. Share your project idea, what you tried, what worked and what didn't, and what you learned from the project if you aren't able to get results for this independent portion.  

To get you started, we've come up with some project ideas you may use for the independent portion, but coming up with your own idea is highly encouraged! Follow your interests.

#### Project ideas:

- Run additional assemblers on our data and compare their performance. Is Flye the best assembler for our data?
- Characterize the repetitive elements in our assembly (Hint: RepeatMasker)
- Build a phylogeny with our Wolbacchia assembly and other species (Hint: USHER)
- Comparative genomics: [Mauve](https://darlinglab.org/mauve/mauve.html), [Mummer](https://mummer.sourceforge.net) Are there interesting variations between our assembly and other relevant datasets?
- Take the repeat graph produced by Flye and visualize it in [Bandage](https://github.com/rrwick/Bandage). What does this visualization show you about the repeat structure and quality of the assembly?


### Extra:

Sharing guppy files:
```
tar -zcvf guppy_fastqs.tar.gz guppy_fastqs
```
