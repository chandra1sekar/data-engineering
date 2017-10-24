FROM ubuntu:xenial

#############################

## Environnement Variables ##

#############################

## set environment variables
ENV SHELL /bin/bash
ENV NB_USER science
ENV NB_UID 1000
ENV HOME /home/$NB_USER

ENV DEBIAN_FRONTEND=non-interactive
ENV LC_ALL=C
ENV LANG=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8

## expose ports for jupyter notebook and shiny server
EXPOSE 8888
EXPOSE 4000

VOLUME /home/$NB_USER

#################################

## Basic and Numeric libraries ##

#################################

COPY policy-rc.d /usr/sbin

### Install compiler and other required basic and numerical libraries
RUN apt-get update -y && \
      apt-get install build-essential -y && \
      apt-get install -y --no-install-recommends \
      apt-transport-https \
      build-essential \
      bash-completion \
      ca-certificates \
      ca-certificates \
      curl \
      curl \
      ed \
      elinks \
      gcc \
      gdebi-core \
      gfortran \
      git \
      less \
      libatlas-base-dev \
      libblas-dev \
      libcairo2-dev \
      libcurl4-openssl-dev \
      libffi-dev \
      libfreetype6 \
      libfreetype6-dev \
      libjpeg8 \
      libjpeg8-dev \
      liblapack-dev \
      libmysqlclient-dev \
      libpq-dev \
      libreadline6 \
      libreadline6-dev \
      libsqlite3-dev \
      libssl-dev \
      libssl-dev \
      libv8-dev \
      libxcb1-dev \
      libxdmcp-dev \
      libxml2-dev \
      libxml2-dev \
      libxslt1-dev \
      libxslt1-dev \
      libxt-dev \
      libxt-dev \
      links \
      links2 \
      locales \
      lynx \
      make \
      nano \
      openssl \
      pandoc \
      pandoc-citeproc \
      pkg-config \
      software-properties-common \
      sudo \
      vim \
      w3m \
      wget \
      zlib1g-dev

                                                                                                                                                                                                                                    RUN apt-get -qqy clean
                                                                                                                                                                                                                                    RUN rm -rf /var/lib/apt/lists/*



###################################

## Python data science libraries ##

###################################

## install python3.5
RUN sed -i 's/archive.ubuntu.com/mirror.us.leaseweb.net/' /etc/apt/sources.list \
      && sed -i 's/deb-src/#deb-src/' /etc/apt/sources.list \
      && apt-get update \
      && apt-get upgrade -y \
      && apt-get install -y \
      aria2 \
      build-essential \
      ca-certificates \
      python-pip \
      python3-pip \
      python3.5 \
      python3.5-dev \
      && apt-get autoremove -y \
      && apt-get clean

## make some useful symlinks that are expected to exist
RUN cd /usr/local/bin \
      && ln -s idle3 idle \
      && ln -s pydoc3 pydoc \
      && ln -s python3 python \
      && ln -s python3-config python-config

RUN pip3 install \
      beautifulsoup4 \
      bokeh \
      jupyter \
      jupyterhub \
      jupyterlab \
      matplotlib \
      networkx \
      nltk \
      notebook \
      numpy \
      pandas \
      pyzmq \
      requests \
      scikit-image \
      scikit-learn \
      scipy \
      seaborn \
      sqlalchemy \
      statsmodels \
      sympy \
      textblob


##################################

## user and configuration files ##

##################################

## create new user and homer directory
RUN useradd $NB_USER \
    && usermod -a -G sudo $NB_USER \
    && mkdir -p $HOME \
    && chown -R  $NB_USER $HOME

## copy files to working directory
WORKDIR $HOME


RUN mkdir -p /home/science
COPY entry.sh /usr/local/bin/entry.sh
RUN chmod 777 /usr/local/bin/entry.sh
ENTRYPOINT /usr/local/bin/entry.sh



COPY bash.bashrc /etc/

