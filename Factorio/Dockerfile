FROM debian:buster

ENV GAME_PORT=34197
ENV GAME_VERSION='1.1.30'

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
    chown -R facto:facto /factorio

COPY --chown=facto:facto startup.sh /tmp/startup.sh
RUN chmod 777 /tmp/startup.sh

USER facto

RUN wget -qc https://factorio.com/get-download/$GAME_VERSION/headless/linux64 -O - | tar -xJ -C /tmp && \
    ln -s "$GAME_SAVE_DIR" /tmp/factorio/saves && \
    ln -s "$GAME_MOD_DIR" /tmp/factorio/mods

VOLUME ["/factorio"]
ENTRYPOINT ["/tmp/startup.sh"]
