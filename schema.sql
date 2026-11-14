-- ==============================================================
-- منظومة إدارة وحسابات برج العمارة - كود إعداد وتفعيل صلاحيات Supabase
-- ==============================================================
-- انسخ هذا الكود والصقه في SQL Editor داخل لوحة تحكم Supabase واضغط Run

-- 1. إنشاء جدول الحسابات الرئيسي إن لم يكن موجوداً
create table if not exists public.building_finance (
  id text primary key default 'main',
  data jsonb not null,
  updated_at timestamp with time zone default timezone('utc'::text, now())
);

-- 2. إيقاف RLS تماماً لضمان عدم حدوث أي حظر في الصلاحيات أو رفض الحفظ
alter table public.building_finance disable row level security;

-- 3. منح كافة الصلاحيات الكاملة للقراءة والكتابة والتعديل
grant all on table public.building_finance to anon, authenticated, service_role;
grant all on schema public to anon, authenticated, service_role;
grant usage, select on all sequences in schema public to anon, authenticated, service_role;

-- 4. تمكين الاستماع اللحظي (Supabase Realtime) لمزامنة الدفعات فوراً بين جميع الأجهزة
do $$
begin
  if not exists (select 1 from pg_publication_tables where pubname = 'supabase_realtime' and tablename = 'building_finance') then
    alter publication supabase_realtime add table public.building_finance;
  end if;
end $$;
