#!/usr/bin/env bash

helm lint charts/*
for chart in charts/*; do helm dep up $chart; done
helm package -d docs charts/*
helm repo index docs --url https://wildbeavers.github.io/beaver-deployment-application/
echo "" > docs/README.md
echo "" > docs/README2.md
find ./charts -name "*.md" -exec sh -c "cat {} >> docs/README2.md" \;
cat ./README.md >> docs/README.md
cat ./docs/README2.md | ./gh-md-toc.sh - >> docs/README.md
cat ./docs/README2.md >> docs/README.md
