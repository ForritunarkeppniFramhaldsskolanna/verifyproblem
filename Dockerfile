FROM ubuntu:24.04

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
                       mono-mcs \
                       nodejs \
                       npm \
                       openjdk-21-jdk \
                       pypy3 \
                       python3-minimal \
                       python3-pip \
                       python3-plastex \
                       python3-venv \
                       python3-yaml \
                       rustc \
                       sudo \
                       swi-prolog \
                       texlive-fonts-recommended \
                       texlive-lang-cyrillic \
                       texlive-latex-extra \
                       texlive-luatex \
                       texlive-plain-generic \
                       tidy \
                       vim

RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

COPY install_problemtools /usr/bin/install_problemtools

RUN install_problemtools

COPY languages.yaml /usr/local/lib/python3.12/dist-packages/problemtools/config/languages.yaml
COPY entrypoint.sh /entrypoint.sh
COPY check_verifyproblem_output.py /check_verifyproblem_output.py

ENTRYPOINT ["/entrypoint.sh"]
