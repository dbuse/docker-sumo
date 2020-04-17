FROM python:3.8-buster

MAINTAINER Dominik S. Buse (buse@ccs-labs.org)
LABEL Description="Dockerised Simulation of Urban MObility (SUMO)"

ENV SUMO_VERSION 1_1_0
ENV SUMO_HOME /opt/sumo
ENV SUMO_USER your_username

# Install system dependencies.
RUN apt-get update && apt-get -qq install \
    wget \
    g++ \
    make \
    cmake \
    libxerces-c-dev \
    libfox-1.6-0 libfox-1.6-dev \
    libgdal-dev \
    libproj-dev \
    python2.7 \
    && rm -rf /var/lib/apt/lists/*

# Download and extract source code
RUN cd /tmp &&\
    wget -q -O /tmp/sumo.tar.gz https://github.com/eclipse/sumo/archive/v$SUMO_VERSION.tar.gz &&\
    tar xzf sumo.tar.gz && \
    mv sumo-$SUMO_VERSION $SUMO_HOME && \
    rm sumo.tar.gz

# Configure and build from source.
RUN cd $SUMO_HOME &&\
    ls  -l &&\
    mkdir build/cmake-build &&\
    cd build/cmake-build &&\
    cmake ../.. &&\
    make -j$(nproc) &&\
    make install

# CMD sumo-gui
