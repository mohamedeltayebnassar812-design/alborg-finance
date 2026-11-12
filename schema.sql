-- جدول حسابات برج العمارة
-- انسخ هذا الكود والصقه في SQL Editor داخل لوحة تحكم Supabase واضغط Run

create table if not exists building_finance (
  id text primary key default 'main',
  data jsonb not null,
  updated_at timestamp with time zone default timezone('utc'::text, now())
);

-- تمكين الوصول العام (قراءة وتعديل) باستخدام المفتاح العام (Anon Key)
alter table building_finance enable row level security;

create policy "Public Access Policy"
  on building_finance
  for all
  using (true)
  with check (true);

-- تمكين الاستماع اللحظي (Realtime) لمزامنة أي تعديل فوراً عبر جميع الأجهزة والهواتف
alter publication supabase_realtime add table building_finance;
