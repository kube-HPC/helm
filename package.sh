#!/usr/bin/env bash
CHART_VERSION=$(git describe --abbrev=0)
APP_VERSION=0.0.1
mkdir -p /tmp/helm-charts
helm package --app-version=${APP_VERSION} --version=${CHART_VERSION} -d /tmp/helm-charts hkube
helm package --app-version=${APP_VERSION} --version=${CHART_VERSION} -d /tmp/helm-charts thirdparty
git checkout gh-pages
cp /tmp/helm-charts/hkube-${CHART_VERSION}.tgz .
cp /tmp/helm-charts/thirdparty-${CHART_VERSION}.tgz .
helm repo index --merge ./index.yaml /tmp/helm-charts/
cp /tmp/helm-charts/index.yaml .