#!/usr/bin/env bash
mkdir -p /tmp/helm-charts
rm /tmp/helm-charts/*
helm package -d /tmp/helm-charts thirdparty/thirdparty
git stash
git checkout gh-pages
cp /tmp/helm-charts/thirdparty-*.tgz ./dev
helm repo index --merge ./dev/index.yaml /tmp/helm-charts/
cp /tmp/helm-charts/index.yaml ./dev
git add .
git commit -m "update thirdparty charts"
git push
git checkout master