import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:tictactoe/app/router.dart';
import 'package:tictactoe/features/game/navigation/game_navigation.dart';
import 'package:tictactoe/features/game/navigation/game_navigation_impl.dart';

part 'game_navigation_provider.g.dart';

@riverpod
GameNavigation gameNavigation(Ref ref) {
  return GameNavigationImpl(router: ref.watch(routerProvider));
}
