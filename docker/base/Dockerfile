# syntax=docker/dockerfile:1

FROM debian:stable-slim AS tcpp-base
# RUN apk update
# RUN apk add --no-cache tzdata clang cmake make gcc g++ p7zip curl
# RUN apk add --no-cache bzip2-dev boost-dev mariadb-dev mariadb-client mariadb-connector-c-dev ncurses-dev readline-dev libressl-dev
# RUN apk add --no-cache dpkg
# # RUN apk add --no-cache tzdata clang cmake make gcc g++ libmariadbclient-dev libssl-dev libbz2-dev libreadline-dev libncurses-dev libboost-all-dev mariadb-server p7zip libmariadb-client-lgpl-dev-compat curl
# # RUN dpkg install libbz2-dev libboost-all-dev libmariadbclient-dev libmariadb-client-lgpl-dev-compat libncurses-dev mariadb-server libreadline-dev libssl-dev

RUN apt-get update -y \
  && apt-get install -y --no-install-recommends git clang cmake make gcc g++ libmariadbclient-dev-compat libssl-dev libbz2-dev libreadline-dev libncurses-dev libboost-all-dev mariadb-server p7zip default-libmysqlclient-dev \
  && update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100 \
  && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang 100

COPY ./tcpp-repo /tcpp-repo

# RUN mkdir /tcpp-build
# WORKDIR /tcpp-build
RUN mkdir /tcpp-build \
  && cd /tcpp-build \
  && cmake /tcpp-repo -DCMAKE_INSTALL_PREFIX=/tcpp-server -DWITH_DYNAMIC_LINKING=ON -DSCRIPTS="dynamic" \
  && make -j$(grep processor /proc/cpuinfo | wc -l) install

COPY ./tcpp-tdb/ /tcpp-server/bin
# WORKDIR /tcpp-server/bin
RUN cd /tcpp-server/bin \
  && TDB_FILENAME="$(ls *TDB_full_434.*.7z)" \
  && 7zr x $TDB_FILENAME \
  && rm $TDB_FILENAME
# RUN 7zr x "$(ls *TDB_full_434.*.7z)"
# RUN rm TDB_full_434.21071_2021_07_06.7z

RUN apt-get install -y --no-install-recommends crudini