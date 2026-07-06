import 'package:go_router/go_router.dart';
import 'package:tictactoe/features/home/presentation/home_view.dart';

/// Route constants for the home feature.
abstract final class HomeRoutes {
  static const String path = '/home';
  static const String name = 'home';
}

/// Home feature routes for the application router.
final List<RouteBase> homeRoutes = [
  GoRoute(
    path: HomeRoutes.path,
    name: HomeRoutes.name,
    builder: (context, state) => const HomeView(),
  ),
];
