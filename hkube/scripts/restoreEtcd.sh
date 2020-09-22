#!/bin/bash

function wait-etcd-down()
{
    PODS=$(kubectl get po -l etcd_cluster=etcd  --no-headers)
    if [[ -n ${PODS} ]]; then
      echo -n Waiting for etcd pods to go down
      while true; do
        PODS=$(kubectl get po -l etcd_cluster=etcd  --no-headers)
        if [[ -z "${PODS}" ]]; then
          break
        fi
        sleep 1
        echo -n '.'
      done
    fi
}

function wait-etcd-up()
{
    DESIRED_COUNT=${1:-3}
    echo Waiting for ${DESIRED_COUNT} etcd pods
   
    while true; do
      PODS=$(kubectl get po -l etcd_cluster=etcd  --no-headers|grep Running| wc -l)
      echo -ne "has ${PODS} running etcd pods\033[0K\r"
      if [[ ${PODS} = ${DESIRED_COUNT} ]]; then
        break
      fi
        sleep 1
    done
    echo OK

}

command -v jq >/dev/null 2>&1
HAS_JQ=$?
set -e
if [[ ${HAS_JQ} != 0 ]]
then
    echo This script need 'jq' to run.
    echo Install using: 
    echo "    sudo apt install jq"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi
TMP_FILE=$(mktemp).json
echo write current cluster to ${TMP_FILE}
kubectl get EtcdCluster etcd -o json |\
  jq 'del('.status', .metadata["resourceVersion", "selfLink", "uid", "creationTimestamp", "generation"],.metadata.annotations["kubectl.kubernetes.io/last-applied-configuration"])' > ${TMP_FILE}
echo current etcd pods
kubectl get po -l etcd_cluster=etcd -o custom-columns=NAME:.metadata.name,STATUS:.status.phase --no-headers
echo deleting etcd cluster.
read -p "Are you sure? [y/n]" -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo Canceled. No harm done
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi
echo proceeding
kubectl delete EtcdCluster etcd
wait-etcd-down
# kubectl apply -f /tmp/tmp.eOlxn4lSU0.yaml
kubectl apply -f ${TMP_FILE}
wait-etcd-up
echo deleting the following hkube pods for quicker recovery
kubectl get po -l group=hkube,thirdparty!=true -o custom-columns=NAME:.metadata.name,STATUS:.status.phase --no-headers
read -p "Are you sure? [y/n]" -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo Canceled. No harm done
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi
kubectl delete job -l group=hkube,thirdparty!=true
kubectl delete po -l group=hkube,thirdparty!=true
