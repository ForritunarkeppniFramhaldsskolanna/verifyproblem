FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get clean && \
    apt-get update && \
    apt-get install -y automake \
                       g++ \
                       git \
                       libboost-all-dev \
                       libgmp-dev \
                       libgmp10 \
                       libgmpxx4ldbl \
                       pypy3 \
                       python3-minimal \
                       python3-pip \
                       python3-plastex \
                       python3-yaml \
                       rustc \
                       sudo \
                       texlive-fonts-recommended \
                       texlive-lang-cyrillic \
                       texlive-latex-extra \
                       texlive-plain-generic \
                       tidy \
                       vim

RUN pip3 install git+https://github.com/kattis/problemtools

COPY languages.yaml /usr/local/lib/python3.10/dist-packages/problemtools/config/languages.yaml
COPY entrypoint.sh /entrypoint.sh
COPY check_verifyproblem_output.py /check_verifyproblem_output.py

ENTRYPOINT ["/entrypoint.sh"]
