-- Timber Joints CRM: quotations
-- Run this once in Supabase SQL Editor.
create table if not exists public.quotations (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  quote_number text not null,
  customer text not null,
  phone text not null,
  address text,
  sofa text not null,
  dimensions text,
  fabric text,
  quantity integer not null default 1 check (quantity > 0),
  unit_price numeric(12,2) not null default 0 check (unit_price >= 0),
  discount numeric(12,2) not null default 0 check (discount >= 0),
  delivery_charge numeric(12,2) not null default 0 check (delivery_charge >= 0),
  advance numeric(12,2) not null default 0 check (advance >= 0),
  validity_days integer not null default 7,
  terms text,
  status text not null default 'Draft' check (status in ('Draft','Sent','Accepted','Rejected','Converted')),
  order_id uuid references public.orders(id) on delete set null,
  created_at timestamptz not null default now(),
  constraint quotations_user_quote_unique unique (user_id, quote_number)
);

alter table public.quotations enable row level security;

drop policy if exists "Users can view their own quotations" on public.quotations;
create policy "Users can view their own quotations"
on public.quotations for select
to authenticated
using (auth.uid() = user_id);

drop policy if exists "Users can insert their own quotations" on public.quotations;
create policy "Users can insert their own quotations"
on public.quotations for insert
to authenticated
with check (auth.uid() = user_id);

drop policy if exists "Users can update their own quotations" on public.quotations;
create policy "Users can update their own quotations"
on public.quotations for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists "Users can delete their own quotations" on public.quotations;
create policy "Users can delete their own quotations"
on public.quotations for delete
to authenticated
using (auth.uid() = user_id);

create index if not exists quotations_user_created_idx
on public.quotations (user_id, created_at desc);
