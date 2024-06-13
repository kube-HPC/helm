#!/bin/bash

# This script is used for updating a third party into the hkube charts.
# Make sure you have updated the required version in the chart.yaml file (in thirdparty).
# Also make sure you have updated the required version in the requirements.lock and requirements.yaml files (in hkube).

set -e

THIRD_PARTY_DIR="/home/$USER/dev/hkube/helm/thirdparty/dependecies/"
CHARTS_DIR="/home/$USER/dev/hkube/helm/hkube/charts/"

cd "$THIRD_PARTY_DIR"

echo "Third party folders:"
ls -d */ | sed 's#/##'
echo 
echo -n "Enter the helm chart name you want to pack: "
read folder

helm package $folder -d $CHARTS_DIR
echo
echo "To apply the changes into helm, run: helm upgrade hkube /home/$USER/dev/hkube/helm/hkube"