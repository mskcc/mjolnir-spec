FROM r-base:4.3.2
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends build-essential libpq-dev python3.8 python3-pip python3-setuptools python3-dev
RUN apt-get install wget tar
ENV PYTHONPATH "${PYTHONPATH}:/app"

RUN wget https://github.com/samtools/samtools/releases/download/1.18/samtools-1.18.tar.bz2
RUN tar -axf samtools-1.18.tar.bz2
WORKDIR "/samtools-1.18"
RUN ./configure --prefix=/bin/samtools-1.18/
RUN make
RUN make install
ENV PATH="${PATH}:/bin/samtools-1.18/bin/"
RUN rm -rf /samtools-1.18.tar.bz2 /samtools-1.18

WORKDIR "/"
