#!/bin/sh

set -e

mkdir -p ~/.kube/
touch ~/.kube/config

echo ${KUBE_CONFIG_DATA} | base64 -d > ~/.kube/config

chmod go-r ~/.kube/config

sh -c " $*"
