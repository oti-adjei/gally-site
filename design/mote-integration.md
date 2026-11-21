# Gally × Mote — integration and fitted onboarding

## Delivered changes

The web onboarding is a single full-height split under a 64px header. The left side carries short context, a dedicated Mote art area, compact progress and privacy/storage status. The right side carries the existing authoritative setup form and its action footer. The repeated live summary was removed; the final confirmation still presents all actual draft values before creating an account.

The dashboard's financial grid and calculations are preserved. Mote decorates discussion/empty-state callouts in a reserved side area. It is not drawn over balances, charts, input fields or controls. Mobile web/the handset prototype uses smaller, fewer shapes in the welcome artwork and selected callouts.

The landing page now has Mote in its hero edges, a mobile hero strip, the privacy section and closing section. It retains the connected-entry story and other motion, and adds an interactive planned/late-payday comparison plus a replayable sample conversation. These examples remain clearly illustrative and change no ledger data.

## Actual Mote packages

- Library: Mote, by George Heavenson.
- Site: https://mote.hearvie.dev/
- Source: https://github.com/oti-adjei/mote
- Runtime: `@usemote/core@0.1.1`.
- Shapes: `@usemote/pack-fintech@0.1.1`.
- License: MIT; retained at `assets/vendor/mote/LICENSE`.
- Provenance: `assets/vendor/mote/provenance.json`.

The actual npm packages were bundled into `assets/vendor/mote/mote-fintech.js`, a local classic-script bundle exposing `GallyMoteLibrary`. This is not a redraw or imitation of Mote's shapes. No CDN connection is required at runtime, and the component never receives ledger records, personal preferences or account amounts.

`assets/vendor/mote/source-entry.js` preserves the entry imports. To rebuild with the same pinned packages, bundle that entry as an IIFE with global name `GallyMoteLibrary`, targeting ES2020. The delivered bundle is already usable without npm, a bundler or a package installation.

## Reusable Gally adapter

`mote-fields.js` is the integration source; `mote-fields.css` reserves decorative space. The engine receives actual FinTech shape definitions and Gally's colour stops. Selected objects are wallet, coins, card, receipt, calculator and currency; the currency renderer explicitly requests the pack's supported cedi variant. Decorative percentage tickers are excluded so the background does not resemble made-up financial results.

`globalThis.GallyMoteSettings.placements` exposes the active placement configuration in the page. Edit the configuration in `mote-fields.js` to change counts, sizes, seeds, shape selections and speed for eventual product integration.

| Placement | Desktop count / size | Mobile treatment | Purpose |
| --- | --- | --- | --- |
| Hero left | 4 / 72px | Hidden, replaced by mobile strip | Coins/wallet/cedi along the outer edge |
| Hero right | 4 / 80px | Hidden, replaced by mobile strip | Card/receipt/calculator along the outer edge |
| Mobile hero strip | Not displayed | 3 / 40px | A small characterful area above the headline |
| Desktop onboarding art | 6 / 64px | Desktop pane hidden | Dedicated open area between context and progress |
| Mobile welcome | Not used in desktop form | 3 / 44px | Real Mote shapes replace the old static decorative art |
| Dashboard callout | 3 / 48px | At most 3 / 44px in a smaller reserved zone | Character without obscuring financial content |
| Privacy | 4 / 56px | Hidden when the available width is small | Light/citron shapes on forest |
| Closing invitation | 4 / 60px | Hidden on tablet/phone | A small desktop art pocket between copy and action |

The selected motion is Mote's `bob`, with per-placement speeds. Fields have stable seeds, depth enabled and pointer interaction disabled. The surrounding host retains its own layout. A dedicated absolute inner plane is passed to `createField` because Mote intentionally fills its host; passing the flex/grid layout container directly would let its absolute-fill defaults affect the layout.

The adapter destroys detached fields after application rerenders, mounts new ones after the current view is composed, responds to theme/viewport changes and uses the library's own offscreen and document-visibility behaviour. The financial model and save paths are unchanged.

## Pause and reduced motion

A visible pause/play control is available in the landing-page footer, desktop onboarding, mobile welcome and application Settings under “A little character.” The local preference uses the separate browser key `gally-background-motion`; it is not part of financial data.

System reduced motion has priority. Both the engine's `static` mode and `paused` option are set, keeping a still frame without a continuing animation loop. The control explains that the system has reduced motion. Backgrounds have `aria-hidden` and no pointer events. Their absence never removes meaningful information or blocks a form.

## Desktop height strategy

The app keeps the viewport as its outer frame and reserves one header row. The two panes share the remaining height; the form has a content row and an action-footer row. Large surrounding padding, an extra nested card and the duplicate side summary no longer consume the vertical budget.

At desktop heights up to 800px the composition uses a smaller, readable type tier, shorter gaps, compact currency options and a two-column account type/name group. Side progress uses two columns where appropriate and removes repeated descriptions. When session-only storage needs attention, the warning stays visible and a repeated privacy pledge gives way to it.

Targets are common desktop windows including 1366×768, 1440×900 and 1920×1080. The normal steps are designed to fit those heights with their actions visible. Unexpectedly long content can remain accessible within a pane; at heights of 660 CSS pixels or less, an explicit scrolling fallback takes precedence over clipping. Browser zoom can activate that fallback. The implementation does not scale the whole UI or hide fields just to remove a scrollbar.

The draft uses the original account validation and explicit confirmation. Prior-step navigation remains available and does not bypass invalid opening-balance checks. Mobile retains the ordinary single-column flow, while the same field labels and IDs remain authoritative.

## Additional landing interaction

The forecast example now has On schedule and Payday 2 weeks late controls. They change an illustrative timeline and explanatory copy, while retaining the recorded opening balance. There is no interpolated financial number or personalised affordability claim.

The conversation example has a replay control and a one-time viewport entrance sequence. It remains visibly identified as a guided example; no model call, microphone recording or simulated real processing is introduced. The original quick-capture example and four-step process story remain available.

## Verification and limits

JavaScript syntax checks passed for `desktop-onboarding.js`, `mote-fields.js`, `landing-interactions.js` and the locally bundled Mote runtime. A missing event-listener delimiter found by the initial check was repaired before the checks passed.

The headless browser attempted during planning exited at launch in this environment. No rendered-height measurement, browser screenshot, animation playback or native build is claimed for these changes. The desktop fit is implemented through the explicit height/layout constraints above and still needs a rendered browser check when a browser is available.

Mote works directly in the delivered HTML-based mobile web/prototype. A native Flutter application cannot import this DOM renderer unchanged. For native iOS/Android, reuse the pack's actual SVG shapes and reproduce the movement with Flutter animation, or choose a deliberate embedded-web surface; keep the same reduced-motion and performance boundaries. No Flutter-native Mote renderer is delivered here.


## Personality artwork and ambient Pip

Pip now has four visual looks, bounded welcome gestures and larger character placements across onboarding, landing and selected app views. Ambient Pip uses a project-local custom pack passed to the bundled Mote runtime. See [the placement and motion guide](pip-placements-and-motion.md) for artwork paths, shared pause behaviour, responsive placements and integration limits. Earlier character notes describe the original unadorned seed.
