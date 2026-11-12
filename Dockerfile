FROM ubuntu:22.04

SHELL [ "/bin/bash","-c" ]

RUN apt update && apt install -y \
    autoconf \
    make \
    libtool \
    git \
    automake \
    libreadline-dev \
    bison \ 
    flex \
    && git clone http://git.code.sf.net/p/ngspice/ngspice \
    && cd ngspice \
    && ./compile_linux.sh \