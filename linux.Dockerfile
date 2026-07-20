FROM lacledeslan/steamcmd AS gmod-builder

# Copy cached build files (if any)
COPY ./dist/linux/build-cache /output

# Download Garry's Mod
RUN mkdir --parents /output && \
    /app/steamcmd.sh +force_install_dir /output +login anonymous +app_update 4020 validate +quit;

COPY ./dist/linux/ll-tests /output/ll-tests


#---------------------------------
FROM debian:bookworm-slim

ARG BUILD_DATE=unspecified \
    BUILD_NODE=unspecified \
    GIT_REVISION=unspecified

ENV LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

HEALTHCHECK NONE

LABEL architecture="amd64" \
      com.lacledeslan.build-node="$BUILD_NODE" \
      maintainer="Laclede's LAN <contact@lacledeslan.com>" \
      org.opencontainers.image.created="$BUILD_DATE" \
      org.opencontainers.image.description="Garry's Mod Dedicated Server" \
      org.opencontainers.image.revision="$GIT_REVISION" \
      org.opencontainers.image.source="https://github.com/LacledesLAN/gamesvr-garrysmod" \
      org.opencontainers.image.vendor="Laclede's LAN"

RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y \
        ca-certificates lib32gcc-s1 libncurses5:i386 libstdc++6 libstdc++6:i386 locales locales-all tmux && \
    apt-get clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*;

# Set up Environment
RUN useradd --home /app --gid root --system GarrysMod && \
    mkdir --parents /app/.steam/sdk32 && \
    chown GarrysMod:root -R /app;

COPY --chown=GarrysMod:root --from=gmod-builder /output /app

RUN chmod +x /app/ll-tests/*.sh && \
    echo $'\n\nLinking steamclient.so to prevent srcds_run errors' && \
    ln -s /app/bin/steamclient.so /app/.steam/sdk32/steamclient.so

USER GarrysMod

WORKDIR /app

CMD ["/bin/bash"]

ONBUILD USER root
