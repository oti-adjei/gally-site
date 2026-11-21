# Pip, app identity and notifications

Pip is Gally’s money companion. Its introduction is “I’m Pip. Let’s make your money a little clearer.” The name suggests a small, useful beginning. Gally remains the product and notification sender; Pip is the conversational character, not a second application.

## Character and placement

Pip is clear, patient and practical. Never shame spending, pretend to feel human emotions, promise financial outcomes or present expected income as money already received. The visual identity uses the original Gally stroke in a mint badge, with a small dot. It complements the existing Mote artwork rather than replacing it with a new mascot.

- Onboarding: **Set up with Pip instead** opens the guided questions. **Later** preserves the draft.
- Home: **Talk with Pip** opens the discussion. The desktop dashboard keeps its existing composition.
- Discussion: Pip’s badge, name, guided status, speaking-style selector and an explanation of how it works remain visible in the header.
- Settings: **Pip & your Gally** groups personality, app icon and notification look/privacy.
- About Pip: compare all four styles using one explicitly illustrative financial example, then start a conversation.

## Four speaking styles

| Style | Character | Example phrasing |
| --- | --- | --- |
| Calm & clear — default | Measured explanation, room to think | “We can go through the breakdown when you’re ready.” |
| Warm & encouraging | Friendly support without judgement | “Let’s make a little room to breathe.” |
| Direct & practical | Facts first, concise next step | “Next step: review the breakdown.” |
| Curious & thoughtful | Gentle questions and reflection | “Which part would you like to understand first?” |

The preview uses GHS 2,000.00 recorded balance, GHS 500.00 bills and GHS 250.00 goal reservation: GHS 1,250.00 remains. Every style excludes expected payments. These figures are labelled illustrative, not sourced from the user’s ledger.

Actual guided replies retain the existing local calculations. A style-specific opening is applied around the answer; it does not change arithmetic, scope or confirmation. New replies store their tone label, so switching styles does not relabel previous replies. Old replies without a stored label use the original Calm label. Setup draft replies retain the selected style as they are created.

The selected personality is saved locally in `db.pip.style`. It survives entering and leaving example mode without merging financial data. In storage-failure mode the existing session-only warning applies. Live language models and spoken voice variants are not connected. Voice capture remains an explicitly labelled typed transcript preview.

## Notification concepts

Open `appearance-lab.html` for interactive iOS/Android phone previews. Switch between notification and home-screen views, five icons, four reminder types and Pip’s four styles. Controls here are exploratory; they initialise from saved app preferences but do not overwrite them. Set lasting preferences inside Gally.

| Reminder | Detailed example | Review destination |
| --- | --- | --- |
| Subscription renewal | Music plan: GHS 35.00 scheduled tomorrow from Everyday bank | Subscription detail |
| Budget exceeded | Shopping: GHS 720.00 spent of GHS 600.00 | Budget and its entries |
| Expected payment overdue | Kofi: GHS 2,000.00, six days late; excluded from balance | Expected payment |
| Backup reminder | Keep a current backup of the money file | Backup/export |

All examples are illustrative. Private preview mode is the default: amounts, names, account names and service names are omitted. The generic reminder type can still be visible. App sender is always **Gally**. The phone illustration includes its logo; Android uses the separate monochrome small notification mark. Icon choice is illustrated on iOS notifications and both home screens; Android’s small notification mark stays separate.

### Native interaction requirements

1. Explain the benefit when someone enables their first useful reminder, then request the platform’s notification permission. Do not ask on first launch without context.
2. If permission is denied, preserve the in-app reminder and offer device settings. Do not simulate a grant or repeatedly prompt.
3. Schedule only after the user saves the relevant plan. Changing or deleting that plan must update or cancel its reminder. Handle time zones and repeat schedules in the native implementation.
4. A notification’s Review action opens the relevant record after any required device/app authentication. It never marks a payment received, records a renewal or alters a budget automatically.
5. Later dismisses the notification. Do not imply snooze/rescheduling unless separately implemented.
6. Re-check current record state when opened. A removed or changed item needs a useful explanation, not stale financial actions.
7. Combine private content with native lock-screen visibility controls; app preferences cannot override a phone’s system settings. Reminder preference and OS authorisation are distinct states.

The preview action buttons report the intended destination only. This browser package requests no notification permission, schedules nothing and triggers no financial mutation.

## Alternate app icons

| ID | Visual treatment |
| --- | --- |
| original | Existing citron background and forest Gally mark |
| forest | Forest background and white mark |
| mint | Mint background and forest mark |
| citron | Citron background, forest coin and citron mark |
| monochrome | Ink background and white mark |

Settings → App icon immediately saves `db.pip.appIcon`, updates the in-app preview and sets the browser favicon where supported. It does not change an installed application’s launcher icon or an installed web app’s manifest identity.

Editable vector sources live in `assets/brand/app-icons/`, with a manifest and 108 × 108 source canvases. Each variant has full artwork and separate foreground/background sources. `adaptive-monochrome.svg` and `notification-monochrome.svg` serve different roles. Native asset catalogs, density exports, Android resource XML and compiled platform projects are not included; these source assets require conversion and packaging for release.

On iOS, bundle alternate icons, check support, then call the platform’s alternate-icon API. Keep the previous selection on error and show a recoverable message. Apple documents the API and icon declarations in [setAlternateIconName](https://developer.apple.com/documentation/uikit/uiapplication/setalternateiconname(_:completionhandler:)).

For Android, an activity alias can have its own icon and launcher intent filter. An alias-based switching design is a proposed native approach, not an implemented or universally verified launcher behaviour. Validate the chosen approach on target launchers, preserving a working entry point. See [activity-alias](https://developer.android.com/guide/topics/manifest/activity-alias-element).

Native notification integration must follow the platform permission, channel and icon APIs. Android documents the required small icon, channels and runtime notification permission in [Create a notification](https://developer.android.com/develop/ui/compose/notifications/create-notification). Apple’s entry point is [Asking permission to use notifications](https://developer.apple.com/documentation/usernotifications/asking-permission-to-use-notifications).

## Delivery boundaries

The phone shells retain the bundled platform frame templates. Their notification cards and home screens are illustrative compositions; actual appearance varies by OS, launcher, font scaling and user settings. They are not screenshots from native builds.

The app still uses a fixed reference date for example calculations. No live AI, native microphone capture, OS notification delivery or native launcher switching has been added. This increment has not been browser-previewed or compiled as a native app.


## Character, presence and shared controls update

Pip now offers Your Guy, Girl’s Girl, The Coach and Quiet Companion alongside the classic styles. The web/mobile apps share contextual access explanations, a labelled voice/state preview and custom dropdown/calendar components. The landing page includes interactive character examples. See [the expanded handoff](pip-states-and-controls.md) and [the design-system reference](../design-system.html#pip-characters). Earlier speaking-style notes above describe the original four styles, which remain available.
