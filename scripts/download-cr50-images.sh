#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "usage: $0 <cr50 image output dir>" >&2
    exit 1
fi

out="$1"
prod="$out/prod"
prepvt="$out/prepvt"

mkdir -p "$prod" "$prepvt"

gsutil ls gs://chromeos-localmirror/distfiles \
    | grep '/cr50' \
    | grep '\.tbz2$' \
    | sort -V \
    | while read -r uri; do
        name="${uri##*/}"

        case "$name" in
            *FFFF_00000000_00000010*|*ffff_00000000_00000010*)
                dst="$prepvt/$name"
                ;;
            *)
                dst="$prod/$name"
                ;;
        esac

        echo "$uri -> $dst"
        gsutil cp "$uri" "$dst"
    done
