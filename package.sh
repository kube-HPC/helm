#!/usr/bin/env bash
CHART_VERSION=$(git describe --abbrev=0)
APP_VERSION=0.0.1
mkdir -p /tmp/helm-charts
helm package --app-version=${APP_VERSION} --version=${CHART_VERSION} -d /tmp/helm-charts hkube
helm package --app-version=${APP_VERSION} --version=${CHART_VERSION} -d /tmp/helm-charts thirdparty
