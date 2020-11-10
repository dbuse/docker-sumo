FROM python:3.7-buster AS builder

MAINTAINER Dominik S. Buse (buse@ccs-labs.org)
LABEL Description="Dockerised Simulation of Urban MObility (SUMO)"

ENV SUMO_VERSION 1_6_0
ENV SUMO_HOME /opt/sumo

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
    sed -i 's/endif (PROJ_FOUND)/\tadd_compile_definitions(ACCEPT_USE_OF_DEPRECATED_PROJ_API_H)\n\0/' CMakeLists.txt &&\
    mkdir build/cmake-build &&\
    cd build/cmake-build &&\
    cmake -DCMAKE_BUILD_TYPE:STRING=Release ../.. &&\
    make -j$(nproc)

FROM python:3.7-buster
MAINTAINER Dominik S. Buse (buse@ccs-labs.org)
LABEL Description="Dockerised Simulation of Urban MObility (SUMO)"

ENV SUMO_VERSION 1_6_0
ENV SUMO_HOME /opt/sumo

RUN apt-get update && apt-get -qq install \
    libgdal20 \
    libc6 \
    libfox-1.6-0 \
    libgcc1 \
    libgdal20 \
    libgl1 \
    libgl2ps1.4 \
    libglu1 \
    libproj13 \
    libstdc++6 \
    libxerces-c3.2 \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p $SUMO_HOME
COPY --from=builder $SUMO_HOME/data $SUMO_HOME/data
COPY --from=builder $SUMO_HOME/tools $SUMO_HOME/tools
COPY --from=builder $SUMO_HOME/bin $SUMO_HOME/bin

ENV PATH="$SUMO_HOME/bin:${PATH}"
