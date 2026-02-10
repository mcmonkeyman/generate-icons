#!/usr/bin/env bash
set -euo pipefail

IN_SVG="${1:?usage: svg-to-png.sh <input.svg> <size> <output.png>}"
SIZE="${2:?usage: svg-to-png.sh <input.svg> <size> <output.png>}"
OUT_PNG="${3:?usage: svg-to-png.sh <input.svg> <size> <output.png>}"

if ! command -v rsvg-convert &>/dev/null; then
  echo "ERROR: rsvg-convert not found. Install with: brew install librsvg" >&2
  exit 1
fi

mkdir -p "$(dirname "$OUT_PNG")"
rsvg-convert -w "$SIZE" -h "$SIZE" "$IN_SVG" -o "$OUT_PNG"
