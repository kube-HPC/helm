#!/usr/bin/env bash
set -o xtrace
APP_VERSION=$(grep systemversion hkube/values.yaml | awk -F': ' '{print $2}')
mkdir -p /tmp/helm-charts
rm /tmp/helm-charts/*
helm package --app-version=${APP_VERSION} --version=${APP_VERSION} -d /tmp/helm-charts hkube
git checkout gh-pages
cp /tmp/helm-charts/hkube-${APP_VERSION}.tgz .
helm repo index --merge ./index.yaml /tmp/helm-charts/
cp /tmp/helm-charts/index.yaml .
git add .
git commit -m "update charts"
git push