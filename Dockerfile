FROM r-base:4.3.2

# Install python 3

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends build-essential libpq-dev python3.8 python3-pip python3-setuptools python3-dev python3.11-venv
RUN apt-get install wget tar
ENV PYTHONPATH "${PYTHONPATH}:/app"
RUN mv /usr/lib/python3.11/EXTERNALLY-MANAGED /usr/lib/python3.11/EXTERNALLY-MANAGED.old

# Install samtools

RUN wget https://github.com/samtools/samtools/releases/download/1.18/samtools-1.18.tar.bz2
RUN tar -axf samtools-1.18.tar.bz2
WORKDIR "/samtools-1.18"
RUN ./configure --prefix=/bin/samtools-1.18/
RUN make
RUN make install
ENV PATH="${PATH}:/bin/samtools-1.18/bin/"
RUN rm -rf /samtools-1.18.tar.bz2 /samtools-1.18

WORKDIR "/"

# Install htslib

RUN wget https://github.com/samtools/htslib/releases/download/1.18/htslib-1.18.tar.bz2 
RUN tar -axf htslib-1.18.tar.bz2
WORKDIR "/htslib-1.18"
RUN ./configure --prefix=/bin/htslib-1.18
RUN make
RUN make install
ENV PATH="${PATH}:/bin/htslib-1.18/bin/"
RUN rm -rf /htslib-1.18.tar.bz2 /htslib-1.18

WORKDIR "/"

# Install bedtools

RUN apt-get install bedtools

# Install R packages

RUN install2.r \
    tidyverse \
    readxl \
    openxlsx \
    devtools \
    argparse \
    Cairo \
    docopt \
    Hmisc \
    jsonlite \
    pals \
    patchwork \
    reticulate \
    rlang \
    rjson \
    yaml

# Install python packages

RUN pip3 install ipython numpy scipy pandas
