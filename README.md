[index-foot.html](https://github.com/user-attachments/files/31863469/index-foot.html)
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Mon club foot</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Barlow+Condensed:wght@600;700&family=Barlow:wght@400;500;600&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2.45.4/dist/umd/supabase.min.js"></script>
<style>
/* ─────────────────────────── RÉGLAGES DU SITE (à remplir) ─────────────── */
/* voir le bloc <script> tout en bas : SUPABASE_URL et SUPABASE_ANON_KEY   */

:root{
  --fond:#EEF1F5; --surface:#FFFFFF; --encre:#14213D; --encre-2:#4B5566;
  --ligne:#D5DBE3; --accent:#F26522; --accent-2:#C64E10; --ok:#1E7F4F; --alerte:#B45309;
  --r:6px; --display:'Barlow Condensed',Impact,'Arial Narrow',sans-serif;
  --texte:'Barlow',system-ui,-apple-system,'Segoe UI',sans-serif;
}
*{box-sizing:border-box}
html,body{margin:0;background:var(--fond);color:var(--encre);font:16px/1.45 var(--texte)}
button,input,select{font:inherit;color:inherit}
h1,h2,h3{font-family:var(--display);font-weight:700;letter-spacing:.01em;margin:0}
h1{font-size:2.6rem;line-height:1}
h2{font-size:1.5rem}
a{color:var(--accent-2)}
.cache{display:none!important}

/* ── Bandeau haut : le nom du club, façon tableau d'affichage ── */
header{background:var(--encre);color:#fff;padding:18px 20px 0;position:relative;overflow:hidden}
header::after{content:"";position:absolute;left:0;right:0;bottom:0;height:3px;background:var(--accent)}
header .club{display:flex;align-items:flex-end;justify-content:space-between;gap:16px;max-width:1040px;margin:0 auto}
header h1{color:#fff;text-transform:uppercase}
header .qui{font-size:.9rem;color:#C9D0DB;padding-bottom:6px;white-space:nowrap}
header .qui button{background:none;border:0;color:#fff;text-decoration:underline;cursor:pointer;padding:0;margin-left:10px}
nav.onglets{max-width:1040px;margin:14px auto 0;display:flex;gap:4px}
nav.onglets button{background:transparent;border:0;border-bottom:3px solid transparent;color:#C9D0DB;padding:10px 14px;cursor:pointer;font-family:var(--display);font-size:1.15rem;text-transform:uppercase;letter-spacing:.03em}
nav.onglets button[aria-selected=true]{color:#fff;border-bottom-color:#fff;margin-bottom:-3px}
nav.onglets button:focus-visible{outline:2px solid var(--accent);outline-offset:2px}

main{max-width:1040px;margin:0 auto;padding:22px 20px 60px}
section.onglet>.barre{display:flex;align-items:center;justify-content:space-between;gap:12px;flex-wrap:wrap;margin-bottom:14px}

/* ── Écrans plein cadre (connexion, choix du club) ── */
.cadre{min-height:100vh;display:grid;place-items:center;padding:24px}
.carte{background:var(--surface);border:1px solid var(--ligne);border-radius:var(--r);padding:28px;width:100%;max-width:420px}
.carte h1{color:var(--encre);text-transform:uppercase;margin-bottom:4px}
.carte p.sous{color:var(--encre-2);margin:0 0 20px}

/* ── Formulaires ── */
label{display:block;font-weight:500;margin:12px 0 4px}
input,select{width:100%;padding:9px 10px;border:1px solid var(--ligne);border-radius:var(--r);background:#fff}
input:focus-visible,select:focus-visible{outline:2px solid var(--accent);outline-offset:1px;border-color:var(--accent)}
.ligne{display:grid;grid-template-columns:1fr 1fr;gap:10px}
@media (max-width:520px){.ligne{grid-template-columns:1fr}}
.btn{display:inline-block;padding:9px 16px;border-radius:var(--r);border:1px solid var(--encre);background:var(--encre);color:#fff;cursor:pointer;font-weight:600}
.btn.principal{background:var(--accent);border-color:var(--accent)}
.btn.principal:hover{background:var(--accent-2);border-color:var(--accent-2)}
.btn.second{background:#fff;color:var(--encre)}
.btn.petit{padding:5px 10px;font-size:.9rem}
.btn:disabled{opacity:.55;cursor:wait}
.btn:focus-visible{outline:2px solid var(--accent);outline-offset:2px}
.actions{display:flex;gap:10px;margin-top:18px;flex-wrap:wrap}
.code input{font-family:var(--display);font-size:2rem;letter-spacing:.35em;text-align:center}

/* ── Messages ── */
.msg{margin-top:12px;padding:10px 12px;border-radius:var(--r);border:1px solid var(--ligne);background:#F8FAFC;font-size:.95rem}
.msg.erreur{border-color:#F3B7A0;background:#FFF3EE;color:#8B2E0B}
.msg.ok{border-color:#B7E0C8;background:#EEF9F2;color:#125A38}
.msg:empty{display:none}
.vide{padding:28px;text-align:center;color:var(--encre-2);border:1px dashed var(--ligne);border-radius:var(--r);background:#fff}

/* ── Tableaux ── */
.tableau{overflow-x:auto;background:var(--surface);border:1px solid var(--ligne);border-radius:var(--r)}
table{width:100%;border-collapse:collapse;min-width:560px}
th,td{text-align:left;padding:10px 12px;border-bottom:1px solid var(--ligne);vertical-align:middle}
th{font-family:var(--display);font-size:1.05rem;text-transform:uppercase;letter-spacing:.03em;color:var(--encre-2);font-weight:600}
tr:last-child td{border-bottom:0}
td.act{white-space:nowrap;text-align:right}
.puce{display:inline-block;padding:2px 8px;border-radius:999px;font-size:.85rem;font-weight:500;border:1px solid var(--ligne)}
.puce.demandee{color:var(--alerte);border-color:#F1D3A8;background:#FFF8EC}
.puce.payee{color:#1D4ED8;border-color:#BFD3FB;background:#EEF4FF}
.puce.validee{color:var(--ok);border-color:#B7E0C8;background:#EEF9F2}
.puce.refusee{color:#7A1E1E;border-color:#F3B7B7;background:#FFF0F0}
.cat{font-family:var(--display);font-weight:700;font-size:1.1rem;color:var(--accent-2)}

/* ── Fenêtre modale ── */
dialog{border:0;border-radius:var(--r);padding:0;width:min(520px,94vw)}
dialog::backdrop{background:rgba(20,33,61,.55)}
dialog form{padding:24px}
dialog h2{margin-bottom:6px}
.compteur{color:var(--encre-2);font-size:.95rem}
@media (prefers-reduced-motion:no-preference){dialog[open]{animation:pop .16s ease-out}}
@keyframes pop{from{transform:translateY(8px);opacity:0}to{transform:none;opacity:1}}
</style>
</head>
<body>

<!-- ══════════════════ ÉCRAN 0 : réglages manquants ══════════════════ -->
<div id="ecran-config" class="cadre cache">
  <div class="carte">
    <h1>Site pas encore branché</h1>
    <p class="sous">Il manque l'adresse et la clé du projet Supabase.</p>
    <p>Ouvre ce fichier <b>index.html</b>, va tout en bas, et remplace les deux valeurs <code>SUPABASE_URL</code> et <code>SUPABASE_ANON_KEY</code> par celles de ton projet (Project Settings → API).</p>
  </div>
</div>

<!-- ══════════════════ ÉCRAN 1 : connexion ══════════════════ -->
<div id="ecran-login" class="cadre cache">
  <div class="carte">
    <h1>Mon club foot</h1>
    <p class="sous">Connexion par code envoyé sur ton email. Pas de mot de passe.</p>
    <form id="form-email">
      <label for="email">Ton email</label>
      <input id="email" type="email" autocomplete="email" required placeholder="prenom@exemple.fr">
      <div class="actions"><button class="btn principal" type="submit">Recevoir mon code</button></div>
      <div class="msg" id="msg-email"></div>
    </form>
    <form id="form-code" class="cache">
      <p>Un code à 6 chiffres vient de partir vers <b id="email-rappel"></b>. Il est valable quelques minutes.</p>
      <div class="code"><input id="code" inputmode="numeric" pattern="[0-9]{6,8}" maxlength="8" required autocomplete="one-time-code"></div>
      <div class="actions">
        <button class="btn principal" type="submit">Me connecter</button>
        <button class="btn second" type="button" id="btn-autre-email">Changer d'email</button>
      </div>
      <div class="msg" id="msg-code"></div>
    </form>
  </div>
</div>

<!-- ══════════════════ ÉCRAN 2 : choisir / créer un club ══════════════════ -->
<div id="ecran-club" class="cadre cache">
  <div class="carte">
    <h1>Ton club</h1>
    <p class="sous" id="club-sous"></p>
    <div id="liste-clubs"></div>
    <form id="form-club">
      <label for="nom-club">Créer un nouveau club</label>
      <input id="nom-club" required placeholder="Ex. Étoile Sportive de Tresson Football">

      <div class="actions">
        <button class="btn principal" type="submit">Créer le club</button>
        <button class="btn second" type="button" data-deconnexion>Se déconnecter</button>
      </div>
      <div class="msg" id="msg-club"></div>
    </form>
  </div>
</div>

<!-- ══════════════════ ÉCRAN 3 : l'application ══════════════════ -->
<div id="app" class="cache">
  <header>
    <div class="club">
      <h1 id="titre-club">Club</h1>
      <div class="qui"><span id="qui-email"></span><button type="button" data-changer-club>Changer de club</button><button type="button" data-deconnexion>Déconnexion</button></div>
    </div>
    <nav class="onglets" role="tablist">
      <button role="tab" aria-selected="true" data-onglet="familles">Familles</button>
      <button role="tab" aria-selected="false" data-onglet="licences">Licences</button>
      <button role="tab" aria-selected="false" data-onglet="equipes">Équipes</button>
      <button role="tab" aria-selected="false" data-onglet="acces">Accès</button>
    </nav>
  </header>
  <main>

    <section class="onglet" id="onglet-familles">
      <div class="barre">
        <h2>Familles et joueurs <span class="compteur" id="cpt-familles"></span></h2>
        <button class="btn principal" type="button" data-ouvrir="famille">Ajouter une famille</button>
      </div>
      <div id="zone-familles"></div>
    </section>

    <section class="onglet cache" id="onglet-licences">
      <div class="barre">
        <h2>Licences <span class="compteur" id="cpt-licences"></span></h2>
        <div><label for="saison" class="cache">Saison</label><select id="saison" style="width:auto"></select></div>
      </div>
      <div id="zone-licences"></div>
    </section>

    <section class="onglet cache" id="onglet-equipes">
      <div class="barre">
        <h2>Équipes <span class="compteur" id="cpt-equipes"></span></h2>
        <button class="btn principal" type="button" data-ouvrir="equipe">Ajouter une équipe</button>
      </div>
      <div id="zone-equipes"></div>
    </section>

    <section class="onglet cache" id="onglet-acces">
      <div class="barre"><h2>Qui a accès à ce club</h2></div>
      <p>Pour donner accès à quelqu'un du bureau : il doit d'abord se connecter une fois au site avec son email (ça crée son compte), puis tu l'ajoutes ici.</p>
      <form id="form-invite" class="ligne" style="align-items:end;max-width:640px">
        <div><label for="invite-email">Email de la personne</label><input id="invite-email" type="email" required></div>
        <div><label for="invite-role">Rôle</label>
          <select id="invite-role"><option value="bureau">Bureau</option><option value="admin">Admin</option><option value="coach">Coach</option></select></div>
        <div><button class="btn principal" type="submit">Donner l'accès</button></div>
      </form>
      <div class="msg" id="msg-invite"></div>
      <div id="zone-acces" style="margin-top:16px"></div>
    </section>

  </main>
</div>

<!-- ══════════════════ Fenêtres ══════════════════ -->
<dialog id="dlg-famille">
  <form method="dialog" id="form-famille">
    <h2 id="dlg-famille-titre">Nouvelle famille</h2>
    <input type="hidden" id="f-id">
    <label for="f-nom">Nom de famille</label><input id="f-nom" required>
    <div class="ligne">
      <div><label for="f-email">Email</label><input id="f-email" type="email"></div>
      <div><label for="f-tel">Téléphone</label><input id="f-tel" type="tel"></div>
    </div>
    <div class="actions"><button class="btn principal" value="ok">Enregistrer</button><button class="btn second" value="annuler" formnovalidate>Annuler</button></div>
    <div class="msg" id="msg-famille"></div>
  </form>
</dialog>

<dialog id="dlg-personne">
  <form method="dialog" id="form-personne">
    <h2 id="dlg-personne-titre">Nouveau joueur</h2>
    <input type="hidden" id="p-id"><input type="hidden" id="p-famille">
    <div class="ligne">
      <div><label for="p-prenom">Prénom</label><input id="p-prenom" required></div>
      <div><label for="p-nom">Nom</label><input id="p-nom" required></div>
    </div>
    <div class="ligne">
      <div><label for="p-naissance">Date de naissance</label><input id="p-naissance" type="date"></div>
      <div><label for="p-sexe">Sexe</label><select id="p-sexe"><option value="">—</option><option value="F">Fille / femme</option><option value="M">Garçon / homme</option></select></div>
    </div>
    <label for="p-licence">N° de licence FFBB (si connu)</label><input id="p-licence">
    <div class="actions"><button class="btn principal" value="ok">Enregistrer</button><button class="btn second" value="annuler" formnovalidate>Annuler</button></div>
    <div class="msg" id="msg-personne"></div>
  </form>
</dialog>

<dialog id="dlg-licence">
  <form method="dialog" id="form-licence">
    <h2>Licence <span id="l-qui"></span></h2>
    <input type="hidden" id="l-personne">
    <p class="compteur">Saison <b id="l-saison"></b> — catégorie proposée d'après la date de naissance, modifiable.</p>
    <div class="ligne">
      <div><label for="l-cat">Catégorie</label><select id="l-cat"></select></div>
      <div><label for="l-montant">Montant (€)</label><input id="l-montant" type="number" step="0.01" min="0"></div>
    </div>
    <div class="actions"><button class="btn principal" value="ok">Créer la licence</button><button class="btn second" value="annuler" formnovalidate>Annuler</button></div>
    <div class="msg" id="msg-licence"></div>
  </form>
</dialog>

<dialog id="dlg-equipe">
  <form method="dialog" id="form-equipe">
    <h2>Nouvelle équipe</h2>
    <label for="e-nom">Nom de l'équipe</label><input id="e-nom" required placeholder="Ex. U13 A">
    <div class="ligne">
      <div><label for="e-cat">Catégorie</label><select id="e-cat"></select></div>
      <div><label for="e-saison">Saison</label><input id="e-saison" required></div>
    </div>
    <div class="actions"><button class="btn principal" value="ok">Créer l'équipe</button><button class="btn second" value="annuler" formnovalidate>Annuler</button></div>
    <div class="msg" id="msg-equipe"></div>
  </form>
</dialog>

<script>
/* ═══════════════════════════════════════════════════════════════════════════
   RÉGLAGES — remplace ces deux valeurs par celles de ton projet Supabase
   (menu Project Settings → API : « Project URL » et clé « anon public »)
   ═══════════════════════════════════════════════════════════════════════════ */
const SUPABASE_URL      = 'COLLE_ICI_TON_PROJECT_URL';
const SUPABASE_ANON_KEY = 'COLLE_ICI_TA_CLE_ANON';

/* ─────────────────────────── Sports et catégories ─────────────────────────── */
// Catégories FFF : U6 à U19, Seniors, Vétérans (35 ans et plus)
const CATEGORIES = () => ['U6','U7','U8','U9','U10','U11','U12','U13','U14','U15','U16','U17','U18','U19','Seniors','Vétérans'];

// Saison en cours : elle démarre en juillet.
function saisonCourante(d = new Date()){
  const a = d.getMonth() >= 6 ? d.getFullYear() : d.getFullYear() - 1;
  return `${a}-${a+1}`;
}
// Catégorie proposée d'après l'année de naissance (âge sportif = année de
// début de saison − année de naissance). Indicative : le bureau peut corriger.
function categorieProposee(dateNaissance, sexe, saison){
  if(!dateNaissance) return '';
  const debut = parseInt(saison.slice(0,4),10);
  // Règle FFF : la catégorie est l'âge atteint pendant la saison (année de fin − année de naissance)
  const u = debut + 1 - new Date(dateNaissance).getFullYear();
  if(u <= 6)  return 'U6';
  if(u <= 19) return 'U' + u;
  if(u >= 35) return 'Vétérans';
  return 'Seniors';
}

/* ─────────────────────────── Petits utilitaires ─────────────────────────── */
const $  = s => document.querySelector(s);
const $$ = s => [...document.querySelectorAll(s)];
const esc = s => String(s ?? '').replace(/[&<>"']/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
function msg(id, texte, type=''){ const el = $(id); el.textContent = texte || ''; el.className = 'msg ' + type; }
function montrer(id){ ['#ecran-config','#ecran-login','#ecran-club','#app'].forEach(s => $(s).classList.toggle('cache', s !== id)); }
function dateFr(d){ return d ? new Date(d).toLocaleDateString('fr-FR') : ''; }
function erreurLisible(e){
  const t = (e && (e.message || e.error_description || e)) + '';
  if(/rate limit/i.test(t)) return 'Trop de codes demandés d\'un coup. Attends une minute et réessaie.';
  if(/expired|invalid/i.test(t)) return 'Code faux ou expiré. Demande-en un nouveau.';
  if(/row-level security/i.test(t)) return 'La base a refusé cette action (droits insuffisants).';
  return t;
}

/* ─────────────────────────── État ─────────────────────────── */
let sb, session = null, club = null, clubs = [];
let familles = [], personnes = [], equipes = [], licences = [], membres = [];

/* ─────────────────────────── Démarrage ─────────────────────────── */
async function demarrer(){
  if(!SUPABASE_URL.startsWith('https://') || SUPABASE_ANON_KEY.length < 40){ montrer('#ecran-config'); return; }
  sb = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
  const { data } = await sb.auth.getSession();
  session = data.session;
  sb.auth.onAuthStateChange((_ev, s) => { session = s; if(!s) montrer('#ecran-login'); });
  if(!session){ montrer('#ecran-login'); return; }
  await chargerClubs();
}

/* ─────────────────────────── Connexion ─────────────────────────── */
$('#form-email').addEventListener('submit', async ev => {
  ev.preventDefault();
  const email = $('#email').value.trim().toLowerCase();
  const btn = ev.target.querySelector('button'); btn.disabled = true; msg('#msg-email','');
  const { error } = await sb.auth.signInWithOtp({ email, options:{ shouldCreateUser:true } });
  btn.disabled = false;
  if(error){ msg('#msg-email', erreurLisible(error), 'erreur'); return; }
  $('#email-rappel').textContent = email;
  $('#form-email').classList.add('cache'); $('#form-code').classList.remove('cache');
  $('#code').value = ''; $('#code').focus();
});
$('#btn-autre-email').addEventListener('click', () => { $('#form-code').classList.add('cache'); $('#form-email').classList.remove('cache'); });
$('#form-code').addEventListener('submit', async ev => {
  ev.preventDefault();
  const email = $('#email-rappel').textContent, token = $('#code').value.trim();
  const btn = ev.target.querySelector('button'); btn.disabled = true; msg('#msg-code','');
  const { data, error } = await sb.auth.verifyOtp({ email, token, type:'email' });
  btn.disabled = false;
  if(error){ msg('#msg-code', erreurLisible(error), 'erreur'); return; }
  session = data.session;
  await chargerClubs();
});
$$('[data-deconnexion]').forEach(b => b.addEventListener('click', async () => { await sb.auth.signOut(); club = null; montrer('#ecran-login'); }));
$$('[data-changer-club]').forEach(b => b.addEventListener('click', () => { club = null; afficherChoixClub(); }));

/* ─────────────────────────── Clubs ─────────────────────────── */
async function chargerClubs(){
  const { data, error } = await sb.from('clubs').select('id, nom, ville').order('nom');
  if(error){ montrer('#ecran-club'); msg('#msg-club', erreurLisible(error), 'erreur'); return; }
  clubs = data || [];
  const memo = localStorage.getItem('club_id');
  const auto = clubs.length === 1 ? clubs[0] : clubs.find(c => c.id === memo);
  if(auto) ouvrirClub(auto); else afficherChoixClub();
}
function afficherChoixClub(){
  montrer('#ecran-club');
  $('#club-sous').textContent = clubs.length ? 'Choisis le club à ouvrir, ou crées-en un autre.' : 'Tu n\'as encore aucun club : crée le tien ci-dessous.';
  $('#liste-clubs').innerHTML = clubs.map(c => `<button class="btn second" type="button" style="display:block;width:100%;margin:6px 0;text-align:left" data-club="${c.id}">${esc(c.nom)}</button>`).join('');
  $$('#liste-clubs [data-club]').forEach(b => b.addEventListener('click', () => ouvrirClub(clubs.find(c => c.id === b.dataset.club))));
}
$('#form-club').addEventListener('submit', async ev => {
  ev.preventDefault();
  const nom = $('#nom-club').value.trim(); if(!nom) return;
  const btn = ev.target.querySelector('button'); btn.disabled = true; msg('#msg-club','');
  const { data, error } = await sb.rpc('creer_club', { p_nom: nom, p_sport: 'foot' });
  btn.disabled = false;
  if(error){ msg('#msg-club', erreurLisible(error), 'erreur'); return; }
  $('#nom-club').value = '';
  await chargerClubs();
  const nouveau = clubs.find(c => c.id === data); if(nouveau) ouvrirClub(nouveau);
});
async function ouvrirClub(c){
  club = c; localStorage.setItem('club_id', c.id);
  $('#titre-club').textContent = c.nom;
  $('#qui-email').textContent = session?.user?.email || '';
  document.title = c.nom;
  const s = saisonCourante();
  $('#saison').innerHTML = [s, `${+s.slice(0,4)-1}-${+s.slice(0,4)}`, `${+s.slice(0,4)+1}-${+s.slice(0,4)+2}`]
    .map(x => `<option ${x===s?'selected':''}>${x}</option>`).join('');
  montrer('#app');
  await toutRecharger();
}

/* ─────────────────────────── Chargement des données ─────────────────────────── */
async function toutRecharger(){
  const [f, p, e, l, m] = await Promise.all([
    sb.from('familles').select('*').eq('club_id', club.id).order('nom'),
    sb.from('personnes').select('*').eq('club_id', club.id).order('nom').order('prenom'),
    sb.from('equipes').select('*').eq('club_id', club.id).order('saison', {ascending:false}).order('nom'),
    sb.from('licences').select('*').eq('club_id', club.id),
    sb.from('membres_club').select('user_id, role').eq('club_id', club.id),
  ]);
  familles = f.data || []; personnes = p.data || []; equipes = e.data || []; licences = l.data || []; membres = m.data || [];
  const err = [f,p,e,l,m].find(x => x.error); if(err) alert('Chargement incomplet : ' + erreurLisible(err.error));
  rendreFamilles(); rendreLicences(); rendreEquipes(); rendreAcces();
}

/* ─────────────────────────── Onglets ─────────────────────────── */
$$('nav.onglets [data-onglet]').forEach(b => b.addEventListener('click', () => {
  $$('nav.onglets [data-onglet]').forEach(x => x.setAttribute('aria-selected', x === b));
  $$('section.onglet').forEach(s => s.classList.toggle('cache', s.id !== 'onglet-' + b.dataset.onglet));
}));

/* ─────────────────────────── Familles ─────────────────────────── */
function rendreFamilles(){
  $('#cpt-familles').textContent = `${familles.length} famille${familles.length>1?'s':''}, ${personnes.length} joueur${personnes.length>1?'s':''}`;
  if(!familles.length){ $('#zone-familles').innerHTML = '<div class="vide">Aucune famille pour l\'instant. Ajoute la première pour commencer.</div>'; return; }
  const saison = $('#saison').value;
  $('#zone-familles').innerHTML = familles.map(f => {
    const ps = personnes.filter(p => p.famille_id === f.id);
    return `<div class="tableau" style="margin-bottom:14px">
      <table><thead><tr>
        <th colspan="4">${esc(f.nom)} <span class="compteur">${esc(f.email||'')} ${esc(f.telephone||'')}</span></th>
        <th class="act"><button class="btn second petit" data-ouvrir="personne" data-famille="${f.id}">Ajouter un joueur</button>
                        <button class="btn second petit" data-modifier-famille="${f.id}">Modifier</button>
                        <button class="btn second petit" data-supprimer-famille="${f.id}">Supprimer</button></th></tr></thead>
      <tbody>${ps.length ? ps.map(p => {
          const lic = licences.find(l => l.personne_id === p.id && l.saison === saison);
          return `<tr><td>${esc(p.prenom)} <b>${esc(p.nom)}</b></td><td>${dateFr(p.date_naissance)}</td>
            <td><span class="cat">${categorieProposee(p.date_naissance, p.sexe, saison)}</span></td>
            <td>${lic ? `<span class="puce ${lic.statut}">${lic.statut}</span>` : `<button class="btn second petit" data-licencier="${p.id}">Licencier ${saison}</button>`}</td>
            <td class="act"><button class="btn second petit" data-modifier-personne="${p.id}">Modifier</button>
                            <button class="btn second petit" data-supprimer-personne="${p.id}">Supprimer</button></td></tr>`;
        }).join('') : '<tr><td colspan="5" class="compteur">Aucun joueur dans cette famille.</td></tr>'}</tbody></table></div>`;
  }).join('');
}
$('#saison').addEventListener('change', () => { rendreFamilles(); rendreLicences(); });

document.addEventListener('click', ev => {
  const b = ev.target.closest('button'); if(!b) return;
  if(b.dataset.ouvrir === 'famille')      ouvrirFamille();
  if(b.dataset.modifierFamille)           ouvrirFamille(familles.find(f => f.id === b.dataset.modifierFamille));
  if(b.dataset.supprimerFamille)          supprimer('familles', b.dataset.supprimerFamille, 'Supprimer cette famille et tous ses joueurs ?');
  if(b.dataset.ouvrir === 'personne')     ouvrirPersonne(null, b.dataset.famille);
  if(b.dataset.modifierPersonne)          ouvrirPersonne(personnes.find(p => p.id === b.dataset.modifierPersonne));
  if(b.dataset.supprimerPersonne)         supprimer('personnes', b.dataset.supprimerPersonne, 'Supprimer ce joueur et ses licences ?');
  if(b.dataset.licencier)                 ouvrirLicence(personnes.find(p => p.id === b.dataset.licencier));
  if(b.dataset.statut)                    changerStatut(b.dataset.statut, b.dataset.licence);
  if(b.dataset.supprimerLicence)          supprimer('licences', b.dataset.supprimerLicence, 'Supprimer cette licence ?');
  if(b.dataset.ouvrir === 'equipe')       ouvrirEquipe();
  if(b.dataset.supprimerEquipe)           supprimer('equipes', b.dataset.supprimerEquipe, 'Supprimer cette équipe ? Les licences rattachées seront détachées.');
});

function ouvrirFamille(f){
  $('#dlg-famille-titre').textContent = f ? 'Modifier la famille' : 'Nouvelle famille';
  $('#f-id').value = f?.id || ''; $('#f-nom').value = f?.nom || ''; $('#f-email').value = f?.email || ''; $('#f-tel').value = f?.telephone || '';
  msg('#msg-famille',''); $('#dlg-famille').showModal();
}
$('#form-famille').addEventListener('submit', async ev => {
  if(ev.submitter?.value !== 'ok') return;
  ev.preventDefault();
  const ligne = { club_id: club.id, nom: $('#f-nom').value.trim(), email: $('#f-email').value.trim() || null, telephone: $('#f-tel').value.trim() || null };
  const id = $('#f-id').value;
  const { error } = id ? await sb.from('familles').update(ligne).eq('id', id) : await sb.from('familles').insert(ligne);
  if(error){ msg('#msg-famille', erreurLisible(error), 'erreur'); return; }
  $('#dlg-famille').close(); await toutRecharger();
});

/* ─────────────────────────── Personnes ─────────────────────────── */
function ouvrirPersonne(p, familleId){
  $('#dlg-personne-titre').textContent = p ? 'Modifier le joueur' : 'Nouveau joueur';
  $('#p-id').value = p?.id || ''; $('#p-famille').value = p?.famille_id || familleId || '';
  $('#p-prenom').value = p?.prenom || ''; $('#p-nom').value = p?.nom || (familles.find(f => f.id === familleId)?.nom || '');
  $('#p-naissance').value = p?.date_naissance || ''; $('#p-sexe').value = p?.sexe || ''; $('#p-licence').value = p?.num_licence || '';
  msg('#msg-personne',''); $('#dlg-personne').showModal();
}
$('#form-personne').addEventListener('submit', async ev => {
  if(ev.submitter?.value !== 'ok') return;
  ev.preventDefault();
  const ligne = { club_id: club.id, famille_id: $('#p-famille').value || null, prenom: $('#p-prenom').value.trim(), nom: $('#p-nom').value.trim(),
    date_naissance: $('#p-naissance').value || null, sexe: $('#p-sexe').value || null, num_licence: $('#p-licence').value.trim() || null };
  const id = $('#p-id').value;
  const { error } = id ? await sb.from('personnes').update(ligne).eq('id', id) : await sb.from('personnes').insert(ligne);
  if(error){ msg('#msg-personne', erreurLisible(error), 'erreur'); return; }
  $('#dlg-personne').close(); await toutRecharger();
});

/* ─────────────────────────── Licences ─────────────────────────── */
function ouvrirLicence(p){
  const saison = $('#saison').value;
  $('#l-qui').textContent = `${p.prenom} ${p.nom}`; $('#l-personne').value = p.id; $('#l-saison').textContent = saison;
  const prop = categorieProposee(p.date_naissance, p.sexe, saison);
  $('#l-cat').innerHTML = CATEGORIES().map(c => `<option ${c===prop?'selected':''}>${c}</option>`).join('');
  $('#l-montant').value = ''; msg('#msg-licence',''); $('#dlg-licence').showModal();
}
$('#form-licence').addEventListener('submit', async ev => {
  if(ev.submitter?.value !== 'ok') return;
  ev.preventDefault();
  const ligne = { club_id: club.id, personne_id: $('#l-personne').value, saison: $('#l-saison').textContent, categorie: $('#l-cat').value,
    montant: $('#l-montant').value ? parseFloat($('#l-montant').value) : null };
  const { error } = await sb.from('licences').insert(ligne);
  if(error){ msg('#msg-licence', erreurLisible(error), 'erreur'); return; }
  $('#dlg-licence').close(); await toutRecharger();
});
async function changerStatut(statut, id){
  const { error } = await sb.from('licences').update({ statut }).eq('id', id);
  if(error){ alert(erreurLisible(error)); return; }
  await toutRecharger();
}
function rendreLicences(){
  const saison = $('#saison').value;
  const ls = licences.filter(l => l.saison === saison);
  const nbValid = ls.filter(l => l.statut === 'validee').length;
  $('#cpt-licences').textContent = ls.length ? `${ls.length} licence${ls.length>1?'s':''}, ${nbValid} validée${nbValid>1?'s':''}` : '';
  if(!ls.length){ $('#zone-licences').innerHTML = `<div class="vide">Aucune licence pour ${saison}. Va dans Familles et clique « Licencier » sur un joueur.</div>`; return; }
  const ordre = { demandee:0, payee:1, validee:2, refusee:3 };
  ls.sort((a,b) => ordre[a.statut]-ordre[b.statut] || a.categorie.localeCompare(b.categorie));
  $('#zone-licences').innerHTML = `<div class="tableau"><table><thead><tr><th>Joueur</th><th>Catégorie</th><th>Équipe</th><th>Montant</th><th>Statut</th><th class="act"></th></tr></thead><tbody>` +
    ls.map(l => {
      const p = personnes.find(x => x.id === l.personne_id) || {};
      const eqs = equipes.filter(e => e.saison === saison);
      return `<tr><td>${esc(p.prenom)} <b>${esc(p.nom)}</b></td><td><span class="cat">${esc(l.categorie)}</span></td>
        <td><select data-equipe-licence="${l.id}" style="width:auto"><option value="">—</option>${eqs.map(e => `<option value="${e.id}" ${e.id===l.equipe_id?'selected':''}>${esc(e.nom)}</option>`).join('')}</select></td>
        <td>${l.montant != null ? l.montant.toFixed(2).replace('.',',') + ' €' : ''}</td>
        <td><span class="puce ${l.statut}">${l.statut}</span></td>
        <td class="act">
          ${l.statut==='demandee' ? `<button class="btn second petit" data-statut="payee" data-licence="${l.id}">Paiement reçu</button>` : ''}
          ${l.statut==='payee'    ? `<button class="btn second petit" data-statut="validee" data-licence="${l.id}">Valider</button>` : ''}
          ${l.statut!=='refusee' && l.statut!=='validee' ? `<button class="btn second petit" data-statut="refusee" data-licence="${l.id}">Refuser</button>` : ''}
          ${l.statut==='validee' || l.statut==='refusee' ? `<button class="btn second petit" data-statut="demandee" data-licence="${l.id}">Rouvrir</button>` : ''}
          <button class="btn second petit" data-supprimer-licence="${l.id}">Supprimer</button></td></tr>`;
    }).join('') + '</tbody></table></div>';
  $$('[data-equipe-licence]').forEach(s => s.addEventListener('change', async () => {
    const { error } = await sb.from('licences').update({ equipe_id: s.value || null }).eq('id', s.dataset.equipeLicence);
    if(error) alert(erreurLisible(error)); else await toutRecharger();
  }));
}

/* ─────────────────────────── Équipes ─────────────────────────── */
function ouvrirEquipe(){
  $('#e-nom').value = ''; $('#e-saison').value = $('#saison').value;
  $('#e-cat').innerHTML = CATEGORIES().map(c => `<option>${c}</option>`).join('');
  msg('#msg-equipe',''); $('#dlg-equipe').showModal();
}
$('#form-equipe').addEventListener('submit', async ev => {
  if(ev.submitter?.value !== 'ok') return;
  ev.preventDefault();
  const { error } = await sb.from('equipes').insert({ club_id: club.id, nom: $('#e-nom').value.trim(), categorie: $('#e-cat').value, saison: $('#e-saison').value.trim() });
  if(error){ msg('#msg-equipe', erreurLisible(error), 'erreur'); return; }
  $('#dlg-equipe').close(); await toutRecharger();
});
function rendreEquipes(){
  $('#cpt-equipes').textContent = equipes.length ? `${equipes.length}` : '';
  if(!equipes.length){ $('#zone-equipes').innerHTML = '<div class="vide">Aucune équipe. Crée-les, puis rattache les licences depuis l\'onglet Licences.</div>'; return; }
  $('#zone-equipes').innerHTML = `<div class="tableau"><table><thead><tr><th>Équipe</th><th>Catégorie</th><th>Saison</th><th>Effectif</th><th class="act"></th></tr></thead><tbody>` +
    equipes.map(e => `<tr><td><b>${esc(e.nom)}</b></td><td><span class="cat">${esc(e.categorie)}</span></td><td>${esc(e.saison)}</td>
      <td>${licences.filter(l => l.equipe_id === e.id).length}</td>
      <td class="act"><button class="btn second petit" data-supprimer-equipe="${e.id}">Supprimer</button></td></tr>`).join('') + '</tbody></table></div>';
}

/* ─────────────────────────── Accès ─────────────────────────── */
function rendreAcces(){
  $('#zone-acces').innerHTML = `<div class="tableau"><table><thead><tr><th>Compte</th><th>Rôle</th></tr></thead><tbody>` +
    membres.map(m => `<tr><td>${m.user_id === session.user.id ? esc(session.user.email) + ' (toi)' : 'Membre ' + m.user_id.slice(0,8)}</td><td>${esc(m.role)}</td></tr>`).join('') + '</tbody></table></div>';
}
$('#form-invite').addEventListener('submit', async ev => {
  ev.preventDefault(); msg('#msg-invite','');
  const { data, error } = await sb.rpc('inviter_membre', { p_club: club.id, p_email: $('#invite-email').value.trim(), p_role: $('#invite-role').value });
  if(error){ msg('#msg-invite', erreurLisible(error), 'erreur'); return; }
  if(data === 'inconnu'){ msg('#msg-invite', 'Cette adresse n\'a encore jamais ouvert le site. Demande à la personne de se connecter une fois, puis réessaie.', 'erreur'); return; }
  msg('#msg-invite', 'Accès donné.', 'ok'); $('#invite-email').value = ''; await toutRecharger();
});

/* ─────────────────────────── Suppression générique ─────────────────────────── */
async function supprimer(table, id, question){
  if(!confirm(question)) return;
  const { error } = await sb.from(table).delete().eq('id', id);
  if(error){ alert(erreurLisible(error)); return; }
  await toutRecharger();
}

demarrer();
</script>
</body>
</html>
