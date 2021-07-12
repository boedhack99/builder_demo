#!/bin/bash

mkdir -p ~/rom
cd ~/rom || exit 1

# Sync Fresh Files From Git Server
_repo_sync_fresh_files() {
  repo init -q --no-repo-verify --depth=1 -u git://github.com/LineageOS/android.git -b lineage-18.1 -g default,-device,-mips,-darwin,-notdefault
  git clone https://github.com/boedhack/local_manifest.git --depth 1 -b 11 .repo/local_manifests
  time repo sync -c -q --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j16
}

if [[ $# = 0 || "${1}" = "fresh" ]]; then
  _repo_sync_fresh_files
fi
