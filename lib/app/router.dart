import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/core/navigation/app_route_observer.dart';
import 'package:tictactoe/features/game/navigation/game_routes.dart';
import 'package:tictactoe/features/home/navigation/home_routes.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: HomeRoutes.path,
    observers: [appRouteObserver],
    routes: [
      ...homeRoutes,
      ...gameRoutes,
    ],
  );
}
