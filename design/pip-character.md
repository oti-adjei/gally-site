# Pip / the seed character

Pip is an original rounded seed character for Gally. Its mint silhouette, forest-green facial features and citron sprout carry Gally’s existing palette. Small hands and grounded feet give the full character a recognisable pose; the compact face retains the same seed and sprout without limbs.

The visual direction was chosen to fit Gally’s approachable, calm identity. It suggests a small beginning, without implying investment growth, promised financial outcomes or gamified spending.

## Editable assets

All artwork is code-authored SVG with transparent backgrounds; no raster-generation or conversion is involved.

- `assets/brand/pip/character.svg`: primary ready/hello pose, 320 × 336 canvas.
- `assets/brand/pip/compact.svg`: primary compact face, 64 × 64 canvas.
- `assets/brand/pip/{state}.svg`: full ready, listening, review, thinking, replying, interrupted and unavailable expressions.
- `assets/brand/pip/compact-{state}.svg`: matching compact expressions.
- `assets/brand/pip/manifest.json`: dimensions, palette, state names and source identity.
- `pip-character.js`: shared inline geometry for the same expressions.
- `pip-character.css`: sizing and integration styles.

The older P-stroke `assets/brand/pip-mark.svg` is retained as historical source artwork. Active Pip components use the seed character instead. Gally’s launcher icons and notification small icon are unchanged.

## Expressions

| Expression | Visual cue | Intended use |
| --- | --- | --- |
| Ready | Open eyes, quiet smile and raised hand | Welcome and idle state |
| Listening | Attentive eyes and hand near the side | Explicit listening preview; eventual active capture |
| Review | Slight downward gaze and small smile | Transcript checking |
| Thinking | Upward gaze, reflective mouth, hand near chin | Processing-state demonstration |
| Replying | Open smile and outward hands | Answer presentation |
| Interrupted | Closed resting eyes and a gentle smile | Paused or stopped interaction |
| Unavailable | Neutral mouth and calm eyes | Capability unavailable or access denied |

Denied reuses the unavailable face. Success reuses the replying face. No fearful, angry or judgemental expression is attached to a financial shortfall or overspending.

## Same Pip, different company

Your Guy, Girl’s Girl, The Coach and Quiet Companion keep the same body, palette and face. The illustrative personality comparison uses a hello, open smile, considered glance or restful expression respectively. There are no gendered costume changes. Conversation-state expressions follow the actual UI state independently of the selected speaking character.

Personality does not change arithmetic, privacy or confirmation rules. The character does not claim to be human, to feel emotions or to be a financial adviser.

## Placement and sizing

Use the compact face in bottom navigation, headers, Settings rows and speaker identity, generally at 28–64px. Use the full character in introductory content and interaction-state panels, generally at 80–280px. The full canvas includes breathing room around the sprout, hands and feet; keep the full frame and natural aspect ratio.

The app’s About Pip introduction shows the full character. Shared badges use the compact seed face. Shared state panels use full expressions. Existing landing-page comparisons and permission references inherit the same character component. The design-system character sheet shows all exported expressions and download links.

Keep the solid forest/mint/citron artwork consistent in both themes. Do not recolour it to indicate error or success, or add warning badges to its face. Status text and relevant controls communicate the state. Decorative inline artwork is hidden from assistive technology when a nearby label already names Pip; standalone SVG assets include a title and accessible name.

## Motion

The existing signal bars communicate the listening preview. The thinking preview keeps its restrained vertical motion; reply entry remains short and bounded. Face changes happen with the selected UI state. Reduced motion disables animation and preserves the expression and text. A normal guided reply is still synchronous—there is no fabricated thinking delay.

No live model, microphone capture or native OS integration was added. These are editable vectors integrated into the existing browser prototypes. No browser visual review, image rendering or native compilation was performed for this increment.


## Personality artwork and ambient Pip

Pip now has four visual looks, bounded welcome gestures and larger character placements across onboarding, landing and selected app views. Ambient Pip uses a project-local custom pack passed to the bundled Mote runtime. See [the placement and motion guide](pip-placements-and-motion.md) for artwork paths, shared pause behaviour, responsive placements and integration limits. Earlier character notes describe the original unadorned seed.
