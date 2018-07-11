#!/bin/sh
ALLDEPLOYS=$(kubectl get deploy -l metrics-group=algorithm-queue  | grep algorithm-queue | awk '{ print $1 }')
ALLJOBS=$(kubectl get jobs | grep clean-old-jobs | awk '{ print $1 }')
echo ALLJOBS=$ALLJOBS
echo ALLDEPLYS=$ALLDEPLOYS
kubectl get deploy -l metrics-group=algorithm-queue  | grep algorithm-queue | awk '{ print $1 }'
kubectl delete jobs | grep clean-old-jobs | awk '{ print $1 }'