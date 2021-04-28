#!/usr/bin/env bash
set -o xtrace
CHART_VERSION=$(git describe --abbrev=0)
APP_VERSION=$(grep systemversion hkube/values.yaml | awk -F': ' '{print $2}')
mkdir -p /tmp/helm-charts
rm /tmp/helm-charts/*
helm package --app-version=${APP_VERSION} --version=${CHART_VERSION} -d /tmp/helm-charts hkube
git checkout gh-pages
git pull
cp /tmp/helm-charts/hkube-${CHART_VERSION}.tgz .
helm repo index --merge ./index.yaml /tmp/helm-charts/
cp /tmp/helm-charts/index.yaml .
git add .
git commit -m "update charts"
git push