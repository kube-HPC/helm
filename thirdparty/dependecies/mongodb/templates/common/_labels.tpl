{{/* vim: set filetype=mustache: */}}
{{/*
Kubernetes standard labels
*/}}
{{- define "mongodb.labels.standard" -}}
app.kubernetes.io/name: {{ include "mongodb.names.name" . }}
helm.sh/chart: {{ include "mongodb.names.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Labels to use on deploy.spec.selector.matchLabels and svc.spec.selector
*/}}
{{- define "mongodb.labels.matchLabels" -}}
app.kubernetes.io/name: {{ include "mongodb.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
