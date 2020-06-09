# {{ .Project.ShortName }}

[{{ .Project.Name }}]({{ .Project.URL }}) - {{ .Project.Description }}

## TL;DR;

```console
$ helm repo add {{ .Repository.Name }} {{ .Repository.URL }}
$ helm repo update
$ helm install {{ .Release.Name }} {{ .Repository.Name }}/{{ .Chart.Name }} {{ with .Release.Namespace }} --namespace {{ . }} {{ end }}{{ with .Chart.Version }} --version={{.}}{{ end }}
```

## Introduction

This chart deploys {{ .Project.App }} on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites
Hkube requires a working installation of kubernetes.  
There are many options for local k8s installations. e.g  [Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/) or [microk8s](https://microk8s.io/).  

Hkube is installed using helm. Both helm 2 and the newer [helm 3](https://helm.sh/docs/intro/install/) should work.

> Make sure kubectl is configured to your cluster.  
> For collecting algorithm logs, and to create builds, Hkube requires that certain pods will run in privileged security permissions. Consult your kubernetes installation to see how to do that. "`--allow-privileged` flag must be set to true for both the API server and the kubelet (or set global.isPrivileged=false)"

{{ range .Prerequisites }}
- {{ . }}
{{- end }}

## Installing the Chart

To install the chart with the release name `{{ .Release.Name }}`:

```console
$ helm repo add hkube http://hkube.io/helm/
$ helm install hkube hkube/hkube
```

The command deploys {{ .Project.App }} on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `{{ .Release.Name }}`:

```console
$ helm delete {{ .Release.Name }} {{ with .Release.Namespace }} --namespace {{ . }} {{ end }}
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the `{{ .Chart.Name }}` chart and their default values.

{{ .Chart.Values }}

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example:

```console
$ helm install {{ .Release.Name }} {{ .Repository.Name }}/{{ .Chart.Name }} {{ with .Release.Namespace }} --namespace {{ . }} {{ end }}{{ with .Chart.Version }} --version={{.}}{{ end }} --set {{ .Chart.ValuesExample }}
```

Alternatively, a YAML file that specifies the values for the parameters can be provided while
installing the chart. For example:

```console
$ helm install {{ .Release.Name }} {{ .Repository.Name }}/{{ .Chart.Name }} {{ with .Release.Namespace }} --namespace {{ . }} {{ end }}{{ with .Chart.Version }} --version={{.}}{{ end }} --values values.yaml
```