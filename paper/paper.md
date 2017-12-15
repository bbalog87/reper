---
title: 'reper: find, classify and quantify repeats without a genome assembly'
tags:  
  - repeats
  - transposons
  - kmer
  - pipeline
  - repeat landscape
  - NGS
authors:
  - name: Niklas Terhoeven
    orcid: 0000-0002-8669-0000
    affiliation: "1, 2" # (Multiple affiliations must be quoted)
  - name: Jörg Schultz
    orcid:
    affiliation: "1, 2"
    - name: Thomas Hackl
    orcid: 0000-0002-0022-320X
    affiliation: 3
affiliations:
  - name: Center for Computational and Thoeretical Biology, Universität Würzburg
    index: 1
  - name: Lehrstuhl für Bioinformatik, Universität Würzburg
    index: 2
  - name: Chisholm Lab, Massachusetts Institute of Technology
    index: 3
date: 07 December 2017
bibliography: paper.bib
---

# Summary

Repetitive elements comprise a substantial part of all eukaryotic genomes. While all species contain
these sequences, the amount of them differs widely. For example, the yeast genome contains about 3 %
repeats, Arabidopsis 14 %, human 50 % and wheat 90 % ([@kim_transposable_1998],[@the_arabidopsis_genome_initiative_analysis_2000],[@lander_initial_2001],[@clavijo_improved_2017]).
Identification of these elements is done by searching for typical structures and sequences in the genome
assembly. However, the presence of repetetive elements is a challenge for assembly algorithms, which
leads to an underrepresentation of repeats in a genome assembly. Thus, the annotation of repeat regions based
on an assembly is error prone.

To adress this challenge, we present reper, a kmer based method to detect, classify and quantify repeats
in NGS data without the need of a genome assembly.
Our pipeline samples reads with high kmer coverage (jellyfish, [@marcais_fast_2011]) from the NGS dataset. This subset is then
assembled using the transcriptome assembler Trinity ([@grabherr_full-length_2011]). This ensures that all possible variants of a repetitive
element are reported. The repeats are then clustered using cd-hit ([@li_cd-hit:_2006],[@fu_cd-hit:_2012]) to create exemplar sequences of each repeat
in the genome. The exemplars are classified based on homolgy to known repeats. Since reper was developed with
plant data, the default classification libraries are REdat ([@nussbaumer_mips_2012]) for repeats and refseq ([@oleary_reference_2016]) for chloroplast and mitochondrial
sequences. The reference database can be changed by the user to accomodate ones need. A configuration script for
the popular, but proprietary database repbase is also provided.
By using read mappings (bowtie2 and samtools, [@langmead_fast_2012] and [@li_sequence_2009]), the repeat content can then be quantified on class and cluster level. The resulting
repeat landscapes can then be analyzed by using the supplementary R scripts provided with the pipeline.

Currently reper is only able to work on paired end Illumina data. Support of long-read technologies
such as PacBio and Nanopore is in developement.

A similar approach is used by dnaPipeTE ([@goubert_novo_2015]). However it is cumbersome to install since it relies on many
dependencies including the RepeatMasker package and the proprietary repeat database repbase by giri.

The reper source code is available on github under the MIT license. For easy installation and usage, a Docker container is
also provided. Since reper is usually run in an HPC environment where users don't have root or
Docker rights, there is also a singularity image available which can be used with normal user permissions.


We are currently using reper to analyze the repeat content in multiple plant genome sequencing projects.



# Acknowledgements

We would like to thank Markus Ankenbrand and Frank Förster for valuable discussions and their support and advice on different topics like Docker and pipeline design.


# TODO

- workflow graphic?


# joss template content
- A summary describing the high-level functionality and purpose of the software
for a diverse, non-specialist audience
- A clear statement of need that illustrates the purpose of the software
- A list of key references including a link to the software archive
- Mentions (if applicable) of any ongoing research projects using the software
or recent scholarly publications enabled by it

Citations to entries in paper.bib should be in
[rMarkdown](http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html)
format.

This is an example citation [@figshare_archive].

Figures can be included like this: ![Fidgit deposited in figshare.](figshare_article.png)

# References