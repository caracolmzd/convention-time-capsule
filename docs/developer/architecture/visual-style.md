# Visual style — Convention Time Capsule UI

Implementation style guide derived from [aflcio.org/convention-info](https://aflcio.org/convention-info) and the AFL-CIO site theme CSS. This is a **derived guide** for the Time Capsule app — not a replacement for the official brand system at [redesign-docs.aflcio.org](https://redesign-docs.aflcio.org/).

Architecture context: [time-capsule.md](time-capsule.md).

## Design intent

Match AFL-CIO convention digital presence: institutional strength, clarity, and worker-centered optimism. Favor readable forms and calm content sections over heavy chrome unless stakeholders request full site header/footer (see [mvp-scoping.md](../approach/mvp-scoping.md)).

## Color palette

| Token | Hex | Usage |
|-------|-----|-------|
| `brand-teal` | `#115e67` | Theme color, default links |
| `brand-orange` | `#f4633a` | Link hover, primary CTA buttons |
| `brand-orange-dark` | `#d94b20` | CTA hover state |
| `brand-yellow` | `#ffd757` | Accent backgrounds |
| `brand-yellow-light` | `#ffdd71`, `#ffe38a` | Yellow tints |
| `teal-muted` | `#cfe5e5` | Light teal accent, success borders |
| `text-primary` | `#373a3a` | Body copy |
| `text-muted` | `#6f7777`, `#818a91` | Secondary text |
| `surface-dark` | `#000000` | Hero / convention band (optional) |
| `surface-white` | `#ffffff` | Content sections |
| `surface-page` | `#f7f7f9` | Alternate light background |

### CSS custom properties (recommended)

```css
:root {
  --brand-teal: #115e67;
  --brand-orange: #f4633a;
  --brand-orange-dark: #d94b20;
  --brand-yellow: #ffd757;
  --text-primary: #373a3a;
  --text-muted: #6f7777;
  --surface-white: #ffffff;
}
```

## Typography

| Element | Spec |
|---------|------|
| Primary stack | `"Proxima Nova", "Helvetica Neue", Arial, sans-serif` |
| Monospace | `Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace` |
| Body | `1rem`, `line-height: 1.61`, `font-weight: normal`, color `text-primary` |
| Headings | `font-weight: 700`, `line-height: 1.1`, `margin-bottom: 0.5rem` |
| Section titles | Centered `h2`, convention pages use `.section-title` |
| CTA pills | `font-weight: 600`, `font-size: 1.25rem`, white text on orange |

**Font licensing:** Proxima Nova is licensed. Use org-provided webfont assets or approved fallback stack (`"Helvetica Neue", Arial, sans-serif`) until Comms confirms delivery.

## Layout

| Pattern | Spec |
|---------|------|
| Grid | `container` max-width center; responsive columns |
| Section rhythm | Alternating content bands: light (`surface-white`) vs optional dark hero (`surface-dark`) |
| Section headers | Centered `h2` per major block |
| Hero imagery | Full-width responsive images (`max-width: 100%`, centered) |
| Spacing | Section padding ~`1rem 2rem`; pill nav gap `1rem` |

## Components

### Primary button (pill CTA)

Convention-info in-page nav pattern:

- Background: `brand-orange`; hover: `brand-orange-dark`
- `border-radius: 9999px`
- Padding: `0.5rem 2rem`
- White text; `transition: background-color 0.3s ease`

### Links

- Default: `brand-teal`, no underline
- Hover/focus: `brand-orange`
- In-body CTAs: bold label ("Learn more", "Read more")

### Tables

Bootstrap-style `.table` for schedules and structured lists: collapsed borders, readable cell padding.

### Forms

- High contrast labels on white backgrounds
- Error states: avoid relying on color alone; include text
- Mobile-first: touch targets ≥ 44px where possible

## Accessibility and tone

- Provide skip-to-main-content link (match AFL site pattern)
- Orange CTAs: white text on `#f4633a` (sufficient contrast for large text/buttons)
- Focus visible on interactive elements
- Tone: direct, institutional, optimistic — avoid jargon in submitter-facing copy

## Reference assets

| Asset | Source |
|-------|--------|
| AFL-CIO logo | `https://aflcio.org/themes/custom/afl/source/images/logo.svg` |
| Convention OG image | `convention30-websitecover-small.png` on aflcio.org |
| Official design handoff | [redesign-docs.aflcio.org](https://redesign-docs.aflcio.org/) |
| Convention info page | [aflcio.org/convention-info](https://aflcio.org/convention-info) |

## Time Capsule application notes

- Prefer a **lightweight convention-branded shell** (logo, title, link to convention-info) unless MVP scoping selects full site chrome.
- Submission form: white content area, teal links, orange submit CTA.
- Prior-submission panel: `teal-muted` or light gray background to distinguish from compose area.
- HTML archive export should embed these tokens inline for offline readability (BR-006).
