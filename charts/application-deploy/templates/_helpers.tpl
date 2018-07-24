{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 24 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fullname" -}}
{{- if .Values.nameOverride -}}
{{- .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trimSuffix "-app" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Define ingress stage. Can be either 'preproduction' or 'production'.
*/}}
{{- define "ingress.stage" -}}
  {{- $ingressStage := lower .Values.ingress.stage -}}
  {{- eq $ingressStage "production" | ternary "production" "preproduction" -}}
{{- end -}}


{{/*
Define hostname based on ingress stage.
*/}}
{{- define "ingress.host" -}}
  {{- $ingressStage := include "ingress.stage" . -}}
  {{- eq $ingressStage "preproduction" | ternary "paas-preprod01.obi.dmz" "paas-intern01.obi.dmz" -}}
{{- end -}}

{{/*
Define ingress class. Can be either 'intern' or 'extern'.
Routes for preproduction environments are always internal.
*/}}
{{- define "ingress.class" -}}
  {{- $ingressClass := lower .Values.ingress.class -}}
  {{- $ingressStage := include "ingress.stage" . -}}
  {{- and (eq $ingressClass "extern") (not (eq $ingressStage "preproduction")) | ternary "extern" "intern" -}}
{{- end -}}

{{/*
Define ingress.fqdn. Requires external domain for production deployments.
*/}}
{{- define "ingress.fqdn" -}}
  {{- $ingressClass := include "ingress.class" . -}}
  {{- $ingressStage := include "ingress.stage" . -}}
  {{- if and (eq $ingressStage "production") (eq $ingressClass "extern") -}}
    {{- required "A domain name is required for external production builds." .Values.ingress.externalDomain -}}
  {{- else -}}
    {{- $defaultHostPrefix := printf "%s-%s" .Values.ci.projectName $ingressStage -}}
    {{- $hostPrefix := default $defaultHostPrefix .Values.ingress.subdomain -}}
    {{- $host := include "ingress.host" . -}}
    {{- printf "%s.%s" $hostPrefix $host -}}
  {{- end -}}
{{- end -}}
