#!/usr/bin/env bash
set -o pipefail
# helm lint hkube/
CHART_VERSION=$(git describe --abbrev=0)
VALUES_YAML_PATH=hkube/values.yaml NEW_VALUES_YAML_PATH=hkube/values.yaml ./version-updater
APP_VERSION=$(grep systemversion hkube/values.yaml | awk -F': ' '{print $2}')
mkdir -p /tmp/helm-charts
helm dependency update hkube
helm package --app-version=${APP_VERSION} --version=${CHART_VERSION} -d /tmp/helm-charts hkube
git stash
git remote -v
git fetch
git checkout -b gh-pages origin/gh-pages
cp /tmp/helm-charts/hkube-${CHART_VERSION}.tgz ./dev
helm repo index --merge ./dev/index.yaml /tmp/helm-charts/
cp /tmp/helm-charts/index.yaml ./dev
git add .
git commit -m "update charts"
git push
git checkout $BRANCH
git stash apply
echo git add hkube/values.yaml
git add hkube/values.yaml
echo git commit -m "update version to ${CHART_VERSION} [skip ci]"
git commit -m "update version to ${CHART_VERSION} [skip ci]"
git pull --no-commit
git commit -m "merge from $BRANCH [skip ci]"
git push