#!/usr/bin/env bash
helm lint charts/*
for chart in charts/*; do helm dep up $chart; done
helm package -d docs charts/*
helm repo index docs --url https://github.com/WildBeavers/beaver-deployment-application/docs