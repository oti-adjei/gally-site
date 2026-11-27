// Waitlist form → /api/waitlist (Pages Function → the owner's own D1).
// One email, one row, one announcement. No third party, no analytics.
(function () {
  var form = document.getElementById('waitlist-form');
  if (!form) return;
  var email = document.getElementById('waitlist-email');
  var button = document.getElementById('waitlist-submit');
  var note = document.getElementById('waitlist-note');

  form.addEventListener('submit', function (e) {
    e.preventDefault();
    var value = email.value.trim();
    if (!value) {
      note.textContent = 'Add an email address first.';
      email.focus();
      return;
    }
    button.disabled = true;
    button.textContent = 'One moment…';
    fetch('/api/waitlist', {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({ email: value }),
    })
      .then(function (r) {
        return r.json().then(function (body) {
          return { ok: r.ok, body: body };
        });
      })
      .then(function (res) {
        if (res.ok && res.body.already) {
          form.classList.add('done');
          note.textContent =
            'Good to see you again — you\u2019re already on the list.';
        } else if (res.ok) {
          form.classList.add('done');
          note.textContent =
            'You\u2019re on the list. One email, when the app is ready.';
          email.value = '';
        } else {
          note.textContent =
            res.body.error || 'Something went wrong — try again in a moment.';
        }
      })
      .catch(function () {
        note.textContent = 'No connection right now — try again in a moment.';
      })
      .finally(function () {
        button.disabled = false;
        button.textContent = 'Tell me when it\u2019s ready';
      });
  });
})();
