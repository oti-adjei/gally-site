# Gally screen specifications

Version 1.1 · iOS + Android · 20 November 2026 example dataset

## Product and design decisions

Gally is a local-first personal money manager for salary, mobile money, bank and cash users. Keep the name and “Your money, your file.” The product must help someone capture a spend quickly and plan around uncertain income. There are no accounts, servers, bank credentials, adverts, subscriptions or upsell surfaces in the proposed native experience.

The user requested Yummygum's typography and playfulness with an independent palette. The design therefore uses friendly typographic proportions, an original ledger-inspired G, citron capture controls and gently rounded surfaces. It does not reuse Yummygum's pink palette or client imagery. Forest green, white, mint and blue-grey are design proposals chosen for Gally, rather than pre-existing approved brand assets.

Use Home, Ledger, Accounts and Settings as the stable four-tab shell. The centre capture action is an action, not a fifth destination. Home has Today and Look ahead views. Planning tools live below Look ahead instead of competing with daily capture. Settings exposes category management, import, backup, recovery and recurring rules. The neutral handset shell is presentation only. The component system is custom Gally on both platforms, with native system conventions specified separately. Material role mapping is an optional engineering adapter, not a widget/style dependency.

## Financial invariants

- Store amounts as integer minor units. Render the full amount with two decimal places and explicit ISO currency. GHS, USD, CAD and NGN never combine in a single sum or chart. Do not convert currencies implicitly.
- Opening balance plus non-deleted transactions dated through today gives current balance. Future dated ledger entries affect the forecast when their date occurs. Transfers create two linked equal and opposite legs within one currency.
- A parsed sentence or dictated transcript always goes through preview and explicit confirmation. Keep the original sentence attached to the transaction.
- Received expected money changes from an expectation into exactly one confirmed ledger entry. Until then it affects only the dashed forecast alternative.
- Soft-delete transactions. Removing either transfer leg removes both; restoring either restores both. Archived accounts keep their history and balance in the combined recorded-money view.
- Financial red means an actual negative balance, an exceeded budget, a projected shortfall or an invalid amount. Pair financial warnings with words and/or a symbol. Ordinary caution comes from clear language and confirmation.
- Month reporting excludes both legs of transfers. Recent activity can span currencies because each row names its own currency; it never sums those rows.

## Shared screen anatomy

Top: wordmark, appearance action, balance visibility action, settings shortcut. Scrollable content sits between this header and persistent bottom navigation. Bottom actions reserve their own space. Native implementation uses SafeArea, 48dp hit areas, logical focus order and system back. Sheets offer a visible close button, contain focus in the browser prototype and return it to a surviving trigger or main navigation.

Display stack: Noi Grotesk, then Trebuchet MS and system-ui in the prototype. Body stack: Fusion Neue, then system-ui. Fonts have not been supplied; the current files contain no unlicensed embedded font data. Numbers use the declared tabular monospace stack. The Flutter implementation should register licensed fonts and support large system text without scaling the entire screen.

Baseline spacing: 8dp grid, 4dp detail spacing, 24dp content gutters, 8/16/24dp shape scale, capsule actions. Body 16sp at 1.55 line-height, primary figures 32–40sp, headings 22–32sp. The prototype uses restrained 200ms entrance movement and disables it under reduced motion. Flat surfaces express hierarchy through space and typography; a sheet gets the elevated shadow.

## §5.1 Quick Add

### Entry and modes

The citron centre action opens the bottom sheet from every tab. The default Quick tab asks “What happened?”; Form and Transfer are one tap away. Keep draft fields when switching capture modes or returning from confirmation. Closing without confirmation writes nothing.

### Quick

Show a labelled multiline input, a microphone action, account selector, live interpretation card and Review & confirm. A sentence like “spent 45 on food at the chop bar” resolves amount, expense direction, category, payee, account and date. “Received” and “salary” can indicate income. Category keywords propose a category. “Yesterday” changes the date. An explicit ISO currency in the sentence must match the selected account. Missing or zero amounts leave confirmation disabled. A preview explains it is not saved yet.

Review opens a full confirmation with exact signed amount, currency, account, category, payee and date. Edit details returns to the draft. Confirm & save commits once to the shared model, updates balances, budget usage and ledger, closes the sheet and acknowledges success. Form mode can correct every interpreted detail before saving. Parsing here is deterministic and deliberately limited; production parsing should retain ambiguous words and surface uncertainty without guessing silently.

### Form

Expense/Income toggle, amount, account, matching category selector, payee/note and date. Default date is today. Invalid amount feedback appears after attempted review, not on an untouched form. Inputs accept positive decimal amounts with at most two fractional digits; direction sets the sign. Future entries are labelled Scheduled and do not enter today's balance.

### Voice

The microphone opens an honest explanation in this browser prototype. It does not call a browser speech service or upload audio. Native Flutter: request permission only at hold-to-talk, use a verified offline recogniser, expose listening/cancel/error states, place transcript into the same Quick input, and require the same confirmation. If the device lacks an offline language pack, explain that and keep text capture available. Never silently fall back to cloud speech.

### Transfer

Select from account, to account, amount and date. Offer only other active accounts in the same currency. No destination produces a useful message instead of an invalid save. Confirmation names both accounts. Saving produces a linked pair; editing the amount or date updates both legs. Different-currency transfer is intentionally unavailable because exchange is not defined in the brief.

## §5.2 Home / Today

Order: date and short friendly heading; Today/Look ahead; recorded-money hero with currency picker; safe-to-spend calculation; expected-money preview; monthly income and expenses; category budgets; recent activity. Available money is explicitly described as across accounts. The hero is not the monthly net result.

The month switcher changes reporting data only. Future dashboard months cannot be selected; direct users to Look ahead. The currency switcher changes all aggregate figures without touching data or converting amounts. Monthly cards and budget bars use the selected month and currency. Recent activity shows the last five actual transactions with currency on every row. A tap opens edit.

Overview opens a screen with income minus expenses, descending category spending bars and a six-month comparison. Uncategorised stays last. Chart detail disclosures give exact values for each month, including zero-data months. Budget progress shows actual spend, limit and percentage. Overspending uses a red bar plus “over”.

First launch now begins with optional, resumable personalised setup. First-use Home does not show synthetic money balances where no account exists; it offers the next useful action. No mandatory tour. Example mode is explicitly labelled and kept separate from the personal ledger. The prototype keeps the fixed example date for repeatable design discussion. See the version 1.1 onboarding and states specification.

## §5.3 Ledger

Search payee, original note and category, case-insensitively. All/Money in/Money out chips combine with account and category filters. Day groups sort newest first; all active transactions are eligible, with future ones labelled Scheduled. Each row shows category glyph, payee, account/category, exact signed currency amount and transfer glyph where applicable. Long user text truncates in the row and wraps in the edit/review sheet.

Edit opens Form with the current entry. Review precedes commit. Remove explains that data leaves the ledger but stays in the file. The Recently removed view provides restoration, including transfer-pair recovery. Clearing filters restores all applicable rows. No results and no transactions have different explanatory copy. Native long lists should paginate or virtualise; the browser dataset is intentionally small.

## §5.4 Accounts

A tile names the account, type, currency and derived balance. Types include Bank, Mobile money, Savings and Cash. New account requires name, type, ISO currency and opening balance. Currency is locked after creation, with “Currency stays fixed so history stays honest.” Rename/type changes do not rewrite financial history. Archive/unarchive keeps all rows. Archived accounts are not offered for new captures, but history can still be inspected.

Native future enhancement: a balance-reconciliation action creates an explicit adjustment transaction after review; never overwrite the derived balance. This is a recommended extension, not a working prototype control.

## §5.5 Categories

Expense and Income views expose name, icon and keyword phrases. The keyword helper explains comma-separated matching with “lunch, chop bar, kfc”. Save updates subsequent Quick parsing. The prototype uses theme-governed category tint instead of arbitrary user colour, keeping meaning readable without colour. Native custom category colour can use accessible palette presets; never assign the reserved financial error colour to an everyday category. 24 SVG glyphs are included; the prototype editor exposes a smaller starter selection. Category row labels remain visible.

## §5.6 Budgets

Choose reporting month and currency, category and amount. One budget exists per category/month/currency. Saving the same combination updates its amount. A positive amount is required. Clear removes the limit without touching expenses. Current spending and budget progress derive from the ledger. An exceeded limit is factual feedback, with no judgement or lockout. Goal navigation is available from this page.

## §5.7 Settings, import, export and recovery

### Preferences

Default currency preselects new account creation and never changes an existing account. Appearance toggles light/dark. Balance hiding affects sensitive summary amounts in the main app. It is a shoulder-surfing aid, not encryption or an app lock. Category, budget, goal and recurring-rule links lead to the same screens used elsewhere.

### CSV import

Pick a CSV or try the included in-app example. Parser supports commas, quoted cells, escaped quotes and quoted newlines. Map date, payee/description and signed amount to three separate columns. Choose exactly one destination account/currency. Column guesses use header names; successful mappings are remembered by normalised header layout.

Review displays ready, duplicate and unreadable counts. Duplicate comparison normalises destination account, date, signed minor-unit amount and description, both against existing records (including soft-deleted ones) and within this batch. Unreadable rows list their row number and reason. Ready rows can proceed while errors are quarantined. Repeating a committed statement yields zero new rows. A zero-ready import has no active commit action. Confirmation commits from this reviewed batch and rechecks existing content before adding.

Prototype boundaries: ISO YYYY-MM-DD dates; one signed amount column; no debit/credit dual-column mapper or bank-specific locale normalisation yet. Native importer should add date/number locale selection, bank-shape adapters and a content hash calculated from a documented canonical representation. Use a cryptographic or strong content hash as an index, preserving canonical fields for duplicate reasoning. Do not use provider credentials or bank login.

### Export and backups

CSV includes active ledger rows with ISO dates, signed amounts, currency, account, category, raw note and transfer identity. Browser download is requested through a Blob. The JSON backup includes the full prototype model, preferences, mappings, soft-deleted rows and recoverable wiped snapshot when present.

Native contract: exporting the user's actual SQLite file is a safe database copy/checkpoint operation and includes everything; expose JSON as an interchange backup and CSV as a spreadsheet export. Use the OS share sheet. A browser JSON file is not a SQLite file, and this prototype does not claim otherwise.

### Restore and wipe

Restore accepts a prototype JSON backup, checks the expected structure, presents record counts, explains replacement instead of merging, asks to continue, then asks a final replace confirmation. Cancel preserves the existing state. Invalid file feedback appears inline. Successful restore replaces the model and refreshes Home.

Wipe first explains the scope and offers backup. Continue leads to a second step requiring the literal word WIPE. The prototype clears active accounts, transactions, budgets, expectations, rules and goals while retaining preferences, categories and mappings. Its recoverable prior money snapshot stays in the exported JSON under removedData; restoration of that snapshot is a developer/native recovery concern, not an exposed browser control. Make this retention explicit in the native product's privacy policy and implement a separately named permanent erasure flow if required. Never promise forensic erasure for a soft-delete operation.

### Other settings

Explore example money creates an isolated sample model while retaining the full personal model; Return to my ledger restores the personal model rather than merging examples. Starting example mode twice does not duplicate it. The backup reminder is an in-app reminder on launch after seven example days; native local-notification scheduling remains an implementation dependency. Footer states no paywall, ever and identifies version and prototype boundaries. Browser persistence is best effort with an in-memory fallback.

## §6 Planning / Look ahead

### Expected payments

Pending blocks use dashed borders, blue-grey tint and explicit “Expected · not received” text. Add/edit requires description, positive amount, destination account and expected date. Overdue copy gives a factual number of days late. Received opens a confirmation naming amount, account, payee and today; confirmation adds an actual income transaction and removes the expectation. Removing an expectation requires confirmation and never changes actual balances.

### Recurring rules

Name, money-in/out direction, positive amount, account, next date and weekly/monthly frequency. Monthly dates preserve the anchor day and clamp to each month's final date. Home shows the next seven days. Rules feed the forecast but never silently create real ledger transactions. Recording actual payments remains a capture-and-confirm action. Native implementer should support occurrence identity and match recorded payments to avoid counting a rule and its scheduled occurrence twice.

### Forecast

30/90/180-day selectors; per currency and optionally per account. Current balance plus future-dated ledger entries plus recurring rules yields the solid line. The dashed alternative adds expected payments. Overdue expected payments are assumed today only in that alternative; state the assumption clearly. Undocumented future daily spending is not predicted.

The headline shows the exact projected end balance. If any projected day is negative, show “Runs dry on [date]” in financial error colour with alert icon and a tap target for that day's events. Otherwise show “Covered across this projection”; this is conditional on recorded assumptions, not a guarantee. Day detail excludes unreceived money from the headline balance. The event list names scheduled, recurring and scenario contributions. The native version should support per-day chart inspection and occurrence matching.

### Safe-to-spend

Recorded balance minus negative obligations dated before the next scheduled income minus goal reservations, within the selected currency. If no scheduled income exists in 180 days, use a disclosed 30-day commitment window. No pending income is included. The detail sheet exposes every subtotal and the cutoff date. This is available money after known commitments, not a per-day allowance. A negative result is labelled shortfall.

### Goals and sinking funds

Name, currency, target, already reserved amount and target date. Reservations stay within account balances and reduce safe-to-spend; they do not move money or create income. Progress caps visually at 100% but the exact saved figure remains readable. Monthly contribution is the remaining amount divided by the estimated months remaining, rounded up to a minor unit; in native UI explain month-counting convention. Changing or removing reservations updates planning only. Removing requires confirmation.

### Scenarios

A “payday 2 weeks late” preset opens the forecast with temporary assumptions. Controls vary recurring income delay (0–30 days), income reduction (0–100%), one-off spend, and a simple principal-only loan with 3/6/12 repayments. Update recalculates without saving. Loan remainder is included in the last instalment so repayments exactly equal principal. No interest or fees are assumed; this is stated. Reset clears assumptions. Back to forecast restores the ordinary curve. There is no scenario Save action.

### Phase 2b/3 design guidance

- Hold-to-talk: same capture sheet and preview; an accessible tap alternative accompanies a gesture.
- Subscription renewal: use recurring rule → local notification → detail/review, no subscription marketplace. Native adds renewal metadata and notification permission settings.
- Widget: compact “Add a spend” and “Say a spend” targets, optional hidden figures, deep link into a draft rather than saving directly.
- Household: reserve an optional `ownerLabel` (“Ama”, “Shared”) beside account or entry metadata, not a fake online avatar. Shared storage, merge conflicts, encryption and synchronisation require a separately resolved architecture. No server or sync claim is made here.
- Tablet: preserve the phone hierarchy initially; later use list/detail panes with the same components and tokens. Do not stretch phone figures across the full tablet width.

## Included useful additions

Balance hiding; explanatory safe-to-spend breakdown; in-app backup reminder; Recently removed recovery; non-destructive scenario assumptions; preserved raw capture sentence. These strengthen the private-money purpose without adding social mechanics, gamification, a bank integration or a paywall.

## Delivery and implementation boundaries

The prototype is editable HTML/CSS/JavaScript with local best-effort browser storage. It is not a Flutter executable, SQLite implementation, bank connector, native audio recorder, biometric lock or multi-device system. Seeded content illustrates Ama's usage and is not a real person's financial data. The app's demonstration clock is fixed at 20 November 2026; native implementation must use the device's local date and refresh calculations at day boundaries.

No browser preview, screenshot, automated test, or Flutter compilation was performed as part of this delivery. Contrast and accessibility values are design targets; perform native accessibility, large-text, TalkBack, date/timezone, import-fixture and financial-invariant tests during engineering integration.


## Version 1.1 — onboarding, full state coverage and shared components

Read `states-and-onboarding.md` as the current specification for entry, personalisation, loading, recovery and platform conventions. It supersedes earlier descriptions of an example-seeded first launch and a Material-based component skeleton. Existing financial flows and invariants above remain in force. Material colour role files remain optional compatibility assets. `gally_components.dart` provides custom widget starters; it has not been compiled or integrated into a native app.


## Version 1.2 — subscriptions, flexible budgets, discussion and splash

See [Planning and conversation](planning-and-conversation.md) for the current design contract. The prototype now includes a Subscriptions destination under Settings and Look ahead, overall/category budgets with weekly/monthly/custom periods and optional positive rollover, and Talk it through from onboarding, Home and Settings. The discussion is explicitly guided, with local calculations and no connected AI model. Voice is a typed-transcript interaction preview; no audio is recorded. A 900ms app-owned splash introduces the mark and wordmark; reduced motion goes directly to the ready screen. Settings offers replay.

`planning.js` contains the new local interaction and calculation logic. Material remains optional compatibility data. No rendered video, live AI integration, OS notification scheduling or native speech engine is included. The new sources were not visually previewed or run through automated checks during this production turn.
