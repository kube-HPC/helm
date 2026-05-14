{{/* vim: set filetype=mustache: */}}
{{/*
Kubernetes standard labels
Supports both old-style call (passing . directly) and new-style dict call
(dict "customLabels" .Values.commonLabels "context" $)
*/}}
{{- define "common.labels.standard" -}}
{{- if and (hasKey . "customLabels") (hasKey . "context") -}}
{{- $ctx := .context -}}
app.kubernetes.io/name: {{ include "common.names.name" $ctx }}
helm.sh/chart: {{ include "common.names.chart" $ctx }}
app.kubernetes.io/instance: {{ $ctx.Release.Name }}
app.kubernetes.io/managed-by: {{ $ctx.Release.Service }}
{{- if and .customLabels (ne (typeOf .customLabels) "string") (gt (len .customLabels) 0) }}
{{ toYaml .customLabels | trim }}
{{- end -}}
{{- else -}}
app.kubernetes.io/name: {{ include "common.names.name" . }}
helm.sh/chart: {{ include "common.names.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
{{- end -}}

{{/*
Labels to use on deploy.spec.selector.matchLabels and svc.spec.selector
Supports both old-style call and new-style dict call.
*/}}
{{- define "common.labels.matchLabels" -}}
{{- if and (hasKey . "customLabels") (hasKey . "context") -}}
{{- $ctx := .context -}}
app.kubernetes.io/name: {{ include "common.names.name" $ctx }}
app.kubernetes.io/instance: {{ $ctx.Release.Name }}
{{- else -}}
app.kubernetes.io/name: {{ include "common.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
{{- end -}}
