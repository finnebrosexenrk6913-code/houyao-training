-- 后腰训练台 · 建表脚本（无需登录版 v2）
-- 在 Supabase 控制台 SQL Editor 中一次性运行。
-- 会删除旧表并重建：settings / checkins / weights / reviews / runs

drop table if exists public.runs;
drop table if exists public.user_settings;
drop table if exists public.checkins;
drop table if exists public.weights;
drop table if exists public.reviews;
drop table if exists public.settings;

-- 个人设置
create table public.settings (
  id integer primary key default 1 check (id = 1),
  current_week integer not null default 1,
  run_base integer not null default 2,
  run_target integer not null default 48
);

-- 训练打卡
create table public.checkins (
  id bigint generated always as identity primary key,
  checkin_date date not null,
  task_id text not null,
  done boolean not null default false,
  updated_at timestamptz not null default now(),
  unique (checkin_date, task_id)
);

-- 体重
create table public.weights (
  id bigint generated always as identity primary key,
  recorded_on date not null,
  weight_kg numeric(5, 1) not null,
  created_at timestamptz not null default now(),
  unique (recorded_on)
);

-- 赛后复盘
create table public.reviews (
  id bigint generated always as identity primary key,
  review_date date not null,
  good text not null default '',
  fix text not null default '',
  next text not null default '',
  created_at timestamptz not null default now()
);

-- 校园跑（每次 2 公里）
create table public.runs (
  id bigint generated always as identity primary key,
  run_date date not null,
  distance_km numeric(4, 1) not null default 2,
  duration_min numeric(5, 1),
  note text not null default '',
  created_at timestamptz not null default now(),
  unique (run_date)
);

-- 个人自用：关闭 RLS，匿名可读写
alter table public.settings disable row level security;
alter table public.checkins disable row level security;
alter table public.weights disable row level security;
alter table public.reviews disable row level security;
alter table public.runs disable row level security;

grant select, insert, update, delete on public.settings to anon, authenticated;
grant select, insert, update, delete on public.checkins to anon, authenticated;
grant select, insert, update, delete on public.weights to anon, authenticated;
grant select, insert, update, delete on public.reviews to anon, authenticated;
grant select, insert, update, delete on public.runs to anon, authenticated;

grant usage on sequence public.checkins_id_seq to anon, authenticated;
grant usage on sequence public.weights_id_seq to anon, authenticated;
grant usage on sequence public.reviews_id_seq to anon, authenticated;
grant usage on sequence public.runs_id_seq to anon, authenticated;

create index if not exists checkins_date_idx on public.checkins (checkin_date);
create index if not exists weights_date_idx on public.weights (recorded_on);
create index if not exists runs_date_idx on public.runs (run_date);

-- 初始设置：第 1 周；校园跑已有的 2 次记在 run_base
insert into public.settings (id, current_week, run_base, run_target)
values (1, 1, 2, 48)
on conflict (id) do nothing;
