#!/usr/bin/env bash

figlet Multitool

echo "Version: ${MULTITOOL_VERSION}"

echo "[ + ] system"
echo

cat /etc/os-release | grep -E "PRETTY_NAME|DEBIAN_VERSION_FULL"

echo
echo "[ + ] docker"
echo

docker --version

echo
echo "[ + ] kubectl"
echo

kubectl version --client=true

echo
echo "[ + ] helm"
echo

helm version

echo
echo "[ + ] utils"
echo

jq --version
yq --version
