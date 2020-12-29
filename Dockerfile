FROM ubuntu:focal

MAINTAINER Brayan Camilo Riveros <camilor2611@gmail.com>

WORKDIR /home

#essentials 
RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y install apt-utils \
    && apt-get install -y software-properties-common 
    
RUN apt-get install -y wget

RUN add-apt-repository ppa:inkscape.dev/stable-0.92  \
    && apt-get -y update \
    && apt-get -y install inkscape

RUN apt-get install -y python3-pip

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1 \
    && update-alternatives  --set python /usr/bin/python3.8

RUN apt-get install -y texlive-full

#sage and sagetex
RUN apt-get install -y sagemath

RUN mkdir ../usr/share/texlive/texmf-dist/tex/latex/sagetex
COPY sty/sagetex.sty ../usr/share/texlive/texmf-dist/tex/latex/sagetex
   
#wolfram 
RUN wget https://account.wolfram.com/download/public/wolfram-engine/desktop/LINUX && bash LINUX -- -auto -verbose && rm LINUX

RUN mkdir ../usr/share/texlive/texmf-dist/tex/latex/latexalpha2
COPY sty/latexalpha2.sty ../newusr/share/texlive/texmf-dist/tex/latex/latexalpha2

#r-rstudio server
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 \
    && add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/' \
    && apt-get -y update \
    && apt-get install -y r-base \
    && apt-get install -y gdebi-core \
    && wget https://s3.amazonaws.com/rstudio-ide-build/server/bionic/amd64/rstudio-server-1.3.959-amd64.deb \
    && gdebi --non-interactive rstudio-server-1.3.959-amd64.deb \
    && rm rstudio-server-1.3.959-amd64.deb 

#git    
RUN add-apt-repository ppa:git-core/ppa \
    && apt-get -y update \
    && apt-get -y install git
    
#libraries python
RUN pip3 install Pygments \
    && pip3 install pandas \ 
    && pip3 install numpy \
    && pip3 install matplotlib \
    && pip3 install seaborn \
    && pip3 install scipy \
    && pip3 install -U scikit-learn \
    && pip3 install Django==3.1.4
    
#new user with privileges
RUN groupadd -r newuser -g 1000 && useradd -u 1000 -r -g newuser -m newuser \
    && adduser newuser sudo \
    && chmod 0440 ../etc/sudoers

#user default
USER newuser
