---
source: https://github.com/Leonxlnx/taste-skill/blob/main/skills/minimalist-skill/SKILL.md
snapshot_date: 2026-05-18
license: MIT. See minimalist-ui.LICENSE in this directory.
---

# minimalist-ui Reference Snapshot

This is a local reference snapshot for `site-design-orchestration`. It is not an active project skill. Use it as a site-specific quality reference when a managed site needs restrained editorial minimalism.

For `leks.us`, prefer this reference over the broader `taste-skill.md` reference unless the user asks for a more expressive redesign.

# Protocol: Premium Utilitarian Minimalism UI Architect

## 1. Protocol Overview

Name: Premium Utilitarian Minimalism & Editorial UI.

Description: an advanced frontend engineering directive for generating refined, ultra-minimalist, document-style web interfaces analogous to top-tier workspace platforms.

This protocol enforces:

- warm monochrome palette;
- typographic contrast;
- structural macro-whitespace;
- flat bento/grid architecture when grids are appropriate;
- muted pastel accents;
- rejection of generic SaaS design trends.

## 2. Absolute Negative Constraints

Avoid these defaults:

- Do not use `Inter`, `Roboto`, or `Open Sans`.
- Do not use generic thin-line icon libraries like Lucide, Feather, or standard Heroicons when icon style is open.
- Do not use heavy default Tailwind shadows such as `shadow-md`, `shadow-lg`, or `shadow-xl`.
- Do not use primary colored backgrounds for large elements or sections.
- Do not use gradients, neon colors, or 3D glassmorphism.
- Do not use `rounded-full` pill shapes for large containers, cards, or primary buttons.
- Do not use emojis in code, markup, UI text, headings, or alt text.
- Do not use generic placeholder names, `Lorem Ipsum`, or generic companies.
- Do not use AI copywriting cliches such as “Elevate”, “Seamless”, “Unleash”, “Next-Gen”, “Game-changer”, or “Delve”.

## 3. Typographic Architecture

Use typographic contrast and premium font selection to establish an editorial feel.

- Primary sans-serif: use clean geometric or system-native fonts with character, such as `SF Pro Display`, `Geist Sans`, `Helvetica Neue`, or `Switzer`.
- Editorial serif: for hero headings or quotes when appropriate, use `Lyon Text`, `Newsreader`, `Playfair Display`, or `Instrument Serif`.
- Monospace: use `Geist Mono`, `SF Mono`, or `JetBrains Mono`.
- Body text must not be absolute black. Prefer off-black or charcoal such as `#111111` or `#2F3437`.
- Secondary text should be muted gray such as `#787774`.
- Body copy should use generous line height, around `1.6`.

## 4. Color Palette

Color should be scarce and used for semantic meaning or subtle accents.

- Canvas: white or warm off-white such as `#FFFFFF`, `#F7F6F3`, or `#FBFBFA`.
- Primary surface: `#FFFFFF` or `#F9F9F8`.
- Structural borders/dividers: ultra-light gray such as `#EAEAEA` or `rgba(0,0,0,0.06)`.
- Accents: use highly desaturated washed-out pastels for tags, inline code backgrounds, or subtle highlights.

Suggested accent pairs:

- Pale red: `#FDEBEC`, text `#9F2F2D`.
- Pale blue: `#E1F3FE`, text `#1F6C9F`.
- Pale green: `#EDF3EC`, text `#346538`.
- Pale yellow: `#FBF3DB`, text `#956400`.

## 5. Component Specifications

- Bento/grid cards, when used, should have `border: 1px solid #EAEAEA`.
- Border radius should be crisp: `8px` or `12px` maximum.
- Internal padding should be generous: `24px` to `40px`.
- Primary actions should use solid off-black backgrounds, white text, slight radius, and no box-shadow.
- Hover states should be subtle: color shift or tiny active scale.
- Tags/status badges may be small pills with muted pastel backgrounds and compact uppercase text.
- Accordions should be stripped down, separated by borders.
- Keystrokes should use `<kbd>` styling with light border, warm background, and monospace.
- Software mockups may use minimalist faux-OS window chrome, but only when contextually useful.

## 6. Iconography And Imagery

- Prefer Phosphor Icons in bold/fill weights or Radix UI Icons when icon choice is open.
- Standardize icon stroke/weight.
- Illustrations should be monochromatic, minimal, and contextual.
- Photography should be desaturated and warm if real assets are available.
- Do not use oversaturated stock-like media.

## 7. Subtle Motion

Motion should be nearly invisible and never distracting.

- Scroll entry can use gentle opacity/translateY transitions.
- Hover states can use ultra-subtle shadow shifts or active scale.
- Animate only `transform` and `opacity`.
- Avoid layout-triggering animation properties.
- For `leks.us`, keep motion minimal unless the user explicitly requests implementation polish.

## 8. Execution Protocol

When designing or implementing:

1. Establish macro-whitespace first.
2. Constrain main typography widths.
3. Apply monochromatic color variables early.
4. Keep cards, dividers, and borders crisp and quiet.
5. Use plain, specific content from the actual site.
6. Avoid future-facing sections unless the user provides content or asks to expand the site.
7. Preserve an uncluttered editorial aesthetic without requiring manual cleanup.
