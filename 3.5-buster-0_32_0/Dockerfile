FROM python:3.5-buster

MAINTAINER Dominik S. Buse (buse@ccs-labs.org)
LABEL Description="Dockerised Simulation of Urban MObility (SUMO)"

ENV SUMO_VERSION 0_32_0
ENV SUMO_HOME /opt/sumo

# TODO: use separate container for build

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

# Add patch for sumo error with recent versions of c++ compilers
COPY patch-sumo-0.32.0-ComparatorIdLess.txt /tmp/patch-sumo-0.32.0-ComparatorIdLess.txt

# Configure and build from source.
RUN cd $SUMO_HOME &&\
    patch -p1 < /tmp/patch-sumo-0.32.0-ComparatorIdLess.txt &&\
    sed -i 's/endif (PROJ_FOUND)/\tadd_compile_definitions(ACCEPT_USE_OF_DEPRECATED_PROJ_API_H)\n\0/' CMakeLists.txt &&\
    mkdir build/cmake-build &&\
    cd build/cmake-build &&\
    cmake -DCMAKE_BUILD_TYPE:STRING=Release ../.. &&\
    make -j$(nproc)

# Make install is not supported by sumo 0.32.0, so we have to "install" manually by adapting the PATH
ENV PATH="/$SUMO_HOME/bin:${PATH}"

# CMD sumo-gui
