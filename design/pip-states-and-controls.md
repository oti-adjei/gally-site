# Pip: character, presence, permissions and form controls

This increment extends the existing mobile and responsive web prototypes, landing page and design-system reference. It preserves Gally’s forest/mint/citron palette, Mote artwork and dashboard layout. It does not add a live AI model or audio service.

## Character, beyond tone

The main character choices are now:

| Character | Social energy | Boundaries |
| --- | --- | --- |
| Your Guy | Relaxed, candid, straight-talking; “Let’s see where it went. No lectures.” | No forced slang, bravado or pressure to spend |
| Girl’s Girl | Expressive, supportive and honest; “We can be kind to you and honest about the spending.” | No gender assumptions, patronising pet names or automatic praise for risky decisions |
| The Coach | Encouraging, focused on a manageable next step | No shame, achievement scoring or unsupported promises |
| Quiet Companion | Calm, reflective and patient; default for new preferences | No false certainty or pretending to be a human confidant |

Every character is available to everyone. These names describe conversational energy, not a user’s gender. Choosing one does not infer identity. Pip remains one companion with different ways of speaking; no separate model or spoken voice is implied.

Classic Calm, Warm, Direct and Curious styles remain in a disclosure. Existing saved choices and old reply labels retain their original IDs and meanings. New characters use `quiet`, `guy`, `girl` and `coach`. New preferences default to Quiet Companion; existing valid preferences remain untouched.

Topic-specific openings, introductions, setup greetings and illustrative examples carry the character. The underlying guided calculations are shared. Messages retain their selected style ID. Selecting a character never changes balances, planning rules, privacy or confirmation requirements. Live discussion history remains session-only; setup draft messages retain the existing local persistence behaviour.

## Pip’s presence

One shared component supplies a Gally-derived mark, signal and readable status. The app, landing page and reference use the same state definitions.

| State | Visual behaviour | Action / truth boundary |
| --- | --- | --- |
| Ready | Still mark and quiet signal | Type or start the voice preview |
| Listening | Small signal bars scale vertically | Explicitly labelled preview; no microphone recording |
| Transcript review | Still mark, transcript presented for checking | Edit or send; text is not a ledger entry |
| Thinking | Mark gently rises and fades | Design demonstration only; no model request is running |
| Replying | Short signal movement and reply entrance | Read the complete exact answer; no counting-up amounts |
| Interrupted | Still, subdued mark | Draft stays available; nothing is sent |
| Unavailable | Still mark and explanation | Keep typing; preserve the draft |

Entrances use 240ms, exits 160ms and a 1200ms listening/thinking loop in explicit previews. The reply signal is bounded to two cycles. Only transform and opacity animate. Reduced motion removes animation while retaining readable state text.

The guided discussion computes synchronously. It does not add an artificial thinking delay. New replies use an entrance animation; the composer remains ready. The explicit **Pip in motion** sheet and landing/reference demonstrations expose processing states without pretending a backend exists.

Voice preview flow: contextual explanation → clearly labelled listening demonstration → user types sample words → Stop & review transcript → edit or send → guided reply. Sending still does not commit proposed financial changes. **Keep draft & close** retains the typed words and returns them to the composer. Empty transcripts retain validation and never send. No audio or OS permission API is invoked.

## Contextual permission explanations

App Settings → Pip & your Gally → Access & permissions explains microphone, notifications and files. Try voice enters the microphone explanation at the moment of use. Enabling the reminder preference presents the notification explanation; this preference is distinct from OS authorisation.

- Microphone: benefit, typing alternative, stop/review controls and the proposed native on-device transcription boundary. Continue opens the labelled preview, not an OS prompt.
- Notifications: reminders the user chooses, private content by default, no automatic payment recording. Continue opens reminder preferences.
- Files: system picker for one selected file, review before import and separate confirmation before restore. No invented broad storage permission.

The design-system reference shows Why access, Not now, Denied, Unavailable and Access ready for each capability. These examples change no actual permission. Native implementation must request permission only after the contextual choice and derive denied/granted states from platform results. Keep typing/in-app reminders/current ledger usable after refusal or failure. A route to native device settings must be integrated on each platform; the browser does not claim to open it.

OS-owned dialogs and file pickers retain native appearance. Gally owns the explanation before them and the recovery path after them. No custom impersonation of an OS permission dialog is included.

## A shared form system

`gally-controls.css` centralises control height (48px), radius (12px), menu radius (16px), calendar radius (20px), padding, focus colour, shadow and motion. Palette values inherit existing light/dark tokens. Text, textarea, file selectors, checkboxes, radios, range tracks, custom dropdowns and calendars share the same visual vocabulary. Existing Gally switches retain their custom track/thumb treatment.

### Dropdowns

The original select remains the canonical value for existing saves, imports, validation and change handlers. A custom named button and listbox provide presentation. Options include selected and disabled states; values are plain text. Keyboard support includes arrows, Home/End, Enter/Space, type-ahead, Escape and Tab. Menus close on outside interaction, relevant scroll, resize or removal of the source view. Opening a dynamic sheet does not add duplicate handlers.

Native popovers place menus above scrolling surfaces. The fallback stays in the handset screen or current sheet. The list is bounded to the current viewport/phone width and has internal scrolling. Long option labels wrap. Multi-selects are intentionally not transformed; no such flow is introduced here.

### Dates

A custom calendar controls the original date input and dispatches its existing value-change events. It includes previous/next month, selected day, Today and Clear, respecting min/max dates and required fields. Arrow keys move days, Page Up/Down moves months, Escape closes. Date values retain `YYYY-MM-DD`; display labels use an explicit UTC date formatter to avoid time-zone day shifts. The app’s existing fixed reference date supplies Today where available.

### Errors and states

Controls retain visible labels. Invalid examples show a nearby remedy and accessible description; untouched app forms keep their existing validation lifecycle. Disabled controls remain labelled with a reason. Focus remains visible in both themes. Native file dialogs remain device-owned; only their in-page controls are styled.

The reference examples are isolated: choosing a file does not import it, and reference toggles schedule nothing. App forms retain the underlying ledger workflows.

## Entry points and implementation limits

- `landing.html#meet-pip`: character comparison and state demonstration; sample amounts are explicitly illustrative.
- `web-app.html?view=companion`: character preference, discussion, access and motion preview.
- `index.html`: same shared Pip/form features in the handset prototype.
- `design-system.html#pip-characters`: character, state, permission-outcome and form examples.
- `appearance-lab.html`: earlier icon/notification preview, now includes the new character choices and shared dropdown styling.

Native AI, speech capture, permission requests, notification delivery and installed-icon switching remain separate work. These changes were written without browser preview, screenshots or native compilation. No OS-level functionality is claimed by the demonstrations.


## Mobile fit refinement

The handset prototype now gets mobile composition rules from its actual surface, even when the surrounding browser is wide. Responsive web uses the same rules below 768px; desktop dashboard composition stays intact.

- Navigation: Home, Ledger, Add, Pip, Accounts. Pip opens directly from its persistent tab. Settings is reached through the profile control, or the settings control in Pip’s header. Guided onboarding retains its Later action and setup entry to Pip.
- Conversation: the duplicate application topbar is removed on mobile. The compact Pip header retains character selection, Settings and a More sheet for secondary actions, currency, access explanations, state previews and clearing discussion. Clear discussion still requires confirmation. Suggested questions move into an expandable group; setup suggestions begin expanded.
- Space: messages retain a scrollable reading region and full readable text. The composer uses 16px text, balanced action buttons and expandable suggestions. Under severe height constraints the conversation surface can scroll rather than hiding essential actions. The phone’s visible-viewport overlap is reserved when a software keyboard reduces the available area.
- Character and identity preferences: character choices are one column, including sheets; descriptions remain readable. App icon choices use three columns, reducing to two below a 350px content width. Permission and state-preview sections use the same compact mobile spacing.
- Sheets: actions stack, headings wrap, close controls retain a fixed touch target, and the sheet body scrolls within the phone. System safe areas stay reserved.
- Dropdowns and calendars: shared placement intersects the visible viewport with the phone’s safe content area and bounds both width and height. It chooses above/below when space allows, otherwise uses the available safe region with internal scrolling. In a scaled handset frame, popup geometry is converted back to local coordinates; menus stay inside the phone rather than inheriting mismatched top-layer coordinates. Responsive web keeps native popover layering. Menus close when the visible viewport changes.

Changes are in `mobile-fit.css`, `mobile-fit.js` and the shared menu/calendar placement code. Shell hardware, frame scale and safe-area declarations are preserved. No browser screenshots or visual verification were performed for this refinement.
