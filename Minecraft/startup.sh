#!/bin/bash

# exit when any command fails
set -e


JAR_NAME="${GAME_DATA_DIR}/server-${SERVER_VERSION}.jar"

# Check if the server exists & download if not
if [[ ! -f $JAR_NAME ]]; then
  echo "Server not found... downloading..."

  SERVER_TXT="${GAME_DATA_DIR}/server.txt"

  lynx -listonly -nonumbers -dump https://mcversions.net/download/$SERVER_VERSION | grep mojang | grep server > ${SERVER_TXT}
  cd ${GAME_DATA_DIR} && wget -i ${SERVER_TXT}
  rm ${SERVER_TXT}
  mv ${GAME_DATA_DIR}/server.jar $JAR_NAME
  chmod 777 $JAR_NAME

  echo "Server downloaded & ready..."
else
  echo "Server jar found, skipping download..."
fi

# Accept the EULA
if grep -q 'true' eula.txt
then
    echo "EULA Already Accepted :)"
else
    echo "Accepting EULA..."
    echo "eula=true" > eula.txt
fi

command="-Xms${GAME_RAM}M -Xmx${GAME_RAM}M -jar ${JAR_NAME} nogui"
echo "About to startup server with arguments: ${command}"
java $command