#!/usr/bin/env bash
# usage: ./render-movie.sh [<snapshotsDir>] [<movieFile>]

# --- config ---
MOVIE_WIDTH="1280"
MOVIE_HEIGHT="720"
MOVIE_BITRATE="8000"
USE_SYMLINKS="1"
# --- /config ---

TIMELAPSE_HOME="`dirname "$0"`"
if [ "$TIMELAPSE_HOME" = "." ]; then
	TIMELAPSE_HOME="`pwd`"
fi

SNAPSHOTS_DIR="$1"
if [ -z "$SNAPSHOTS_DIR" ]; then
	SNAPSHOTS_DIR="$TIMELAPSE_HOME/snapshots"
fi

MOVIE_FILE="$2"
if [ -z "$MOVIE_FILE" ]; then
	MOVIE_FILE="$TIMELAPSE_HOME/movie.avi"
fi

TMP_DIR="$TIMELAPSE_HOME/tmp"
mkdir -p "$TMP_DIR"

j=0
_IFS="$IFS"
IFS=$'\n'
for i in $( find "$SNAPSHOTS_DIR" -type f -name "snapshot-*.jpg" -o -name "snapshot-*.png" | sort ); do
	SRC="$SNAPSHOTS_DIR/`basename "$i"`"
	FORMAT="`basename "$i" | awk -F . '{print $NF}'`"
	REF="$TMP_DIR/`printf "%06d" "$j"`.$FORMAT"
	if [ "$USE_SYMLINKS" = "1" ]; then
		ln -sf "$SRC" "$REF"
	else
		cp "$SRC" "$REF"
	fi
	j=`expr $j + 1`
done
IFS="$_IFS"

mencoder "mf://$TMP_DIR/*.$FORMAT" -mf w=$MOVIE_WIDTH:h=$MOVIE_HEIGHT:fps=24:type=$FORMAT \
	-ovc lavc -lavcopts vcodec=mpeg4:mbd=2:trell:vbitrate=$MOVIE_BITRATE -oac copy -o "$MOVIE_FILE"

#rm -rf "$TMP_DIR"
