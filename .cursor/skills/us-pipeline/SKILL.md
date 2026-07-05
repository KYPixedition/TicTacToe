---
name: us-pipeline
description: >-
  Orchestrates a User Story through PO analysis, Flutter architecture plan,
  implementation, local code review, and GitHub PR. Use when the user starts a US
  end-to-end, mentions the US pipeline, or pastes a US key (TIC-1) or Jira URL.
disable-model-invocation: true
---

# US Pipeline — Story → Review locale → PR

Pipeline séquentiel avec **gates de validation humaine** entre chaque étape.

```text
User Story → PO → Architect → Developer → Review locale → GitHub PR → Post-merge
                                              ↑ fixes si besoin ─┘

```

**Règle :** la revue locale est **obligatoire** avant commit / push / PR. Ne jamais ouvrir une PR sans `## Review Report` et gate « OK review ».

## Prérequis

- User Story : clé (`TIC-3`), URL Jira, ou texte complet collé dans le chat.
- Atlassian MCP : optionnel — sinon coller la US manuellement.
- Branche Git dédiée par US : `feature/TIC-3-play-move`.

## Démarrage

1. Récupérer la US :
   - Clé Jira ou URL → `getJiraIssue` (Atlassian MCP) si disponible.
   - Clé MVP (`TIC-1` … `TIC-9`) → utiliser le backlog projet.
   - Sinon → utiliser le texte fourni par l'utilisateur.
2. Créer ou basculer sur la branche `feature/<KEY>-<slug>`.
3. Annoncer le plan en une phrase, puis lancer **Étape 1**.

## Étapes et gates

| # | Skill | Gate |
| --- | --- | --- |
| 1 | [us-product-owner](../us-product-owner/SKILL.md) | Attendre « OK PO » (≤ 8 pts) ou « OK découpage » (13 / 21) |
| 2 | [us-flutter-architect](../us-flutter-architect/SKILL.md) | Attendre « OK plan » |
| 3 | [us-flutter-developer](../us-flutter-developer/SKILL.md) | Attendre « OK impl » ou demande de fix |
| 4 | [us-reviewer](../us-reviewer/SKILL.md) — **revue locale** | Attendre « OK review » ou corrections demandées |
| 5 | PR GitHub (commit, push, `gh pr create`) | Attendre URL PR |
| 6 | [us-post-merge](../us-post-merge/SKILL.md) — **nettoyage Git** | Attendre « OK MERGE » (PR mergée sur `develop`) |

**Ne jamais enchaîner deux étapes sans validation explicite**, sauf si l'utilisateur dit « pipeline complet sans pause ».

L'étape 6 est **optionnelle** mais recommandée : déclenchée après merge humain de la PR (GitHub), pas automatiquement à l'ouverture de la PR.

### Boucle review → fix (étape 4)

Après le `## Review Report` :

- **Bloquants / Important** signalés → corriger sur la branche, relancer tests, **re-review** ou validation ciblée par l'utilisateur.
- **Suggestions seules** → l'utilisateur choisit de fixer ou de passer avec « OK review ».
- Tant que « OK review » n'est pas donné → **ne pas** committer pour PR, **ne pas** `gh pr create`.

### Estimation Fibonacci (gate PO)

Estimation : **1 · 2 · 3 · 5 · 8 · 13 · 21**.

- **≤ 8** → continuer vers l'architecte après « OK PO ».
- **13 ou 21** → **stop** : découpage en US ≤ 8. Relancer le pipeline **une US à la fois** après « OK découpage ».

## Handoffs entre agents

Chaque étape produit un artefact markdown. Le copier tel quel dans le message de l'étape suivante :

| Étape | Artefact | Consommé par |
| --- | --- | --- |
| PO | `## PO Analysis` | Architect |
| Architect | `## Implementation Plan` | Developer |
| Developer | `## Developer Summary` | Reviewer (local) |
| Reviewer | `## Review Report` | gate « OK review » → PR |
| Post-merge | `## Cleanup Summary` | fin de cycle US |

Template détaillé : [handoff-templates.md](handoff-templates.md).

## Étape 4 — Revue locale

Déclenchée **automatiquement** après « OK impl » (ne pas proposer la PR en premier).

1. Invoquer [us-reviewer](../us-reviewer/SKILL.md) sur le diff **branche vs `develop`**.
2. Produire `## Review Report` avec note /10 et findings par sévérité.
3. Attendre « OK review » ou instructions de fix.
4. Si fixes : appliquer, relancer tests, re-review si le diff a changé de façon significative.

Checklist reviewer : `.cursor/BUGBOT.md`, `.cursor/rules/agent-review.mdc`.

## Étape 5 — PR GitHub

**Uniquement après « OK review ».**

Prérequis tooling :

```bash
gh auth status   # doit être connecté avant gh pr create
```

Puis :

```bash
git status
git diff
git log --oneline -5

```

Commit (si demandé), push, `gh pr create` avec :

- Titre : `feat(<feature>): <résumé US> (<KEY>)`
- Corps : clé US, résumé PO, **note review locale** + résumé des fixes post-review

Terminer par : « Mergez la PR sur GitHub, puis validez avec **OK MERGE** pour le nettoyage Git (étape 6). »

## Étape 6 — Post-merge (nettoyage Git)

**Uniquement après merge confirmé sur `develop` et gate « OK MERGE ».**

1. Invoquer [us-post-merge](../us-post-merge/SKILL.md).
2. Vérifier `gh pr view` → `state: MERGED`.
3. Exécuter le cleanup Git.
4. Produire `## Cleanup Summary`.

## Reprise après interruption

Si la conversation reprend en cours de pipeline, identifier l'étape courante via les artefacts déjà produits et reprendre à la gate suivante — ne pas refaire PO/Architect si déjà validés.
