create table if not exists settings (
  id text primary key default 'main',
  currency text not null default 'Rs',
  name_a text not null default 'Me',
  name_b text not null default 'Partner'
);

create table if not exists transactions (
  id uuid primary key default gen_random_uuid(),
  type text not null check (type in ('income','expense')),
  amount numeric not null,
  category text not null,
  note text default '',
  who text not null,
  date date not null,
  is_example boolean not null default false,
  created_at timestamptz not null default now()
);

alter table settings enable row level security;
alter table transactions enable row level security;

create policy "settings_select" on settings for select using (true);
create policy "settings_insert" on settings for insert with check (true);
create policy "settings_update" on settings for update using (true);

create policy "transactions_select" on transactions for select using (true);
create policy "transactions_insert" on transactions for insert with check (true);
create policy "transactions_update" on transactions for update using (true);
create policy "transactions_delete" on transactions for delete using (true);

insert into settings (id, currency, name_a, name_b) values ('main', 'Rs', 'Tharu', 'Adee')
on conflict (id) do nothing;

insert into transactions (type, amount, category, note, who, date, is_example) values
  ('income', 2500, 'Salary', 'Example — edit or delete', 'Me', '2026-09-20', true),
  ('expense', 850, 'Rent & Housing', 'Example — edit or delete', 'Me', '2026-09-19', true),
  ('expense', 64.5, 'Groceries', 'Example — edit or delete', 'Partner', '2026-09-18', true),
  ('income', 500, 'Salary', 'test', 'Me', '2026-09-20', false);

alter publication supabase_realtime add table transactions;
alter publication supabase_realtime add table settings;
