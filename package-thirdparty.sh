#!/usr/bin/env bash
mkdir -p /tmp/helm-charts
rm /tmp/helm-charts/*
CHARTS=$(find thirdparty/dependecies/* -maxdepth 0 -type d \( ! -name . \))
echo ${CHARTS}| xargs helm package -d /tmp/helm-charts
git stash
git checkout gh-pages
cp /tmp/helm-charts/*.tgz ./
helm repo index --merge ./index.yaml /tmp/helm-charts/
cp /tmp/helm-charts/index.yaml ./
git add .
git commit -m "update thirdparty charts"
git push
git checkout master