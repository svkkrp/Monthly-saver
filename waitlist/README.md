# Monthly Saver waitlist site

One static page (English, Telugu, Hindi) that collects Hyderabad waitlist sign-ups and the
"would you pay ₹299 a year?" answer that decides whether the Stage 1 build goes ahead.

## Files
- `index.html`, `styles.css`, `app.js`: the page. Open `?lang=te` or `?lang=hi` for a language; `?src=whatsapp-group-1` tags where a sign-up came from.
- `config.js`: Supabase URL and public anon key. Empty = demo mode (nothing saved).
- `supabase/schema.sql`: the waitlist table. The public key can only add rows, never read them.

## Go live
1. Supabase: new project in the Mumbai region, run `supabase/schema.sql`, copy the URL and anon key into `config.js`.
2. Host as a static site (GitHub Pages from this repo, or Netlify/Vercel).
3. Share the link in WhatsApp groups with a `?src=` tag per group.

## Before sharing widely
- Have a native speaker check the Telugu and Hindi text.
- Add a contact (email or WhatsApp) in the footer for deletion requests.

## Go/no-go
In the Supabase SQL editor: `select would_pay, count(*) from waitlist group by would_pay;`
The plan's gate: go ahead if at least half of the first 20 interviewed families would pay.
