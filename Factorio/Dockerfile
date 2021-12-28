FROM debian:bookworm

ENV GAME_PORT=34197
ENV GAME_VERSION='1.1.50'

ENV GAME_SAVE_DIR=/factorio/saves
ENV GAME_CONFIG_DIR=/factorio/config
ENV GAME_MOD_DIR=/factorio/mods

EXPOSE $GAME_PORT/udp

RUN groupadd -r facto && \
    useradd --create-home -r -s /bin/sh -g facto facto && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget xz-utils && \
    mkdir -p /factorio && \
    chown -R facto:facto /factorio && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

COPY --chown=facto:facto startup.sh /tmp/startup.sh
RUN chmod 777 /tmp/startup.sh

USER facto

RUN mkdir -p /tmp/factorio && \
    ln -s "$GAME_SAVE_DIR" /tmp/factorio/saves && \
    ln -s "$GAME_MOD_DIR" /tmp/factorio/mods

VOLUME ["/factorio"]
ENTRYPOINT ["/tmp/startup.sh"]
