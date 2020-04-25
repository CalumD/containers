FROM adoptopenjdk/openjdk13:jre-13.0.2_8

# Update & Install software
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y wget lynx

# Set Env variables
ENV GAME_PORT=25565
ENV GAME_DATA_DIR=/minecraft_data
ENV GAME_RAM=6144
ENV SERVER_VERSION='1.15.2'

# Create directory for game files
RUN mkdir -p /tmp
RUN mkdir -p $GAME_DATA_DIR

# Setup container variables
EXPOSE $GAME_PORT/tcp
VOLUME ["$GAME_DATA_DIR"]

# Prepare handoff to script
RUN groupadd -r mcserver
RUN useradd -r -s /bin/sh -g mcserver mcserver
RUN chown -R mcserver:mcserver $GAME_DATA_DIR
COPY startup.sh /tmp/startup.sh
RUN chmod 777 /tmp/startup.sh
WORKDIR $GAME_DATA_DIR
USER mcserver

# Ready
ENTRYPOINT ["/tmp/startup.sh"]
