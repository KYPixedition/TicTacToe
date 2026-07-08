import 'package:go_router/go_router.dart';

import 'package:tictactoe/features/game/navigation/game_navigation.dart';
import 'package:tictactoe/features/home/navigation/home_routes.dart';

/// GoRouter implementation of [GameNavigation].
final class GameNavigationImpl implements GameNavigation {
  final GoRouter _router;

  const GameNavigationImpl({required this._router});

  @override
  void goHome() {
    if (_router.canPop()) {
      _router.pop();
      return;
    }

    _router.go(HomeRoutes.path);
  }
}
