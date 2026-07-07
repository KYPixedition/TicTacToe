import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tictactoe/core/error/app_error.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/di/game_navigation_provider.dart';
import 'package:tictactoe/features/game/di/game_repository_provider.dart';
import 'package:tictactoe/features/game/domain/entities/game_entry_mode.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/repositories/game_repository.dart';
import 'package:tictactoe/features/game/navigation/game_navigation.dart';
import 'package:tictactoe/features/game/presentation/notifiers/game_notifier.dart';

class MockGameNavigation extends Mock implements GameNavigation {}

final class FakeGameRepository implements GameRepository {
  int saveCalls = 0;
  bool shouldFailSave = false;

  @override
  Future<Result<bool>> hasValidSavedGame() async {
    return const Result.success(false);
  }

  @override
  Future<Result<void>> saveGame({required Game game}) async {
    saveCalls++;
    if (shouldFailSave) {
      return const Result.failure(StorageWriteError());
    }
    return const Result.success(null);
  }
}

void main() {
  late MockGameNavigation mockNavigation;
  late FakeGameRepository fakeGameRepository;

  setUp(() {
    mockNavigation = MockGameNavigation();
    fakeGameRepository = FakeGameRepository();
  });

  ProviderContainer createContainer() {
    return ProviderContainer.test(
      overrides: [
        gameNavigationProvider.overrideWithValue(mockNavigation),
        gameRepositoryProvider.overrideWithValue(fakeGameRepository),
      ],
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

  test('playMove applies player and CPU moves then saves twice', () async {
    final container = createContainer();
    addTearDown(container.dispose);
    final notifier = container.read(gameNotifierProvider(GameEntryMode.newGame).notifier);

    await notifier.playMove(cellIndex: 0);

    final updatedState = container.read(gameNotifierProvider(GameEntryMode.newGame));
    expect(updatedState.game?.board[0], Player.x);
    expect(updatedState.game?.board[1], Player.o);
    expect(updatedState.game?.currentPlayer, Player.x);
    expect(updatedState.game?.status, GameStatus.playing);
    expect(fakeGameRepository.saveCalls, 2);
    expect(updatedState.isCpuThinking, isFalse);
  });

  test('playMove refuses occupied cell and does not save', () async {
    final container = createContainer();
    addTearDown(container.dispose);
    final notifier = container.read(gameNotifierProvider(GameEntryMode.newGame).notifier);

    await notifier.playMove(cellIndex: 0);
    final saveCallsAfterValidMove = fakeGameRepository.saveCalls;
    final boardAfterValidMove = List<Player?>.from(
      container.read(gameNotifierProvider(GameEntryMode.newGame)).game?.board ??
          List<Player?>.filled(9, null),
    );

    await notifier.playMove(cellIndex: 0);

    final updatedState = container.read(gameNotifierProvider(GameEntryMode.newGame));
    expect(updatedState.game?.board, boardAfterValidMove);
    expect(fakeGameRepository.saveCalls, saveCallsAfterValidMove);
    expect(updatedState.error, isNull);
  });

  test('playMove does not trigger cpu when player wins', () async {
    final container = createContainer();
    addTearDown(container.dispose);
    final notifier = container.read(gameNotifierProvider(GameEntryMode.newGame).notifier);

    await notifier.playMove(cellIndex: 0);
    await notifier.playMove(cellIndex: 3);
    fakeGameRepository.saveCalls = 0;
    await notifier.playMove(cellIndex: 6);

    final updatedState = container.read(gameNotifierProvider(GameEntryMode.newGame));
    expect(updatedState.game?.status, GameStatus.won);
    expect(updatedState.game?.board[0], Player.x);
    expect(updatedState.game?.board[3], Player.x);
    expect(updatedState.game?.board[6], Player.x);
    expect(updatedState.game?.board.where((cell) => cell == Player.o).length, 2);
    expect(fakeGameRepository.saveCalls, 1);
    expect(updatedState.isCpuThinking, isFalse);
  });

  test('playMove reverts human move when save fails', () async {
    final container = createContainer();
    addTearDown(container.dispose);
    fakeGameRepository.shouldFailSave = true;
    final notifier = container.read(gameNotifierProvider(GameEntryMode.newGame).notifier);

    await notifier.playMove(cellIndex: 0);

    final updatedState = container.read(gameNotifierProvider(GameEntryMode.newGame));
    expect(updatedState.game?.board[0], isNull);
    expect(updatedState.game?.currentPlayer, Player.x);
    expect(updatedState.error, isA<StorageWriteError>());
    expect(fakeGameRepository.saveCalls, 1);
    expect(updatedState.isCpuThinking, isFalse);
  });
}
