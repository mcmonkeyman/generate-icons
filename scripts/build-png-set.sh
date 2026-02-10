#!/usr/bin/env bash
set -euo pipefail

IN_FILE="${1:?usage: build-png-set.sh <input.png|input.svg> <output_dir>}"
OUT_DIR="${2:?usage: build-png-set.sh <input.png|input.svg> <output_dir>}"

mkdir -p "$OUT_DIR"

EXT="${IN_FILE##*.}"
SIZES=(16 32 48 128 256)

for SIZE in "${SIZES[@]}"; do
  if [[ "$EXT" == "svg" ]]; then
    rsvg-convert -w "$SIZE" -h "$SIZE" "$IN_FILE" -o "$OUT_DIR/${SIZE}.png"
  else
    sips -z "$SIZE" "$SIZE" "$IN_FILE" --out "$OUT_DIR/${SIZE}.png" >/dev/null
  fi
done

echo "Wrote PNG set: $OUT_DIR"
