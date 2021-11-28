# syntax=docker/dockerfile:1

FROM debian:stable-slim AS tcpp-base
ARG TCPP_REPO=https://github.com/The-Cataclysm-Preservation-Project/TrinityCore.git
ARG TCPP_BRANCH
ARG TCPP_UPSTREAM

RUN apt-get update -y \
  # Install and setup all tcpp build dependencies ( https://trinitycore.atlassian.net/wiki/spaces/tc/pages/10977288/Linux+Requirements )
  && apt-get install -y --no-install-recommends git clang cmake make gcc g++ libmariadbclient-dev-compat libssl-dev libbz2-dev libreadline-dev libncurses-dev libboost-all-dev mariadb-server p7zip default-libmysqlclient-dev \
  && update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100 \
  && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang 100 \
  && apt-get clean -y \
  \
  # Fix the certificates and clone the tcpp repo ( https://stackoverflow.com/a/69394518/13620003 )
  && apt-get install -y --no-install-recommends ca-certificates \
  && apt-get clean -y \
  && update-ca-certificates \
  && git clone $([ -z "${TCPP_BRANCH}" ] || echo "-b ${TCPP_BRANCH}") $TCPP_REPO /tcpp-repo \
  && [ -z "${TCPP_UPSTREAM}" ] || git -C /tcpp-repo remote add upstream ${TCPP_UPSTREAM} \
  # && if [ ! -z "${TCPP_UPSTREAM}" ] ; then cd /tcpp-repo && git remote add upstream ${TCPP_UPSTREAM} ; fi \
  \
  # Build and install tcpp ( https://trinitycore.atlassian.net/wiki/spaces/tc/pages/10977309/Linux+Core+Installation )
  && mkdir /tcpp-repo/build \
  && cd /tcpp-repo/build \
  # Build using make
  && cmake ../ -DCMAKE_INSTALL_PREFIX=/tcpp-server -DWITH_DYNAMIC_LINKING=ON -DSCRIPTS="dynamic" \
  && make -j$(grep processor /proc/cpuinfo | wc -l) install
  # # Alternatively build using ninja (experimental)
  # && apt-get install -y --no-install-recommends ninja-build \
  # && apt-get clean -y \
  # && cmake ../ -G Ninja -DCMAKE_INSTALL_PREFIX=/tcpp-server -DWITH_DYNAMIC_LINKING=ON -DSCRIPTS="dynamic" \
  # && ninja -j$(grep processor /proc/cpuinfo | wc -l) install

# Copy and unpack the TDB release
COPY ./tcpp-tdb/ /tcpp-server/bin
RUN cd /tcpp-server/bin \
  && TDB_FILENAME="$(ls *TDB_full_434.*.7z)" \
  && 7zr x $TDB_FILENAME \
  && rm $TDB_FILENAME \
  \
  && apt-get install -y --no-install-recommends crudini \
  && apt-get clean -y