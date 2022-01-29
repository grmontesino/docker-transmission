#!/bin/sh

# cfg_set(): Configure a simple setting on settings.json
cfg_set() {
  local CFG_NAME=$1
  local CFG_VALUE=$2
  local CFG_FILE="$TRANSMISSION_HOME/settings.json"
  local REGEX="^(\s*\"$CFG_NAME\"\s*:\s*)(\".*\"|\w*)(,)?"

  echo "* Setting $CFG_NAME to $CFG_VALUE..."

  if [ ! -f $CFG_FILE ]; then
    echo "{" > $CFG_FILE
    echo "\"$CFG_NAME\": $CFG_VALUE" >> $CFG_FILE
    echo "}" >> $CFG_FILE

  elif grep -q -E $REGEX $CFG_FILE; then
    sed -i -E "s/$REGEX/\1$CFG_VALUE\3/g" $CFG_FILE

  else
    sed -i "1a \"$CFG_NAME\": $CFG_VALUE," $CFG_FILE
  fi
}

# cfg_toogle_set(): Configure a setting composed of two values: a boolean
# enable/disable toogle and a value
cfg_toogle_set(){
  local BOOL_NAME=$1
  local CFG_NAME=$2
  local CFG_VALUE=$3

  if [ "$CFG_VALUE" == "0" -o "$CFG_VALUE" == "false" ]; then
    cfg_set "$BOOL_NAME" "false"

  else
    cfg_set "$BOOL_NAME" "true"
    cfg_set "$CFG_NAME" "$CFG_VALUE"
  fi
}

if [ "$1" == "transmission-daemon" ]; then

  # Command line options
  [ -n "$ALLOWED" ] && EXTRA_ARGS="$EXTRA_ARGS -a $ALLOWED"
  [ -n "$PEER_LIMIT_GLOBAL" ] && EXTRA_ARGS="$EXTRA_ARGS -L $PEER_LIMIT_GLOBAL"
  [ -n "$PEER_LIMIT_TORRENT" ] && \
    EXTRA_ARGS="$EXTRA_ARGS -l $PEER_LIMIT_TORRENT"

  # Config file simple options
  [ -n "$CACHE_SIZE_MB" ] && cfg_set "cache-size-mb" "$CACHE_SIZE_MB"
  [ -n "$PORT_FORWARDING" ] && cfg_set \
    "port-forwarding-enabled" "$PORT_FORWARDING"
  [ -n "$RPC_HOST_WHITELIST" ] && cfg_set "rpc-host-whitelist" \
    "\"$RPC_HOST_WHITELIST\""

  # Config file toogle options
  [ -n "$SPEED_LIMIT_DOWN" ] && cfg_toogle_set \
    "speed-limit-down-enabled" "speed-limit-down" "$SPEED_LIMIT_DOWN"
  [ -n "$SPEED_LIMIT_UP" ] && cfg_toogle_set \
    "speed-limit-up-enabled" "speed-limit-up" "$SPEED_LIMIT_UP"
  [ -n "$DOWNLOAD_QUEUE " ] && cfg_toogle_set \
    "download-queue-enabled" "download-queue-size" "$DOWNLOAD_QUEUE"
  [ -n "$SEED_QUEUE" ] && cfg_toogle_set \
    "seed-queue-enabled" "seed-queue-size" "$SEED_QUEUE"

  echo "* $@ $EXTRA_ARGS"
  exec $@ $EXTRA_ARGS
else
  echo "* $@"
  exec $@
fi
