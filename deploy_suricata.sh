#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

pushd $SCRIPT_DIR > /dev/null

rm -f suricata-*.tgz
sudo rm -rf /opt/suricata/*

sudo mkdir -p /opt/suricata/logs
sudo mkdir -p /opt/suricata/pcaps
sudo mkdir -p /opt/suricata/rules

sudo cp suricata_rules/cpsenergy.rules /opt/suricata/rules/suricata.rules
helm uninstall suricata -n suricata

helm package chart
helm install suricata suricata-0.1.5.tgz -n suricata

popd > /dev/null