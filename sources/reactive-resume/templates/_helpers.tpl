{{/*
Expand the name of the chart.
*/}}
{{- define "reactive-resume.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "reactive-resume.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "reactive-resume.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "reactive-resume.server.labels" -}}
helm.sh/chart: {{ include "reactive-resume.chart" . }}
{{ include "reactive-resume.server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "reactive-resume.client.labels" -}}
helm.sh/chart: {{ include "reactive-resume.chart" . }}
{{ include "reactive-resume.client.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels - server
*/}}
{{- define "reactive-resume.server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "reactive-resume.name" . }}-server
app.kubernetes.io/instance: {{ .Release.Name }}-server
{{- end }}

{{/*
Selector labels - client
*/}}
{{- define "reactive-resume.client.selectorLabels" -}}
app.kubernetes.io/name: {{ include "reactive-resume.name" . }}-client
app.kubernetes.io/instance: {{ .Release.Name }}-client
{{- end }}

