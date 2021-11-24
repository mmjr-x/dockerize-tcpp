# syntax=docker/dockerfile:1

FROM dockerize-tcpp/tcpp-base AS tcpp-worldserver

# This is to ensure that we will not accidentally use the copied repo instead of the volume mounted one defined in the docker-compose.yml
RUN rm -rf /tcpp-repo

# WORKDIR /tcpp-server/bin
# ENTRYPOINT ["./worldserver"]

# Uncomment this if you want to just run the container indefinitely (to inspect it or something)
ENTRYPOINT ["tail"]
CMD ["-f","/dev/null"]