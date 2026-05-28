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
  mkdir -p "${NOS_DIR}/citadel/prod" "${NOS_DIR}/dauntless"
  /usr/bin/env bash "${SCRIPT_DIR}/nugget-os/citadel/citadel-downloader.sh" "${NOS_DIR}/citadel/prod"
  /usr/bin/env bash "${SCRIPT_DIR}/nugget-os/dauntless/dauntless-downloader.sh" "${NOS_DIR}/dauntless"
fi
