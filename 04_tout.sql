-- ═══════════════════════════════════════════════════════════════════════════
--  LOT « TOUT D'UN COUP » — espace famille, entraînements, présences,
--  covoiturage, infos, boutique, maillots. À coller dans Supabase → SQL Editor.
--  Ne supprime AUCUNE donnée existante (ajouts et nouvelles règles seulement).
-- ═══════════════════════════════════════════════════════════════════════════

-- ── Colonnes ajoutées ──────────────────────────────────────────────────────
alter table clubs     add column if not exists lien_paiement text;
alter table familles  add column if not exists code_acces text default upper(substr(md5(random()::text),1,6));
update familles set code_acces = upper(substr(md5(random()::text),1,6)) where code_acces is null;
alter table personnes add column if not exists numero_maillot integer;
create table if not exists matchs (
  id uuid primary key default gen_random_uuid(),
  club_id uuid not null references clubs(id) on delete cascade,
  equipe_id uuid not null references equipes(id) on delete cascade,
  date_match date not null, heure text, adversaire text not null,
  domicile boolean not null default true,
  score_nous integer check (score_nous >= 0), score_eux integer check (score_eux >= 0),
  commentaire text, cree_le timestamptz not null default now());
alter table matchs add column if not exists lieu text;
alter table matchs add column if not exists lavage_personne_id uuid references personnes(id) on delete set null;

-- ── Nouvelles tables ───────────────────────────────────────────────────────
create table if not exists acces_famille (
  user_id uuid not null references auth.users(id) on delete cascade,
  famille_id uuid not null references familles(id) on delete cascade,
  club_id uuid not null references clubs(id) on delete cascade,
  primary key (user_id, famille_id));

create table if not exists entrainements (
  id uuid primary key default gen_random_uuid(),
  club_id uuid not null references clubs(id) on delete cascade,
  equipe_id uuid not null references equipes(id) on delete cascade,
  date_seance date not null, heure_debut text, heure_fin text, lieu text,
  note text, extra boolean not null default false,
  cree_le timestamptz not null default now());

create table if not exists presences (
  id uuid primary key default gen_random_uuid(),
  club_id uuid not null references clubs(id) on delete cascade,
  personne_id uuid not null references personnes(id) on delete cascade,
  type text not null check (type in ('match','entrainement')),
  ref_id uuid not null,
  statut text not null check (statut in ('present','absent')),
  maj_le timestamptz not null default now(),
  unique (personne_id, type, ref_id));

create table if not exists covoiturages (
  id uuid primary key default gen_random_uuid(),
  club_id uuid not null references clubs(id) on delete cascade,
  match_id uuid not null references matchs(id) on delete cascade,
  famille_id uuid not null references familles(id) on delete cascade,
  places integer not null check (places between 0 and 8),
  note text, cree_le timestamptz not null default now(),
  unique (match_id, famille_id));

create table if not exists annonces (
  id uuid primary key default gen_random_uuid(),
  club_id uuid not null references clubs(id) on delete cascade,
  equipe_id uuid references equipes(id) on delete cascade,
  titre text not null, texte text not null,
  auteur text, cree_le timestamptz not null default now());

create table if not exists articles (
  id uuid primary key default gen_random_uuid(),
  club_id uuid not null references clubs(id) on delete cascade,
  nom text not null, prix numeric(8,2) not null default 0,
  tailles text, actif boolean not null default true,
  cree_le timestamptz not null default now());

create table if not exists commandes (
  id uuid primary key default gen_random_uuid(),
  club_id uuid not null references clubs(id) on delete cascade,
  famille_id uuid not null references familles(id) on delete cascade,
  article_id uuid not null references articles(id) on delete cascade,
  taille text, quantite integer not null default 1 check (quantite > 0),
  statut text not null default 'nouvelle' check (statut in ('nouvelle','payee','recuperee','annulee')),
  cree_le timestamptz not null default now());

create index if not exists entrainements_club_idx on entrainements(club_id);
create index if not exists presences_ref_idx on presences(type, ref_id);
create index if not exists annonces_club_idx on annonces(club_id);
create index if not exists commandes_club_idx on commandes(club_id);

-- ── Fonctions de rôle ──────────────────────────────────────────────────────
create or replace function est_staff(p_club uuid) returns boolean
language sql stable security definer set search_path = public as $$
  select exists (select 1 from membres_club where user_id = auth.uid() and club_id = p_club and role in ('admin','bureau','coach'))
$$;
create or replace function mes_familles() returns setof uuid
language sql stable security definer set search_path = public as $$
  select famille_id from acces_famille where user_id = auth.uid()
$$;
create or replace function mes_personnes() returns setof uuid
language sql stable security definer set search_path = public as $$
  select p.id from personnes p where p.famille_id in (select famille_id from acces_famille where user_id = auth.uid())
$$;

-- Un parent rejoint sa famille avec le code donné par le club.
create or replace function rejoindre_famille(p_code text) returns uuid
language plpgsql security definer set search_path = public as $$
declare v_fam familles%rowtype;
begin
  if auth.uid() is null then raise exception 'Non connecté'; end if;
  select * into v_fam from familles where upper(code_acces) = upper(trim(p_code));
  if v_fam.id is null then raise exception 'Code inconnu'; end if;
  insert into acces_famille(user_id, famille_id, club_id) values (auth.uid(), v_fam.id, v_fam.club_id) on conflict do nothing;
  insert into membres_club(user_id, club_id, role) values (auth.uid(), v_fam.club_id, 'parent') on conflict do nothing;
  return v_fam.club_id;
end $$;
grant execute on function est_staff(uuid) to authenticated;
grant execute on function mes_familles() to authenticated;
grant execute on function mes_personnes() to authenticated;
grant execute on function rejoindre_famille(text) to authenticated;

-- ── Règles d'accès (RLS) ───────────────────────────────────────────────────
alter table acces_famille  enable row level security;
alter table entrainements  enable row level security;
alter table presences      enable row level security;
alter table covoiturages   enable row level security;
alter table annonces       enable row level security;
alter table articles       enable row level security;
alter table commandes      enable row level security;
alter table matchs         enable row level security;

drop policy if exists familles_all  on familles;
drop policy if exists personnes_all on personnes;
drop policy if exists licences_all  on licences;
drop policy if exists equipes_all   on equipes;
drop policy if exists matchs_all    on matchs;
drop policy if exists clubs_update  on clubs;

create policy clubs_update on clubs for update using (est_staff(id));

create policy familles_sel on familles for select using (est_staff(club_id) or id in (select mes_familles()));
create policy familles_ecr on familles for insert with check (est_staff(club_id));
create policy familles_maj on familles for update using (est_staff(club_id) or id in (select mes_familles()));
create policy familles_sup on familles for delete using (est_staff(club_id));

create policy personnes_sel on personnes for select using (est_staff(club_id) or famille_id in (select mes_familles()));
create policy personnes_ecr on personnes for insert with check (est_staff(club_id) or famille_id in (select mes_familles()));
create policy personnes_maj on personnes for update using (est_staff(club_id) or famille_id in (select mes_familles()));
create policy personnes_sup on personnes for delete using (est_staff(club_id));

create policy licences_sel on licences for select using (est_staff(club_id) or personne_id in (select mes_personnes()));
create policy licences_ecr on licences for insert with check (est_staff(club_id) or personne_id in (select mes_personnes()));
create policy licences_maj on licences for update using (est_staff(club_id));
create policy licences_sup on licences for delete using (est_staff(club_id));

create policy equipes_sel on equipes for select using (club_id in (select mes_clubs()));
create policy equipes_ecr on equipes for all using (est_staff(club_id)) with check (est_staff(club_id));

create policy matchs_sel on matchs for select using (club_id in (select mes_clubs()));
create policy matchs_ecr on matchs for all using (est_staff(club_id)) with check (est_staff(club_id));

create policy entr_sel on entrainements for select using (club_id in (select mes_clubs()));
create policy entr_ecr on entrainements for all using (est_staff(club_id)) with check (est_staff(club_id));

create policy pres_sel on presences for select using (club_id in (select mes_clubs()));
create policy pres_ecr on presences for all
  using (est_staff(club_id) or personne_id in (select mes_personnes()))
  with check (est_staff(club_id) or personne_id in (select mes_personnes()));

create policy covoit_sel on covoiturages for select using (club_id in (select mes_clubs()));
create policy covoit_ecr on covoiturages for all
  using (est_staff(club_id) or famille_id in (select mes_familles()))
  with check (est_staff(club_id) or famille_id in (select mes_familles()));

create policy annonces_sel on annonces for select using (club_id in (select mes_clubs()));
create policy annonces_ecr on annonces for all using (est_staff(club_id)) with check (est_staff(club_id));

create policy articles_sel on articles for select using (club_id in (select mes_clubs()));
create policy articles_ecr on articles for all using (est_staff(club_id)) with check (est_staff(club_id));

create policy cmd_sel on commandes for select using (est_staff(club_id) or famille_id in (select mes_familles()));
create policy cmd_ecr on commandes for insert with check (est_staff(club_id) or famille_id in (select mes_familles()));
create policy cmd_maj on commandes for update using (est_staff(club_id));
create policy cmd_sup on commandes for delete using (est_staff(club_id) or famille_id in (select mes_familles()));

create policy acces_sel on acces_famille for select using (user_id = auth.uid() or est_staff(club_id));
create policy acces_sup on acces_famille for delete using (est_staff(club_id));

-- Fin. Rien à faire de plus côté base.
