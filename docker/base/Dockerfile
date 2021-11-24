# syntax=docker/dockerfile:1

FROM debian:stable-slim AS tcpp-base
# RUN apk update
# RUN apk add --no-cache tzdata clang cmake make gcc g++ p7zip curl
# RUN apk add --no-cache bzip2-dev boost-dev mariadb-dev mariadb-client mariadb-connector-c-dev ncurses-dev readline-dev libressl-dev
# RUN apk add --no-cache dpkg
# # RUN apk add --no-cache tzdata clang cmake make gcc g++ libmariadbclient-dev libssl-dev libbz2-dev libreadline-dev libncurses-dev libboost-all-dev mariadb-server p7zip libmariadb-client-lgpl-dev-compat curl
# # RUN dpkg install libbz2-dev libboost-all-dev libmariadbclient-dev libmariadb-client-lgpl-dev-compat libncurses-dev mariadb-server libreadline-dev libssl-dev

RUN apt-get update -y
RUN apt-get install -y --no-install-recommends git clang cmake make gcc g++ libmariadbclient-dev-compat libssl-dev libbz2-dev libreadline-dev libncurses-dev libboost-all-dev mariadb-server p7zip default-libmysqlclient-dev

RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100
RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang 100

COPY ./tcpp-repo /tcpp-repo

RUN mkdir /tcpp-build
WORKDIR /tcpp-build
RUN cmake /tcpp-repo -DCMAKE_INSTALL_PREFIX=/tcpp-server -DWITH_DYNAMIC_LINKING=ON -DSCRIPTS="dynamic"

# RUN rm -rf /tcpp-repo/build
# RUN mkdir /tcpp-repo/build
# WORKDIR /tcpp-repo/build
# RUN cmake ../ -DCMAKE_INSTALL_PREFIX=/tcpp-server -DWITH_DYNAMIC_LINKING=ON -DSCRIPTS="dynamic"
RUN make -j$(grep processor /proc/cpuinfo | wc -l) install