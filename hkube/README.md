# Hkube

[Hkube](https://github.com/kube-HPC/hkube) - cloud-native open source framework to run distributed pipeline of algorithms

## TL;DR;

```console
$ helm repo add hkube https://hkube.io/helm/dev
$ helm repo update
$ helm install hkube hkube/hkube 
```

## Introduction

This chart deploys  on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites
Hkube requires a working installation of kubernetes.  
There are many options for local k8s installations. e.g  [Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/) or [microk8s](https://microk8s.io/).  

Hkube is installed using helm. Both helm 2 and the newer [helm 3](https://helm.sh/docs/intro/install/) should work.

> Make sure kubectl is configured to your cluster.  
> For collecting algorithm logs, and to create builds, Hkube requires that certain pods will run in privileged security permissions. Consult your kubernetes installation to see how to do that. "`--allow-privileged` flag must be set to true for both the API server and the kubelet (or set global.isPrivileged=false)"


- Kubernetes v1.14+
- Dynamic storage provisioning (optional)
- Ingress controller (optional)

## Installing the Chart

To install the chart with the release name `hkube`:

```console
$ helm repo add hkube http://hkube.io/helm/
$ helm install hkube hkube/hkube
```

The command deploys  on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `hkube`:

```console
$ helm delete hkube 
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the `hkube` chart and their default values.

|                     Parameter                     |                                                                                   Description                                                                                   |                    Default                     |
|---------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------|
| global.clusterName                                | kubernetes cluster domain name                                                                                                                                                  | `cluster.local`                                |
| global.registry                                   | private registry to use                                                                                                                                                         | `''`                                           |
| global.registry_namespace                         | private registry namespace for pulling base image in builds                                                                                                                     | `hkube`                                        |
| global.registry_username                          | private registry username for pulling base image in builds                                                                                                                      | `''`                                           |
| global.registry_password                          | private registry password for pulling base image in builds                                                                                                                      | `''`                                           |
| global.registry_insecure                          | private registry insecure (http) for pulling base image in builds                                                                                                               | `false`                                        |
| global.registry_skip_tls_verify                   | private registry with self signed certificate for pulling base image in builds                                                                                                  | `false`                                        |
| global.storage.encoding                           | encoding for storage. can be msgpack, bson, json                                                                                                                                | `msgpack`                                      |
| global.storage.s3.access_key                      | s3 access and secret key. If using internal minio, must match minio.accessKey and secretKey                                                                                     | `hkubeminiokey`                                |
| global.storage.s3.secret_key                      |                                                                                                                                                                                 | `hkubeminiosecret`                             |
| global.storage.s3.url                             |                                                                                                                                                                                 | `'http://hkube-minio:9000'`                    |
| global.k8senv                                     | kubernetes environment. Possible values are k8s, openshift                                                                                                                      | `k8s`                                          |
| global.namespaced                                 | use only namespace. Set to true in restricted environments such as openshift                                                                                                    | `false`                                        |
| global.isPrivileged                               | run worker pods as privileged containers. Makes log aggregation easier                                                                                                          | `true`                                         |
| global.ingress.hostname                           |                                                                                                                                                                                 | `''`                                           |
| global.ingress.prefix                             |                                                                                                                                                                                 | `''`                                           |
| global.ingress.use_regex                          | set to false if using nginx-ingress-controller prior to 0.21                                                                                                                    | `true`                                         |
| global.ingress.requireTls                         |                                                                                                                                                                                 | `false`                                        |
| global.ingress.maxBodySize                        |                                                                                                                                                                                 | `500m`                                         |
| env.default_storage                               | storage mode. can be s3 or fs. Set global.storage.fs or global.storage.s3 accordingly                                                                                           | `s3`                                           |
| env.node_env                                      |                                                                                                                                                                                 | `production`                                   |
| image.pullPolicy                                  | pull policy for images                                                                                                                                                          | `IfNotPresent`                                 |
| etcd.enable                                       |                                                                                                                                                                                 | `true`                                         |
| etcd.replicas                                     | set number of replicas. defualt 3                                                                                                                                               | `3`                                            |
| etcd.persistentVolume.enabled                     |                                                                                                                                                                                 | `true`                                         |
| etcd.persistentVolume.storageClass                |                                                                                                                                                                                 | `''`                                           |
| etcd.persistentVolume.storage                     |                                                                                                                                                                                 | `1Gi`                                          |
| redis-ha.enable                                   |                                                                                                                                                                                 | `true`                                         |
| redis-ha.replicas                                 | set number of replicas. defualt 3. If set to 1 also set min-slaves-to-write to 0                                                                                                | `3`                                            |
| redis-ha.redis.config.min-slaves-to-write         |                                                                                                                                                                                 | `1`                                            |
| redis-ha.hardAntiAffinity                         | set to true for multiple nodes                                                                                                                                                  | `false`                                        |
| jaeger.enable                                     | enable jaeger and cassandra                                                                                                                                                     | `false`                                        |
| jaeger.fullnameOverride                           |                                                                                                                                                                                 | `jaeger`                                       |
| jaeger.nameOverride                               |                                                                                                                                                                                 | `jaeger`                                       |
| jaeger.query.basePath                             |                                                                                                                                                                                 | `/jaeger`                                      |
| jaeger.query.ingress.enabled                      |                                                                                                                                                                                 | `true`                                         |
| jaeger.agent.daemonset.useHostPort                | set to false to allow running in non privileged environment (e.g. openshift)                                                                                                    | `true`                                         |
| jaeger.cassandra.config.cluster_size              |                                                                                                                                                                                 | `1`                                            |
| jaeger.cassandra.config.cluster_domain            |                                                                                                                                                                                 | `cluster.local`                                |
| jaeger.external_agent_address                     | optional external jaeger agent address. leave blank for defaults                                                                                                                | `''`                                           |
| nginx-ingress.enable                              | install nginx-ingress-controller with hkube                                                                                                                                     | `false`                                        |
| minio.enable                                      |                                                                                                                                                                                 | `true`                                         |
| minio.accessKey                                   |                                                                                                                                                                                 | `hkubeminiokey`                                |
| minio.secretKey                                   |                                                                                                                                                                                 | `hkubeminiosecret`                             |
| minio.persistence.enabled                         |                                                                                                                                                                                 | `true`                                         |
| minio.persistence.storageClass                    |                                                                                                                                                                                 | `''`                                           |
| metrics.serviceMonitorSelector.release            |                                                                                                                                                                                 | `metrics`                                      |
| metrics.grafanaDashboardLabel.grafana_dashboard   |                                                                                                                                                                                 | `'1'`                                          |
| systemversion                                     |                                                                                                                                                                                 | `v1.3.88`                                      |
| build_secret.docker_registry                      | docker registry for algorithm builds. defaults to docker.io                                                                                                                     | `''`                                           |
| build_secret.docker_namespace                     | docker registry namespace for algorithm builds. defaults to username                                                                                                            | `''`                                           |
| build_secret.docker_username                      | docker registry username for algorithm builds.                                                                                                                                  | `''`                                           |
| build_secret.docker_password                      | docker registry password for algorithm builds.                                                                                                                                  | `''`                                           |
| build_secret.docker_registry_insecure             | docker registry is insecure for algorithm builds.                                                                                                                               | `false`                                        |
| build_secret.docker_registry_skip_tls_verify      | docker registry has self signed certificate for algorithm builds.                                                                                                               | `false`                                        |
| build_secret.npm_registry                         | npm registry for algorithm builds. Defaults to npmjs.com                                                                                                                        | `''`                                           |
| build_secret.npm_token                            | npm registry token for algorithm builds.                                                                                                                                        | `''`                                           |
| build_secret.pip_registry                         | pip registry for algorithm builds. Defaults to pypi.org                                                                                                                         | `''`                                           |
| build_secret.pip_token                            | pip registry token for algorithm builds. Defaults to pypi.org                                                                                                                   | `''`                                           |
| nodeSelector                                      | node selector for hkube containers.                                                                                                                                             | `{}`                                           |
| algorithm_operator.build_mode                     | build mode for automatic builds. set to openshift if running on openshift                                                                                                       | `kaniko`                                       |
| algorithm_operator.resources                      | Compute resources required for algorithm-operator                                                                                                                               | `{"requests":{"cpu":"100m","memory":"512Mi"}}` |
| storage_cleaner.pattern                           |                                                                                                                                                                                 | `0 0 * * *`                                    |
| storage_cleaner.env.temp_object_expiration_days   | number of days to save intermediate results in storage                                                                                                                          | `'5'`                                          |
| storage_cleaner.env.result_object_expiration_days | number of days to save final pipeline results in storage                                                                                                                        | `'20'`                                         |
| task_executor.env.pipeline_drivers_amount         | the number of pipeline drivers to run.                                                                                                                                          | `1`                                            |
| task_executor.env.worker_socket_max_payload_bytes |                                                                                                                                                                                 | `1000000000`                                   |
| task_executor.env.worker_memory                   | worker container memory request in MB. Only set if resources_enable=true                                                                                                        | `512`                                          |
| task_executor.env.worker_cpu                      | worker container cpu request. Only set if resources_enable=true                                                                                                                 | `0.1`                                          |
| task_executor.env.resources_enable                | if true, sets resource requests on worker container                                                                                                                             | `false`                                        |
| task_executor.env.interval                        | task executor internal processing interval in MS                                                                                                                                | `'1000'`                                       |
| task_executor.env.default_quota_cpu               | set to the number of CPUs in the cluster (or quota) when running on openshift                                                                                                   | `30`                                           |
| task_executor.env.default_quota_mem               | set to the total amount of memory in the cluster (or quota) when running on openshift                                                                                           | `20Gi`                                         |
| task_executor.env.default_quota_gpu               | set to the total number of GPUs in the cluster (or quota) when running on openshift                                                                                             | `0`                                            |
| task_executor.env.has_node_list                   | if running on openshift on labeled nodes, set to true and create a config-map named `hkube-nodes` with key `hkube-nodes` and value of the output of `kubectl get nodes -o json` | `false`                                        |
| task_executor.resources                           | Compute resources required for algorithm-operator                                                                                                                               | `{"requests":{"cpu":"100m","memory":"512Mi"}}` |
| fullSystemVersion                                 |                                                                                                                                                                                 | `v1.3.88-1594909167851`                        |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example:

```console
$ helm install hkube hkube/hkube  --set global.clusterName=cluster.local
```

Alternatively, a YAML file that specifies the values for the parameters can be provided while
installing the chart. For example:

```console
$ helm install hkube hkube/hkube  --values values.yaml
```