FROM debian:buster

# Update & Install software
RUN apt-get update && apt-get upgrade -y && apt-get install -y wget xz-utils

# Create directory for game files
RUN mkdir -p /opt

# Set Env variables
ENV GAME_PORT=34197
ENV GAME_VERSION='1.0.0'
ENV GAME_SAVE_DIR=/factorio_files/saves
ENV GAME_CONFIG_DIR=/factorio_files/config
ENV GAME_MOD_DIR=/factorio_files/mods


# Setup container variables
EXPOSE $GAME_PORT/udp
VOLUME ["/factorio_files"]

# Prepare handoff to script
RUN groupadd -r factorio
RUN useradd -r -s /bin/sh -g factorio factorio
RUN chown -R factorio:factorio /opt
COPY startup.sh /tmp/startup.sh
RUN chmod 777 /tmp/startup.sh
USER factorio

# Ready
ENTRYPOINT ["/tmp/startup.sh"]
