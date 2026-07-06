import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/navigation/game_routes.dart';
import 'package:tictactoe/features/home/navigation/home_routes.dart';

part 'router.g.dart';

/// Provides the application [GoRouter] instance.
@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: HomeRoutes.path,
    routes: [
      ...homeRoutes,
      ...gameRoutes,
    ],
  );
}
