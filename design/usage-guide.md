# Gally usage and implementation guide

## Open the deliverables

Open `../index.html` for the mobile prototype. The neutral presentation shell collapses to the available viewport on narrow screens. Open `../design-system.html` for the identity, tokens, component reference, both theme treatments and asset downloads. All assets are local, and the prototype has no remote dependencies or server requirement.

New users begin with optional, resumable setup. Name/currency → starting priority → first account → confirmation. Use “Set up later” to skip, or explore example money separately. Existing ledgers are preserved when personalising. Settings → Your Gally lets you revisit setup or edit preferences.

After setup, the primary walkthrough is Home → centre + → Quick → type “spent 45 on food at the chop bar” → review → confirm. Then inspect Ledger, Accounts and budget usage. Home → Look ahead leads to expected money, recurring payments, goals and forecast scenarios. Settings includes an example CSV import that demonstrates one valid new row, an in-file duplicate and an unreadable row.

A persistent banner identifies isolated example mode and offers Return to my ledger. The design date remains fixed. It can wipe active money data for an empty-state exploration after two explicit confirmation steps; Load example data adds the examples back without duplicating them.

## File map

| File | Purpose |
| --- | --- |
| `../index.html` | Runnable iOS/Android shared prototype in a neutral presentation shell |
| `../app.css` | Product theme tokens, components and responsive styles |
| `../experience.js` | Custom onboarding, personalisation, isolated example mode and recovery |
| `../app.js` | Local model, financial derivations, navigation and interaction flows |
| `../design-system.html` | Component library, brand reference and design resources |
| `tokens.json` | Machine-readable light/dark colours, type, spacing, radius, elevation and motion |
| `material-3.json` | Optional Material interoperability colour mapping |
| `material-3.css` | Full role variables for reuse |
| `gally_theme.dart` | Optional Material adapter; does not define Gally components |
| `gally_components.dart` | Custom Flutter widget starters without Material or Cupertino widget styling |
| `states-and-onboarding.md` | Version 1.1 onboarding, state matrix and cross-platform interaction contract |
| `screen-specs.md` | Screen behaviour keyed to brief §5 and §6; states and native boundaries |
| `../assets/brand/` | Wordmark, one-colour mark, app icon, adaptive layers and splash SVG |
| `../assets/icons/` | 24 original category SVGs |
| `icon-paths.json` | Editable category path definitions |

## Naming and voice

Keep Gally as the product name and “Your money, your file.” as the promise. Write plain sentences to someone who wants clarity, not a lecture. Avoid banking jargon, streaks, celebration for spending, moral language about budgets, fake urgency and growth claims.

| Context | Prefer | Avoid |
| --- | --- | --- |
| Confirmed income | Received GHS 2,000.00 from Kofi | TXN-8843 credited |
| Expected income | Expected · not received | Available now |
| Late payment | 6 days late | You're falling behind |
| Budget exceeded | 120% · over | Bad spending habits |
| Delete | Removed from your ledger. Still in your file. | Gone forever |
| Forecast | Runs dry on 19 December | You're in trouble |
| Empty ledger | A fresh page. Add your first spend. | No data |
| Import duplicate | Nothing new to import. Your ledger stays unchanged. | Import failed |
| Offline operation | On your phone. Always yours. | Connecting to your account |

Use ISO currency codes for ambiguity-free money: `GHS 45.00`, `USD 45.00`, `CAD 45.00`, `NGN 45.00`. Do not use a bare dollar symbol for multi-currency contexts. Locale separators may adapt later, but exact values and currency identity must remain. Screen readers should announce “forty-five Ghanaian cedis”, direction and account; engineer semantic labels rather than reading every punctuation mark. Amount fields take positive values; the direction control defines the sign.

## Foundations

The canonical colour roles are in `tokens.json` and `material-3.json`. Keep body foreground/background pairs together when extending themes. Citron needs dark ink, not white text. Do not treat an expected payment as income or give a pending block the same treatment as recorded money.

The light theme uses clean white, forest actions and mint recorded-money surfaces. Dark uses a deep green-neutral ground, independently assigned light text and pale green actions. Red belongs to money facts and amount validation, not ordinary category colour or decorative marks. Pattern, icon and wording accompany state colour.

Display: Noi Grotesk semibold. Body: Fusion Neue regular. Numeric: tabular monospace. No licensed font files were supplied. The prototype therefore declares those families with working local fallbacks; it does not include the exact Yummygum fonts. Obtain appropriate licenses and add local font assets before production. The supplied SVG wordmark keeps live text and will use its fallback until that work is done. Convert the final licensed wordmark to outlines for print/vendor portability.

Use consistent 8pt layout rhythm with 4pt detail steps. Cards 16px, hero/sheet 24px, internal inserts 8px. Capsule actions are a functional motif. Keep the centre capture action in reach without obscuring navigation. Keep normal flow for content and reserve space for persistent chrome. Never hide essential copy to force a layout to fit.

## Component conventions

- Amount: currency + exact tabular number. Direction has an explicit sign; balances are never abbreviated into K/M values.
- Preview card: amount first, account and date visible, full payee/note reachable. Raw interpretation remains reviewable.
- Pending card: dashed outline, blue-grey treatment, explicit expected status and date/overdue age. Received leads to confirmation.
- Budget progress: limit, actual, percentage and “over” text; cap bar geometry, never the actual figure.
- Account tile: name, type, ISO code and derived balance. Keep currency immutable.
- Category glyph: 24px canvas, 1.6px stroke, round caps/joins. 24 original glyphs are provided. Use text labels at small sizes.
- Sheets: visible handle and close, labelled fields, one primary decision, a return path. Modal content wraps full data text.
- Empty state: explain why it is empty and provide the single next useful action.
- Feedback: validation only after user interaction; success follows a committed state update. A download-request message does not claim the OS saved the file.
- Motion: 200ms enter, 140ms exit, state-oriented and quiet; respect reduced motion. Native may eliminate motion without removing feedback.

## Brand assets

All supplied marks and category icons are original editable vector work for this project. No stock photography or third-party logos were used, so no external image attribution sidecar is required.

The adaptive icon sources use a 108×108 design viewport. `adaptive-background.svg` is a full citron plane; foreground and monochrome artwork stay in the central safe region. Android engineers should convert these SVG paths into VectorDrawable resources and wire the foreground/background/monochrome resource layers in adaptive icon XML. Platform resources, launcher previews and Android builds are not included. The combined app-icon SVG illustrates the intended treatment without baking in a launcher mask.

Use `splash.svg` as the design specification for a native launch screen, not as a full-screen bitmap to stretch. Native Android splash constraints may show only the centred icon and background initially; the wordmark and tagline belong in the subsequent app-owned launch state if needed. Do not prolong launch to display branding.

Minimum mark guidance is a design proposal: 16px screen width or 5mm print width, with one stroke-width of clear space for compact marks and a letter-height around the wordmark. A print vendor must confirm actual engraving tolerances.

## Native integration priorities

1. Connect the theme and components to the existing Flutter app. Use the custom component contract on iOS and Android. Material mappings are optional interop data. The shared widgets do not require a MaterialApp, Material buttons or Cupertino styling. Native OS surfaces still own permissions, file picking, sharing and system navigation.
2. Replace the browser state layer with the existing local SQLite repository. Keep one authoritative write path and exact integer arithmetic. Match recurring occurrences to actual/scheduled payments to avoid double-counting.
3. Use the real device date and timezone; treat a ledger day as a local calendar date. Recalculate at date boundaries and after every mutation.
4. Add device-local dictation with permission, recording/cancel/error states and shared parse confirmation. Do not upload transcripts or audio implicitly.
5. Implement safe database-copy export and OS sharing, atomic backup restoration, defensive import size limits and native file-picker error handling. The HTML prototype downloads JSON; it does not produce or manipulate a real SQLite backup.
6. Add local notification scheduling for backup/renewal reminders, widget deep links and optional household owner labels only after the underlying product architecture is defined.
7. Integrate accessibility and financial correctness tests in the native repository: currency isolation, linked transfers, soft deletes, duplicate imports, future-date balance handling, large text, keyboard, TalkBack, dark-mode contrast and exact semantics.

## Known boundaries

The prototype is functional local interaction design with illustrative data. Persistence depends on browser storage availability and uses memory if storage is blocked. It is not encrypted storage, financial advice, a finished application or a secure database-backup implementation. Its deterministic parser handles a limited set of phrases. Voice, native share sheets, widgets, OS notifications, household synchronisation and native app icon packaging remain engineering tasks. No previews, automated tests or compilation were run in this delivery.


## Version 1.1 update

The startup syntax error that previously prevented rendering was repaired in the preceding turn and its syntax check passed then. This update adds a non-empty initial HTML surface, a startup recovery message, and an in-app screen-error fallback. It does not clear stored data when opening fails. Unreadable stored JSON gets its own recovery screen and can be downloaded before replacement. See `states-and-onboarding.md` for exact behaviour.

Onboarding stores an optional display name, preferred currency, starting priority and setup draft locally. These are personalisation preferences, not an online account or a bank connection. Actual first-account creation happens only at the final confirmation. Example mode keeps the original model under a separate personal-ledger snapshot and returns to it without merging sample transactions. Browser storage availability still limits persistence; an honest session-only notice and save retry remain visible when writing fails.

The new component/reference source has not been visually previewed or compiled into a native app. Native accessibility, large-type behaviour and platform integrations still need verification in the application's engineering environment.


## Version 1.2 — subscriptions, flexible budgets, discussion and splash

See [Planning and conversation](planning-and-conversation.md) for the current design contract. The prototype now includes a Subscriptions destination under Settings and Look ahead, overall/category budgets with weekly/monthly/custom periods and optional positive rollover, and Talk it through from onboarding, Home and Settings. The discussion is explicitly guided, with local calculations and no connected AI model. Voice is a typed-transcript interaction preview; no audio is recorded. A 900ms app-owned splash introduces the mark and wordmark; reduced motion goes directly to the ready screen. Settings offers replay.

`planning.js` contains the new local interaction and calculation logic. Material remains optional compatibility data. No rendered video, live AI integration, OS notification scheduling or native speech engine is included. The new sources were not visually previewed or run through automated checks during this production turn.


## Responsive web release

Use `../landing.html` for the product website and `../web-app.html` for the responsive browser app. `../index.html` remains the original handset prototype. The browser workspace retains the same model and financial flows; it adds desktop sidebar navigation, a wider overview, ledger tables and layout adaptations for accounts, budgets, goals, discussion and settings. See [Web guide](web-guide.md) for entry points, storage behaviour, links and current boundaries.


## Desktop onboarding and motion update

Desktop onboarding now uses a dedicated two-pane composition at 1024px and wider, with progress/context and a live draft summary beside the form. The existing dashboard composition is preserved. The landing page adds a process-led story with scroll-driven steps and manual controls. Shared web/mobile motion covers step changes, selections, sheets, notifications and discussion replies, with reduced-motion alternatives and exact, non-interpolated amounts.

See [Desktop and motion guidance](motion-guide.md) for the implementation and accessibility contract. No preview, screenshots or automated validation were performed for this update.


## Version 1.4 — fitted onboarding and actual Mote integration

Desktop onboarding is now one full-height split with compact context/progress and an action-footer row. The repeated side summary was removed; account creation still waits for final review. Responsive height tiers target standard desktop windows, with accessible scrolling retained for very short windows or enlarged text. The dashboard’s financial composition is preserved.

The landing page, onboarding and selected dashboard callouts now use actual locally bundled Mote FinTech shapes with Gally colour stops. Mobile uses smaller fields, and pause/reduced-motion behaviour is included. The landing also adds a payday timing comparison and replayable conversation example. See [Mote integration and height-fit guidance](mote-integration.md). JavaScript syntax checks passed; rendered height-fit and animation playback remain unverified because the browser could not launch here.
