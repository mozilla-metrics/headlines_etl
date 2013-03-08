#!/bin/bash

BASE_DIR=/opt/pentaho/kettle/etl/headlines_etl
OUTPUT_DIR=$BASE_DIR/output/
REMOTE_OUTPUT_DIR=/var/www/protected/headline/data
PUB_OUTPUT_DIR=/var/www/html/data
LOG_FILE=$BASE_DIR/hif_export.log

# This should be a symlink to the desired kettle version
KETTLE_DIR=$BASE_DIR/kettle

KETTLE_JOB=$BASE_DIR/run_and_transfer_hif_export.kjb

cd "$KETTLE_DIR"

./kitchen.sh -file "$KETTLE_JOB" \
   -param:OUTPUT_DIR="$OUTPUT_DIR" \
   -param:REMOTE_OUTPUT_DIR="$REMOTE_OUTPUT_DIR" \
   -param:PUB_OUTPUT_DIR="$PUB_OUTPUT_DIR" > "$LOG_FILE"

grep -i exception "$LOG_FILE"
