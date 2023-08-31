# De-novo assembly of a Wolbacchia genome

This document contains instructions for generating a de-novo assembly of a wolbacchia genome for BMEB bootcamp 2023. This is part 1 of the computational portion of the bootcamp.

I recommend that you clone this repository to your local computer, and open up this document in a text editor. That way you can save any changes you make to the code in this tutorial (like file paths)

## 0. Log onto the hummingbird server and create a project directory

You can access the hummingbird server with your UCSC username and Gold password. Please see the humming bird wiki on ["Getting Started"](https://hummingbird.ucsc.edu/getting-started/) for more details. (Feel free to run this analysis on your local computer if you prefer, but note that we may not be familiar with your operating system and be able to help as much.)

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

## 2. Install miniconda in your home directory.

Now that we have our data, we need to install the assembler we are going to use, which is Flye. To install Flye, we're going to use the package manager conda.

Go to [the conda website](https://docs.conda.io/en/latest/miniconda-other-installer-links.html). We need to install an earlier version of Miniconda3, because of an incompatibility with hummingbird. I used the version with python 3.8. Copy the link for `Miniconda3 Linux 64-bit` from the website.  

Now, go back to your terminal and download the installer.  
```
# go back to home directory
cd

# create new folder for software
mkdir progs
cd progs

# download miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-py38_23.5.2-0-Linux-x86_64.sh

# install
bash Miniconda3-latest-Linux-x86_64.sh
```
Follow the prompts on the screen. You should see this message
```
Do you accept the license terms? [yes|no]
[no] >>> yes

Miniconda3 will now be installed into this location:
/hb/home/mmastora/miniconda3

  - Press ENTER to confirm the location
  - Press CTRL-C to abort the installation
  - Or specify a different location below

[/hb/home/mmastora/miniconda3] >>>
```
It might take a couple of minutes. You'll know its installed when you see:
```
Thank you for installing Miniconda3!
```
## 3. Create a conda environment for assembly.

First, load conda: (you will need to run this again every time you log onto hummingbird or open a new terminal screen. Replace my username with yours in the path.
```
source /hb/home/mmastora/miniconda3/etc/profile.d/conda.sh
```

Create a new conda environment for assembly
```
conda create -n assembly
```
Activate the assembly environment.
```
conda activate assembly
```

You'll know you are in the assembly environment when you see this `(assembly)` at the beginning of your command prompt.

Now, we will install Flye assembler into our assembly environment.
```
conda install -c conda-forge tqdm
conda install -c bioconda flye
```

## Running Flye assembler

The [manual](https://github.com/fenderglass/Flye/blob/flye/docs/USAGE.md) gives a whole list of all the possible parameters we can give Flye. You can also check these by running `flye -h` Please read through and make sure you understand why this is the command we need to run:

```
flye --nano-corr /hb/home/mmastora/bootcamp2023/guppy_fastqs/ -t 1
```

## Independent project / presentation ideas

For the rest of bootcamp, your task is to find an interesting analysis to do with our Wolbacchia data. This is **purposefully open-ended**, to give you practice with developing your own question or hypothesis, figuring out the research steps necessary to answer it, executing those steps, and presenting your work to others.  

We DO NOT expect everyone to come up with incredible groundbreaking results. The **worst thing you could do** would be to give up and not present anything, just because you couldn't get an analysis to work. Share your project idea, what you tried, what worked and what didn't, and what you learned from the project if you aren't able to get results for this independent portion.  

To get you started, we've come up with some project ideas you may use for the independent portion, but coming up with your own idea is highly encouraged! Follow your interests.

##### Project ideas:

- Run quality control on our assembly. What metrics are used to assess assembly quality?  
- Run additional assemblers on our data and compare their performance. Is Flye the best assembler for our data?
- Characterize the repetitive elements in our assembly (Hint: RepeatMasker)
- Build a phylogeny with our Wolbacchia assembly and other species (Hint: USHER)
- Comparative genomics: [Mauve](https://darlinglab.org/mauve/mauve.html), [Mummer](https://mummer.sourceforge.net/)


### Extra:

Sharing guppy files:
```
tar -zcvf guppy_fastqs.tar.gz guppy_fastqs
```
