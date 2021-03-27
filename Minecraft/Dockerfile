FROM adoptopenjdk:13.0.2_8-jre-hotspot

ENV GAME_PORT=25565
ENV SERVER_VERSION='1.16.5'
ENV GAME_RAM=6144
ENV GAME_DATA_DIR=/minecraft_data

EXPOSE $GAME_PORT/tcp

RUN groupadd -r mcserver && \
    useradd --create-home -r -s /bin/sh -g mcserver mcserver && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget lynx && \
    mkdir -p /tmp && \
    mkdir -p $GAME_DATA_DIR && \
    chown -R mcserver:mcserver $GAME_DATA_DIR

COPY --chown=mcserver:mcserver startup.sh /tmp/startup.sh

RUN chmod 777 /tmp/startup.sh
WORKDIR $GAME_DATA_DIR
USER mcserver
VOLUME ["$GAME_DATA_DIR"]

ENTRYPOINT ["/tmp/startup.sh"]
