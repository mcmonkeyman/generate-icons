# generate-icons

Scripts that convert source images (PNG or SVG) into macOS `.icns` files and multi-size PNG sets.

## Requirements

- **macOS** — uses `sips` and `iconutil`
- **librsvg** (optional) — required only if you have SVG sources: `brew install librsvg`

Run `make check-deps` to verify.

## Quick start

```sh
cp ~/my-icon.png icons/       # 1. add a 1024×1024 PNG (or SVG) to icons/
make                          # 2. build everything
```

That's it. You'll find the output in `dist/`:

```
dist/
├── icns/my-icon.icns                  # macOS app icon
└── png/my-icon/{16,32,48,128,256}.png # multi-size PNGs
```

## Other targets

```sh
make icns     # .icns only
make png      # PNG sets only
make verify   # validate sources without building
make clean    # wipe dist/
```
