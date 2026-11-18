-- Monthly Saver waitlist. Run once in Supabase: SQL Editor > New query > paste > Run.
-- Create the project in the Mumbai region (ap-south-1) so data stays in India.

create table if not exists public.waitlist (
  id            bigint generated always as identity primary key,
  created_at    timestamptz not null default now(),
  name          text not null check (char_length(name) between 1 and 80),
  phone         text not null unique check (phone ~ '^[6-9][0-9]{9}$'),
  area          text not null check (char_length(area) <= 60),
  pincode       text not null check (pincode ~ '^5[0-9]{5}$'),
  family_size   text not null check (family_size in ('1-2','3-4','5+')),
  monthly_spend text not null check (monthly_spend in ('<3000','3000-6000','6000-10000','>10000')),
  apps          text[] not null default '{}',
  would_pay     text not null check (would_pay in ('yes','maybe','no')),
  wish          text check (char_length(wish) <= 300),
  language      text not null check (language in ('en','te','hi')),
  consent       boolean not null check (consent),
  source        text check (char_length(source) <= 60)
);

-- The public website may only ADD rows. Nobody can read, change or delete them
-- with the public key; you see them in the Supabase dashboard (Table Editor).
alter table public.waitlist enable row level security;

drop policy if exists "anyone can join" on public.waitlist;
create policy "anyone can join" on public.waitlist
  for insert to anon with check (consent);

revoke all on public.waitlist from anon;
grant insert (name, phone, area, pincode, family_size, monthly_spend, apps, would_pay, wish, language, consent, source)
  on public.waitlist to anon;

-- The number that decides the go-ahead (run any time in the SQL Editor):
-- select would_pay, count(*) from public.waitlist group by would_pay;
