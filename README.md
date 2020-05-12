# Hkube

[Hkube](https://github.com/kube-HPC/hkube) - cloud-native open source framework to run distributed pipeline of algorithms

## TL;DR;

```console
$ helm repo add hkube https://hkube.io/helm/dev
$ helm repo update
$ helm install  hkube/hkube -n  --version=v1.2.186
```

## Introduction

This chart deploys  on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes v1.14+
- `--allow-privileged` flag must be set to true for both the API server and the kubelet
- (If you use Docker) The Docker daemon of the cluster nodes must allow shared mounts
- Pre-installed HashiCorp Vault server.

## Installing the Chart

To install the chart with the release name ``:

```console
$ helm install  hkube/hkube -n  --version=v1.2.186
```

The command deploys  on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the ``:

```console
$ helm delete  -n 
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the `hkube` chart and their default values.

|                        Parameter                        |          Description           |                            Default                             |
|---------------------------------------------------------|--------------------------------|----------------------------------------------------------------|
| global.clusterName                                      | kubernetes cluster domain name | `cluster.local`                                                |
| global.registry                                         | private registry to use        | `''`                                                           |
| global.registry_namespace                               |                                | `hkube`                                                        |
| global.registry_username                                |                                | `''`                                                           |
| global.registry_password                                |                                | `''`                                                           |
| global.registry_insecure                                |                                | `false`                                                        |
| global.registry_skip_tls_verify                         |                                | `false`                                                        |
| global.storage.binary                                   |                                | `false`                                                        |
| global.storage.fs.pvc.name                              |                                | `hkube-storage`                                                |
| global.storage.fs.pvc.capacity                          |                                | `10Gi`                                                         |
| global.storage.fs.pvc.nfs_server                        |                                | `nfs-server`                                                   |
| global.storage.fs.pvc.nfs_root                          |                                | `/srv/vol_nfs`                                                 |
| global.storage.fs.pvc.pv_name                           |                                | `''`                                                           |
| global.storage.fs.pvc.storage_class                     |                                | `'-'`                                                          |
| global.storage.fs.base_directory                        |                                | `/hkubedata`                                                   |
| global.storage.s3.access_key                         |                                | `hkubeminiokey`                                                |
| global.storage.s3.secret_key                         |                                | `hkubeminiosecret`                                             |
| global.storage.s3.url                                |                                | `'http://minio-service:9000'`                                  |
| global.production                                       |                                | `false`                                                        |
| global.ingress_controller_enable                        |                                | `true`                                                         |
| global.install_ingress_controller                       |                                | `false`                                                        |
| global.k8senv                                           |                                | `k8s`                                                          |
| global.namespaced                                       |                                | `false`                                                        |
| global.isPrivileged                                     |                                | `true`                                                         |
| global.ingress.hostname                                 |                                | `''`                                                           |
| global.ingress.prefix                                   |                                | `''`                                                           |
| global.ingress.use_regex                                |                                | `false`                                                        |
| global.ingress.requireTls                               |                                | `true`                                                         |
| global.ingress.maxBodySize                              |                                | `500m`                                                         |
| env.default_storage                                     |                                | `s3`                                                           |
| env.node_env                                            |                                | `production`                                                   |
| image.pullPolicy                                        |                                | `IfNotPresent`                                                 |
| labels.core.value                                       |                                | `'true'`                                                       |
| labels.group.value                                      |                                | `hkube`                                                        |
| systemversion                                           |                                | `v1.2.186`                                                     |
| build_secret.docker_registry                            |                                | `''`                                                           |
| build_secret.docker_namespace                           |                                | `''`                                                           |
| build_secret.docker_username                            |                                | `''`                                                           |
| build_secret.docker_password                            |                                | `''`                                                           |
| build_secret.docker_registry_insecure                   |                                | `false`                                                        |
| build_secret.docker_registry_skip_tls_verify            |                                | `false`                                                        |
| build_secret.npm_registry                               |                                | `''`                                                           |
| build_secret.npm_token                                  |                                | `''`                                                           |
| build_secret.pip_registry                               |                                | `''`                                                           |
| build_secret.pip_token                                  |                                | `''`                                                           |
| algorithm-example.image.repository                      |                                | `hkube/algorithm-example`                                      |
| algorithm-example.image.tag                             |                                | `v1.2.1`                                                       |
| algorithm_operator.env.metric_port                      |                                | `'3000'`                                                       |
| algorithm_operator.env.builder_cpu                      |                                | `0.1`                                                          |
| algorithm_operator.env.algorithm_builder_builder_memory |                                | `1024`                                                         |
| algorithm_operator.env.algorithm_builder_main_cpu       |                                | `0.5`                                                          |
| algorithm_operator.env.algorithm_builder_main_memory    |                                | `512`                                                          |
| algorithm_operator.env.resources_enable                 |                                | `false`                                                        |
| algorithm_operator.env.algorithm_queue_interval         |                                | `200`                                                          |
| algorithm_operator.env.boards_timeout                   |                                | `10800`                                                        |
| algorithm_operator.env.producer_update_interval         |                                | `1000`                                                         |
| algorithm_operator.image.repository                     |                                | `hkube/algorithm-operator`                                     |
| algorithm_operator.image.tag                            |                                | `v1.2.36`                                                      |
| algorithm_operator.ingress.enabled                      |                                | `false`                                                        |
| algorithm_operator.ingress.path                         |                                | `/hkube/algorithm-operator`                                    |
| algorithm_operator.service.type                         |                                | `ClusterIP`                                                    |
| algorithm_operator.build_mode                           |                                | `kaniko`                                                       |
| algorithm_operator.healthcheck.enabled                  |                                | `true`                                                         |
| algorithm_operator.healthcheck.port                     |                                | `5000`                                                         |
| algorithm_operator.healthcheck.path                     |                                | `/healthz`                                                     |
| algorithm_operator.healthcheck.initialDelaySeconds      |                                | `100`                                                          |
| algorithm_operator.healthcheck.periodSeconds            |                                | `60`                                                           |
| algorithm_operator.healthcheck.timeoutSeconds           |                                | `1`                                                            |
| algorithm_operator.healthcheck.failureThreshold         |                                | `3`                                                            |
| algorithm_operator.resources.requests.cpu               |                                | `100m`                                                         |
| algorithm_operator.resources.requests.memory            |                                | `512Mi`                                                        |
| algorithm-queue.image.repository                        |                                | `hkube/algorithm-queue`                                        |
| algorithm-queue.image.tag                               |                                | `v1.2.26`                                                      |
| algorithm-queue-svc.env.metric_port                     |                                | `'3000'`                                                       |
| algorithm-queue-svc.service.type                        |                                | `ClusterIP`                                                    |
| algorunner.image.repository                             |                                | `hkube/algorunner`                                             |
| algorunner.image.tag                                    |                                | `v1.2.8`                                                       |
| api_server.env.base_url_path                            |                                | `/hkube/api-server`                                            |
| api_server.env.metric_port                              |                                | `'3001'`                                                       |
| api_server.env.port                                     |                                | `'3000'`                                                       |
| api_server.env.pipeline_driver_cpu                      |                                | `'0.2'`                                                        |
| api_server.env.pipeline_driver_mem                      |                                | `'2048'`                                                       |
| api_server.image.repository                             |                                | `hkube/api-server`                                             |
| api_server.image.tag                                    |                                | `v1.2.96`                                                      |
| api_server.ingress.enabled                              |                                | `true`                                                         |
| api_server.ingress.path                                 |                                | `/hkube/api-server`                                            |
| api_server.service.type                                 |                                | `ClusterIP`                                                    |
| api_server.resources.requests.cpu                       |                                | `100m`                                                         |
| api_server.resources.requests.memory                    |                                | `512Mi`                                                        |
| busybox.image.repository                                |                                | `busybox`                                                      |
| busybox.image.tag                                       |                                | `latest`                                                       |
| clean_old_jobs.env.hkube_log_level                      |                                | `'2'`                                                          |
| clean_old_jobs.env.max_completed_job_age_hours          |                                | `'0.0166'`                                                     |
| clean_old_jobs.env.max_failed_job_age_hours             |                                | `'0.0166'`                                                     |
| clean_old_jobs.env.max_pending_job_age_hours            |                                | `'0.0166'`                                                     |
| clean_old_jobs.env.clean_cron                           |                                | `'*/1 * * * *'`                                                |
| clean_old_jobs.healthcheck.enabled                      |                                | `true`                                                         |
| clean_old_jobs.healthcheck.port                         |                                | `5000`                                                         |
| clean_old_jobs.healthcheck.path                         |                                | `/healthz`                                                     |
| clean_old_jobs.healthcheck.initialDelaySeconds          |                                | `100`                                                          |
| clean_old_jobs.healthcheck.periodSeconds                |                                | `60`                                                           |
| clean_old_jobs.healthcheck.timeoutSeconds               |                                | `1`                                                            |
| clean_old_jobs.healthcheck.failureThreshold             |                                | `3`                                                            |
| clean_old_jobs.image.repository                         |                                | `hkube/clean-old-jobs`                                         |
| clean_old_jobs.image.tag                                |                                | `v1.2.7`                                                       |
| clean_old_jobs.resources.requests.cpu                   |                                | `100m`                                                         |
| clean_old_jobs.resources.requests.memory                |                                | `512Mi`                                                        |
| cpu-load-algorithm.image.repository                     |                                | `hkube/cpu-load-algorithm`                                     |
| cpu-load-algorithm.image.tag                            |                                | `v1.2.1`                                                       |
| tensorboard.image.repository                            |                                | `hkube/tensorboard`                                            |
| tensorboard.image.tag                                   |                                | `v1.2.1`                                                       |
| delete_deployment_and_jobs.image.repository             |                                | `hkube/del-dep-and-jobs`                                       |
| delete_deployment_and_jobs.image.tag                    |                                | `v1.0.8`                                                       |
| delete_deployment_and_jobs.resources.requests.cpu       |                                | `100m`                                                         |
| delete_deployment_and_jobs.resources.requests.memory    |                                | `512Mi`                                                        |
| etcd_cleaner.env.object_expiration_days                 |                                | `'5'`                                                          |
| etcd_cleaner.image.repository                           |                                | `hkube/etcd-cleaner`                                           |
| etcd_cleaner.image.tag                                  |                                | `v1.2.3`                                                       |
| etcd_cleaner.resources.requests.cpu                     |                                | `100m`                                                         |
| etcd_cleaner.resources.requests.memory                  |                                | `512Mi`                                                        |
| monitor_server.healthcheck.enabled                      |                                | `true`                                                         |
| monitor_server.healthcheck.port                         |                                | `5000`                                                         |
| monitor_server.healthcheck.path                         |                                | `/healthz`                                                     |
| monitor_server.healthcheck.initialDelaySeconds          |                                | `500`                                                          |
| monitor_server.healthcheck.periodSeconds                |                                | `60`                                                           |
| monitor_server.healthcheck.timeoutSeconds               |                                | `1`                                                            |
| monitor_server.healthcheck.failureThreshold             |                                | `3`                                                            |
| monitor_server.env.metric_port                          |                                | `30010`                                                        |
| monitor_server.env.log_external_requests                |                                | `false`                                                        |
| monitor_server.env.elasticsearch_service_url            |                                | `''`                                                           |
| monitor_server.env.logs_view_source                     |                                | `k8s`                                                          |
| monitor_server.image.repository                         |                                | `hkube/monitor-server`                                         |
| monitor_server.image.tag                                |                                | `v1.2.28`                                                      |
| monitor_server.ingress.enabled                          |                                | `true`                                                         |
| monitor_server.ingress.path                             |                                | `/hkube/monitor-server`                                        |
| monitor_server.service.type                             |                                | `ClusterIP`                                                    |
| monitor_server.resources.requests.cpu                   |                                | `100m`                                                         |
| monitor_server.resources.requests.memory                |                                | `512Mi`                                                        |
| nodeSelector                                            |                                | `{}`                                                           |
| monitor_server_listener.enable                          |                                | `false`                                                        |
| monitor_server_listener.pattern                         |                                | `'*/10 * * * *'`                                               |
| monitor_server_listener.timeout                         |                                | `60000`                                                        |
| monitor_server_listener.image.repository                |                                | `hkube/monitor-server-listener`                                |
| monitor_server_listener.image.tag                       |                                | `v1.2.0`                                                       |
| monitor_server_listener.resources.requests.cpu          |                                | `100m`                                                         |
| monitor_server_listener.resources.requests.memory       |                                | `512Mi`                                                        |
| pipeline_cleaner.image.repository                       |                                | `hkube/pipeline-cleaner`                                       |
| pipeline_cleaner.image.tag                              |                                | `v1.2.1`                                                       |
| pipeline_cleaner.resources.requests.cpu                 |                                | `100m`                                                         |
| pipeline_cleaner.resources.requests.memory              |                                | `512Mi`                                                        |
| pipeline-driver.env.metric_port                         |                                | `'3001'`                                                       |
| pipeline-driver.image.repository                        |                                | `hkube/pipeline-driver`                                        |
| pipeline-driver.image.tag                               |                                | `v1.2.51`                                                      |
| pipeline-driver.service.type                            |                                | `ClusterIP`                                                    |
| pipeline_driver_queue.env.hkube_log_level               |                                | `'2'`                                                          |
| pipeline_driver_queue.env.metric_port                   |                                | `'3000'`                                                       |
| pipeline_driver_queue.env.check_queue_interval          |                                | `'500'`                                                        |
| pipeline_driver_queue.image.repository                  |                                | `hkube/pipeline-driver-queue`                                  |
| pipeline_driver_queue.image.tag                         |                                | `v1.2.18`                                                      |
| pipeline_driver_queue.ingress.enabled                   |                                | `false`                                                        |
| pipeline_driver_queue.ingress.path                      |                                | `/hkube/pipeline-driver-queue`                                 |
| pipeline_driver_queue.replicaCount                      |                                | `1`                                                            |
| pipeline_driver_queue.service.type                      |                                | `ClusterIP`                                                    |
| pipeline_driver_queue.resources.requests.cpu            |                                | `100m`                                                         |
| pipeline_driver_queue.resources.requests.memory         |                                | `512Mi`                                                        |
| private_registry                                        |                                | `docker.io`                                                    |
| resource_manager.healthcheck.enabled                    |                                | `false`                                                        |
| resource_manager.healthcheck.port                       |                                | `5000`                                                         |
| resource_manager.healthcheck.path                       |                                | `/healthz`                                                     |
| resource_manager.healthcheck.initialDelaySeconds        |                                | `100`                                                          |
| resource_manager.healthcheck.periodSeconds              |                                | `20`                                                           |
| resource_manager.healthcheck.timeoutSeconds             |                                | `1`                                                            |
| resource_manager.healthcheck.failureThreshold           |                                | `3`                                                            |
| resource_manager.env.algorithms_threshold_cpu           |                                | `'0.9'`                                                        |
| resource_manager.env.algorithms_threshold_mem           |                                | `'0.9'`                                                        |
| resource_manager.env.driver_threshold_cpu               |                                | `'0.1'`                                                        |
| resource_manager.env.driver_threshold_mem               |                                | `'1'`                                                          |
| resource_manager.env.hkube_log_level                    |                                | `'2'`                                                          |
| resource_manager.env.interval                           |                                | `'1000'`                                                       |
| resource_manager.env.metric_port                        |                                | `'3000'`                                                       |
| resource_manager.env.prometheus_endpoint                |                                | `'http://monitoring-prometheus-server.monitoring:9090/api/v1'` |
| resource_manager.image.repository                       |                                | `hkube/resource-manager`                                       |
| resource_manager.image.tag                              |                                | `v1.2.12`                                                      |
| resource_manager.service.type                           |                                | `ClusterIP`                                                    |
| resource_manager.resources.requests.cpu                 |                                | `100m`                                                         |
| resource_manager.resources.requests.memory              |                                | `512Mi`                                                        |
| simulator.env.hkube_log_level                           |                                | `'2'`                                                          |
| simulator.env.metric_port                               |                                | `9050`                                                         |
| simulator.env.monitor_backend_path                      |                                | `/hkube/monitor-server/`                                       |
| simulator.env.monitor_backend_path_socketio             |                                | `/hkube/monitor-server/socket.io`                              |
| simulator.env.monitor_backend_use_location              |                                | `'true'`                                                       |
| simulator.env.monitor_backend_host                      |                                | `''`                                                           |
| simulator.env.monitor_backend_port                      |                                | `''`                                                           |
| simulator.env.board_host                                |                                | `''`                                                           |
| simulator.env.board_port                                |                                | `''`                                                           |
| simulator.env.board_path                                |                                | `/hkube/board`                                                 |
| simulator.env.board_use_location                        |                                | `'true'`                                                       |
| simulator.env.is_secure                                 |                                | `''`                                                           |
| simulator.image.repository                              |                                | `hkube/simulator`                                              |
| simulator.image.tag                                     |                                | `v1.2.51`                                                      |
| simulator.ingress.enabled                               |                                | `true`                                                         |
| simulator.ingress.path                                  |                                | `/hkube/dashboard`                                             |
| simulator.ingress.alt_path                              |                                | `/hkube/simulator`                                             |
| simulator.metrics.port                                  |                                | `9050`                                                         |
| simulator.service.port                                  |                                | `9050`                                                         |
| simulator.service.type                                  |                                | `ClusterIP`                                                    |
| simulator.resources.requests.cpu                        |                                | `100m`                                                         |
| simulator.resources.requests.memory                     |                                | `512Mi`                                                        |
| storage_cleaner.env.temp_object_expiration_days         |                                | `'5'`                                                          |
| storage_cleaner.env.result_object_expiration_days       |                                | `'20'`                                                         |
| storage_cleaner.image.repository                        |                                | `hkube/storage-cleaner`                                        |
| storage_cleaner.image.tag                               |                                | `v1.2.2`                                                       |
| storage_cleaner.resources.requests.cpu                  |                                | `100m`                                                         |
| storage_cleaner.resources.requests.memory               |                                | `512Mi`                                                        |
| task_executor.healthcheck.enabled                       |                                | `true`                                                         |
| task_executor.healthcheck.port                          |                                | `5000`                                                         |
| task_executor.healthcheck.path                          |                                | `/healthz`                                                     |
| task_executor.healthcheck.initialDelaySeconds           |                                | `100`                                                          |
| task_executor.healthcheck.periodSeconds                 |                                | `20`                                                           |
| task_executor.healthcheck.timeoutSeconds                |                                | `1`                                                            |
| task_executor.healthcheck.failureThreshold              |                                | `3`                                                            |
| task_executor.env.metric_port                           |                                | `'3000'`                                                       |
| task_executor.env.pipeline_drivers_amount               |                                | `30`                                                           |
| task_executor.env.worker_socket_max_payload_bytes       |                                | `1000000000`                                                   |
| task_executor.env.worker_memory                         |                                | `512`                                                          |
| task_executor.env.worker_cpu                            |                                | `0.1`                                                          |
| task_executor.env.resources_enable                      |                                | `false`                                                        |
| task_executor.env.interval                              |                                | `'1000'`                                                       |
| task_executor.env.log_external_requests                 |                                | `false`                                                        |
| task_executor.env.default_quota_cpu                     |                                | `30`                                                           |
| task_executor.env.default_quota_mem                     |                                | `20Gi`                                                         |
| task_executor.env.has_node_list                         |                                | `false`                                                        |
| task_executor.image.repository                          |                                | `hkube/task-executor`                                          |
| task_executor.image.tag                                 |                                | `v1.2.34`                                                      |
| task_executor.service.type                              |                                | `ClusterIP`                                                    |
| task_executor.resources.requests.cpu                    |                                | `100m`                                                         |
| task_executor.resources.requests.memory                 |                                | `512Mi`                                                        |
| thirdparty.enabled                                      |                                | `true`                                                         |
| tolerations                                             |                                | `[]`                                                           |
| trigger_service.env.metric_port                         |                                | `'3000'`                                                       |
| trigger_service.image.repository                        |                                | `hkube/trigger-service`                                        |
| trigger_service.image.tag                               |                                | `v1.2.14`                                                      |
| trigger_service.service.type                            |                                | `ClusterIP`                                                    |
| trigger_service.resources.requests.cpu                  |                                | `100m`                                                         |
| trigger_service.resources.requests.memory               |                                | `256Mi`                                                        |
| worker.env.metric_port                                  |                                | `'3000'`                                                       |
| worker.image.repository                                 |                                | `hkube/worker`                                                 |
| worker.image.tag                                        |                                | `v1.2.57`                                                      |
| worker.metrics.port                                     |                                | `3001`                                                         |
| worker.service.type                                     |                                | `ClusterIP`                                                    |
| caching_service.env.port                                |                                | `'9005'`                                                       |
| caching_service.image.repository                        |                                | `hkube/caching-service`                                        |
| caching_service.image.tag                               |                                | `v1.2.14`                                                      |
| caching_service.service.type                            |                                | `ClusterIP`                                                    |
| caching_service.resources.requests.cpu                  |                                | `100m`                                                         |
| caching_service.resources.requests.memory               |                                | `512Mi`                                                        |
| algorithm-builder.image.repository                      |                                | `hkube/algorithm-builder`                                      |
| algorithm-builder.image.tag                             |                                | `v1.2.43`                                                      |
| algorithm-builder.resources.requests.cpu                |                                | `100m`                                                         |
| algorithm-builder.resources.requests.memory             |                                | `512Mi`                                                        |
| kaniko.image.repository                                 |                                | `hkube/kaniko`                                                 |
| kaniko.image.tag                                        |                                | `v1.2.1`                                                       |
| kaniko.resources.requests.cpu                           |                                | `100m`                                                         |
| kaniko.resources.requests.memory                        |                                | `1Gi`                                                          |
| oc_builder.image.repository                             |                                | `hkube/oc-builder`                                             |
| oc_builder.image.tag                                    |                                | `v1.2.1`                                                       |
| oc_builder.resources.requests.cpu                       |                                | `100m`                                                         |
| oc_builder.resources.requests.memory                    |                                | `1Gi`                                                          |
| algorithm_example_python.image.repository               |                                | `hkube/algorithm-example-python`                               |
| algorithm_example_python.image.tag                      |                                | `v1.2.5`                                                       |
| etcd_defrag.enable                                      |                                | `true`                                                         |
| etcd_defrag.pattern                                     |                                | `'*/10 * * * *'`                                               |
| etcd_defrag.image.repository                            |                                | `hkube/etcd-defrag-cron`                                       |
| etcd_defrag.image.tag                                   |                                | `v1.0.0`                                                       |
| etcd_defrag.resources.requests.cpu                      |                                | `100m`                                                         |
| etcd_defrag.resources.requests.memory                   |                                | `512Mi`                                                        |
| nodejs_env.image.repository                             |                                | `hkube/nodejs-env`                                             |
| nodejs_env.image.tag                                    |                                | `v1.2.1`                                                       |
| python_env.image.repository                             |                                | `hkube/python-env`                                             |
| python_env.image.tag                                    |                                | `v1.2.3`                                                       |
| storage_migration.enable                                |                                | `false`                                                        |
| storage_migration.image.repository                      |                                | `hkube/storage-migration`                                      |
| storage_migration.image.tag                             |                                | `v1.2.4`                                                       |
| fullSystemVersion                                       |                                | `v1.2.186-1588251362004`                                       |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example:

```console
$ helm install  hkube/hkube -n  --version=v1.2.186 --set global.clusterName=cluster.local
```

Alternatively, a YAML file that specifies the values for the parameters can be provided while
installing the chart. For example:

```console
$ helm install  hkube/hkube -n  --version=v1.2.186 --values values.yaml
```
