#!/usr/bin/env bash
mkdir -p /tmp/helm-charts
rm /tmp/helm-charts/*
helm package -d /tmp/helm-charts mini-thirdparty
git stash
git checkout --track origin/gh-pages
cp /tmp/helm-charts/mini-thirdparty-*.tgz .
helm repo index --merge ./index.yaml /tmp/helm-charts/
cp /tmp/helm-charts/index.yaml .
git add .
git commit -m "update mini-thirdparty charts"
git push
git checkout master