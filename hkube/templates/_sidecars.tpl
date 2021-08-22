{{/*
fluent bit sidecar
*/}}
{{- define "hkube.fluent_bit.sidecar" -}}
{{- if .Values.global.sidecars.fluent_bit.enable -}}
- name: sidecar-log-collector    
  image: "{{ .Values.global.registry }}{{ .Values.global.sidecars.fluent_bit.image.repository }}:{{ .Values.global.sidecars.fluent_bit.image.tag }}"
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  env: []
  resources:
{{ toYaml .Values.global.sidecars.fluent_bit.resources | indent 4 }}
{{ include "hkube.fluent_bit.volumemount_full" . | indent 2 }}
    - name: fluent-bit-cm
      mountPath: /fluent-bit/etc/
{{- end -}}
{{- end -}}

{{/*
fluent bit volume mount
*/}}
{{- define "hkube.fluent_bit.volumemount" -}}
{{- if .Values.global.sidecars.fluent_bit.enable -}}
- name: log-storage
  mountPath: {{ .Values.global.sidecars.fluent_bit.config.mount_path }} 
{{- end -}}
{{- end -}}

{{/*
fluent bit volume mount full
*/}}
{{- define "hkube.fluent_bit.volumemount_full" -}}
{{- if .Values.global.sidecars.fluent_bit.enable -}}
volumeMounts:
{{ include "hkube.fluent_bit.volumemount" . | indent 2 }}
{{- end -}}
{{- end -}}

{{/*
fluent bit volume
*/}}
{{- define "hkube.fluent_bit.volume" -}}
{{- if .Values.global.sidecars.fluent_bit.enable -}}
- name: log-storage
  emptyDir: {}
- name: fluent-bit-cm
  configMap:
    name: {{ .Values.global.sidecars.fluent_bit.config.name }}
{{- end -}}
{{- end -}}

{{/*
fluent bit volume full
*/}}
{{- define "hkube.fluent_bit.volume_full" -}}
{{- if .Values.global.sidecars.fluent_bit.enable -}}
volumes:
{{ include "hkube.fluent_bit.volume" . | indent 2 }}
{{- end -}}
{{- end -}}


{{/*
fluent bit config
*/}}
{{- define "hkube.fluent_bit.config" -}}
fluent-bit.conf: |-
    [SERVICE]
        Flush     5
        Daemon    off
        Log_Level {{ .Values.global.sidecars.fluent_bit.config.logLevel | default "info" }}
        Parsers_File parsers.conf
    [INPUT]
        Name tail
        Path {{ .Values.global.sidecars.fluent_bit.config.mount_path }}/{{ .Values.global.sidecars.fluent_bit.config.log_file }}
        Parser json
        Tag kube.*
        Mem_Buf_Limit 5mb
        Skip_Long_Lines On
    [FILTER]
        Name modify
        Match kube.*
        Add pod_name ${HOSTNAME}
    [OUTPUT]
        Name es
        Match kube.*
        Host {{ .Values.global.sidecars.fluent_bit.config.es.url }}
        Port {{ .Values.global.sidecars.fluent_bit.config.es.port }}
        Logstash_Format On
        Logstash_Prefix {{ .Values.global.sidecars.fluent_bit.config.es.logStashPrefix }}
        HTTP_User {{ .Values.global.sidecars.fluent_bit.config.es.user }}
        HTTP_Passwd {{ .Values.global.sidecars.fluent_bit.config.es.password }}
        Retry_Limit False
        Replace_Dots On
        tls {{ .Values.global.sidecars.fluent_bit.config.es.tls }}
        tls.verify {{ .Values.global.sidecars.fluent_bit.config.es.tls_verify }}
parsers.conf: |-
    [PARSER]
        Name json
        Format json
        Time_Keep off
        Time_Key time
        Time_Format %Y-%m-%d%T%H:%M:%S.%L
{{- end -}}