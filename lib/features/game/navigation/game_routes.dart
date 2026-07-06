import 'package:go_router/go_router.dart';
import 'package:tictactoe/features/game/domain/entities/game_entry_mode.dart';
import 'package:tictactoe/features/game/presentation/game_view.dart';

/// Route constants for the game feature.
abstract final class GameRoutes {
  static const String path = '/game';
  static const String name = 'game';

  /// Resolves navigation [extra] to a typed [GameEntryMode].
  static GameEntryMode entryModeFromExtra(Object? extra) {
    return extra is GameEntryMode ? extra : GameEntryMode.newGame;
  }
}

/// Game feature routes for the application router.
final List<RouteBase> gameRoutes = [
  GoRoute(
    path: GameRoutes.path,
    name: GameRoutes.name,
    builder: (context, state) =>
        GameView(entryMode: GameRoutes.entryModeFromExtra(state.extra)),
  ),
];
