-- ============================================================
-- PULSEGEAR v2 — SUPABASE SCHEMA
-- Run this entire file in Supabase > SQL Editor
-- ============================================================

-- 1. PRODUCTS TABLE
CREATE TABLE IF NOT EXISTS products (
  id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name        TEXT NOT NULL,
  category    TEXT NOT NULL,
  price       INTEGER NOT NULL,
  stock       INTEGER DEFAULT 0,
  emoji       TEXT DEFAULT '📦',
  image_url   TEXT,
  description TEXT,
  active      BOOLEAN DEFAULT true,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- 2. ORDERS TABLE
CREATE TABLE IF NOT EXISTS orders (
  id             UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  order_id       TEXT NOT NULL UNIQUE,
  user_id        UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  user_email     TEXT,
  customer_name  TEXT NOT NULL,
  phone          TEXT NOT NULL,
  address        TEXT NOT NULL,
  payment_method TEXT NOT NULL,
  product_id     UUID,
  product_name   TEXT NOT NULL,
  product_price  INTEGER NOT NULL,
  status         TEXT DEFAULT 'pending' CHECK (status IN ('pending','shipped','delivered','cancelled')),
  delivered_at   TIMESTAMPTZ,
  created_at     TIMESTAMPTZ DEFAULT NOW()
);

-- 3. SETTINGS TABLE (store config, fully editable by admin)
CREATE TABLE IF NOT EXISTS settings (
  key        TEXT PRIMARY KEY,
  value      TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Insert default settings
INSERT INTO settings (key, value) VALUES
  ('store_name',    '"PulseGear"'),
  ('hero_tagline',  '"Next-gen tech. Delivered to your door."'),
  ('whatsapp',      '"03001234567"'),
  ('jazzcash',      '"03001234567"'),
  ('jazzcash_name', '"Store Owner"'),
  ('easypaisa',     '"03001234567"'),
  ('easypaisa_name','"Store Owner"'),
  ('cod_enabled',   'true'),
  ('badge1',        '"⚡ Fast Delivery"'),
  ('badge2',        '"🔒 Secure Checkout"'),
  ('badge3',        '"📦 COD Available"')
ON CONFLICT (key) DO NOTHING;

-- 4. ADMIN USERS TABLE
CREATE TABLE IF NOT EXISTS admin_users (
  id         UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  email      TEXT NOT NULL UNIQUE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add your admin email here:
INSERT INTO admin_users (email) VALUES ('sfarhanahmad439@gmail.com')
ON CONFLICT (email) DO NOTHING;

-- ============================================================
-- ROW LEVEL SECURITY
-- ============================================================

-- PRODUCTS: public read, admin write
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
CREATE POLICY "public_read_products"    ON products FOR SELECT USING (true);
CREATE POLICY "admin_write_products"    ON products FOR ALL USING (
  EXISTS (SELECT 1 FROM admin_users WHERE email = auth.email())
);

-- ORDERS: users see own, admin sees all
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
CREATE POLICY "users_select_own_orders" ON orders FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "users_insert_own_orders" ON orders FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "admin_all_orders"        ON orders FOR ALL USING (
  EXISTS (SELECT 1 FROM admin_users WHERE email = auth.email())
);

-- SETTINGS: public read, admin write
ALTER TABLE settings ENABLE ROW LEVEL SECURITY;
CREATE POLICY "public_read_settings"    ON settings FOR SELECT USING (true);
CREATE POLICY "admin_write_settings"    ON settings FOR ALL USING (
  EXISTS (SELECT 1 FROM admin_users WHERE email = auth.email())
);

-- ADMIN USERS: admin only
ALTER TABLE admin_users ENABLE ROW LEVEL SECURITY;
CREATE POLICY "admin_manage_admins"     ON admin_users FOR ALL USING (
  EXISTS (SELECT 1 FROM admin_users WHERE email = auth.email())
);

-- ============================================================
-- INDEXES
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_orders_user     ON orders(user_id);
CREATE INDEX IF NOT EXISTS idx_orders_status   ON orders(status);
CREATE INDEX IF NOT EXISTS idx_orders_created  ON orders(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_orders_delivered ON orders(delivered_at DESC);
CREATE INDEX IF NOT EXISTS idx_products_active ON products(active, category);

-- ============================================================
-- DONE. Replace 'your-admin@email.com' above with your email.
-- ============================================================
