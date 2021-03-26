#!/bin/bash

mkdir -p $GAME_SAVE_DIR
mkdir -p $GAME_CONFIG_DIR
mkdir -p $GAME_MOD_DIR

# Get the game
wget -qc https://factorio.com/get-download/$GAME_VERSION/headless/linux64 -O - | tar -xJ -C /tmp
ln -s "$GAME_SAVE_DIR" /tmp/factorio/saves
ln -s "$GAME_MOD_DIR" /tmp/factorio/mods

# Check files exist.
if [[ ! -f $GAME_CONFIG_DIR/server-settings.json ]]; then
  cp /tmp/factorio/data/server-settings.example.json "$GAME_CONFIG_DIR/server-settings.json"
fi

if [[ ! -f $GAME_CONFIG_DIR/map-gen-settings.json ]]; then
  cp /tmp/factorio/data/map-gen-settings.example.json "$GAME_CONFIG_DIR/map-gen-settings.json"
fi

if [[ ! -f $GAME_CONFIG_DIR/map-settings.json ]]; then
  cp /tmp/factorio/data/map-settings.example.json "$GAME_CONFIG_DIR/map-settings.json"
fi

if [[ ! -f $GAME_CONFIG_DIR/server-adminlist.json ]]; then
  echo "[]" >"$GAME_CONFIG_DIR/server-adminlist.json"
fi

if [[ ! -f $GAME_CONFIG_DIR/server-banlist.json ]]; then
  echo "[]" >"$GAME_CONFIG_DIR/server-banlist.json"
fi

# Delete incomplete saves (such as after a forced exit)
INCOMPLETE_SAVES=$(find -L "$GAME_SAVE_DIR" -mindepth 1 -iname \*.tmp.zip | wc -l)
if [[ $INCOMPLETE_SAVES -gt 0 ]]; then
  rm -f "$GAME_SAVE_DIR"/*.tmp.zip
fi

TOTAL_SAVES=$(find -L "$GAME_SAVE_DIR" -mindepth 1 -iname \*.zip | wc -l)
if [[ $TOTAL_SAVES == 0 ]]; then
  /tmp/factorio/bin/x64/factorio \
    --create "$GAME_SAVE_DIR/_autosave1.zip" \
    --map-gen-settings "$GAME_CONFIG_DIR/map-gen-settings.json" \
    --map-settings "$GAME_CONFIG_DIR/map-settings.json"
fi

## Run the Game
exec /tmp/factorio/bin/x64/factorio \
  --port "$GAME_PORT" \
  --server-settings "$GAME_CONFIG_DIR/server-settings.json" \
  --server-banlist "$GAME_CONFIG_DIR/server-banlist.json" \
  --server-adminlist "$GAME_CONFIG_DIR/server-adminlist.json" \
  --console-log "$GAME_CONFIG_DIR/serverlog.log" \
  --server-id "$GAME_CONFIG_DIR/serverID.json" \
  --start-server-load-latest

#/bin/bash
