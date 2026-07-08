import 'package:go_router/go_router.dart';

import 'package:tictactoe/features/game/domain/entities/difficulty.dart';
import 'package:tictactoe/features/game/domain/entities/game_entry_intent.dart';
import 'package:tictactoe/features/game/navigation/game_routes.dart';
import 'package:tictactoe/features/home/navigation/home_navigation.dart';

/// GoRouter implementation of [HomeNavigation].
final class HomeNavigationImpl implements HomeNavigation {
  final GoRouter _router;

  const HomeNavigationImpl({required this._router});

  @override
  void openNewGame({required Difficulty difficulty}) {
    _router.push(
      GameRoutes.path,
      extra: GameEntryIntent.newGame(difficulty: difficulty),
    );
  }

  @override
  void openResumeGame() {
    _router.push(GameRoutes.path);
  }
}
