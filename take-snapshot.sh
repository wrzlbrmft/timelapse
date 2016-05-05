#!/usr/bin/env bash
# usage: ./take-snapshot.sh [<device>] [<snapshotsDir>]

# --- config ---
RESOLUTION="1280x720"
TIMESTAMP="%Y-%m-%d %H:%M"
TIMESTAMP_POSITION="bottom" # top or bottom
TIMESTAMP_FONT="sans" # sans or serif
TIMESTAMP_SIZE="16"
TIMESTAMP_COLOR="#00FFFFFF" # #AARRGGBB (Alpha, Red, Green, Blue)
FORMAT="jpg" # jpg or png
QUALITY="95" # jpg: 0-95, png: 0-9 (the higher the better)
# --- /config ---

TIMELAPSE_HOME="`dirname "$0"`"
if [ "$TIMELAPSE_HOME" = "." ]; then
	TIMELAPSE_HOME="`pwd`"
fi

DEVICE="$1"
if [ -z "$DEVICE" ]; then
	DEVICE="/dev/video0"
fi

SNAPSHOTS_DIR="$2"
if [ -z "$SNAPSHOTS_DIR" ]; then
	SNAPSHOTS_DIR="$TIMELAPSE_HOME/snapshots"
fi

# fswebcam uses --jpeg for the jpg format
FORMAT_ARG="$FORMAT"
if [ "$FORMAT_ARG" = "jpg" ]; then
	FORMAT_ARG="jpeg"
fi

mkdir -p "$SNAPSHOTS_DIR"

fswebcam --quiet --device "$DEVICE" --resolution "$RESOLUTION" \
	--$TIMESTAMP_POSITION-banner --banner-colour "#FF000000" --line-colour "#FF000000" \
	--font "$TIMESTAMP_FONT:$TIMESTAMP_SIZE" --text-colour "$TIMESTAMP_COLOR" --no-shadow \
	--timestamp "$TIMESTAMP" \
	--$FORMAT_ARG $QUALITY \
	"$SNAPSHOTS_DIR/snapshot-`date +%Y-%m-%d-%H-%M`.$FORMAT"
