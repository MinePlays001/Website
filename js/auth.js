let currentUser = null;

async function initAuth() {
  const { data: { session } } = await sb().auth.getSession();
  currentUser = session?.user || null;
  updateNav();
  sb().auth.onAuthStateChange((_, s) => { currentUser = s?.user || null; updateNav(); });
}

function updateNav() {
  const u = currentUser;
  document.getElementById('nav-login')?.style && (document.getElementById('nav-login').style.display = u ? 'none' : 'inline-block');
  document.getElementById('nav-logout')?.style && (document.getElementById('nav-logout').style.display = u ? 'inline-block' : 'none');
  document.getElementById('nav-orders')?.style && (document.getElementById('nav-orders').style.display = u ? 'inline' : 'none');
  if (document.getElementById('nav-username')) document.getElementById('nav-username').textContent = u ? u.email.split('@')[0].toUpperCase() : '';
}

async function logout() {
  await sb().auth.signOut();
  window.location.href = '/index.html';
}

document.addEventListener('DOMContentLoaded', initAuth);
