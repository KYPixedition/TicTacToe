---
name: us-post-merge
description: >-
  Post-merge Git cleanup after a merged US PR. MANDATORY when user says OK MERGE:
  verify merge via gh pr view, checkout develop, fetch --prune, pull --rebase,
  delete local and remote feature branch. Produce Cleanup Summary.
---

# Agent Post-Merge — nettoyage Git

Rôle : **nettoyage Git uniquement** après merge confirmé — pas de code, pas de nouvelle PR.

## Entrée

- Gate **« OK MERGE »** (ou variante explicite : « PR mergée », « nettoie la branche »).
- Contexte pipeline : numéro/URL PR, clé US (`TIC-3`), nom de branche feature (`feature/TIC-3-play-move`).
- Branche de base du repo : **`develop`** (sauf indication contraire).

## Gate

**Ne jamais exécuter sans validation explicite « OK MERGE ».**

Si la PR n'est pas mergée → **stop** et informer l'utilisateur.

## Procédure

### 1. Pré-vérifications

```bash
git status -sb
gh auth status

```

- S'il reste des **modifications non commitées** sur la branche feature → **stop**, lister les fichiers, demander commit/stash avant cleanup.
- Mémoriser le nom de la branche courante : `git branch --show-current`.

### 2. Vérifier le merge (obligatoire)

Si numéro PR connu :

```bash
gh pr view <num> --json state,mergedAt,headRefName,baseRefName,url
```

- `state` doit être `MERGED`.
- Sinon → **stop** : « La PR #N n'est pas mergée (état : …). »

Sans numéro PR : demander le numéro ou une confirmation explicite que le merge est fait sur `develop`.

### 3. Nettoyage (ordre strict)

```bash
git fetch --prune origin
git checkout develop
git pull --rebase origin develop

```

Puis suppression de la branche feature (nom mémorisé à l'étape 1) :

```bash

# locale — -d uniquement (refuse si non mergée)

git branch -d feature/TIC-3-play-move

# distante — ignorer l'erreur si déjà supprimée (auto-delete GitHub)

git push origin --delete feature/TIC-3-play-move
```

### 4. État final

```bash
git status -sb
git branch -vv

```

Confirmer : sur `develop`, à jour avec `origin/develop`, branche feature absente en local (et remote si applicable).

## Règles de sécurité

- **Jamais** `git config` (global ou local).
- **Jamais** `git branch -D` / `push --force` sauf demande explicite de l'utilisateur.
- **Jamais** supprimer `develop`, `main`, ou une branche autre que la feature de la US courante.
- **Jamais** merger ni ouvrir de PR dans cette étape.

## Sortie obligatoire

Utiliser le template `## Cleanup Summary` de [handoff-templates.md](../us-pipeline/handoff-templates.md).

Terminer par : « Branche feature supprimée. Prêt pour la prochaine US avec `/us-pipeline TIC-X`. »
