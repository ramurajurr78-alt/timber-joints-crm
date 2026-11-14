-- Timber Joints CRM: secure per-user order storage
create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  order_number text not null,
  customer text not null,
  phone text not null,
  address text,
  sofa text not null,
  fabric text,
  status text not null default 'Enquiry'
    check (status in ('Enquiry','Confirmed','Frame','Foam','Stitching','Upholstery','Ready for delivery','Delivered')),
  total numeric(12,2) not null default 0 check (total >= 0),
  advance numeric(12,2) not null default 0 check (advance >= 0 and advance <= total),
  created_at timestamptz not null default now()
);

alter table public.orders enable row level security;

drop policy if exists "Users can view their own orders" on public.orders;
create policy "Users can view their own orders"
  on public.orders for select to authenticated
  using (auth.uid() = user_id);

drop policy if exists "Users can create their own orders" on public.orders;
create policy "Users can create their own orders"
  on public.orders for insert to authenticated
  with check (auth.uid() = user_id);

drop policy if exists "Users can update their own orders" on public.orders;
create policy "Users can update their own orders"
  on public.orders for update to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Users can delete their own orders" on public.orders;
create policy "Users can delete their own orders"
  on public.orders for delete to authenticated
  using (auth.uid() = user_id);

grant select, insert, update, delete on public.orders to authenticated;
