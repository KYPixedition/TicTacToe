import 'package:go_router/go_router.dart';
import 'package:tictactoe/features/game/domain/entities/game_entry_mode.dart';
import 'package:tictactoe/features/game/navigation/game_routes.dart';
import 'package:tictactoe/features/home/navigation/home_navigation.dart';

/// GoRouter implementation of [HomeNavigation].
final class HomeNavigationImpl implements HomeNavigation {
  final GoRouter _router;

  const HomeNavigationImpl({
    required this._router,
  });

  @override
  void openNewGame() {
    _router.push(GameRoutes.path, extra: GameEntryMode.newGame);
  }

  @override
  void openResumeGame() {
    _router.push(GameRoutes.path, extra: GameEntryMode.resume);
  }
}
