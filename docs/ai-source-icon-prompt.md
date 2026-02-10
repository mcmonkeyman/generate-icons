# AI Source Icon Prompt Spec

## Goal
Generate a single source icon that:
- Scales cleanly to 16px
- Works for macOS ICNS and web PNG sets
- Has a strong, simple silhouette

## Preferred Format

**SVG** — the pipeline renders each output size directly from the SVG, producing the sharpest results at every scale. PNG (1024x1024, transparent) is also supported but SVG is preferred.

## Constraints
- Square aspect ratio
- Transparent background
- No text, no letters, no watermark
- Minimal detail — simple geometry
- Centered composition
- ~10-15% padding (safe area)
- Avoid thin strokes and micro-details

## Prompt Template

Create a square SVG app icon with a transparent background.

Subject: <describe the symbol or metaphor>
Brand tone: <developer tool / professional / friendly>
Style: flat or lightly shaded, geometric
Detail level: low
Avoid thin strokes and micro-details
No background plate unless specified
No text or lettering
High contrast
Centered composition
Transparent background

Output:
- SVG with viewBox="0 0 1024 1024"
- Crisp, simple geometry
- No raster elements embedded

## Example

Create a square SVG app icon with a transparent background.

Subject: a stylized portal made of two overlapping rounded rectangles forming a doorway.
Brand tone: modern developer tool, calm and confident.
Style: geometric, minimal.
No text or watermark.
Leave ~12% padding.
High contrast.
Transparent background.

Deliver as an SVG with viewBox="0 0 1024 1024".

## Validation Checklist
- Does it read at 16px?
- Does it remain crisp at 32px?
- Are shapes bold enough?
- Is contrast sufficient?
- Is the geometry simple enough for clean rasterization?
