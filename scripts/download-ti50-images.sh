#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "usage: $0 <ti50 image output dir>" >&2
    exit 1
fi

out="$1"

mkdir -p \
    "$out/prod/dauntless" \
    "$out/prod/nuvotitan" \
    "$out/prepvt/dauntless" \
    "$out/prepvt/nuvotitan"

gsutil ls gs://chromeos-localmirror/distfiles \
    | grep '/ti50' \
    | grep '\.tar\.xz$' \
    | sort -V \
    | while read -r uri; do
        name="${uri##*/}"

        case "$name" in
            *FFFF_00000000_00000010*|*ffff_00000000_00000010*)
                kind="prepvt"
                ;;
            *)
                kind="prod"
                ;;
        esac

        case "$name" in
            *-nt*)
                chip="nuvotitan"
                ;;
            *)
                chip="dauntless"
                ;;
        esac

        dst="$out/$kind/$chip/$name"

        echo "$uri -> $dst"
        gsutil cp "$uri" "$dst"
    done
