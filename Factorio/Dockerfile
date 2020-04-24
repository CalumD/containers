FROM debian:buster

# Update & Install software
RUN apt-get update
RUN apt-get upgrade
RUN apt-get install -y wget xz-utils

# Create directory for game files
RUN mkdir -p /opt

# Set Env variables
ENV GAME_PORT=34197
ENV GAME_VERSION='0.18.21'
ENV GAME_SAVE_DIR=/factorio_files/saves
ENV GAME_CONFIG_DIR=/factorio_files/config

# Get the game
RUN wget -qc https://factorio.com/get-download/$GAME_VERSION/headless/linux64 -O - | tar -xJ -C /opt
RUN chmod 777 /opt/factorio

# Setup container variables
EXPOSE $GAME_PORT/udp
VOLUME ["/factorio_files"]
RUN ln -s "$GAME_SAVE_DIR" /opt/factorio/saves

# Prepare handoff to script
RUN groupadd -r factorio
RUN useradd -r -s /bin/sh -g factorio factorio
RUN chown -R factorio:factorio /opt/factorio
COPY startup.sh /tmp/startup.sh
RUN chmod 777 /tmp/startup.sh
USER factorio

# Ready
ENTRYPOINT ["/tmp/startup.sh"]
