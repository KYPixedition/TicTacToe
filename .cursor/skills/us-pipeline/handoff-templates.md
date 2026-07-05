# Handoff templates — US Pipeline (TicTacToe)

## PO Analysis (sortie Étape 1)

```markdown

## PO Analysis

**Issue:** TIC-3 — [titre]
**Estimation:** [1 | 2 | 3 | 5 | 8 | 13 | 21] — [justification en 1-2 phrases]

### User Story clarifiée

[Reformulation sans ambiguïté]

### Découpage proposé (obligatoire si estimation 13 ou 21)

| # | Titre US | Objectif | Estimation | Critères d'acceptation clés |
| --- | --- | --- | --- | --- |
| 1 | … | … | 3 | … |
| 2 | … | … | 5 | … |

*(Omettre cette section si estimation ≤ 8.)*

### Ambiguïtés détectées

- [ ] …

### Règles métier

- …

### Cas limites

- …

### Critères d'acceptation

- [ ] Given … When … Then …
- [ ] …

### Questions ouvertes (bloquantes / non bloquantes)

- …

```

## Implementation Plan (sortie Étape 2)

```markdown

## Implementation Plan

**Issue:** TIC-3
**Feature:** home | game | settings

### Fichiers à créer

| Fichier | Rôle |
| --- | --- |
| `lib/features/game/domain/usecases/play_move_use_case.dart` | Use Case pur |
| `lib/features/game/di/play_move_use_case_provider.dart` | `@riverpod` wiring |
| `lib/features/game/presentation/notifiers/game_notifier.dart` | Notifier |
| `test/features/game/domain/usecases/play_move_use_case_test.dart` | Tests unitaires |

### Fichiers à modifier

| Fichier | Changement |
| --- | --- |
| `lib/app/router.dart` | … |

### Couches touchées

- domain / data / di / presentation / navigation / tests

### Providers & routes

- `di/` : …
- routes : …
- navigation abstraction : …

### Tests à ajouter

- Use Case unit tests (priorité)
- Notifier tests (Mockito `verify` si navigation)
- Widget smoke tests (optionnel)

### Hors scope explicite

- …

### Ordre d'implémentation

1. Domain (entities, Use Cases)
2. Data (repository, datasource, mappers)
3. DI (providers)
4. Presentation (Notifier, widgets, view)
5. Navigation (routes, abstraction)
6. Tests

```

## Developer Summary (sortie Étape 3)

```markdown

## Developer Summary

**Issue:** TIC-3
**Branch:** feature/TIC-3-play-move

### Fichiers modifiés

- …

### Tests

- [ ] `flutter test test/features/game/…` — OK
- [ ] `dart analyze` — OK
- [ ] `dart run build_runner build --delete-conflicting-outputs` — OK (si codegen touché)

### Écarts vs plan

- Aucun | [détailler avec justification]

### Notes pour le reviewer

- …

```

Terminer par : « Validez avec **OK impl** pour lancer la **revue locale** (étape 4), ou demandez des corrections. »

## Review Report (sortie Étape 4 — revue locale)

```markdown

## Review Report

**Branche:** feature/TIC-3-play-move vs `develop`
**Issue:** TIC-3 — [titre]
**Note globale:** X/10

| Critère | Note /10 | Commentaire |
| --- | --- | --- |
| Architecture |  | domain pur, di/, Notifier → Use Cases |
| Riverpod & navigation |  | watch/read, pas de nav dans build |
| Testabilité |  | Use Cases, Mockito/fakes |
| Lisibilité |  | extraction widgets, pas de sur-engineering |
| Sécurité |  | pas de secrets, validation domain |

### Bloquants

- …

### Important

- …

### Suggestions

- …

### Alignement scope PO

| Critère PO | Statut |
| --- | --- |
| … | ✅ / ❌ |

### Points positifs

- …

```

Terminer par : « Corrigez les bloquants ou validez avec **OK review** pour ouvrir la PR. »

## PR body (sortie Étape 5 — après OK review)

Inclure dans le corps de la PR :

- Clé US + résumé PO
- Note review locale (X/10) et fixes appliqués post-review
- Test plan (auto cochés + manuels restants)

Exemple titre : `feat(game): play move on board (TIC-3)`

## Cleanup Summary (sortie Étape 6 — après OK MERGE)

```markdown

## Cleanup Summary

**Issue:** TIC-3
**PR:** #N — [URL] — MERGED
**Branche supprimée:** feature/TIC-3-play-move

### Actions effectuées

- [ ] `gh pr view` — état MERGED confirmé
- [ ] `git fetch --prune origin`
- [ ] `git checkout develop`
- [ ] `git pull --rebase origin develop`
- [ ] `git branch -d feature/…` — OK
- [ ] `git push origin --delete feature/…` — OK | déjà absente

### État final

- Branche courante : `develop`
- Synchronisation : `develop` à jour avec `origin/develop`

```

Terminer par : « Branche feature supprimée. Prêt pour la prochaine US avec `/us-pipeline TIC-X`. »
