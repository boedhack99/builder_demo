#!/bin/bash

ccache_task="${1}"    # upload/download

CCache_URL="https://server.boedhack.workers.dev/ccache/ci2/ccache.tgz"

mkdir -p /home/runner/.cache/ccache /home/runner/.config/rclone

cd /home/runner/.cache/

if [[ ${ccache_task} =~ upload ]]; then
  printf "Compressing ccache data...\n"
  tar -I "pigz -k -3" -cf ccache.tgz ccache
  du -sh ccache.tgz
  printf "Setting up rclone and uploading...\n"
  echo "${RCLONE}" > /home/runner/.config/rclone/rclone.conf
  rclone delete td:/mojito_ccache/ccache.tgz 2>/dev/null || true
  rclone copy ccache.tgz td:/mojito_ccache/ --progress
  rm -rf ccache.tgz
elif [[ ${ccache_task} =~ download ]]; then
  printf "Downloading previous ccache...\n"
  aria2c -c -x8 -s16 "${CCache_URL}"
  printf "Expanding ccache files...\n"
  tar -I "pigz" -xf ccache.tgz
  rm -rf ccache.tgz
fi
