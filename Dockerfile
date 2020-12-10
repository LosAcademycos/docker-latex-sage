FROM ubuntu:focal

MAINTAINER Brayan Riveros <camilor2611@gmail.com>

WORKDIR /home

RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y install apt-utils \
    && apt-get install -y software-properties-common 
    
RUN apt-get install -y wget

RUN add-apt-repository ppa:inkscape.dev/stable-0.92  \
    && apt-get -y update \
    && apt-get -y install inkscape

RUN apt-get install -y python3-pip

RUN pip3 install Pygments
RUN pip3 install pandas
RUN pip3 install numpy
RUN pip3 install matplotlib
RUN pip3 install seaborn
RUN pip3 install scipy
RUN pip3 install -U scikit-learn

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1 \
    && update-alternatives  --set python /usr/bin/python3.8

RUN apt-get install -y texlive-full

RUN apt-get install -y sagemath
