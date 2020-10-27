#!/usr/bin/env bash
set -o xtrace
helm lint hkube/
CHART_VERSION=$(git describe --abbrev=0)
APP_VERSION=$(grep systemversion hkube/values.yaml | awk -F': ' '{print $2}')
mkdir -p /tmp/helm-charts
rm -rf /tmp/helm-charts/*
helm dependency update hkube
helm package --app-version=${APP_VERSION} --version=${APP_VERSION} -d /tmp/helm-charts hkube
git stash
git checkout gh-pages
cp /tmp/helm-charts/hkube-${APP_VERSION}.tgz ./
helm repo index --merge ./index.yaml /tmp/helm-charts/
cp /tmp/helm-charts/index.yaml ./
git add .
git commit -m "update charts"
git push
