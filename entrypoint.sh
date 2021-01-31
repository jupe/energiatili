#!/bin/sh

set -e

export ENERGIATILI_USERNAME="username"
export ENERGIATILI_PASSWORD="password"
export INFLUXDB_URL="http://localhost:8080"
export INFLUXDB_DB="energiatili"
echo "generating config file"
envsubst < energiatili.tmpl > energiatili.toml

energiatili-import >> data.json
echo data.json
cat data.json >> influxdb-export
