#!/usr/bin/env bash
set -euo pipefail

ICON_DIR="${1:-icons}"

if [[ ! -d "$ICON_DIR" ]]; then
  echo "ERROR: icon dir not found: $ICON_DIR" >&2
  exit 1
fi

shopt -s nullglob
files=("$ICON_DIR"/*.png "$ICON_DIR"/*.svg)

if (( ${#files[@]} == 0 )); then
  echo "ERROR: no source icons found in $ICON_DIR" >&2
  exit 1
fi

fail=0

for f in "${files[@]}"; do
  ext="${f##*.}"

  if [[ "$ext" == "png" ]]; then
    w=$(sips -g pixelWidth "$f" 2>/dev/null | awk -F': ' '/pixelWidth/ {print $2}' | tr -d ' ')
    h=$(sips -g pixelHeight "$f" 2>/dev/null | awk -F': ' '/pixelHeight/ {print $2}' | tr -d ' ')

    if [[ "$w" != "1024" || "$h" != "1024" ]]; then
      echo "✗ $f  (expected 1024x1024, got ${w:-?}x${h:-?})"
      fail=1
    else
      echo "✓ $f  (1024x1024 PNG)"
    fi

  elif [[ "$ext" == "svg" ]]; then
    if ! command -v rsvg-convert &>/dev/null; then
      echo "✗ $f  (rsvg-convert not found — brew install librsvg)"
      fail=1
      continue
    fi

    tmp="$(mktemp)"
    if rsvg-convert -w 1 -h 1 "$f" -o "$tmp" 2>/dev/null; then
      rm -f "$tmp"
      echo "✓ $f  (valid SVG)"
    else
      rm -f "$tmp"
      echo "✗ $f  (invalid SVG — failed to parse)"
      fail=1
    fi
  fi
done

if (( fail )); then
  echo
  echo "One or more source icons failed validation. Fix them before building."
  exit 2
fi
