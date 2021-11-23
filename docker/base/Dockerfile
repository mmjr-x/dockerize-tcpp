# syntax=docker/dockerfile:1

FROM alpine AS tcpp-base
RUN apk add --no-cache tzdata clang cmake make gcc g++ libmariadbclient-dev libssl-dev libbz2-dev libreadline-dev libncurses-dev libboost-all-dev mariadb-server p7zip libmariadb-client-lgpl-dev-compat curl

RUN apk add --no-cache dpkg
RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100
RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang 100

RUN rm -rf /tcpp-repo/build
RUN mkdir /tcpp-repo/build
WORKDIR /tcpp-repo/build
RUN cmake ../ -DCMAKE_INSTALL_PREFIX=/server -DWITH_DYNAMIC_LINKING=ON -DSCRIPTS="dynamic"
RUN make -j$(grep processor /proc/cpuinfo | wc -l) install
WORKDIR /server/bin