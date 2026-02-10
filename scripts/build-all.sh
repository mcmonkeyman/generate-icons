#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-all}" # all | icns | png

SRC_DIR="icons"
OUT_DIR="dist"

mkdir -p "$OUT_DIR/icns" "$OUT_DIR/png"

shopt -s nullglob
ICONS=("$SRC_DIR"/*.png "$SRC_DIR"/*.svg)

if (( ${#ICONS[@]} == 0 )); then
  echo "ERROR: no source icons found in $SRC_DIR" >&2
  exit 1
fi

# Check for rsvg-convert if any SVGs exist
HAS_SVG=0
for ICON in "${ICONS[@]}"; do
  [[ "${ICON##*.}" == "svg" ]] && HAS_SVG=1 && break
done

if (( HAS_SVG )) && ! command -v rsvg-convert &>/dev/null; then
  echo "ERROR: SVG sources found but rsvg-convert is not installed." >&2
  echo "       Install with: brew install librsvg" >&2
  exit 1
fi

for ICON in "${ICONS[@]}"; do
  BASENAME="$(basename "$ICON")"
  NAME="${BASENAME%.*}"

  case "$MODE" in
    all)
      ./scripts/build-icns.sh "$ICON" "$OUT_DIR/icns/$NAME.icns"
      ./scripts/build-png-set.sh "$ICON" "$OUT_DIR/png/$NAME"
      ;;
    icns)
      ./scripts/build-icns.sh "$ICON" "$OUT_DIR/icns/$NAME.icns"
      ;;
    png)
      ./scripts/build-png-set.sh "$ICON" "$OUT_DIR/png/$NAME"
      ;;
    *)
      echo "ERROR: unknown mode: $MODE" >&2
      exit 2
      ;;
  esac
done
