#!/bin/bash
set -euo pipefail

if [ -n "$1" ]; then
  BRANCH="$1"
else
  BRANCH="main"
fi

set -x
zarf package create --set BRANCH="$BRANCH" --set REPOSITORY=registry.hub.docker.com/jasonish/suricata --set TAG=6.0.2 --set INTERFACE=eth0 --set SURICATA_LOG_PATH=/data/suricata --set NODE_LABEL=kubernetes.io/os --set NODE_LABEL_VALUE=linux --confirm --skip-sbom
