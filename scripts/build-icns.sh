#!/usr/bin/env bash
set -euo pipefail

IN_FILE="${1:?usage: build-icns.sh <input.png|input.svg> <output.icns>}"
OUT_ICNS="${2:?usage: build-icns.sh <input.png|input.svg> <output.icns>}"

mkdir -p "$(dirname "$OUT_ICNS")"

EXT="${IN_FILE##*.}"
SIZES=(16 32 64 128 256 512 1024)

ICONSET_DIR="$(mktemp -d)"
trap 'rm -rf "$ICONSET_DIR"' EXIT

# Rename temp dir to have .iconset extension (required by iconutil)
ICONSET="${ICONSET_DIR}.iconset"
mv "$ICONSET_DIR" "$ICONSET"
trap 'rm -rf "$ICONSET"' EXIT

render_png() {
  local size="$1" out="$2"
  if [[ "$EXT" == "svg" ]]; then
    rsvg-convert -w "$size" -h "$size" "$IN_FILE" -o "$out"
  else
    sips -z "$size" "$size" "$IN_FILE" --out "$out" >/dev/null
  fi
}

for SIZE in "${SIZES[@]}"; do
  render_png "$SIZE" "$ICONSET/icon_${SIZE}x${SIZE}.png"

  if (( SIZE < 1024 )); then
    RETINA=$((SIZE * 2))
    if (( RETINA <= 1024 )); then
      render_png "$RETINA" "$ICONSET/icon_${SIZE}x${SIZE}@2x.png"
    fi
  fi
done

iconutil -c icns "$ICONSET" -o "$OUT_ICNS"
echo "Wrote $OUT_ICNS"
