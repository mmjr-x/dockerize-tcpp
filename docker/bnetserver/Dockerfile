# syntax=docker/dockerfile:1

FROM dockerize-tcpp/tcpp-base AS tcpp-worldserver

# This is to ensure that we will not accidentally use the copied repo instead of the volume mounted one defined in the docker-compose.yml
RUN rm -rf /tcpp-repo

COPY ./bnetserver-base-changes.conf /
RUN touch /tcpp-server/etc/bnetserver.conf && crudini --output=/tcpp-server/etc/bnetserver.conf --merge /tcpp-server/etc/bnetserver.conf.dist < /bnetserver-base-changes.conf

COPY ./bnetserver-init.sh /
ENTRYPOINT ["/bin/bash", "/bnetserver-init.sh"]