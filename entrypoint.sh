#!/bin/sh

set -e

mkdir -p ~/.kube/
touch ~/.kube/config

echo "${KUBE_CONFIG_DATA}" | base64 -d > ~/.kube/config

chmod go-r ~/.kube/config

ADD_REPOS_CMD=$(echo "$INPUT_REPOS" | awk 'NF {print "helm repo add", $1,$2}')

if [ -n "$ADD_REPOS_CMD" ]; then
  eval "$ADD_REPOS_CMD"
fi

ADD_PLUGINS_CMD=$(echo "$INPUT_PLUGINS" | awk -F@ 'NF {print "helm plugin install", $1, "--version", $2}')

if [ -n "$ADD_PLUGINS_CMD" ]; then
  eval "$ADD_PLUGINS_CMD"
fi

sh -c " $*"
