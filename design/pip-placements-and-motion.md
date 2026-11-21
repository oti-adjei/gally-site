# Pip: personality looks, placements and motion

This increment extends the existing seed character into the landing page, onboarding, responsive browser application and handset prototype. Financial data, calculations and confirmation paths are unchanged.

## Four looks, one character

| Speaking personality | Visual identity | Greeting |
| --- | --- | --- |
| Your Guy | Forest cap with citron brim | Easygoing hand wave |
| Girl’s Girl | Citron headband and small knot | Three small hand-wave cycles |
| The Coach | Forest vest with citron trim | Focused nod and a welcoming hand |
| Quiet Companion | Unadorned seed with softer eyes | One gentle wave |

Every look is available to everyone. No user gender is inferred. The shared silhouette, sprout, palette and facial language retain Pip’s identity. Classic Calm, Warm, Direct and Curious settings map visually to Quiet Companion, Girl’s Girl, Your Guy and The Coach respectively; their speaking labels and existing message identities remain unchanged.

Selected preferences drive app badges, character introductions, state expressions and new scenes through the existing local Pip setting. Landing-page examples select an illustrative personality without changing the user’s preference.

Editable artwork is in `assets/brand/pip/personalities/`: four looks × seven expressions × full/compact formats. Files follow `{look}-{state}.svg` and `{look}-{state}-compact.svg`. Full canvases remain 320 × 336; compact canvases remain 64 × 64. Keep the natural aspect ratio and transparent background. `pip-character.js` renders the same editable geometry for the application.

## Placement map

| Surface | Pip treatment | Space and behaviour |
| --- | --- | --- |
| Landing hero | Main Quiet Companion hello | Normal-flow character and replay above the headline; one sparse Coach background on larger screens |
| Landing personality comparison | Larger selected look | Replaces the look when a comparison is selected; exact illustrative numbers stay unchanged |
| Landing conversation story | Expressive Girl’s Girl | Dedicated foreground character above the editorial copy |
| Landing closing invitation | Your Guy greeting | Own flex item beside the invitation; existing finance-art pocket is hidden here to avoid competing illustrations |
| Desktop onboarding | Selected full character in the art pane | One small ambient Pip behind the main illustration; compact height tiers preserve the form/action space |
| Tablet onboarding | Selected welcome character | Main character in the welcome artwork, with a faint ambient copy in the reserved area on wider tablets |
| Mobile onboarding | Larger selected hello | Approximately 176px artwork with replay; replaces the old ledger/coin welcome illustration, without background duplicates |
| Home Pip invitation | Selected full character | Dedicated art lane on desktop/tablet; larger normal-flow character above the invitation on mobile |
| Empty conversation | Selected full character | Approximately 136–144px artwork above the first question; compact header remains available |
| Selected full-page empty states | Selected character | Accounts, Ledger, Goals and Budgets use a quiet character when the primary view is empty; existing instructions and actions remain |
| Browser first-account prompt | Selected character | A small normal-flow companion before the existing next step |
| Navigation, headers, Settings | Compact selected look | No full-body artwork is inserted into financial rows or dense controls |
| Voice/permission/state previews | State-specific selected look | Existing truthful labels and recovery controls stay authoritative |

No decorative character covers financial figures, charts, forms or primary actions. Foreground artwork participates in normal flow. Background copies are restricted to purpose-sized decorative hosts and are hidden on handset surfaces and narrow layouts.

## Motion vocabulary

The welcome is a bounded hand wave, with a short 320ms entrance and 300–360ms wave cycles. It plays when a greeting enters view; welcome surfaces offer **Say hello again**. A replay updates an accessible status message. Personality differences use a different cadence or a small nod, without changing the character’s body proportions.

The listening preview adds a restrained sprout lean, replying a short nod, and interrupted/unavailable expressions stay calm. Thinking remains an explicitly labelled design preview; synchronous guided replies are not delayed to imitate processing. No numeric counting, confetti or reward animation is connected to financial outcomes.

## Actual custom Mote pack

The project’s bundled `@usemote/core@0.1.1` accepts packs containing shape definitions with `id`, `label`, `kind`, `ar` and a `render` function. Its shipped runtime combines pack shapes and uses their returned SVG in the DOM renderer. The existing FinTech adapter uses the same interface.

`pip-mote-pack.js` supplies `GallyPipMotePack` with four original object shapes:

- `pip-quiet`
- `pip-guy`
- `pip-girl`
- `pip-coach`

Each renderer returns `PipCharacter.svg('ready', { look })` with an SVG that fills the particle’s own dimensions. The aspect ratio is 320/336. Artwork keeps its registered palette instead of adopting a random finance-object colour theme.

`pip-spaces.js` passes this project-local pack directly to the real bundled Mote `createField` function. There is one particle per reserved ambient host, with a stable seed, 80px base size, low-speed bob motion and no financial data. The ordinary FinTech objects remain in their existing compatible landing placements. Character-led welcome and invitation areas suppress the competing finance-object art.

For later reuse with Mote, retain the shape definitions and renderer geometry, then import/adapt them into the consuming project. This is a local custom pack, not a package published to Mote’s registry or a modification of the Mote library itself. The vendored library and its MIT notice are unchanged.

## Pointer movement, pause and lifecycle

Desktop/tablet ambient planes respond to a fine pointer with at most approximately ±6px horizontally and ±4px vertically. Movement changes only a decorative outer plane; the Mote particle retains its own bob motion. Coarse-pointer/touch devices do not require hover or pointer movement. The mobile app gets foreground character moments instead of ambient copies.

The background preference remains `gally-background-motion`, shared with the existing Mote controls. Pausing leaves a visible still character. Reduced motion has priority, removes welcome/state character movement and disables pointer parallax. Background fields use Mote’s paused/static mode and native offscreen lifecycle. Detached fields are destroyed during composition, and page-hide destroys active handles. Reopening creates new handles without stacking old planes.

The reference shows the four looks and a replayable greeting. No rendered browser measurements or animation playback were performed for this increment. Native Flutter rendering of these vectors and motion still needs implementation; the delivered interaction runs in the existing HTML applications. Live AI, audio capture and OS permissions remain separate integration work.
