#!/usr/bin/env bash

helm lint charts/*
for chart in charts/*; do helm dep up $chart; done
helm package -d docs charts/*
helm repo index docs --url https://wildbeavers.github.io/beaver-deployment-application/
echo "# Beaver Charts" > docs/README.md
find ./charts -name "*.md" -exec sh -c "cat {} >> docs/README.md" cat {} \;
