# escape=`
FROM lacledeslan/steamcmd AS gmod-builder

# Copy cached build files (if any)
COPY ./dist/linux/build-cache /output

# Download Garry's Mod
RUN /app/steamcmd.sh +force_install_dir /output +login anonymous +app_update 4020 validate +quit;

COPY ./dist/linux/ll-tests /output/ll-tests

#=======================================================================
FROM debian:bookworm-slim

ARG BUILDNODE=unspecified
ARG SOURCE_COMMIT=unspecified

HEALTHCHECK NONE

RUN dpkg --add-architecture i386 &&`
    apt-get update && apt-get install -y `
        ca-certificates lib32gcc-s1 libncurses5:i386 libstdc++6 libstdc++6:i386 locales locales-all tmux &&`
    apt-get clean &&`
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*;

ENV LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

LABEL com.lacledeslan.build-node=$BUILDNODE `
      org.label-schema.schema-version="1.0" `
      org.label-schema.url="https://github.com/LacledesLAN/README.1ST" `
      org.label-schema.vcs-ref=$SOURCE_COMMIT `
      org.label-schema.vendor="Laclede's LAN" `
      org.label-schema.description="Garry's Mod Dedicated Server" `
      org.label-schema.vcs-url="https://github.com/LacledesLAN/gamesvr-garrysmod"

# Set up Environment
RUN useradd --home /app --gid root --system GarrysMod &&`
    mkdir --parents /app/.steam/sdk32 &&`
    chown GarrysMod:root -R /app;

COPY --chown=GarrysMod:root --from=gmod-builder /output /app

RUN chmod +x /app/ll-tests/*.sh &&`
    echo $'\n\nLinking steamclient.so to prevent srcds_run errors' &&`
    ln -s /app/bin/steamclient.so /app/.steam/sdk32/steamclient.so

USER GarrysMod

WORKDIR /app

CMD ["/bin/bash"]

ONBUILD USER root
