// Gally waitlist — a Pages Function writing to the owner's own D1 database.
// No third-party form service, no analytics: one email, one row, used only
// for the launch announcement. Duplicates answer 409 politely.
// Binding: WAITLIST_DB (D1). Schema (run once in the D1 console):
//   CREATE TABLE IF NOT EXISTS waitlist (
//     email TEXT PRIMARY KEY,
//     created_at TEXT NOT NULL
//   );

const EMAIL = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;

export async function onRequestPost(context) {
  const { request, env } = context;
  if (!env.WAITLIST_DB) {
    return json(503, { error: 'Waitlist is not configured yet.' });
  }
  let email;
  try {
    const body = await request.json();
    email = String(body.email ?? '').trim().toLowerCase();
  } catch (_) {
    return json(400, { error: 'Send JSON: { "email": "you@example.com" }' });
  }
  if (!EMAIL.test(email) || email.length > 254) {
    return json(400, { error: 'That does not look like an email address.' });
  }
  try {
    await env.WAITLIST_DB
      .prepare('INSERT INTO waitlist (email, created_at) VALUES (?, ?)')
      .bind(email, new Date().toISOString())
      .run();
  } catch (e) {
    if (String(e?.message ?? '').includes('UNIQUE')) {
      return json(200, { ok: true, already: true });
    }
    return json(500, { error: 'Could not save right now — try again shortly.' });
  }
  return json(201, { ok: true, already: false });
}

function json(status, body) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { 'content-type': 'application/json' },
  });
}
