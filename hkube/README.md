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

|                        Parameter                        | Description |                            Default                             |
|---------------------------------------------------------|-------------|----------------------------------------------------------------|
| global.clusterName                                      |             | `cluster.local`                                                |
| global.registry                                         |             | `''`                                                           |
| global.registry_namespace                               |             | `hkube`                                                        |
| global.registry_username                                |             | `''`                                                           |
| global.registry_password                                |             | `''`                                                           |
| global.registry_insecure                                |             | `false`                                                        |
| global.registry_skip_tls_verify                         |             | `false`                                                        |
| global.storage.binary                                   |             | `false`                                                        |
| global.storage.fs.pvc.name                              |             | `hkube-storage`                                                |
| global.storage.fs.pvc.capacity                          |             | `10Gi`                                                         |
| global.storage.fs.pvc.storage_class                     |             | `'-'`                                                          |
| global.storage.fs.base_directory                        |             | `/hkubedata`                                                   |
| global.storage.s3.access_key                            |             | `hkubeminiokey`                                                |
| global.storage.s3.secret_key                            |             | `hkubeminiosecret`                                             |
| global.storage.s3.url                                   |             | `'http://hkube-minio:9000'`                                    |
| global.k8senv                                           |             | `k8s`                                                          |
| global.namespaced                                       |             | `false`                                                        |
| global.isPrivileged                                     |             | `true`                                                         |
| global.ingress.hostname                                 |             | `''`                                                           |
| global.ingress.prefix                                   |             | `''`                                                           |
| global.ingress.use_regex                                |             | `true`                                                         |
| global.ingress.requireTls                               |             | `false`                                                        |
| global.ingress.maxBodySize                              |             | `500m`                                                         |
| env.default_storage                                     |             | `s3`                                                           |
| env.node_env                                            |             | `production`                                                   |
| image.pullPolicy                                        |             | `IfNotPresent`                                                 |
| labels.core.value                                       |             | `'true'`                                                       |
| labels.group.value                                      |             | `hkube`                                                        |
| etcd-operator.enable                                    |             | `false`                                                        |
| etcd.enable                                             |             | `true`                                                         |
| etcd.replicas                                           |             | `3`                                                            |
| etcd.persistentVolume.enabled                           |             | `true`                                                         |
| etcd.persistentVolume.storageClass                      |             | `''`                                                           |
| etcd.persistentVolume.storage                           |             | `1Gi`                                                          |
| redis-ha.enable                                         |             | `true`                                                         |
| redis-ha.replicas                                       |             | `3`                                                            |
| redis-ha.redis.config.min-slaves-to-write               |             | `1`                                                            |
| redis-ha.hardAntiAffinity                               |             | `false`                                                        |
| jaeger.enable                                           |             | `false`                                                        |
| jaeger.fullnameOverride                                 |             | `jaeger`                                                       |
| jaeger.nameOverride                                     |             | `jaeger`                                                       |
| jaeger.query.basePath                                   |             | `/jaeger`                                                      |
| jaeger.query.ingress.enabled                            |             | `true`                                                         |
| jaeger.agent.daemonset.useHostPort                      |             | `true`                                                         |
| jaeger.cassandra.config.cluster_size                    |             | `1`                                                            |
| jaeger.cassandra.config.cluster_domain                  |             | `cluster.local`                                                |
| nginx-ingress.enable                                    |             | `false`                                                        |
| minio.enable                                            |             | `true`                                                         |
| minio.accessKey                                         |             | `hkubeminiokey`                                                |
| minio.secretKey                                         |             | `hkubeminiosecret`                                             |
| minio.persistence.enabled                               |             | `true`                                                         |
| minio.persistence.storageClass                          |             | `''`                                                           |
| metrics.serviceMonitorSelector.release                  |             | `metrics`                                                      |
| metrics.grafanaDashboardLabel.grafana_dashboard         |             | `'1'`                                                          |
| systemversion                                           |             | `v1.3.7`                                                       |
| build_secret.docker_registry                            |             | `''`                                                           |
| build_secret.docker_namespace                           |             | `''`                                                           |
| build_secret.docker_username                            |             | `''`                                                           |
| build_secret.docker_password                            |             | `''`                                                           |
| build_secret.docker_registry_insecure                   |             | `false`                                                        |
| build_secret.docker_registry_skip_tls_verify            |             | `false`                                                        |
| build_secret.npm_registry                               |             | `''`                                                           |
| build_secret.npm_token                                  |             | `''`                                                           |
| build_secret.pip_registry                               |             | `''`                                                           |
| build_secret.pip_token                                  |             | `''`                                                           |
| nodeSelector                                            |             | `{}`                                                           |
| algorithm-example.image.repository                      |             | `hkube/algorithm-example`                                      |
| algorithm-example.image.tag                             |             | `v1.3.1`                                                       |
| algorithm_operator.env.metric_port                      |             | `'3000'`                                                       |
| algorithm_operator.env.builder_cpu                      |             | `0.1`                                                          |
| algorithm_operator.env.algorithm_builder_builder_memory |             | `1024`                                                         |
| algorithm_operator.env.algorithm_builder_main_cpu       |             | `0.5`                                                          |
| algorithm_operator.env.algorithm_builder_main_memory    |             | `512`                                                          |
| algorithm_operator.env.resources_enable                 |             | `false`                                                        |
| algorithm_operator.env.algorithm_queue_interval         |             | `200`                                                          |
| algorithm_operator.env.boards_timeout                   |             | `10800`                                                        |
| algorithm_operator.env.producer_update_interval         |             | `1000`                                                         |
| algorithm_operator.image.repository                     |             | `hkube/algorithm-operator`                                     |
| algorithm_operator.image.tag                            |             | `v1.3.1`                                                       |
| algorithm_operator.ingress.enabled                      |             | `false`                                                        |
| algorithm_operator.ingress.path                         |             | `/hkube/algorithm-operator`                                    |
| algorithm_operator.service.type                         |             | `ClusterIP`                                                    |
| algorithm_operator.build_mode                           |             | `kaniko`                                                       |
| algorithm_operator.healthcheck.enabled                  |             | `true`                                                         |
| algorithm_operator.healthcheck.port                     |             | `5000`                                                         |
| algorithm_operator.healthcheck.path                     |             | `/healthz`                                                     |
| algorithm_operator.healthcheck.initialDelaySeconds      |             | `100`                                                          |
| algorithm_operator.healthcheck.periodSeconds            |             | `60`                                                           |
| algorithm_operator.healthcheck.timeoutSeconds           |             | `1`                                                            |
| algorithm_operator.healthcheck.failureThreshold         |             | `3`                                                            |
| algorithm_operator.resources.requests.cpu               |             | `100m`                                                         |
| algorithm_operator.resources.requests.memory            |             | `512Mi`                                                        |
| algorithm-queue.image.repository                        |             | `hkube/algorithm-queue`                                        |
| algorithm-queue.image.tag                               |             | `v1.3.1`                                                       |
| algorithm-queue-svc.env.metric_port                     |             | `'3000'`                                                       |
| algorithm-queue-svc.service.type                        |             | `ClusterIP`                                                    |
| algorunner.image.repository                             |             | `hkube/algorunner`                                             |
| algorunner.image.tag                                    |             | `v1.3.2`                                                       |
| api_server.env.base_url_path                            |             | `/hkube/api-server`                                            |
| api_server.env.metric_port                              |             | `'3001'`                                                       |
| api_server.env.port                                     |             | `'3000'`                                                       |
| api_server.env.pipeline_driver_cpu                      |             | `'0.2'`                                                        |
| api_server.env.pipeline_driver_mem                      |             | `'2048'`                                                       |
| api_server.image.repository                             |             | `hkube/api-server`                                             |
| api_server.image.tag                                    |             | `v1.3.4`                                                       |
| api_server.ingress.enabled                              |             | `true`                                                         |
| api_server.ingress.path                                 |             | `/hkube/api-server`                                            |
| api_server.service.type                                 |             | `ClusterIP`                                                    |
| api_server.resources.requests.cpu                       |             | `100m`                                                         |
| api_server.resources.requests.memory                    |             | `512Mi`                                                        |
| busybox.image.repository                                |             | `busybox`                                                      |
| busybox.image.tag                                       |             | `latest`                                                       |
| clean_old_jobs.env.hkube_log_level                      |             | `'2'`                                                          |
| clean_old_jobs.env.max_completed_job_age_hours          |             | `'0.0166'`                                                     |
| clean_old_jobs.env.max_failed_job_age_hours             |             | `'0.0166'`                                                     |
| clean_old_jobs.env.max_pending_job_age_hours            |             | `'0.0166'`                                                     |
| clean_old_jobs.env.clean_cron                           |             | `'*/1 * * * *'`                                                |
| clean_old_jobs.healthcheck.enabled                      |             | `true`                                                         |
| clean_old_jobs.healthcheck.port                         |             | `5000`                                                         |
| clean_old_jobs.healthcheck.path                         |             | `/healthz`                                                     |
| clean_old_jobs.healthcheck.initialDelaySeconds          |             | `100`                                                          |
| clean_old_jobs.healthcheck.periodSeconds                |             | `60`                                                           |
| clean_old_jobs.healthcheck.timeoutSeconds               |             | `1`                                                            |
| clean_old_jobs.healthcheck.failureThreshold             |             | `3`                                                            |
| clean_old_jobs.image.repository                         |             | `hkube/clean-old-jobs`                                         |
| clean_old_jobs.image.tag                                |             | `v1.3.1`                                                       |
| clean_old_jobs.resources.requests.cpu                   |             | `100m`                                                         |
| clean_old_jobs.resources.requests.memory                |             | `512Mi`                                                        |
| cpu-load-algorithm.image.repository                     |             | `hkube/cpu-load-algorithm`                                     |
| cpu-load-algorithm.image.tag                            |             | `v1.3.1`                                                       |
| tensorboard.image.repository                            |             | `hkube/tensorboard`                                            |
| tensorboard.image.tag                                   |             | `v1.3.1`                                                       |
| delete_deployment_and_jobs.image.repository             |             | `hkube/del-dep-and-jobs`                                       |
| delete_deployment_and_jobs.image.tag                    |             | `v1.0.8`                                                       |
| delete_deployment_and_jobs.resources.requests.cpu       |             | `100m`                                                         |
| delete_deployment_and_jobs.resources.requests.memory    |             | `512Mi`                                                        |
| etcd_cleaner.pattern                                    |             | `0 0 * * *`                                                    |
| etcd_cleaner.env.object_expiration_days                 |             | `'5'`                                                          |
| etcd_cleaner.image.repository                           |             | `hkube/etcd-cleaner`                                           |
| etcd_cleaner.image.tag                                  |             | `v1.3.4`                                                       |
| etcd_cleaner.resources.requests.cpu                     |             | `100m`                                                         |
| etcd_cleaner.resources.requests.memory                  |             | `512Mi`                                                        |
| monitor_server.healthcheck.enabled                      |             | `true`                                                         |
| monitor_server.healthcheck.port                         |             | `5000`                                                         |
| monitor_server.healthcheck.path                         |             | `/healthz`                                                     |
| monitor_server.healthcheck.initialDelaySeconds          |             | `500`                                                          |
| monitor_server.healthcheck.periodSeconds                |             | `60`                                                           |
| monitor_server.healthcheck.timeoutSeconds               |             | `1`                                                            |
| monitor_server.healthcheck.failureThreshold             |             | `3`                                                            |
| monitor_server.env.metric_port                          |             | `30010`                                                        |
| monitor_server.env.log_external_requests                |             | `false`                                                        |
| monitor_server.env.elasticsearch_service_url            |             | `''`                                                           |
| monitor_server.env.logs_view_source                     |             | `k8s`                                                          |
| monitor_server.env.jaeger_query_service_host            |             | `''`                                                           |
| monitor_server.env.jaeger_query_service_port            |             | `''`                                                           |
| monitor_server.image.repository                         |             | `hkube/monitor-server`                                         |
| monitor_server.image.tag                                |             | `v1.3.3`                                                       |
| monitor_server.ingress.enabled                          |             | `true`                                                         |
| monitor_server.ingress.path                             |             | `/hkube/monitor-server`                                        |
| monitor_server.service.type                             |             | `ClusterIP`                                                    |
| monitor_server.resources.requests.cpu                   |             | `100m`                                                         |
| monitor_server.resources.requests.memory                |             | `512Mi`                                                        |
| monitor_server_listener.enable                          |             | `false`                                                        |
| monitor_server_listener.pattern                         |             | `'*/10 * * * *'`                                               |
| monitor_server_listener.timeout                         |             | `60000`                                                        |
| monitor_server_listener.image.repository                |             | `hkube/monitor-server-listener`                                |
| monitor_server_listener.image.tag                       |             | `v1.3.0`                                                       |
| monitor_server_listener.resources.requests.cpu          |             | `100m`                                                         |
| monitor_server_listener.resources.requests.memory       |             | `512Mi`                                                        |
| pipeline_cleaner.pattern                                |             | `'*/5 * * * *'`                                                |
| pipeline_cleaner.image.repository                       |             | `hkube/pipeline-cleaner`                                       |
| pipeline_cleaner.image.tag                              |             | `v1.3.1`                                                       |
| pipeline_cleaner.resources.requests.cpu                 |             | `100m`                                                         |
| pipeline_cleaner.resources.requests.memory              |             | `512Mi`                                                        |
| pipeline-driver.env.metric_port                         |             | `'3001'`                                                       |
| pipeline-driver.image.repository                        |             | `hkube/pipeline-driver`                                        |
| pipeline-driver.image.tag                               |             | `v1.3.2`                                                       |
| pipeline-driver.service.type                            |             | `ClusterIP`                                                    |
| pipeline_driver_queue.env.hkube_log_level               |             | `'2'`                                                          |
| pipeline_driver_queue.env.metric_port                   |             | `'3000'`                                                       |
| pipeline_driver_queue.env.check_queue_interval          |             | `'500'`                                                        |
| pipeline_driver_queue.image.repository                  |             | `hkube/pipeline-driver-queue`                                  |
| pipeline_driver_queue.image.tag                         |             | `v1.3.1`                                                       |
| pipeline_driver_queue.ingress.enabled                   |             | `false`                                                        |
| pipeline_driver_queue.ingress.path                      |             | `/hkube/pipeline-driver-queue`                                 |
| pipeline_driver_queue.replicaCount                      |             | `1`                                                            |
| pipeline_driver_queue.service.type                      |             | `ClusterIP`                                                    |
| pipeline_driver_queue.resources.requests.cpu            |             | `100m`                                                         |
| pipeline_driver_queue.resources.requests.memory         |             | `512Mi`                                                        |
| resource_manager.healthcheck.enabled                    |             | `false`                                                        |
| resource_manager.healthcheck.port                       |             | `5000`                                                         |
| resource_manager.healthcheck.path                       |             | `/healthz`                                                     |
| resource_manager.healthcheck.initialDelaySeconds        |             | `100`                                                          |
| resource_manager.healthcheck.periodSeconds              |             | `20`                                                           |
| resource_manager.healthcheck.timeoutSeconds             |             | `1`                                                            |
| resource_manager.healthcheck.failureThreshold           |             | `3`                                                            |
| resource_manager.env.algorithms_threshold_cpu           |             | `'0.9'`                                                        |
| resource_manager.env.algorithms_threshold_mem           |             | `'0.9'`                                                        |
| resource_manager.env.driver_threshold_cpu               |             | `'0.1'`                                                        |
| resource_manager.env.driver_threshold_mem               |             | `'1'`                                                          |
| resource_manager.env.hkube_log_level                    |             | `'2'`                                                          |
| resource_manager.env.interval                           |             | `'1000'`                                                       |
| resource_manager.env.metric_port                        |             | `'3000'`                                                       |
| resource_manager.env.prometheus_endpoint                |             | `'http://monitoring-prometheus-server.monitoring:9090/api/v1'` |
| resource_manager.image.repository                       |             | `hkube/resource-manager`                                       |
| resource_manager.image.tag                              |             | `v1.3.1`                                                       |
| resource_manager.service.type                           |             | `ClusterIP`                                                    |
| resource_manager.resources.requests.cpu                 |             | `100m`                                                         |
| resource_manager.resources.requests.memory              |             | `512Mi`                                                        |
| simulator.env.hkube_log_level                           |             | `'2'`                                                          |
| simulator.env.metric_port                               |             | `9050`                                                         |
| simulator.env.monitor_backend_path                      |             | `/hkube/monitor-server/`                                       |
| simulator.env.monitor_backend_path_socketio             |             | `/hkube/monitor-server/socket.io`                              |
| simulator.env.monitor_backend_use_location              |             | `'true'`                                                       |
| simulator.env.monitor_backend_host                      |             | `''`                                                           |
| simulator.env.monitor_backend_port                      |             | `''`                                                           |
| simulator.env.board_host                                |             | `''`                                                           |
| simulator.env.board_port                                |             | `''`                                                           |
| simulator.env.board_path                                |             | `/hkube/board`                                                 |
| simulator.env.board_use_location                        |             | `'true'`                                                       |
| simulator.env.is_secure                                 |             | `''`                                                           |
| simulator.image.repository                              |             | `hkube/simulator`                                              |
| simulator.image.tag                                     |             | `v1.3.3`                                                       |
| simulator.ingress.enabled                               |             | `true`                                                         |
| simulator.ingress.path                                  |             | `/hkube/dashboard`                                             |
| simulator.ingress.alt_path                              |             | `/hkube/simulator`                                             |
| simulator.metrics.port                                  |             | `9050`                                                         |
| simulator.service.port                                  |             | `9050`                                                         |
| simulator.service.type                                  |             | `ClusterIP`                                                    |
| simulator.resources.requests.cpu                        |             | `100m`                                                         |
| simulator.resources.requests.memory                     |             | `512Mi`                                                        |
| storage_cleaner.pattern                                 |             | `0 0 * * *`                                                    |
| storage_cleaner.env.temp_object_expiration_days         |             | `'5'`                                                          |
| storage_cleaner.env.result_object_expiration_days       |             | `'20'`                                                         |
| storage_cleaner.image.repository                        |             | `hkube/storage-cleaner`                                        |
| storage_cleaner.image.tag                               |             | `v1.3.2`                                                       |
| storage_cleaner.resources.requests.cpu                  |             | `100m`                                                         |
| storage_cleaner.resources.requests.memory               |             | `512Mi`                                                        |
| task_executor.healthcheck.enabled                       |             | `true`                                                         |
| task_executor.healthcheck.port                          |             | `5000`                                                         |
| task_executor.healthcheck.path                          |             | `/healthz`                                                     |
| task_executor.healthcheck.initialDelaySeconds           |             | `100`                                                          |
| task_executor.healthcheck.periodSeconds                 |             | `20`                                                           |
| task_executor.healthcheck.timeoutSeconds                |             | `1`                                                            |
| task_executor.healthcheck.failureThreshold              |             | `3`                                                            |
| task_executor.env.metric_port                           |             | `'3000'`                                                       |
| task_executor.env.pipeline_drivers_amount               |             | `1`                                                            |
| task_executor.env.worker_socket_max_payload_bytes       |             | `1000000000`                                                   |
| task_executor.env.worker_memory                         |             | `512`                                                          |
| task_executor.env.worker_cpu                            |             | `0.1`                                                          |
| task_executor.env.resources_enable                      |             | `false`                                                        |
| task_executor.env.interval                              |             | `'1000'`                                                       |
| task_executor.env.log_external_requests                 |             | `false`                                                        |
| task_executor.env.default_quota_cpu                     |             | `30`                                                           |
| task_executor.env.default_quota_mem                     |             | `20Gi`                                                         |
| task_executor.env.has_node_list                         |             | `false`                                                        |
| task_executor.image.repository                          |             | `hkube/task-executor`                                          |
| task_executor.image.tag                                 |             | `v1.3.3`                                                       |
| task_executor.service.type                              |             | `ClusterIP`                                                    |
| task_executor.resources.requests.cpu                    |             | `100m`                                                         |
| task_executor.resources.requests.memory                 |             | `512Mi`                                                        |
| thirdparty.enabled                                      |             | `true`                                                         |
| tolerations                                             |             | `[]`                                                           |
| trigger_service.env.metric_port                         |             | `'3000'`                                                       |
| trigger_service.image.repository                        |             | `hkube/trigger-service`                                        |
| trigger_service.image.tag                               |             | `v1.3.1`                                                       |
| trigger_service.service.type                            |             | `ClusterIP`                                                    |
| trigger_service.resources.requests.cpu                  |             | `100m`                                                         |
| trigger_service.resources.requests.memory               |             | `256Mi`                                                        |
| worker.env.metric_port                                  |             | `'3000'`                                                       |
| worker.image.repository                                 |             | `hkube/worker`                                                 |
| worker.image.tag                                        |             | `v1.3.1`                                                       |
| worker.metrics.port                                     |             | `3001`                                                         |
| worker.service.type                                     |             | `ClusterIP`                                                    |
| caching_service.env.port                                |             | `'9005'`                                                       |
| caching_service.image.repository                        |             | `hkube/caching-service`                                        |
| caching_service.image.tag                               |             | `v1.3.1`                                                       |
| caching_service.service.type                            |             | `ClusterIP`                                                    |
| caching_service.resources.requests.cpu                  |             | `100m`                                                         |
| caching_service.resources.requests.memory               |             | `512Mi`                                                        |
| algorithm-builder.image.repository                      |             | `hkube/algorithm-builder`                                      |
| algorithm-builder.image.tag                             |             | `v1.3.1`                                                       |
| algorithm-builder.resources.requests.cpu                |             | `100m`                                                         |
| algorithm-builder.resources.requests.memory             |             | `512Mi`                                                        |
| kaniko.image.repository                                 |             | `hkube/kaniko`                                                 |
| kaniko.image.tag                                        |             | `v1.3.1`                                                       |
| kaniko.resources.requests.cpu                           |             | `100m`                                                         |
| kaniko.resources.requests.memory                        |             | `1Gi`                                                          |
| oc_builder.image.repository                             |             | `hkube/oc-builder`                                             |
| oc_builder.image.tag                                    |             | `v1.3.0`                                                       |
| oc_builder.resources.requests.cpu                       |             | `100m`                                                         |
| oc_builder.resources.requests.memory                    |             | `1Gi`                                                          |
| algorithm_example_python.image.repository               |             | `hkube/algorithm-example-python`                               |
| algorithm_example_python.image.tag                      |             | `v1.3.1`                                                       |
| etcd_defrag.enable                                      |             | `true`                                                         |
| etcd_defrag.pattern                                     |             | `'*/10 * * * *'`                                               |
| etcd_defrag.image.repository                            |             | `hkube/etcd-defrag-cron`                                       |
| etcd_defrag.image.tag                                   |             | `v1.0.0`                                                       |
| etcd_defrag.resources.requests.cpu                      |             | `100m`                                                         |
| etcd_defrag.resources.requests.memory                   |             | `512Mi`                                                        |
| nodejs_env.image.repository                             |             | `hkube/nodejs-env`                                             |
| nodejs_env.image.tag                                    |             | `v1.3.1`                                                       |
| python_env.image.repository                             |             | `hkube/python-env`                                             |
| python_env.image.tag                                    |             | `v1.3.1`                                                       |
| storage_migration.enable                                |             | `false`                                                        |
| storage_migration.image.repository                      |             | `hkube/storage-migration`                                      |
| storage_migration.image.tag                             |             | `v1.3.1`                                                       |
| fullSystemVersion                                       |             | `v1.3.7-1591537680069`                                         |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example:

```console
$ helm install hkube hkube/hkube  --set global.clusterName=cluster.local
```

Alternatively, a YAML file that specifies the values for the parameters can be provided while
installing the chart. For example:

```console
$ helm install hkube hkube/hkube  --values values.yaml
```