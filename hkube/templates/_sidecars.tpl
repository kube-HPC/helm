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

{{/* fluent bit environment */}}
{{- define "hkube.fluent_bit.environment" -}}
{{- if .Values.global.sidecars.fluent_bit.enable -}}
- name: HKUBE_LOG_FILE_ENABLED
  value: "true"
- name: HKUBE_LOG_FILE_NAME
  value: "{{ .Values.global.sidecars.fluent_bit.config.mount_path }}/hkube.log"
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
        Config_Watch  true
    [INPUT]
        Name tail
        Path {{ .Values.global.sidecars.fluent_bit.config.mount_path }}/{{ .Values.global.sidecars.fluent_bit.config.log_file }}
        Parser json
        Tag hkube.{{ .Release.Namespace }}_${HOSTNAME}_hkube.log
        Mem_Buf_Limit 5mb
        Refresh_Interval 10
        # Skip_Long_Lines On
    [FILTER]
        Name modify
        Match kube.*
        Add my.pod_name ${HOSTNAME}
    [FILTER]
        Name             kubernetes
        Match            hkube.*
        Kube_URL         https://kubernetes.default.svc:443
        Kube_CA_File     /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
        Kube_Token_File  /var/run/secrets/kubernetes.io/serviceaccount/token
        Kube_Tag_Prefix  hkube.
        Merge_Log        On
        Merge_Log_Key    log_processed
        Regex_Parser     kube-custom
    [OUTPUT]
        Name es
        Match hkube.*
        Host {{ .Values.global.sidecars.fluent_bit.config.es.url }}
        Port {{ .Values.global.sidecars.fluent_bit.config.es.port }}
        Logstash_Format On
        Logstash_Prefix {{ .Values.global.sidecars.fluent_bit.config.es.logStashPrefix }}
{{- if .Values.global.sidecars.fluent_bit.config.es.user }}
        HTTP_User {{ .Values.global.sidecars.fluent_bit.config.es.user }}
        HTTP_Passwd {{ .Values.global.sidecars.fluent_bit.config.es.password }}
{{- end }}
        Retry_Limit False
        Replace_Dots On
        tls {{ .Values.global.sidecars.fluent_bit.config.es.tls }}
{{- if eq .Values.global.sidecars.fluent_bit.config.es.tls "On" }}
        tls.verify {{ .Values.global.sidecars.fluent_bit.config.es.tls_verify }}
{{- end }}
parsers.conf: |-
    [PARSER]
        Name json
        Format json
        Time_Keep off
        Time_Key time
        Time_Format %Y-%m-%d%T%H:%M:%S.%L
    [PARSER]
        Name    kube-custom
        Format  regex
        Regex   (?<namespace_name>.+)_(?<pod_name>.+)_hkube\.log$
{{- end -}}