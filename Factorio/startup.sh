#!/bin/bash

mkdir -p $GAME_CONFIG_DIR
mkdir -p $GAME_SAVE_DIR

# Get the game
wget -qc https://factorio.com/get-download/$GAME_VERSION/headless/linux64 -O - | tar -xJ -C /opt
ln -s "$GAME_SAVE_DIR" /opt/factorio/saves

# Check files exist.
if [[ ! -f $GAME_CONFIG_DIR/server-settings.json ]]; then
  cp /opt/factorio/data/server-settings.example.json "$GAME_CONFIG_DIR/server-settings.json"
fi

if [[ ! -f $GAME_CONFIG_DIR/server-adminlist.json ]]; then
  touch "$GAME_CONFIG_DIR/server-adminlist.json"
fi

# Delete incomplete saves (such as after a forced exit)
INCOMPLETE_SAVES=$( find -L "$GAME_SAVE_DIR" -iname \*.tmp.zip -mindepth 1 | wc -l )
if [[ $INCOMPLETE_SAVES -gt 0 ]]; then
  rm -f "$GAME_SAVE_DIR"/*.tmp.zip
fi

# Run the Game
exec /opt/factorio/bin/x64/factorio \
  --port "$GAME_PORT" \
  --server-settings "$GAME_CONFIG_DIR/server-settings.json" \
  --server-adminlist "$GAME_CONFIG_DIR/server-adminlist.json" \
  --console-log "$GAME_CONFIG_DIR/serverlog.log" \
  --server-id "$GAME_CONFIG_DIR/serverID.json" \
  --start-server-load-latest



