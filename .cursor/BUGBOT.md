# TicTacToe — Agent Review / Bugbot

Application Flutter — morpion **Human vs CPU**, local uniquement, test technique Betclic.

Index des règles à appliquer lors d'une revue. Bugbot et Agent Review suivent les liens ci-dessous.

## Énoncé Betclic (référence)

**Objectif :** application Flutter permettant de jouer au morpion contre une IA, en local.

**Exigences officielles :**

- Clean Architecture
- Mode local : Human vs CPU
- Livraison via dépôt Git

**Critères d'évaluation :** libre choix technique et design. L'exercice vise à démontrer un niveau d'ingénierie **production-ready** et à servir de base de discussion en entretien.

## Choix techniques du projet

Stack retenue pour répondre à cet objectif (décisions du candidat, pas imposées par Betclic) :

- **Riverpod 3** (codegen) — état et DI
- **GoRouter** — navigation
- **Clean Architecture feature-first** — `data` · `di` · `domain` · `navigation` · `presentation`
- **Mockito** + fakes manuels — tests

## Règles du projet

### Architecture & code

- [General](rules/general.mdc) — nommage, null safety, codegen, terminology (Notifier, `di/`)
- [Dart](rules/dart.mdc) — immutabilité, enums, error handling
- [Feature-first Clean Architecture](rules/feature-architecture.mdc) — couches, Use Cases, isolation
- [Riverpod — codegen & DI](rules/riverpod-providers.mdc) — `@riverpod`, providers dans `di/`
- [Navigation GoRouter](rules/navigation.mdc) — abstractions navigation
- [Presentation](rules/presentation.mdc) — ConsumerWidget, `ref.watch` / `ref.read`
- [Flutter infra](rules/flutter-infra.mdc) — bootstrap, stack, router, Talker
- [Design system](rules/design-system.mdc) — `AppThemeContextX`, ThemeExtensions
- [Testing](rules/testing.mdc) — Mockito, fakes, structure `test/features/`

### Focus revue runtime

- [Agent Review — focus revue](rules/agent-review.mdc) — zones game / home / save / settings, sévérité

## Focus revue (aligné entretien)

Prioriser ce qui alimente une discussion technique de qualité :

1. **Clean Architecture** — dépendances, domain pur, responsabilités par couche
2. **Qualité du code** — lisibilité, maintenabilité, cohérence avec les rules du projet
3. **Tests** — logique métier testable (Use Cases, règles de jeu)
4. **Comportement runtime** — régressions fonctionnelles, async, persistance, cohérence UI / état
5. **Choix d'architecture** — capacité à justifier Riverpod, GoRouter, feature-first en entretien

Ne pas re-signaler le style ou les conventions déjà couverts par les rules, sauf si cela introduit un bug.
