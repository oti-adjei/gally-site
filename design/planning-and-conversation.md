# Gally 1.2 — subscriptions, flexible budgets and Talk it through

This extends the 1.1 custom iOS/Android system. The financial truth rules remain: exact integer minor units, per-currency totals, explicit confirmation and no cloud/account assumptions. This is an editable local browser prototype and a native implementation specification.

## Where to find the additions

- Onboarding welcome/name step → Talk me through it instead.
- Home → Let's talk it through; Settings → Think ahead → Talk it through.
- Home → Look ahead → Subscriptions, or Settings → Subscriptions.
- Home/Settings → budgets → A plan that fits.
- Launch → animated mark/wordmark; Settings → Replay the opening animation.

Existing four-destination navigation stays stable. Discussion is a full screen, not a modal transcript squeezed into capture. Capture still lives on the centre action. Native file, permission and share surfaces remain platform-owned.

## Subscription model and management

A subscription names a service, charge amount, paying account/currency, weekly/monthly/yearly cycle, next renewal, anchor date, optional trial end, reminder preference, active/cancellation-recorded status, and dated price changes. There are no provider logos or stock substitutes; category glyphs carry the surface.

Creation/edit → review card → explicit save. This creates a plan, not a ledger payment. Trial end must be on or before the next scheduled charge. Trial-end metadata is visible; there is no automatic trial cancellation or provider integration.

List: per-currency selector; exact total charges in the next 30 days; active vs cancellation-recorded views; next date/cycle on each service. A yearly plan contributes its actual charge if due in the window, not a misleading monthly average. Multiple weekly charges inside the window are each counted. Empty states invite one useful first action.

Detail: exact price, account, cycle, next renewal, trial end, reminder preference and price-change history. Reminders are stored preferences; actual OS scheduling is a native dependency. The prototype does not claim notifications were delivered or permission was granted.

Record a payment accepts an exact positive amount and a payment date on or before the demonstration date. Review names the actual outflow and the scheduled renewal it covers. Confirmation writes the real expense and advances the next renewal once. It does not post every subscription charge automatically. A stale confirmation is rejected if that renewal has already advanced.

Monthly/yearly advancement retains the original day anchor and clamps to the last day of shorter months. Weekly advancement uses seven days. Future changes apply to renewals on/after their effective date; recorded expenses are not rewritten. Editing base details preserves already planned dated price changes, which may still override the base price.

Cancellation requires confirmation that the user has arranged it with the provider. It removes future charges from Gally's forecast only. Reactivation similarly reactivates tracking, not the real service. Status is labelled accordingly. No provider cancellation request or external account action is sent.

### Forecast and accounting integration

Active renewals join recurring/scheduled obligations in upcoming events, forecasts and safe-to-spend. All contributions remain per account and currency. Recording a renewal advances its schedule so the recorded outflow and that same upcoming charge do not both remain in the projection.

If the next recorded renewal is already overdue, the projection conservatively includes one unrecorded renewal today, plus future cycle dates. Detail explains this assumption and asks the user to review the missed renewal. It does not invent every historical charge. Pending expected income remains distinct from subscription obligations.

Deleting the most recently recorded renewal transaction restores its renewal date when the plan still points exactly to the next cycle; restoring that transaction advances it again when the dates still match. Older or manually rescheduled cycles are not silently rewritten. Native engineering should add explicit occurrence identities for complete reconciliation of complex backfilled schedules.

Normal recurring rules and separately entered future ledger transactions remain independent. The prototype cannot infer that a manually entered generic future row is the same occurrence as a subscription; use Record a payment for linked renewal recording. Native occurrence matching remains necessary when importing provider/bank data.

## Budgets that fit different lives

Two scopes: all recorded spending in one currency, or one expense category. Three periods: weekly, monthly or explicit custom inclusive start/end dates. An optional descriptive name distinguishes plans. All amounts are exact positive minor-unit limits. A budget is a view/limit, not an account transfer or a savings reservation.

Creation/edit → review → explicit confirmation. Weekly periods start on the chosen date and last seven days. Monthly periods use calendar months and normalise the start to the first day of the chosen month, shown in review. Custom periods keep the entered dates and do not repeat or roll over.

An “as of” date controls the budget view. A plan starting after that date is marked upcoming. A custom plan whose end is before the date is marked ended. Spending comes from actual non-deleted expenses dated within the window and no later than the view date or the demonstration date. Future scheduled expenses and transfer legs are excluded.

Positive-only rollover is optional for weekly/monthly plans. For each completed period from the plan's start:

`next carry = max(0, base limit + previous carry − actual period spend)`

The current limit is base plus derived carry. Overspending does not become debt in the next period. No rollover value is stored as financial history; editing a historical transaction recalculates it. The detail view discloses base, carry, effective limit and exact spending. Custom periods disable rollover.

Overall and category budgets may cover the same expenses. They are independent perspectives and are never added into an “available budget” total. Goals continue to reserve money separately and reduce safe-to-spend; budget limits do not reduce it a second time. Different currencies remain isolated. Legacy monthly category budgets migrate to recurring monthly plans anchored to their original month, with rollover off.

## Talk it through

### Honest capability boundary

The screen explicitly says “Guided · on this device” and explains that it uses predefined questions and local calculations, not a live language model. There are no API calls, model credentials, transcript uploads or inferred personal-finance advice. Unsupported topics receive a candid capability statement and useful supported choices.

The experience still feels conversational: the user asks in their own words; the guide responds, gives concrete next steps and asks follow-up questions. Suggested questions cover spending, safe-to-spend, subscriptions, budget choices, goals, setup and late-payday scenarios. The user can type free text or use the voice interaction preview.

### Grounded answers

- Spending: exact selected-month income, expense, net and leading categories, with transfer exclusion.
- Safe-to-spend: recorded balances less known commitments before the disclosed cutoff and goal reservations; expected income excluded. A supported “can I afford [amount]” phrase shows subtraction from that remainder, not an assurance or personalised financial recommendation.
- Renewals: actual planned per-currency charges in the next 30 days, with service, date and amount.
- Budget selection: explains overall/category scopes, periods, positive rollover and the relationship to goals, then opens the chosen editor.
- Late income: opens the existing temporary scenario; it does not edit the ledger.
- Capture-like statement: proposes the exact statement as Quick capture, then uses the ordinary interpretation/review/confirm flow.

Answers are snapshots from the model when the question is asked. They name currency/month and instruct the user to ask again to refresh after data changes. Historical replies are not represented as continuously live balances. No answer automatically writes a financial change.

Discussion text lasts in the current browser session. Clear discussion requires confirmation and never deletes transactions, budgets or subscriptions. It is not a messaging service or a support conversation sent to another person.

### Guided onboarding conversation

An optional alternative to the existing form. Questions: preferred name (skip allowed), currency, starting priority, account type or keep/add later, optional pocket name, exact opening balance. Ambiguous currency and unknown account choices trigger a follow-up rather than an invented interpretation. The staged answers are saved as a local setup draft. They are not live balances.

Final summary includes name, currency, priority, account and exact opening balance. Confirm creates at most one account and applies the preferences. Edit using the form carries the draft into the existing setup. Later pauses the guided journey; resume returns to the saved discussion. Existing accounts are preserved and can be kept. A completed user's profile is not downgraded merely by pausing a revisit.

### Voice interaction

Product entry: microphone button → explanation of on-device transcription → labelled interaction preview → typed example transcript → review/edit → send to the same guide. The browser records no audio. “No audio is being recorded” stays visible in the preview. It does not imitate a successful microphone permission grant.

Native contract: ready → permission at point of use → listening/cancel → local transcript → edit/send → local/model answer according to a separately authorised architecture. Permission denied retains text capture. Missing offline language pack does not silently switch to cloud speech. Empty transcript and cancellation preserve the earlier draft. Sending a transcript asks a question; committing a proposed transaction or plan still requires its own confirmation.

The prototype does not include spoken answer playback. If later introduced, it needs clear playback/stop controls, device voice availability handling and an explicit privacy architecture.

## Animated opening

The default app-owned splash uses the original Gally mark, wordmark and tagline over the brand primary ground. Timeline: mark 0–360ms; wordmark 160–460ms; tagline 320–520ms; exit 760–900ms. Motion uses small transforms and opacity, with no bounce or fabricated progress percentage. A 950ms deadline releases input if the animation-end event fails to arrive.

The app prepares its real destination before the reveal starts. The splash is a decorative brand introduction, not a network/loading claim. It blocks duplicate interaction briefly and returns focus to the destination heading. Reduced motion skips the timed reveal and opens the ready screen immediately. The browser HTML fallback remains available if startup fails; no opaque splash is displayed without script startup.

Replay is available in Settings. The design-system reference demonstrates the mark reveal separately. No standalone video export is included or required.

Native Android/iOS system launch screens have their own constraints: use supported static launch assets first, then this animation only in the app-owned frame, avoiding a visible jump in colour/mark position. Engineering must measure actual launch readiness and avoid extending genuine loading merely for branding.

## Data and native handoff

`planning.js` adds the new interaction/calculation layer; `app.js` connects render routes, upcoming obligations, budget presentation, backup validation, renewal soft-delete handling and splash entry; `experience.js` adds the guided-onboarding alternative. `app.css` contains shared component and motion rules. `tokens.json` records the motion and planning choices. New records remain in the same local JSON backup; wiping active money data clears subscriptions too while retaining its recoverable prior snapshot.

An example-mode music plan and cloud-storage trial illustrate the new surfaces without named-provider logos. They are sample data only and remain separate from the user's personal ledger. Native speech, live AI, provider integrations, OS reminder scheduling, encrypted storage and SQLite implementation are not delivered here.

The new files were written without a browser preview, screenshot, syntax-validation pass or native compilation in this production turn. The sources remain editable for implementation and further requested review.
