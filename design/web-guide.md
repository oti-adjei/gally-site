# Gally — product website and responsive web app

## Open and use

Open `../landing.html` for the product landing page. Its Open Gally buttons lead to `../web-app.html`, the responsive application. The original `../index.html` is retained as the handset design prototype and has not been replaced by the website.

Keep the HTML entries, CSS, JavaScript, assets and design directory together. No package installation, build process or external font service is needed. A static HTTP/HTTPS server is preferable for predictable browser storage and downloads; the delivered local files have no remote dependencies. No hosting deployment was performed.

The first application visit offers optional personalised onboarding, a guided-conversation alternative or isolated sample data. Existing browser data is preserved. Landing-page example links deliberately enter example mode and keep the personal model separately, as in the previous app. Returning to the personal model does not merge example transactions.

## Deliverables and implementation

| File | Purpose |
| --- | --- |
| `../landing.html` | Complete marketing/product page with product overview, feature detail, privacy explanation, FAQs and application links |
| `../landing.css` | Responsive site layout, brand treatment and component styles |
| `../landing.js` | Mobile navigation and the clearly labelled capture demonstration |
| `../web-app.html` | Browser application entry without a handset mockup |
| `../web-app.css` | Desktop/sidebar, tablet/mobile layouts, responsive financial views, dialogs and sheets |
| `../web-app.js` | Workspace presentation adapter, desktop overview, table view, shortcuts and entry-link handling |
| `../app.js` | Existing authoritative model and financial interactions, reused unchanged by the new web entry |
| `../experience.js` | Existing onboarding, personalisation and recovery flows |
| `../planning.js` | Existing budgets, subscription rules, guided discussion and splash behaviour |
| `../assets/` | Original Gally brand and category vector assets |

The browser adapter changes presentation, rather than copying financial state into a second desktop model. Capture, editing, account management, linked transfers, budgets, subscriptions, expected income, recurring rules, forecasts, goals, backup/restore and guided conversation continue to use the same model and commit paths. The original mobile entry and its CSS behaviour are retained. The adapter wraps the existing render and sheet entry points only within the browser page.

## Landing page content

The direction continues Gally's white/forest/mint/citron palette, expressive grotesk typography and generous space. The website is light themed; the application retains working light/dark appearance.

The page includes:

- Purpose and a direct Open Gally action, plus an explicit example-data option.
- A code-built illustrative overview with exact sample amounts and currency labels. It is not a captured screenshot or the user's ledger.
- The salary/MoMo/cash context and the distinction between past recording and forward planning.
- A small interactive sentence-capture example, labelled as not saving to a ledger.
- Budgets, subscription tracking, accounts/transfers, currency isolation, goals, import/export and backups.
- Forecasting with a clearly labelled illustrative chart rather than an invented personalised prediction.
- Guided discussion and honest AI/voice capability labels.
- Privacy, no registration/bank login/paywall, and the browser-storage boundary.
- Desktop/mobile use, getting started, practical FAQs and a final application action.

There are no fabricated user counts, client results, testimonials, bank relationships, App Store badges or downloadable native applications. No stock photos, third-party brand assets, remote images or tracking libraries were introduced. Product imagery is composed in HTML/SVG from the app's own interface language.

The landing capture example shows an illustrative GHS interpretation and never writes to the application model. Its review includes a route into the real app for account/category/date confirmation. No amount from the public example is automatically committed or passed as a real transaction.

## Desktop, tablet and phone behaviour

At desktop widths (1024px and wider), navigation occupies a left sidebar. Overview, Ledger, Accounts, Budgets, Subscriptions, Forecast, Goals, Talk it through and Settings are directly reachable. Capture is always available in the sidebar and toolbar. There is no duplicate desktop bottom navigation.

The desktop overview uses real derived balances, safe-to-spend, reporting-month net, recent transactions, six-month income/expense comparison, expected payments, budgets and account summaries. The Look ahead view brings recurring and subscription obligations, expected income, goals and scenarios together. Currency switching affects aggregate values without converting or combining currencies. Month controls affect reporting views; current recorded balances remain current, rather than pretending to be month-end balances.

Ledger uses the existing search and combined filters, presented as a readable table. It shows 50 matching rows at a time with Load 50 more. Every amount retains its own currency. Mobile rows keep account/date metadata inside the transaction description, with the full record reachable through Edit. The amount is not silently abbreviated.

Accounts, budgets, goals and settings organise into wider grids where space permits. Forecast charts use a bounded readable width. Discussion gets a full workspace with a scrolling transcript and persistent composer. Desktop edit/review sheets become centred dialogs; smaller screens use bottom sheets. The sidebar becomes inert while a sheet is open, alongside the main app's existing focus containment and return behaviour.

Below 1024px, a touch-friendly top bar and the original four-destination bottom navigation replace the sidebar. Planning destinations remain reachable from Home and Settings. At phone widths the overview becomes a single column, tables expose a compact description/amount arrangement, forms use full available width and modal content remains scrollable. The app uses the browser viewport directly; no decorative handset surrounds it.

Onboarding remains a focused single-column journey on larger screens; it does not show an empty account dashboard alongside personal questions. Guided onboarding uses the full conversation layout. Recovery screens continue to explain the problem and offer saved-data download or restore rather than resetting the model automatically.

Keyboard shortcuts in the web workspace: N opens capture; / opens Ledger and focuses search. They are ignored in inputs, active sheets and unfinished setup, and do not override browser modifier shortcuts. All ordinary buttons and forms remain keyboard accessible without shortcuts.

## Linked entry points

- `web-app.html`: open the personal notebook or setup.
- `web-app.html?example=1`: explicitly explore isolated sample money.
- `web-app.html?example=1&view=forecast`: open the forecast with sample data.
- `web-app.html?view=talk`: open guided discussion, pausing optional setup if needed.
- The application brand/About Gally link returns to `landing.html`.

The query values are a finite set of local view choices, not arbitrary external URLs, file paths or commands. They do not submit data to a remote service. Merely opening the default app entry does not insert example transactions into a personal ledger.

## Storage and ownership

The application uses the existing `gally-v1` local-storage model. Pages served from the same browser origin can share it; isolated preview origins or local-file storage policies may keep them separate. Do not promise that the original prototype tab and the new app tab always share storage in every host preview environment.

Browser storage stays on that browser/device and is not an automatically synced cloud account. It is not a direct user-owned SQLite file. It may be removed when site data is cleared or private sessions end. Export active ledger data as CSV or the full browser model as JSON, then retain the file somewhere controlled by the user. Restore is explicit and replaces rather than merges the current model after confirmation. A storage failure keeps the in-memory session usable and shows the session-only notice.

The new website/app are frontend/local-functionality deliverables. No remote database, account system, backend API, cloud sync, provider subscription management, live AI or audio-recording service has been added. There is no encryption or hardened-production security claim. The static app source can run locally; a hosted first visit still needs the assets to load. An installable offline cache/service worker is not included.

## Current boundaries

The source reuses the existing fixed reference date of 20 November 2026 for repeatable financial examples. Native and production engineering must replace this with the actual device-local date and day-boundary refresh handling before treating it as a continuously current daily ledger.

Exact licensed Noi Grotesk and Fusion Neue files remain unsupplied. The declared local fallback stacks render without a network dependency. The application is responsive in implementation; it is not an Electron/Tauri desktop package or an App Store/Google Play build. Conversation remains guided and voice remains an explicitly labelled transcript-interaction preview. Reminder preferences do not claim delivered OS notifications.

No browser preview, screenshot, automated checks, native compilation or hosting deployment was performed during this production turn. The source and assets remain editable for further requested implementation or verification.


## Desktop onboarding and motion update

Desktop onboarding now uses a dedicated two-pane composition at 1024px and wider, with progress/context and a live draft summary beside the form. The existing dashboard composition is preserved. The landing page adds a process-led story with scroll-driven steps and manual controls. Shared web/mobile motion covers step changes, selections, sheets, notifications and discussion replies, with reduced-motion alternatives and exact, non-interpolated amounts.

See [Desktop and motion guidance](motion-guide.md) for the implementation and accessibility contract. No preview, screenshots or automated validation were performed for this update.


## Version 1.4 — fitted onboarding and actual Mote integration

Desktop onboarding is now one full-height split with compact context/progress and an action-footer row. The repeated side summary was removed; account creation still waits for final review. Responsive height tiers target standard desktop windows, with accessible scrolling retained for very short windows or enlarged text. The dashboard’s financial composition is preserved.

The landing page, onboarding and selected dashboard callouts now use actual locally bundled Mote FinTech shapes with Gally colour stops. Mobile uses smaller fields, and pause/reduced-motion behaviour is included. The landing also adds a payday timing comparison and replayable conversation example. See [Mote integration and height-fit guidance](mote-integration.md). JavaScript syntax checks passed; rendered height-fit and animation playback remain unverified because the browser could not launch here.
