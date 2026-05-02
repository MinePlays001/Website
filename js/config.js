// == PULSEGEAR CONFIG — fill these in ==
const SUPABASE_URL     = 'https://YOUR_PROJECT.supabase.co';
const SUPABASE_ANON_KEY = 'YOUR_ANON_KEY';

let _sb = null;
function sb() {
  if (!_sb) _sb = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
  return _sb;
}

// Cached store settings (loaded from DB)
let SETTINGS = {
  store_name: 'PulseGear',
  whatsapp: '03001234567',
  jazzcash: '03001234567',
  jazzcash_name: 'Store Owner',
  easypaisa: '03001234567',
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
