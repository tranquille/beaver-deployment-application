#!/usr/bin/env bash
set -eo pipefail

export EXTERNAL_DOMAIN=obi.test
export CI_COMMIT_SHA=1a2b3c4d
export CI_PROJECT_NAME=kubehelmdocker
export CI_PROJECT_NAMESPACE=devops

color_red='\033[0;31m'
color_green='\033[0;32m'
color_reset='\033[0m'

assert() {
  if [ "$1" = "$2" ]; then
    echo -e "${color_green}[OK] $3${color_reset}"
  else
    echo -e "${color_red}[ERROR] $3${color_reset}\\n\\t$1 != $2\\n"
    return 1
  fi;
}

test_command() {
  local stage
  local route
  local subdomain

  helm template . --notes -x templates/NOTES.txt \
  --set ci.projectName=$CI_PROJECT_NAME \
  --set ingress.externalDomain=$EXTERNAL_DOMAIN \
  --set ingress.subdomain=$subdomain \
  --set ingress.stage=$stage \
  --set ingress.class=$route
}

assert \
  "$(test_command | grep 'Domain' | awk '{ print $2 }')" \
  "$CI_PROJECT_NAME-preproduction.paas-preprod01.obi.dmz" \
  "Should apply default values (route=intern stage=preproduction)"

assert \
  "$(route=intern stage=preproduction test_command | grep 'Domain' | awk '{ print $2 }')" \
  "${CI_PROJECT_NAME}-preproduction.paas-preprod01.obi.dmz" \
  "Should have correct host name for intern/preproduction"

assert \
  "$(route=intern stage=production test_command | grep 'Domain' | awk '{ print $2 }')" \
  "${CI_PROJECT_NAME}-production.paas-intern01.obi.dmz" \
  "Should have correct host name for intern/production"

assert \
  "$(route=extern stage=preproduction test_command | grep 'Domain' | awk '{ print $2 }')" \
  "${CI_PROJECT_NAME}-preproduction.paas-preprod01.obi.dmz" \
  "Should have correct host name for extern/preproduction"

assert \
  "$(route=extern stage=preproduction subdomain=subdomain test_command | grep 'Domain' | awk '{ print $2 }')" \
  "subdomain.paas-preprod01.obi.dmz" \
  "Should apply custom subdomain for extern/preproduction"

assert \
  "$(route=extern stage=production test_command | grep 'Domain' | awk '{ print $2 }')" \
  "$EXTERNAL_DOMAIN" \
  "Should apply external domain for extern/production"
