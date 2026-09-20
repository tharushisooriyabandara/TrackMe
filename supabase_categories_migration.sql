create table if not exists categories (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  type text not null check (type in ('income','expense')),
  color text not null default '#8A8F87',
  created_at timestamptz not null default now()
);

alter table categories enable row level security;

create policy "categories_select" on categories for select using (true);
create policy "categories_insert" on categories for insert with check (true);
create policy "categories_update" on categories for update using (true);
create policy "categories_delete" on categories for delete using (true);

insert into categories (name, type, color) values
  ('Salary', 'income', '#2E7D5B'),
  ('Freelance', 'income', '#3A5A78'),
  ('Gift', 'income', '#B5834D'),
  ('Investment', 'income', '#6B5B95'),
  ('Refund', 'income', '#4F9DA6'),
  ('Other', 'income', '#8A8F87'),
  ('Rent & Housing', 'expense', '#B23B49'),
  ('Groceries', 'expense', '#C97B3D'),
  ('Utilities', 'expense', '#4F6D7A'),
  ('Transport', 'expense', '#8E6C88'),
  ('Dining Out', 'expense', '#C2574A'),
  ('Entertainment', 'expense', '#9A7B2F'),
  ('Health', 'expense', '#4A8FA6'),
  ('Shopping', 'expense', '#A6527A'),
  ('Other', 'expense', '#8A8F87');

alter publication supabase_realtime add table categories;
