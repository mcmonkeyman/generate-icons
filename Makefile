SHELL := /bin/bash

.PHONY: all icns png verify clean check-deps

all: verify icns png

icns:
	./scripts/build-all.sh icns

png:
	./scripts/build-all.sh png

verify:
	./scripts/verify-sources.sh icons

clean:
	rm -rf dist
	mkdir -p dist/icns dist/png

check-deps:
	@command -v sips >/dev/null || { echo "ERROR: sips not found (macOS required)"; exit 1; }
	@command -v iconutil >/dev/null || { echo "ERROR: iconutil not found (macOS required)"; exit 1; }
	@command -v rsvg-convert >/dev/null && echo "✓ rsvg-convert available (SVG support)" || echo "⚠ rsvg-convert not found — SVG sources won't work (brew install librsvg)"
