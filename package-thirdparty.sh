#!/usr/bin/env bash
mkdir -p /tmp/helm-charts
rm /tmp/helm-charts/*
helm package -d /tmp/helm-charts thirdparty
git stash
git checkout gh-pages
cp /tmp/helm-charts/thirdparty-*.tgz .
helm repo index --merge ./index.yaml /tmp/helm-charts/
cp /tmp/helm-charts/index.yaml .
git add .
git commit -m "update thirdparty charts"
git push
git checkout master