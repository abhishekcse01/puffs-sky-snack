# Puff's Sky Snack

A bright, bouncy browser game for kids and grown-ups. Steer Puff the cloud, catch falling fruit, dodge bombs and beat Grumble the storm boss. It plays on phones (drag your finger) and laptops (mouse or arrow keys).

## Features

- **Two modes:** Easy Breezy (5 hearts, gentle) for little hands, and Sky Storm (3 hearts, fast) for big kids and adults.
- **Combos:** catch 5 in a row to double your points, up to x5.
- **Power-ups:** magnet, slow-mo, shield and extra hearts.
- **Boss levels:** every 4th level Grumble the storm cloud attacks with bomb volleys and lightning. Catch the suns to zap it.
- **Character skins:** 8 looks for Puff, unlocked by playing (Bubblegum, Minty, Party Puff, Sunny, Rainbow, Galaxy, Royal Puff).
- **Online leaderboard:** top 25 per mode, stored in Supabase. Nicknames are limited to 12 characters and filtered.
- Sound effects made in the browser, so there are no audio files to load.

## Project layout

```
index.html            the whole game (HTML, CSS and JavaScript in one file)
supabase/schema.sql   database table and security rules for the leaderboard
```

No build step and no dependencies. Open `index.html` in a browser to play locally.

## Leaderboard backend

Scores go straight from the browser to Supabase's REST API using the project's **publishable** key, which is safe to ship in client code. Security comes from the database rules in `supabase/schema.sql`:

- anyone can read scores and add a score
- nobody can edit or delete scores through the public API
- names must match `^[A-Za-z0-9][A-Za-z0-9 _.-]{0,11}$`, and scores must be between 1 and 200,000

To point the game at a different Supabase project, run `supabase/schema.sql` there and update the `LB` URL and key near the bottom of `index.html`.

## Deploying

The site is static, so any static host works. On Vercel, import the repository with the default settings (Framework preset: Other, no build command).
