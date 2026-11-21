# Gally 1.3 — desktop onboarding and motion

## Scope

This update addresses the supplied screenshot's narrow, vertically stretched desktop onboarding and introduces motion inspired by process storytelling on https://www.grabbz.app/. Gally keeps its own identity, copy, financial logic and dashboard layout. No Grabbz assets or animation code were copied into the deliverables.

The reference page's accessible markup included an animated delivery route and a pulsing endpoint. Some external animation/CSS bundles returned access errors, so exact runtime easing, timing and scroll behaviour were not verified. The Gally implementation is an original interpretation of motion connecting a process.

## Desktop onboarding

At 1024px and wider, the web app now composes the existing setup into a normal-flow two-pane grid, up to 1280px wide. The left pane gives context, four-step progress, a live draft summary and local-ownership reassurance. The right pane contains the actual form and actions. Headings are 36px on narrow desktops, 40px normally and 44px on very large screens, instead of using a mobile display heading inside a small centred column.

The layout explicitly overrides the earlier 608px direct-child constraint, so the two-pane workspace can use desktop width. Grid children can shrink without overflowing, fields retain readable widths, currency choices are grouped in two columns, and the action footer has a clear separation. The form scrolls naturally when the viewport is short; no device scale or zoom is used to force it to fit.

The left pane's summary uses only the user's current draft: optional name, currency, starting priority, pocket and a valid staged opening amount where applicable. It does not invent a balance or create an account early. The summary states that financial creation happens only after the final confirmation. Account and name data wrap in their allocated column.

Earlier steps can be revisited through the progress list. Future steps remain disabled until reached. Revisiting the review step with an invalid opening amount returns to the relevant form and explains the required correction. Optional setup, pause/resume, example mode and the existing authoritative confirmation/save actions remain in use.

Browser-storage failure notices remain visible in the left pane. The layout does not suppress session-only warnings or imply successful storage. On tablet/phone widths the side pane is hidden and the familiar single-column form is retained. The dashboard grid, financial values and navigation layout are not redesigned by this update.

`desktop-onboarding.js` moves existing form nodes into the composition; it does not copy inputs into a second form. Focused elements are restored by their live ID after composition. `desktop-onboarding.css` scopes its changes to onboarding.

## Landing-page storytelling

`landing-motion.js` and `landing-motion.css` add coordinated hero entry, one-time viewport reveals and a connected example-entry story. Content stays visible without JavaScript, IntersectionObserver or animation support. Nothing relies on a global hidden-until-animation class.

The new story at `landing.html#money-story` has four scenes:

1. Capture a sentence: “spent 45 on food at the chop bar”. No entry is saved.
2. Review and confirmation: an illustrative pocket moves from GHS 1,200.00 to GHS 1,155.00 after a GHS 45.00 expense.
3. Budget context: the same GHS 45.00 against a GHS 1,200.00 food budget leaves GHS 1,155.00 of budget capacity. Budget capacity is not represented as extra account money.
4. Forecast: after the recorded spend and two known GHS 150.00 bills, the illustrative balance is GHS 855.00. Unreceived promises stay outside the calculation.

A persistent note labels these as an illustrative GHS story, not the user's ledger. All numeric values appear exactly; no monetary count-up animation simulates intermediate balances. A travelling accent dot joins four process nodes, reinforcing the current scene. The budget bar's visual entry uses a transform while its exact amount is already readable.

On larger screens, the visual sits in a sticky normal-flow grid column while the four narrative chapters scroll beside it. IntersectionObserver selects the relevant scene; no scroll interception, forced scrolling or pinned full-page playback is used. Four buttons and a Next step / Replay control let the user inspect the story directly. On phone widths the visual returns to normal flow and the manual controls remain available. The narrative chapter text stays readable independently of the visual.

Scene changes do not move keyboard focus unless the user selected a scene button. The hero sequence uses small staggered movement; feature groups reveal once. The reference is about explaining a process, not applying perpetual bouncing or pulsing to every surface.

## Shared app motion

`gally-motion.js` and `gally-motion.css` are loaded by both `index.html` and `web-app.html`. They add presentation around the existing render, sheet and notification functions, rather than changing financial calculations or storage.

| Event | Motion | Timing |
| --- | --- | --- |
| Setup/page change | Small rise and fade of relevant headings/form blocks | 220ms; 40ms stagger |
| Currency/priority selection | Short selected-state acknowledgement | 180ms |
| Sheet opens | 16px rise and fade | 220ms |
| User dismisses sheet | 12px downward fade, then close/focus return | 140ms |
| Programmatic confirm/save close | Existing immediate completion path | No extra waiting |
| Notification appears | 8px rise and fade | 200ms |
| Notification expires | 4px fade exit before hiding | 140ms |
| New discussion messages | Small rise/fade on the new reply pair | 220ms; 40ms stagger |
| Hover/press | Small control movement, arrow travel, press scale | 180–200ms |
| Landing content/process scene | 12–20px entry and opacity | Up to 360ms |

Page motion keys on actual view/step changes, so ordinary typing and search do not restart an entire page entrance. Financial commits keep their original immediate state update. Rows can acknowledge a committed change, but their amounts never interpolate. The dashboard's layout and information hierarchy stay intact.

Only explicit user dismissals animate before closure. Confirmation/save paths do not wait for a decorative animation before committing or refreshing. A new modal opening invalidates a pending visual dismissal, preventing an old exit callback from closing the new modal. Existing focus trapping, inert backgrounds, hidden-state rules and focus return remain authoritative.

There are no artificial loading states, simulated typing pauses, audio/network requests, or added data writes in the motion layer. Discussion replies are still honestly labelled guided calculations. Animation does not imply a real AI or speech service.

## Reduced motion and fallback

The runtime reads `prefers-reduced-motion` and responds to changes. App entries and exits become immediate; selected-state meaning, messages and controls remain visible. Managed animations are cancelled when reduced motion is enabled. Landing scene changes remain functional while motion and the sticky presentation are removed. Existing splash reduced-motion behaviour remains intact.

WAAPI, IntersectionObserver and media-query event support are checked before use. Without them, base content and ordinary interaction remain available. Financial data is represented as text and labelled graphics, never only as movement or colour.

## Files and implementation notes

- `web-app.html`: loads the desktop onboarding adapter and shared motion layer.
- `index.html`: loads the shared motion layer for the original mobile prototype.
- `desktop-onboarding.js` / `.css`: dedicated desktop composition and live draft summary.
- `landing.html`: adds the connected-entry story and semantic scene controls.
- `landing-motion.js` / `.css`: hero, section and process animation.
- `gally-motion.js` / `.css`: shared interaction motion and dismissal handling.
- `design/tokens.json`: version 1.3 desktop layout and motion values.
- `design-system.html`: describes the updated desktop and motion contract.

Native Flutter implementation should translate these timings and behaviours into appropriate native animations, retaining platform navigation and accessibility. The current update edits browser sources; it does not compile native animations or export a video.

No post-generation browser walkthrough, screenshots, animation playback, automated checks or native compilation were performed in this turn. The reference's inaccessible assets remain a limitation on exact reference matching, not a claim that its runtime was inspected.


## Version 1.4 — fitted onboarding and actual Mote integration

Desktop onboarding is now one full-height split with compact context/progress and an action-footer row. The repeated side summary was removed; account creation still waits for final review. Responsive height tiers target standard desktop windows, with accessible scrolling retained for very short windows or enlarged text. The dashboard’s financial composition is preserved.

The landing page, onboarding and selected dashboard callouts now use actual locally bundled Mote FinTech shapes with Gally colour stops. Mobile uses smaller fields, and pause/reduced-motion behaviour is included. The landing also adds a payday timing comparison and replayable conversation example. See [Mote integration and height-fit guidance](mote-integration.md). JavaScript syntax checks passed; rendered height-fit and animation playback remain unverified because the browser could not launch here.
