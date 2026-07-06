import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tictactoe/features/game/di/game_navigation_provider.dart';
import 'package:tictactoe/features/game/domain/entities/game_entry_mode.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/navigation/game_navigation.dart';
import 'package:tictactoe/features/game/presentation/notifiers/game_notifier.dart';

class MockGameNavigation extends Mock implements GameNavigation {}

void main() {
  late MockGameNavigation mockNavigation;

  setUp(() {
    mockNavigation = MockGameNavigation();
  });

  ProviderContainer createContainer() {
    return ProviderContainer.test(
      overrides: [gameNavigationProvider.overrideWithValue(mockNavigation)],
    );
  }

  test('newGame initializes with a fresh game from the use case', () {
    final container = createContainer();
    addTearDown(container.dispose);

    final state = container.read(gameNotifierProvider(GameEntryMode.newGame));

    expect(state.game, isNotNull);
    expect(state.game?.board, List<Player?>.filled(9, null));
    expect(state.game?.currentPlayer, Player.x);
    expect(state.game?.status, GameStatus.playing);
    expect(state.error, isNull);
  });

  test('resume leaves game unset', () {
    final container = createContainer();
    addTearDown(container.dispose);

    final state = container.read(gameNotifierProvider(GameEntryMode.resume));

    expect(state.game, isNull);
    expect(state.error, isNull);
  });

  test('goHome delegates to GameNavigation', () {
    final container = createContainer();
    addTearDown(container.dispose);

    container
        .read(gameNotifierProvider(GameEntryMode.newGame).notifier)
        .goHome();

    verify(mockNavigation.goHome()).called(1);
  });
}
