#!/bin/bash

BASE_DIR=/opt/pentaho/kettle/etl/headlines_etl
OUTPUT_DIR=$BASE_DIR/output/
REMOTE_OUTPUT_DIR=/var/www/protected/headline/data
LOG_FILE=$BASE_DIR/hif_export.log

# This should be a symlink to the desired kettle version
KETTLE_DIR=$BASE_DIR/kettle

KETTLE_JOB=$BASE_DIR/run_and_transfer_hif_export.kjb

VERS=$BASE_DIR/fx_versions.txt

VC=$(head -1 $VERS)
VP1=$(head -2 $VERS | tail -1)
VP2=$(head -3 $VERS | tail -1)
VP3=$(head -4 $VERS | tail -1)

cd "$KETTLE_DIR"

./kitchen.sh -file "$KETTLE_JOB" -param:OUTPUT_DIR="$OUTPUT_DIR" -param:REMOTE_OUTPUT_DIR="$REMOTE_OUTPUT_DIR" \
   -param:V.C=$VC -param:V.P1=$VP1 -param:V.P2=$VP2 -param:V.P3=$VP3 > "$LOG_FILE"

grep -i exception "$LOG_FILE"
