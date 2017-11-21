FROM ubuntu:16.04

RUN apt-get update && apt-get -y dist-upgrade && apt-get -y install wget g++ build-essential unzip libncurses5-dev zlib1g-dev libbz2-dev liblzma-dev libtbb-dev git libipc-run-perl python emacs openjdk-8-jre icedtea-8-plugin

ENV reperDir /reper
ENV depDir /dependencies

WORKDIR $reperDir
COPY reper .
COPY reper.conf .
COPY scripts/ ./scripts/
ENV PATH="$reperDir":$PATH

WORKDIR $depDir
RUN wget https://github.com/gmarcais/Jellyfish/releases/download/v2.2.6/jellyfish-2.2.6.tar.gz && tar xzf jellyfish-2.2.6.tar.gz && cd jellyfish-2.2.6 && ./configure && make && make install
RUN wget https://github.com/trinityrnaseq/trinityrnaseq/archive/Trinity-v2.4.0.tar.gz && tar xzf Trinity-v2.4.0.tar.gz
RUN wget https://github.com/weizhongli/cdhit/releases/download/V4.6.7/cd-hit-v4.6.7-2017-0501-Linux-binary.tar.gz && tar xzf cd-hit-v4.6.7-2017-0501-Linux-binary.tar.gz
RUN wget https://github.com/BenLangmead/bowtie2/releases/download/v2.3.2/bowtie2-2.3.2-linux-x86_64.zip && unzip bowtie2-2.3.2-linux-x86_64.zip
RUN wget https://github.com/samtools/samtools/releases/download/1.4.1/samtools-1.4.1.tar.bz2 && tar xjf samtools-1.4.1.tar.bz2 && cd samtools-1.4.1 && ./configure && make && make install
RUN wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.2.28/ncbi-blast-2.2.28+-x64-linux.tar.gz && tar xzf ncbi-blast-2.2.28+-x64-linux.tar.gz
RUN git clone https://github.com/thackl/kmer-scripts.git
WORKDIR $depDir/kmer-scripts/lib
RUN wget http://search.cpan.org/CPAN/authors/id/M/MS/MSCHILLI/Log-Log4perl-1.49.tar.gz && tar xzf Log-Log4perl-1.49.tar.gz && cd Log-Log4perl-1.49 && perl Makefile.PL && make && make install
RUN git clone https://github.com/BioInf-Wuerzburg/perl5lib-Fastq.git && mv perl5lib-Fastq/lib/* .
RUN git clone https://github.com/BioInf-Wuerzburg/perl5lib-Fasta.git && mv perl5lib-Fasta/lib/* .
RUN git clone https://github.com/thackl/perl5lib-Jellyfish.git && mv perl5lib-Jellyfish/lib/* .
RUN wget http://search.cpan.org/CPAN/authors/id/P/PL/PLICEASE/File-Which-1.22.tar.gz && tar xzf File-Which-1.22.tar.gz && cd File-Which-1.22 && perl Makefile.PL && make && make install
RUN git clone https://github.com/thackl/perl5lib-Kmer.git && mv perl5lib-Kmer/lib/* .
RUN git clone https://github.com/BioInf-Wuerzburg/perl5lib-Verbose.git && mv perl5lib-Verbose/lib/* .

WORKDIR $reperDir

RUN chmod -R ga+rwX $reperDir
RUN chmod -R ga+rwX $depDir

ENTRYPOINT reper help
