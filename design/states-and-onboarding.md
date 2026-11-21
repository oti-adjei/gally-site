# Gally 1.1 — onboarding, states and platform behaviour

This specification extends the original screen specifications. It supersedes the previous example-seeded first launch and Material component-base guidance. The palette and financial invariants remain unchanged.

## A custom product for iOS and Android

Gally's visual system owns buttons, chips, typography, forms, navigation, sheets, surfaces, figures and state treatments. It is not a Material UI with a different colour, nor an iOS clone on Android. Use the same Gally components on both platforms; adapt behaviour and OS-owned surfaces to their native conventions.

The browser prototype uses a neutral handset presentation and does not imitate either OS's permission or file dialogs. No platform selector appears inside the product. `gally_components.dart` contains editable pure Flutter widget starters for a button, surface and semantic amount. `gally_theme.dart` and the Material role files remain optional compatibility references for existing engineering code, not requirements to use Material widgets. No native app was built or compiled for this update.

| Concern | Shared Gally contract | iOS adaptation | Android adaptation |
| --- | --- | --- | --- |
| Navigation | Four stable destinations, capture as an action | Edge-back for pushed detail screens, visible back action | System/predictive back closes sheet, then returns a level |
| Forms | Persistent labels, explicit review, preserved drafts | Native keyboard/input accessory dismissal | IME actions and system back dismiss keyboard first |
| Sheets | Gally content, close affordance, focus return | Native sheet dismissal conventions; preserve draft | Accessible modal sheet with system-back handling |
| Safe areas | Content and controls avoid system overlays | Notch, home indicator, keyboard insets | Edge-to-edge status, navigation and IME insets |
| Accessibility | 48 logical-pixel target, meaning beyond colour | Dynamic Type, VoiceOver, Reduce Motion | Font scaling, TalkBack, reduced animations |
| Permissions | Request at point of use, explain alternatives | Native microphone prompt and app-settings link after denial | Native permission request and denied/permanently-disabled paths |
| Files | Review before import; safe export/restore | Document picker and system share sheet | Document picker and system share sheet |
| Haptics | Optional single quiet acknowledgement after commit | Native selection/confirmation feedback | Native light confirmation feedback |

Do not bake a 200ms delay into saves to display a spinner. Movement expresses a real state change. On slow local work, show actual progress or an indeterminate progress control with useful text. Never imply a remote connection exists.

## Onboarding: personalised, optional and local

The journey is welcome → name/currency → priority → first account → confirmation → Home. It is not an account-registration flow. No email, phone, password, bank connection or upload is requested. The profile is local personalisation data.

### 0. Welcome

Title: “Your money. Your pace.” Supporting copy: “A little space to understand today. A clearer view of what's next.” Private-ledger vector artwork uses the Gally mark, mint and citron; no stock image or third-party logo is involved.

Primary: Make Gally mine. Secondary: Explore with example money when no accounts exist, or Keep my ledger & personalise for an existing ledger. Set up later remains available. Theme switching works before setup. The promise is “No sign-up. No bank login. Everything stays on your device.” In browser contexts this means local model/storage; it does not claim browser encryption.

### 1. A name and everyday currency

Optional name, maximum 32 characters, with a persistent label and device-only helper. Blank is valid and leads to an inclusive non-name greeting. Use a given-name autocomplete hint without requesting any other personal details.

Choose GHS, USD, CAD or NGN in labelled, accessible selection tiles. GHS is the initial recommendation because the product is Ghana-first. Existing preferences prefill where available. Choice sets the default for new accounts and the initial aggregate currency view. It does not redenominate existing accounts or combine balances.

### 2. A starting priority

Single-select: Understand my spending; Feel ready for payday; Make room for a goal. Each has a short explanation and an outlined category glyph; selection is indicated by border, fill, check and pressed state, not colour alone. The starting choice is spending clarity; it can change in Settings. This is an order-of-help preference, not a feature gate or claim about the user's income.

### 3. One first pocket

Account type, optional nickname, opening balance in the chosen currency. Types: Mobile money, Bank, Cash, Savings. No bank connection or permission is required. Empty nickname derives a sensible account name. Exact signed opening amounts are allowed, with at most two decimal places; blank, malformed or excessive-precision amounts need correction. A negative opening balance is possible and is not silently discarded.

“Add an account later” skips financial setup. Existing accounts are preserved and “Keep my existing accounts” is selected initially. Unticking it allows an additional account. A draft opening balance is stored as setup text, not as a live account balance. Only the final confirmation creates the account.

### 4. Review and confirm

Display name (or Not set), currency, starting priority, new account and exact opening balance, or a clear Add later/Keep existing accounts message. All user text wraps. Back edits the draft. Confirm & open Gally commits the staged account at most once; the draft then becomes “keep existing accounts.” No transaction is fabricated to make the overview feel populated.

### Pause and resume

Set up later persists the current step and input and opens Home. It does not create a staged account. Home shows a calm resume card, not repeated blocking prompts. Settings includes Continue my setup / Revisit my setup and a direct profile editor. Revisit keeps existing financial data.

The chosen name and currency can personalise Home after skipping. Existing transactions, balances, budgets and plans are never wiped merely because onboarding is new in version 1.1. Legacy prototype data is preserved and setup is offered around it. Resume is best effort if browser storage is blocked; the session-only notice explains this limitation.

## Personalisation on Home

The greeting uses the optional name; the settings shortcut uses its first character or “You.” The title reflects clarity, payday or goals. Every feature remains reachable.

Next useful action derives from actual data in this order:

1. No account in the selected currency: add a first account, and show a quiet no-data explanation rather than a made-up balance.
2. Account exists but no active entries: offer first capture with a concrete sentence example.
3. Payday priority with no scheduled income: suggest an income rule to anchor the plan.
4. Goal priority with no goal: suggest a first goal.
5. Clarity priority with no budget: suggest a flexible category plan.

No progress score, streak, pressure, fake urgency or invented result is attached. Cards disappear naturally when the relevant data exists. Capture and planning still operate from the same shared model as before.

## Isolated example mode

Fresh personal use starts empty. “Explore example money” creates the sample model and retains the complete personal model in a separate snapshot. A persistent banner says these are sample balances and provides Back to mine. Leaving restores the personal model, profile, accounts and transactions without merging sample rows. Editing examples changes only example mode. Example mode does not request a microphone or create OS permissions.

If browser storage is available, both mode and the retained personal snapshot survive reopening. A JSON backup in example mode includes that snapshot, so it is not a shareable anonymised demo export. Treat it as private. The ordinary CSV export includes the currently visible model's active transactions only.

## State matrix

| Area | State and trigger | Visible treatment | Action / recovery | Delivery boundary |
| --- | --- | --- | --- | --- |
| Startup | Source loading | Real HTML welcome copy and local-opening status | Wait for synchronous app startup | Implemented; no artificial delay |
| Startup | Script/resource cannot start | Persistent explanatory copy instead of an empty phone | Try opening again; saved data not cleared | Implemented fallback |
| Startup | Rendering throws | Dedicated interruption screen | Reload or download saved browser copy | Implemented; does not claim a successful render |
| Saved data | Unreadable JSON/model | “Let's keep your history safe” | Download raw copy, restore backup, retry, or explicitly start new | Implemented; never auto-overwrites unreadable storage |
| Storage | Write fails or access denied | Visible session-only notice, current session remains usable | Try saving again; export before leaving | Implemented; no false durable-save claim |
| Setup | Fresh / in progress | Welcome and four-step progress indicator | Continue, back or pause | Implemented |
| Setup | Optional name absent | Generic greeting | Continue normally | Implemented |
| Setup | Invalid opening balance | Specific error after attempted progression | Correct exact decimal value | Implemented; entered draft preserved |
| Setup | Confirmation | Full summary including new financial data | Back or confirm | Implemented |
| Setup | Complete | “Your notebook is ready” acknowledgement | Personalised Home | Implemented |
| Home | No account for currency | No synthetic balances | Add an account | Implemented |
| Home | Account but no entries | First-capture invitation | Quick capture | Implemented |
| Lists | Empty / no search matches | Context-specific explanation | Add data or clear filters | Existing working flows retained |
| Capture | Untouched / missing amount | No error on untouched form; Quick review unavailable without amount | Add an amount | Existing flow retained |
| Capture | Invalid positive amount after blur | Inline error with invalid/input feedback association | Correct value | Added for amount and budget fields |
| Capture | Parsed | Interpretation preview, not yet saved | Review, correct or cancel | Existing flow retained |
| Capture | Reviewed | Currency, amount, account, category, payee, date | Confirm or edit | Existing flow retained |
| Capture | Commit success | Shared model refresh and concise acknowledgement | Continue capture or review ledger | Existing flow retained; session-only qualifier if persistence fails |
| Transfers | No compatible destination | Explanation in account picker | Add another same-currency account | Existing flow retained |
| Delete | Confirmation | Linked transfer scope / retained data explained | Remove or cancel | Existing flow retained |
| Delete | Removed | Ledger excludes entry; file retains row | Recently removed → restore | Existing flow retained |
| CSV | Reading file | Actual local file-reading status and indeterminate progress | Choose another file if reading fails | Added; no simulated bank connection |
| CSV | Read/parse fails | Clear error and ability to select again | Fix CSV or choose another | Existing flow plus readable loading surface |
| CSV | Mapping | Distinct column selection required | Correct map, review | Existing flow retained |
| CSV | Partial errors | Ready / duplicate / unreadable counts with row reasons | Import good rows, skip others | Existing flow retained |
| CSV | All duplicates | Nothing new to import; commit inactive | Change file or leave | Existing flow retained |
| Restore | Invalid file | Inline explanation; current ledger unchanged | Choose complete valid backup | Existing flow retained |
| Restore | Replacement | Two explicit confirmation stages | Cancel or replace | Existing flow retained |
| Forecast | Pending / overdue | Dashed blue-grey, explicit age and exclusion | Received → review → confirm | Existing flow retained |
| Forecast | Negative projection | “Runs dry” with icon and date | Inspect day's events | Existing flow retained |
| Voice | Not requested | Contextual explanation, typing works | Hold-to-talk in native app | Browser explains boundary |
| Voice | Permission denied | “Microphone is off” | Keep typing or open native app settings | Interactive component example + native specification |
| Voice | Offline engine unavailable | “Offline voice isn't ready”; no cloud fallback | Type; install offline language pack in native system | Interactive component example + native specification |
| Voice | No transcript / cancelled | Draft retained, nothing saved | Retry or type | Native state specified; browser state helper supplied |
| Reminders | Notification permission denied | No loss of planning features | Keep in-app reminders; revisit native settings | Native specification only |

## Component and interaction details

Onboarding uses the same 48px controls, persistent labels, theme pairing and focus treatment as the app. Large titles wrap and long names never clip or truncate. Smaller phone widths reflow the setup; keyboard users can press Enter to continue from setup inputs. Review precedes financial writes. Reduced motion removes entrance animation without suppressing information.

App sheets contain browser focus and restore it on close. Native dialogs and sheets must do the equivalent through the platform accessibility tree. OS screen-reader announcements should include amount direction, currency, account and confirmation state. The provided custom amount starter accepts a localised spoken label; engineers must generate it with the app's localisation layer.

Neutral caution surfaces explain non-financial failures. Red remains for financial facts or amount validation. Permission-denied and storage failures should not borrow overspend styling. Progress reflects real work, not an offline/connecting indicator.

## Recovery invariants

- Do not reset browser data automatically to solve a render or parse error.
- Keep the unreadable raw browser copy available for download. It may contain private data.
- A new-ledger reset requires explicit confirmation after the recovery choices are shown.
- Restoring a complete valid backup replaces the current model only after two confirmations.
- Save retry reports persistent success only if the storage write succeeds.
- An in-memory write is usable but not durable. Always say so when persistence is unavailable.
- Prototype local storage and recovery downloads are not an encrypted SQLite backup system.

## Engineering continuation

The fixed demonstration date and native feature boundaries from the original package remain. Integrate real device-local calendar dates, atomic SQLite writes, occurrence matching, native permissions, local notifications, native export/restore, large text and accessibility semantics in the existing app. Keep custom Gally widget styling independent from optional Material adapters. Exact licensed fonts still need to be supplied.

No browser walkthrough, screenshot or native compilation was performed for this update. The earlier startup syntax repair was checked in the preceding turn. New experience/state sources are delivered as editable design and interaction implementation for engineering integration.
