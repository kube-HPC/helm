#!/bin/sh
ALLDEPLOYS=$(kubectl get deploy -l metrics-group=algorithm-queue  | grep algorithm-queue | awk '{ print $1 }')
ALLJOBS=$(kubectl get jobs | grep clean-old-jobs | awk '{ print $1 }')
echo ALLJOBS=$ALLJOBS
echo ALLDEPLYS=$ALLDEPLOYS
kubectl delete deploy -l metrics-group=algorithm-queue 
kubectl delete job -l delete-group=delete-dep-and-jobs
