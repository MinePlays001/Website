# ⚡ PulseGear v2 — Cyberpunk Tech Store

Full-featured eCommerce for the Pakistani market. Supabase backend, cyberpunk neon UI, fully customizable admin panel — no code editing needed after setup.

---

## 📁 Project Structure

```
pulsegear/
├── index.html              ← Storefront
├── css/
│   └── style.css           ← Cyberpunk theme + animations
├── js/
│   ├── config.js           ← Supabase keys + settings loader
│   └── auth.js             ← Session management
├── pages/
│   ├── login.html          ← Login + Register (combined)
│   └── orders.html         ← User order tracking
├── admin/
│   ├── login.html          ← Admin login (/admin/login.html)
│   └── dashboard.html      ← Full admin panel
├── schema.sql              ← Run this in Supabase
└── README.md
```

---

## 🚀 Setup — Step by Step

### Step 1 — Supabase Project
1. Go to [supabase.com](https://supabase.com) → New Project
2. Wait for setup (~1 min)
3. Go to **Settings → API**
4. Copy **Project URL** and **anon public key**

---

### Step 2 — Run the Database Schema
1. Go to **SQL Editor** in your Supabase dashboard
2. Paste the entire contents of `schema.sql`
3. Before running, change this line to your real email:
   ```sql
   INSERT INTO admin_users (email) VALUES ('your-admin@email.com')
   ```
4. Click **Run**

---

### Step 3 — Configure `js/config.js`
Open `js/config.js` and fill in:

```javascript
const SUPABASE_URL      = 'https://YOUR_PROJECT_ID.supabase.co';
const SUPABASE_ANON_KEY = 'YOUR_ANON_KEY_HERE';
```

That's the only code you ever need to touch. Everything else is managed from the admin panel.

---

### Step 4 — Deploy to GitHub Pages
1. Create a GitHub repo (e.g. `pulsegear`)
2. Upload all files keeping folder structure intact
3. Go to **Settings → Pages → Source: main branch / root**
4. Your site: `https://yourusername.github.io/pulsegear`

---

### Step 5 — First Login as Admin
1. Go to `https://yoursite.com/admin/login.html`
   *(this URL is not linked anywhere on the public site)*
2. First register a normal account on the public site using your admin email
3. Then go to `/admin/login.html` and log in
4. You'll land on the full admin dashboard

---

## ⚙️ Admin Panel Features

| Feature | Where |
|---|---|
| View all orders + customer details | Orders tab |
| Search orders by name / phone / ID | Orders tab |
| Update order status (pending/shipped/delivered/cancelled) | Orders tab → Manage |
| WhatsApp notify buyer on delivery | Auto-opens on mark delivered |
| Export orders to CSV | Orders tab |
| Add / Edit / Delete products | Products tab |
| Set product image URL or emoji | Products tab |
| Show/hide products | Products tab |
| Weekly / Monthly / Yearly / All-time revenue | Sales tab |
| Edit store name | Settings tab |
| Edit hero tagline | Settings tab / Banner tab |
| Edit hero badges | Banner tab |
| Edit JazzCash number + name | Payments tab |
| Edit EasyPaisa number + name | Payments tab |
| Enable/disable COD | Payments tab |
| Add/remove admin users | Admin Users tab |

---

## 🔒 Security Notes

- Admin panel is at `/admin/login.html` — no link from public site
- Admin access is verified against `admin_users` table in DB
- Even if someone finds the URL, they can't log in without being in `admin_users`
- Row Level Security enabled on all tables
- Users can only see their own orders

---

## 💳 Payment Methods

Currently supports:
- **JazzCash** — customer sees your number + instructions
- **EasyPaisa** — same
- **Cash on Delivery** — can be toggled on/off from admin

For credit card support in future, look into **PayFast PK** (requires business NTN registration).

---

## 🛠 Fixing Supabase Pause (Free Tier)

Free projects pause after 7 days of no activity.

**Prevent it:** Set up a free daily ping at [cron-job.org](https://cron-job.org) pointing to your Supabase project URL.

**Restore paused project:** Log into supabase.com → open project → click **Restore Project**.

---

## 📱 WhatsApp Delivery Notification

When admin marks an order as **Delivered**, WhatsApp opens automatically with a pre-filled message to the customer. Just tap Send. No API needed.

---

## ✅ Features Checklist

- [x] Cyberpunk neon UI with glitch animations
- [x] Particle effects on hero
- [x] User register + login (Supabase Auth)
- [x] Login required to buy
- [x] Checkout popup with JazzCash / EasyPaisa / COD
- [x] Orders saved to Supabase DB
- [x] User order tracking page
- [x] Admin login at secret URL `/admin/login.html`
- [x] Admin: full order management
- [x] Admin: search + filter orders
- [x] Admin: export CSV
- [x] Admin: add/edit/delete products
- [x] Admin: product image URL or emoji
- [x] Admin: show/hide products
- [x] Admin: sales report (weekly/monthly/yearly/all)
- [x] Admin: edit store name, tagline, badges
- [x] Admin: edit payment numbers
- [x] Admin: toggle COD on/off
- [x] Admin: add/remove admin users
- [x] WhatsApp notify on delivery
- [x] Mobile responsive
- [x] All settings stored in DB (no code editing needed)
