FROM amazoncorretto:17-alpine

ENV GAME_PORT=25565
ENV SERVER_VERSION='1.18.1'
ENV GAME_RAM=6144
ENV GAME_DATA_DIR=/minecraft_data

EXPOSE $GAME_PORT/tcp

RUN addgroup -S mcserver && \
    adduser -h /home/mcserver -D -S -G mcserver mcserver && \
    apk update && \
    apk upgrade && \
    apk add wget lynx && \
    mkdir -p /tmp && \
    mkdir -p $GAME_DATA_DIR && \
    chown -R mcserver:mcserver $GAME_DATA_DIR

COPY --chown=mcserver:mcserver startup.sh /tmp/startup.sh

RUN chmod 777 /tmp/startup.sh
WORKDIR $GAME_DATA_DIR
USER mcserver
VOLUME ["$GAME_DATA_DIR"]

ENTRYPOINT ["/tmp/startup.sh"]
