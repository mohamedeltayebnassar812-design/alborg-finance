# 🏢 منظومة إدارة وحسابات برج العمارة
> نظام ويب متكامل وسحابي لإدارة اشتراكات السكان، تسجيل المصروفات، متابعة الخزينة والتحصيل اللحظي السريع مع ربط قاعدة بيانات **Supabase** والاستضافة المجانية عبر **GitHub Pages**.

---

## 🌟 المميزات الرئيسية
- **دقة محاسبية 100%:** مطابقة بالكامل لجداول الإكسيل الرسمية لكافة الشهور.
- **ربط سحابي فوري (Supabase Realtime):** مزامنة فورية ثنائية الاتجاه بين جميع الأجهزة (موبايل / كمبيوتر).
- **كشف متأخرات ذكي:** حصر دقيق للمتأخرات السابقة، مع معالجة الديون المشطوبة والمعدومة بقرار الإدارة.
- **تحصيل سريع بنقرة واحدة:** إمكانية تسجيل "سداد كامل" أو دفعات مخصصة بضغطة زر.
- **إضافة شهور جديدة:** ترحيل أرصدة الخزينة والمتأخرات تلقائياً عند فتح كل شهر جديد.
- **دليل المصاريف المعتادة:** حصر البنود المتكررة وإمكانية إضافة بنود جديدة بالاسم فقط.
- **واجهة عصرية متجاوبة:** متوافقة تماماً مع شاشات الهواتف المحمولة والوضع الليلي (Dark Mode) والطباعة.

---

## ⚡ خطوات الربط مع Supabase (مرة واحدة فقط)

1. أنشئ حساباً مجانياً على [Supabase.com](https://supabase.com) وأنشئ مشروعاً جديداً.
2. اذهب إلى **SQL Editor** في القائمة الجانبية.
3. انسخ الكود الموجود في ملف `schema.sql` (أو من نافذة الربط السحابي داخل المنظومة) واضغط **Run**:

```sql
create table if not exists building_finance (
  id text primary key default 'main',
  data jsonb not null,
  updated_at timestamp with time zone default timezone('utc'::text, now())
);

alter table building_finance enable row level security;
create policy "Public Access Policy" on building_finance for all using (true) with check (true);
alter publication supabase_realtime add table building_finance;
```

4. من إعدادات مشروعك في Supabase (**Project Settings -> API**)، انسخ:
   - **Project URL**
   - **anon public key**
5. افتح المنظومة واضغط على زر **"ربط أونلاين / Supabase"** في أعلى الصفحة، الصق الرابط والمفتاح، واضغط **حفظ وتفعيل**.
6. مبروك! أصبح النظام متصلاً سحابياً وتتم المزامنة التلقائية اللحظية مع هاتفك وأي جهاز آخر فوراً!

---

## 🌐 الرابط المباشر للتشغيل أونلاين (GitHub Pages)
بعد تفعيل GitHub Pages من إعدادات المستودع (Settings -> Pages -> Deploy from branch: `main`):
👉 **رابط المنظومة أونلاين:** `https://mohamedeltayebnassar812-design.github.io/alborg-finance/`

---

## 📁 هيكل الملفات
- `index.html`: الصفحة الرئيسية للمنظومة (المُشغلة على GitHub Pages).
- `شهرية_العمارة_المحدثة.html`: النسخة المحلية الأصلية.
- `schema.sql`: كود تهيئة قاعدة بيانات Supabase.
- `شهرية العمارة .xlsx`: ملف الإكسيل المصدري المعتمد.
