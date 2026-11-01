-- Leaderboard for Puff's Sky Snack.
-- Public (anon) clients may read and insert; nobody may update or delete through the API.

create table public.puff_scores (
  id bigint generated always as identity primary key,
  name text not null check (name ~ '^[A-Za-z0-9][A-Za-z0-9 _.-]{0,11}$'),
  score integer not null check (score between 1 and 200000),
  mode text not null check (mode in ('kids','pro')),
  level smallint not null default 1 check (level between 1 and 200),
  skin text not null default 'classic' check (skin ~ '^[a-z]{1,16}$'),
  created_at timestamptz not null default now()
);
comment on table public.puff_scores is 'Leaderboard for the Puff''s Sky Snack browser game.';
create index puff_scores_mode_score_idx on public.puff_scores (mode, score desc);

alter table public.puff_scores enable row level security;
revoke all on public.puff_scores from anon, authenticated;
grant select on public.puff_scores to anon, authenticated;
grant insert (name, score, mode, level, skin) on public.puff_scores to anon, authenticated;

create policy "Anyone can read scores" on public.puff_scores
  for select to anon, authenticated using (true);
create policy "Anyone can add a score" on public.puff_scores
  for insert to anon, authenticated with check (true);
