# gally-site

Gally product site — **landing + live design demo**. Serves `gally.hearvie.dev`.

- `index.html` — the product landing page (as designed, no framework, zero dependencies)
- `web-app.html` — the responsive design demo (example mode via `?example=1`)
- `design/` — the design system package (tokens, specs, guides) kept public on purpose
- `assets/` — brand, icons and the MIT-licensed Mote runtime

Static hosting: any host works (Cloudflare Pages recommended — the product's
sync infrastructure is Cloudflare Workers + D1, so everything stays on one
platform). Fonts use the licensed-fallback stack until Noi Grotesk / Fusion
Neue files are licensed and added.

Source of truth: the design package in the main workspace (`03-Design/`).
This repo is a publishing copy — regenerate rather than hand-edit when the
design updates.
