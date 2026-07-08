import 'package:go_router/go_router.dart';

import 'package:tictactoe/features/game/domain/entities/game_entry_intent.dart';
import 'package:tictactoe/features/game/presentation/game_view.dart';

/// Route constants for the game feature.
abstract final class GameRoutes {
  static const String path = '/game';
  static const String name = 'game';

  /// Resolves navigation [extra] to a typed [GameEntryIntent].
  static GameEntryIntent entryIntentFromExtra(Object? extra) {
    return extra is GameEntryIntent ? extra : const GameEntryIntent.resume();
  }
}

/// Game feature routes for the application router.
final List<RouteBase> gameRoutes = [
  GoRoute(
    path: GameRoutes.path,
    name: GameRoutes.name,
    builder: (context, state) =>
        GameView(entryIntent: GameRoutes.entryIntentFromExtra(state.extra)),
  ),
];
