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

RUN mkdir /usr/share/texlive/texmf-dist/tex/latex/sagetex
COPY sty/sagetex.sty usr/share/texlive/texmf-dist/tex/latex/sagetex

#libraries python
RUN pip3 install Pygments \
    && pip3 install pandas \ 
    && pip3 install numpy \
    && pip3 install matplotlib \
    && pip3 install seaborn \
    && pip3 install scipy \
    && pip3 install -U scikit-learn 

#new user without privileges
RUN groupadd -r newuser -g 1000 && useradd -u 1000 -r -g newuser -m -d /opt/newuser -s /sbin/nologin -c "NewUser" newuser && \
    chmod 755 /opt/newuser

#user default
USER newuser
