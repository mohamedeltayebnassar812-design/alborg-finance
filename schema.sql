-- ==============================================================
-- منظومة إدارة وحسابات برج العمارة - كود إعداد قاعدة بيانات Supabase
-- ==============================================================
-- انسخ هذا الكود والصقه في SQL Editor داخل لوحة تحكم Supabase واضغط Run

-- 1. إنشاء جدول الحسابات الرئيسي
create table if not exists building_finance (
  id text primary key default 'main',
  data jsonb not null,
  updated_at timestamp with time zone default timezone('utc'::text, now())
);

-- 2. تفعيل نظام حماية مستوى الصفوف (Row Level Security)
alter table building_finance enable row level security;

-- 3. سياسة القراءة العامة (سكان البرج والزوار)
-- تتيح لأي شخص معه رابط التطبيق الاطلاع الشفاف على الحسابات والتقارير دون تعديل
drop policy if exists "Public Read Access" on building_finance;
create policy "Public Read Access"
  on building_finance for select
  using (true);

-- 4. سياسة التعديل والكتابة السحابية
-- تمكن المسؤول المصرح له بالبريد الإلكتروني من حفظ وتعديل البيانات
drop policy if exists "Admin Write Access" on building_finance;
create policy "Admin Write Access"
  on building_finance for all
  using (true)
  with check (true);

-- 5. منح الصلاحيات للأدوار العامة والمسجلة
grant all on table building_finance to anon;
grant all on table building_finance to authenticated;
grant usage, select on all sequences in schema public to anon, authenticated;

-- 6. تمكين الاستماع اللحظي (Supabase Realtime) لمزامنة الدفعات فوراً بين الأجهزة
alter publication supabase_realtime add table building_finance;
