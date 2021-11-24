# syntax=docker/dockerfile:1

FROM dockerize-tcpp/tcpp-base AS tcpp-worldserver

# WORKDIR /server/bin
# ENTRYPOINT ["./worldserver"]

# Uncomment this if you want to just run the container indefinitely (to inspect it or something)
ENTRYPOINT ["tail"]
CMD ["-f","/dev/null"]