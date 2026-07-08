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
  int clearCalls = 0;
  bool shouldFailSave = false;
  Game? savedGame;

  @override
  Future<Result<bool>> hasValidSavedGame() async {
    return Result.success(savedGame != null);
  }

  @override
  Future<Result<Game?>> loadSavedGame() async {
    return Result.success(savedGame);
  }

  @override
  Future<Result<void>> saveGame({required Game game}) async {
    saveCalls++;
    if (shouldFailSave) {
      return const Result.failure(StorageWriteError());
    }
    savedGame = game;
    return const Result.success(null);
  }

  @override
  Future<Result<void>> clearSavedGame() async {
    clearCalls++;
    if (shouldFailSave) {
      return const Result.failure(StorageWriteError());
    }
    savedGame = null;
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

  void keepGameNotifierAlive(
    ProviderContainer container, {
    GameEntryMode entryMode = GameEntryMode.newGame,
  }) {
    container.listen(
      gameNotifierProvider(entryMode),
      (_, _) {},
      fireImmediately: true,
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

  test('resume restores saved game when available', () async {
    fakeGameRepository.savedGame = Game(
      board: <Player?>[
        Player.x,
        Player.o,
        null,
        null,
        Player.x,
        null,
        null,
        null,
        null,
      ],
      status: GameStatus.playing,
      currentPlayer: Player.x,
    );

    final container = createContainer();
    addTearDown(container.dispose);
    keepGameNotifierAlive(container, entryMode: GameEntryMode.resume);

    await pumpEventQueue();
    final state = container.read(gameNotifierProvider(GameEntryMode.resume));

    expect(state.game, isNotNull);
    expect(state.game?.board[0], Player.x);
    expect(state.game?.board[1], Player.o);
    expect(state.game?.currentPlayer, Player.x);
    expect(state.error, isNull);
    verifyNever(mockNavigation.goHome());
  });

  test(
    'resume does not trigger cpu turn when restored game expects human',
    () async {
      fakeGameRepository.savedGame = Game(
        board: <Player?>[
          Player.x,
          Player.o,
          null,
          null,
          Player.x,
          null,
          null,
          null,
          null,
        ],
        status: GameStatus.playing,
        currentPlayer: Player.x,
      );

      final container = createContainer();
      addTearDown(container.dispose);
      keepGameNotifierAlive(container, entryMode: GameEntryMode.resume);

      await Future<void>.delayed(const Duration(milliseconds: 450));
      final state = container.read(gameNotifierProvider(GameEntryMode.resume));

      expect(state.game, isNotNull);
      expect(state.game?.board[0], Player.x);
      expect(state.game?.board[1], Player.o);
      expect(state.game?.currentPlayer, Player.x);
      expect(state.isCpuThinking, isFalse);
      expect(fakeGameRepository.saveCalls, 0);
      verifyNever(mockNavigation.goHome());
    },
  );

  test(
    'resume runs cpu turn automatically when restored game expects cpu',
    () async {
      fakeGameRepository.savedGame = Game(
        board: <Player?>[
          Player.x,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
        ],
        status: GameStatus.playing,
        currentPlayer: Player.o,
      );

      final container = createContainer();
      addTearDown(container.dispose);
      keepGameNotifierAlive(container, entryMode: GameEntryMode.resume);

      await Future<void>.delayed(const Duration(milliseconds: 450));
      final state = container.read(gameNotifierProvider(GameEntryMode.resume));

      expect(state.game, isNotNull);
      expect(state.game?.board.where((cell) => cell == Player.o).length, 1);
      expect(state.game?.currentPlayer, Player.x);
      expect(state.isCpuThinking, isFalse);
      expect(fakeGameRepository.saveCalls, greaterThanOrEqualTo(1));
      verifyNever(mockNavigation.goHome());
    },
  );

  test('resume does not redirect home when restore succeeds', () async {
    fakeGameRepository.savedGame = Game(
      board: <Player?>[
        Player.x,
        Player.o,
        null,
        null,
        Player.x,
        null,
        null,
        null,
        null,
      ],
      status: GameStatus.playing,
      currentPlayer: Player.x,
    );

    final container = createContainer();
    addTearDown(container.dispose);
    keepGameNotifierAlive(container, entryMode: GameEntryMode.resume);

    await pumpEventQueue();
    final state = container.read(gameNotifierProvider(GameEntryMode.resume));

    expect(state.game, isNotNull);
    verifyNever(mockNavigation.goHome());
  });

  test('resume starts a new game when no valid save exists', () async {
    fakeGameRepository.savedGame = null;

    final container = createContainer();
    addTearDown(container.dispose);
    keepGameNotifierAlive(container, entryMode: GameEntryMode.resume);

    await pumpEventQueue();
    final state = container.read(gameNotifierProvider(GameEntryMode.resume));

    expect(state.game, isNotNull);
    expect(state.game?.board, List<Player?>.filled(9, null));
    expect(state.game?.status, GameStatus.playing);
    expect(state.game?.currentPlayer, Player.x);
    expect(state.error, isNull);
    verifyNever(mockNavigation.goHome());
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
    keepGameNotifierAlive(container);
    final notifier = container.read(
      gameNotifierProvider(GameEntryMode.newGame).notifier,
    );

    await notifier.playMove(cellIndex: 0);

    final updatedState = container.read(
      gameNotifierProvider(GameEntryMode.newGame),
    );
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
    keepGameNotifierAlive(container);
    final notifier = container.read(
      gameNotifierProvider(GameEntryMode.newGame).notifier,
    );

    await notifier.playMove(cellIndex: 0);
    final saveCallsAfterValidMove = fakeGameRepository.saveCalls;
    final boardAfterValidMove = List<Player?>.from(
      container.read(gameNotifierProvider(GameEntryMode.newGame)).game?.board ??
          List<Player?>.filled(9, null),
    );

    await notifier.playMove(cellIndex: 0);

    final updatedState = container.read(
      gameNotifierProvider(GameEntryMode.newGame),
    );
    expect(updatedState.game?.board, boardAfterValidMove);
    expect(fakeGameRepository.saveCalls, saveCallsAfterValidMove);
    expect(updatedState.error, isNull);
  });

  test('playMove does not trigger cpu when player wins', () async {
    final container = createContainer();
    addTearDown(container.dispose);
    keepGameNotifierAlive(container);
    final notifier = container.read(
      gameNotifierProvider(GameEntryMode.newGame).notifier,
    );

    await notifier.playMove(cellIndex: 0);
    await notifier.playMove(cellIndex: 3);
    fakeGameRepository.saveCalls = 0;
    await notifier.playMove(cellIndex: 6);

    final updatedState = container.read(
      gameNotifierProvider(GameEntryMode.newGame),
    );
    expect(updatedState.game?.status, GameStatus.won);
    expect(updatedState.game?.board[0], Player.x);
    expect(updatedState.game?.board[3], Player.x);
    expect(updatedState.game?.board[6], Player.x);
    expect(
      updatedState.game?.board.where((cell) => cell == Player.o).length,
      2,
    );
    expect(fakeGameRepository.saveCalls, 0);
    expect(fakeGameRepository.clearCalls, 1);
    expect(updatedState.isCpuThinking, isFalse);
  });

  test('playMove clears saved game on draw instead of saving', () async {
    fakeGameRepository.savedGame = Game(
      board: <Player?>[
        Player.x,
        Player.o,
        Player.x,
        Player.x,
        Player.o,
        Player.o,
        Player.o,
        Player.x,
        null,
      ],
      status: GameStatus.playing,
      currentPlayer: Player.x,
    );

    final container = createContainer();
    addTearDown(container.dispose);
    keepGameNotifierAlive(container, entryMode: GameEntryMode.resume);
    await pumpEventQueue();

    final notifier = container.read(
      gameNotifierProvider(GameEntryMode.resume).notifier,
    );
    fakeGameRepository.saveCalls = 0;
    fakeGameRepository.clearCalls = 0;

    await notifier.playMove(cellIndex: 8);

    final updatedState = container.read(
      gameNotifierProvider(GameEntryMode.resume),
    );
    expect(updatedState.game?.status, GameStatus.draw);
    expect(fakeGameRepository.saveCalls, 0);
    expect(fakeGameRepository.clearCalls, 1);
  });

  test('playMove reverts human move when save fails', () async {
    final container = createContainer();
    addTearDown(container.dispose);
    keepGameNotifierAlive(container);
    fakeGameRepository.shouldFailSave = true;
    final notifier = container.read(
      gameNotifierProvider(GameEntryMode.newGame).notifier,
    );

    await notifier.playMove(cellIndex: 0);

    final updatedState = container.read(
      gameNotifierProvider(GameEntryMode.newGame),
    );
    expect(updatedState.game?.board[0], isNull);
    expect(updatedState.game?.currentPlayer, Player.x);
    expect(updatedState.error, isA<StorageWriteError>());
    expect(fakeGameRepository.saveCalls, 1);
    expect(updatedState.isCpuThinking, isFalse);
  });

  test(
    'playAgain resets board and alternates starting player to cpu',
    () async {
      final container = createContainer();
      addTearDown(container.dispose);
      keepGameNotifierAlive(container);
      final notifier = container.read(
        gameNotifierProvider(GameEntryMode.newGame).notifier,
      );

      await notifier.playMove(cellIndex: 0);
      await notifier.playMove(cellIndex: 3);
      await notifier.playMove(cellIndex: 6);

      final finishedState = container.read(
        gameNotifierProvider(GameEntryMode.newGame),
      );
      expect(finishedState.game?.status, GameStatus.won);
      expect(finishedState.lastStartingPlayer, Player.x);

      await notifier.playAgain();
      await Future<void>.delayed(const Duration(milliseconds: 450));

      final replayState = container.read(
        gameNotifierProvider(GameEntryMode.newGame),
      );
      expect(replayState.game?.status, GameStatus.playing);
      expect(replayState.game?.board[0], Player.o);
      expect(replayState.lastStartingPlayer, Player.o);
      expect(replayState.game?.currentPlayer, Player.x);
      expect(fakeGameRepository.saveCalls, greaterThanOrEqualTo(4));
    },
  );

  test('playAgain alternates back to human after second replay', () async {
    final container = createContainer();
    addTearDown(container.dispose);
    keepGameNotifierAlive(container);
    final notifier = container.read(
      gameNotifierProvider(GameEntryMode.newGame).notifier,
    );

    await notifier.playMove(cellIndex: 0);
    await notifier.playMove(cellIndex: 3);
    await notifier.playMove(cellIndex: 6);
    await notifier.playAgain();
    await Future<void>.delayed(const Duration(milliseconds: 450));

    await notifier.playMove(cellIndex: 0);
    await notifier.playMove(cellIndex: 3);
    await notifier.playMove(cellIndex: 6);
    final saveCallsBeforeSecondReplay = fakeGameRepository.saveCalls;
    await notifier.playAgain();

    final replayState = container.read(
      gameNotifierProvider(GameEntryMode.newGame),
    );
    expect(replayState.lastStartingPlayer, Player.x);
    expect(replayState.game?.currentPlayer, Player.x);
    expect(replayState.game?.board, List<Player?>.filled(9, null));
    expect(fakeGameRepository.saveCalls, saveCallsBeforeSecondReplay);
  });

  test('playAgain is ignored while game is still playing', () async {
    final container = createContainer();
    addTearDown(container.dispose);
    keepGameNotifierAlive(container);
    final notifier = container.read(
      gameNotifierProvider(GameEntryMode.newGame).notifier,
    );

    await notifier.playMove(cellIndex: 0);
    final saveCallsBeforeReplay = fakeGameRepository.saveCalls;
    final boardBeforeReplay = List<Player?>.from(
      container.read(gameNotifierProvider(GameEntryMode.newGame)).game?.board ??
          List<Player?>.filled(9, null),
    );

    await notifier.playAgain();

    final state = container.read(gameNotifierProvider(GameEntryMode.newGame));
    expect(state.game?.board, boardBeforeReplay);
    expect(fakeGameRepository.saveCalls, saveCallsBeforeReplay);
  });

  test('playAgain reverts cpu move when save fails after cpu opens', () async {
    final container = createContainer();
    addTearDown(container.dispose);
    keepGameNotifierAlive(container);
    final notifier = container.read(
      gameNotifierProvider(GameEntryMode.newGame).notifier,
    );

    await notifier.playMove(cellIndex: 0);
    await notifier.playMove(cellIndex: 3);
    await notifier.playMove(cellIndex: 6);

    fakeGameRepository.shouldFailSave = true;
    await notifier.playAgain();
    await Future<void>.delayed(const Duration(milliseconds: 450));

    final state = container.read(gameNotifierProvider(GameEntryMode.newGame));
    expect(state.game?.board, List<Player?>.filled(9, null));
    expect(state.game?.currentPlayer, Player.o);
    expect(state.error, isA<StorageWriteError>());
  });

  test('playAgain ignores concurrent calls', () async {
    final container = createContainer();
    addTearDown(container.dispose);
    keepGameNotifierAlive(container);
    final notifier = container.read(
      gameNotifierProvider(GameEntryMode.newGame).notifier,
    );

    await notifier.playMove(cellIndex: 0);
    await notifier.playMove(cellIndex: 3);
    await notifier.playMove(cellIndex: 6);

    final firstReplay = notifier.playAgain();
    await notifier.playAgain();
    await firstReplay;
    await Future<void>.delayed(const Duration(milliseconds: 450));

    final state = container.read(gameNotifierProvider(GameEntryMode.newGame));
    expect(state.isPlayAgainInProgress, isFalse);
    expect(state.game?.status, GameStatus.playing);
    expect(state.game?.board.where((cell) => cell == Player.o).length, 1);
  });
}
