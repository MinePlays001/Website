// == PULSEGEAR CONFIG — fill these in ==
const SUPABASE_URL     = 'https://fnslbjlmnxouvyutcbgt.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZuc2xiamxtbnhvdXZ5dXRjYmd0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzc2OTUxNDYsImV4cCI6MjA5MzI3MTE0Nn0.HlNDeuw__NT6q_sClEjya771oTCAe22inkOXf2f_dIQ';
let _sb = null;
function sb() {
  if (!_sb) _sb = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
  return _sb;
}

// Cached store settings (loaded from DB)
let SETTINGS = {
  store_name: 'PulseGear',
  whatsapp: '03266570023',
  jazzcash: '03266570023',
  jazzcash_name: 'Store Owner',
  easypaisa: '03266570023',
  easypaisa_name: 'Store Owner',
  cod_enabled: true,
  hero_tagline: 'Next-gen tech. Delivered to your door.',
  accent_color: '#00f5ff'
};

async function loadSettings() {
  try {
    const { data } = await sb().from('settings').select('key,value');
    if (data) data.forEach(r => { try { SETTINGS[r.key] = JSON.parse(r.value); } catch { SETTINGS[r.key] = r.value; } });
  } catch(e) {}
}

async function saveSetting(key, value) {
  const val = typeof value === 'string' ? value : JSON.stringify(value);
  await sb().from('settings').upsert({ key, value: val }, { onConflict: 'key' });
  SETTINGS[key] = value;
}
