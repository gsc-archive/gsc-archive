#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CR50_DIR="${SCRIPT_DIR}/../firmware/cr50"
TI50_DIR="${SCRIPT_DIR}/../firmware/ti50"
NOS_DIR="${SCRIPT_DIR}/../firmware/nugget-os"


mkdir -p "${CR50_DIR}/prod"
mkdir -p "${CR50_DIR}/prepvt"

mkdir -p "${TI50_DIR}/prod/dauntless"
mkdir -p "${TI50_DIR}/prepvt/dauntless"

mkdir -p "${TI50_DIR}/prod/nuvotitan"
mkdir -p "${TI50_DIR}/prepvt/nuvotitan"

/usr/bin/env bash "${SCRIPT_DIR}/download-cr50-images.sh" "${CR50_DIR}"
/usr/bin/env bash "${SCRIPT_DIR}/download-ti50-images.sh" "${TI50_DIR}"

if [ -d "${NOS_DIR}" && -d "${SCRIPT_DIR}/nugget-os" ]; then
  # we only have citadel suppot for right now
  # in the future, we'll want to start downloading Dauntless firmware for Pixel 6+.
  /usr/bin/env bash "${SCRIPT_DIR}/citadel/citadel-downloader.sh" "${NOS_DIR}"
fi