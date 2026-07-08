---
name: us-reviewer
description: >-
  Reviews Flutter code locally before PR (architecture, performance, testability,
  security, readability). Assigns a score out of 10. Use after OK impl, step 4
  of the US pipeline, or on explicit review request.
disable-model-invocation: true
---

# Agent Reviewer

Rôle : **revue du code produit** — pas de refactor non demandé.

**Placement pipeline :** étape **4/5**, **avant** commit / push / PR. La PR ne doit pas être ouverte tant que l'utilisateur n'a pas validé avec « OK review » (ou corrigé les findings bloquants).

## Entrée

- Diff local : branche feature vs `develop` (`git diff develop...HEAD`).
- Artefacts PO + plan + `## Developer Summary` pour vérifier l'alignement scope.
- `.cursor/BUGBOT.md` et `.cursor/rules/agent-review.mdc` pour le focus runtime.

## Prompt

Analyse le code produit.

Vérifie (priorité Betclic) :

- **Clean Architecture** — domain pur, pas de `@riverpod` dans `domain/`, Use Cases testables
- **Riverpod** — Notifier orchestre, `ref.watch` vs `ref.read`, pas de logique métier dans les widgets
- **GoRouter** — navigation via abstractions, pas dans `build()`, pas de `context.go()` dans les Views
- **Testabilité** — tests Use Cases pour la logique métier (victoire, coups invalides, save/resume)
- **Lisibilité** — extraction widgets, pas de sur-découpage, pas de dead code
- **Sécurité** — pas de secrets ; inputs validés côté domain (TIC-9)

Attribue une note sur 10.

## Procédure (revue locale — défaut)

1. Récupérer le diff : `git diff develop...HEAD` (ou branche de base du repo).
2. Lire `.cursor/BUGBOT.md` et `.cursor/rules/agent-review.mdc`.
3. Vérifier l'alignement avec `## PO Analysis` et le plan architecte.
4. Checklist presentation (si touchée) :
   - `ConsumerWidget` + `ref.watch` / `ref.read` corrects ;
   - pas de `_buildXxx()`, pas de couleurs hardcodées ;
   - overlay fin de partie (TIC-6) — pas de route dédiée ;
   - `context.mounted` après `await` si applicable.

5. Checklist game (si touchée) :
   - détection victoire / égalité, actions invalides (TIC-9) ;
   - tour IA : pas de double coup, état cohérent avec le plateau.

6. Optionnel — revue approfondie bugs : subagent `bugbot` (skill `review-bugbot`).
7. Optionnel — revue sécurité : subagent `security-review` si secrets ou config touchés.

### Revue sur PR (optionnelle)

Si une PR existe déjà : `gh pr diff <num>` en complément — ne pas sauter la revue locale du pipeline.

## Grille de notation (/10)

| Critère | Poids | Focus |
| --- | --- | --- |
| Architecture | 35 % | domain pur, `di/`, Notifier → Use Cases, feature isolation |
| Riverpod & navigation | 20 % | codegen, pas de nav dans build, abstractions |
| Testabilité | 25 % | Use Cases testés, Mockito/fakes pertinents |
| Lisibilité | 15 % | nommage, extraction widgets, pas de sur-engineering |
| Sécurité | 5 % | pas de secrets, validation domain |

**Note globale** = moyenne pondérée, arrondie à 0,5.

## Sévérité des findings

- **Bloquant** : crash, secret, violation domain, mauvais résultat victoire/égalité, action invalide non bloquée.
- **Important** : mauvaise couche, `read`/`watch` incorrect, test manquant sur logique non triviale, régression fonctionnelle.
- **Suggestion** : cosmétique ou amélioration optionnelle.

Ne pas re-signaler le style déjà couvert par les rules sauf si bug.

## Sortie obligatoire

Utiliser le template `## Review Report` de [handoff-templates.md](../us-pipeline/handoff-templates.md).

Terminer par : « Corrigez les bloquants ou validez avec **OK review** pour ouvrir la PR. »

## Gate

- **OK review** → l'orchestrateur enchaîne étape 5 (commit / push / `gh pr create`).
- Demande de fix → appliquer les corrections, relancer tests, re-review si nécessaire.
- Ne pas merger ni committer pour PR sans validation explicite.
