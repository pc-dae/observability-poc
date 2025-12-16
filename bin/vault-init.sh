#!/usr/bin/env bash

# Utility for initializing vault
# Version: 1.0
# Author: Paul Carlton (mailto:paul.carlton@tesco.com)

set -euo pipefail

function usage()
{
    echo "usage ${0} [--debug] " >&2
    echo "This script will initialize vault" >&2
}

function args() {
  arg_list=( "$@" )
  arg_count=${#arg_list[@]}
  arg_index=0
  tls_skip=""
  while (( arg_index < arg_count )); do
    case "${arg_list[${arg_index}]}" in
          "--tls-skip") tls_skip="-tls-skip-verify";;
          "--debug") set -x;;
               "-h") usage; exit;;
           "--help") usage; exit;;
               "-?") usage; exit;;
        *) if [ "${arg_list[${arg_index}]:0:2}" == "--" ];then
               echo "invalid argument: ${arg_list[${arg_index}]}" >&2
               usage; exit
           fi;
           break;;
    esac
    (( arg_index+=1 ))
  done
}

args "$@"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/envs.sh

# Wait for vault to start
while ( true ); do
  echo "Waiting for vault to start"
  set +e
  started="$(kubectl get pod/vault-0 -n vault -o json 2>/dev/null | jq -r '.status.containerStatuses[0].started')"
  set -e
  if [ "$started" == "true" ]; then
    break
  fi
  sleep 5
done

while ( true); do
  set +e
  vault status --format=json $tls_skip > /tmp/vault-status.json 2>/dev/null
  set -e
  if [ "$(jq -r '.initialized' /tmp/vault-status.json)" == "true" ]; then
    echo "Vault already initialized"
    break
  fi
  vault operator init $tls_skip -format=json > secrets/.vault-init.json
done
