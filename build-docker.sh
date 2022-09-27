#!/usr/bin/env bash
set -euo pipefail

CURR_DIR=$(
  cd "$(dirname "${0}")" || return
  pwd
)

git pull
repo="bobfintech/baas"
commit_id=$(git log -1 --abbrev-commit --pretty=oneline | awk '{print $1}')
if [ "$1" ];then
  docker build --no-cache -t "${repo}/solo:1.0_${commit_id}" -f "${CURR_DIR}/Dockerfile" "${CURR_DIR}"
else
  docker build -t "${repo}/solo:1.0_${commit_id}" -f "${CURR_DIR}/Dockerfile" "${CURR_DIR}"
fi
