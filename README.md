# TicTacToe

Local Tic-Tac-Toe game built with Flutter — **Human vs CPU**, offline only.  
This repository is a **Betclic Flutter technical test**: the focus is production-ready engineering (Clean Architecture, tests, maintainability), not feature breadth.

## Stack

| Area | Choice |
| --- | --- |
| State & DI | Riverpod 3 (codegen) |
| Navigation | GoRouter |
| Architecture | Feature-first Clean Architecture |
| Immutability | freezed |
| Persistence | SharedPreferences |
| Logging | Talker |
| Tests | Mockito + manual fakes |

## Architecture (overview)

```text
lib/
├── app/          # bootstrap, GoRouter
├── core/         # Result, AppError, theme, shared providers
└── features/
    ├── home/
    ├── game/
    └── settings/
        ├── data/
        ├── di/           # @riverpod wiring (never in domain/)
        ├── domain/       # pure Dart — no Flutter / Riverpod
        ├── navigation/
        └── presentation/
```

Dependency rule: **Presentation → DI → Domain ← Data**

User stories are tracked as **TIC-1** … **TIC-9** (home, gameplay, save, AI difficulty, etc.).

---

## Cursor rules (for reviewers & contributors)

This project defines **Cursor project rules** under [`.cursor/rules/`](.cursor/rules/).  
They document conventions intentionally applied across the codebase. When reviewing, please treat them as the source of truth for architectural and style decisions.

| Rule | Purpose |
| --- | --- |
| [`general.mdc`](.cursor/rules/general.mdc) | Naming, null safety, codegen, terminology (Notifier, `di/`) |
| [`dart.mdc`](.cursor/rules/dart.mdc) | Dart idioms, immutability, error handling |
| [`feature-architecture.mdc`](.cursor/rules/feature-architecture.mdc) | Clean Architecture, Use Cases, feature isolation |
| [`riverpod-providers.mdc`](.cursor/rules/riverpod-providers.mdc) | Riverpod 3 codegen, provider placement |
| [`navigation.mdc`](.cursor/rules/navigation.mdc) | GoRouter, navigation abstractions |
| [`presentation.mdc`](.cursor/rules/presentation.mdc) | Views, widgets, `ref.watch` / `ref.read` |
| [`flutter-infra.mdc`](.cursor/rules/flutter-infra.mdc) | Bootstrap, stack, router, Talker |
| [`design-system.mdc`](.cursor/rules/design-system.mdc) | ThemeExtensions, `AppThemeContextX` |
| [`testing.mdc`](.cursor/rules/testing.mdc) | Unit / notifier / widget tests, Mockito |
| [`agent-review.mdc`](.cursor/rules/agent-review.mdc) | Runtime review focus (game, save, settings) |

Review index for automated / agent review: [`.cursor/BUGBOT.md`](.cursor/BUGBOT.md)

> **Note for reviewers:** some choices (Riverpod, GoRouter, feature-first layout) are **candidate decisions** to demonstrate engineering standards — they are not part of the official Betclic test requirements (which ask for Clean Architecture, local Human vs CPU, and a Git repo).

---

## Cursor skills (development workflow)

Agent skills under [`.cursor/skills/`](.cursor/skills/) orchestrate user-story delivery:

| Skill | Role |
| --- | --- |
| [`us-product-owner`](.cursor/skills/us-product-owner/SKILL.md) | PO analysis, acceptance criteria, estimation |
| [`us-flutter-architect`](.cursor/skills/us-flutter-architect/SKILL.md) | Implementation plan (no code) |
| [`us-flutter-developer`](.cursor/skills/us-flutter-developer/SKILL.md) | Implementation following the plan |
| [`us-reviewer`](.cursor/skills/us-reviewer/SKILL.md) | Local code review before PR |
| [`us-pipeline`](.cursor/skills/us-pipeline/SKILL.md) | End-to-end US pipeline with human gates |
| [`us-post-merge`](.cursor/skills/us-post-merge/SKILL.md) | Git cleanup after merge |

Pipeline flow: **PO → Architect → Developer → Review → PR → Post-merge**  
Handoff templates: [`.cursor/skills/us-pipeline/handoff-templates.md`](.cursor/skills/us-pipeline/handoff-templates.md)

---

## Getting started

### Prerequisites

- Flutter SDK compatible with Dart `^3.12.1`
- Git

### Setup

```bash
flutter pub get
```

### Code generation

After changing `@riverpod`, `freezed`, or `json_serializable` sources:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Generated files (`.g.dart`, `.freezed.dart`) are committed to the repository.

### Quality checks

```bash
dart analyze
flutter test
```

---

## License

Private project — not published to pub.dev (`publish_to: none`).
