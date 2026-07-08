import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:tictactoe/app/router.dart';
import 'package:tictactoe/features/home/navigation/home_navigation.dart';
import 'package:tictactoe/features/home/navigation/home_navigation_impl.dart';

part 'home_navigation_provider.g.dart';

/// Provides the [HomeNavigation] implementation.
@riverpod
HomeNavigation homeNavigation(Ref ref) {
  return HomeNavigationImpl(router: ref.watch(routerProvider));
}
