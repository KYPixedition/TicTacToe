import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tictactoe/core/result/result.dart';
import 'package:tictactoe/features/game/domain/entities/difficulty.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/repositories/game_repository.dart';
import '../../../../fakes/fake_game_repository.dart';
import 'package:tictactoe/features/home/di/has_saved_game_use_case_provider.dart';
import 'package:tictactoe/features/home/di/home_navigation_provider.dart';
import 'package:tictactoe/features/home/domain/usecases/has_saved_game_use_case.dart';
import 'package:tictactoe/features/home/navigation/home_navigation.dart';
import 'package:tictactoe/features/home/presentation/notifiers/home_notifier.dart';

class MockHomeNavigation extends Mock implements HomeNavigation {}

final class _DelayedGameRepository implements GameRepository {
  int _callCount = 0;

  @override
  Future<Result<bool>> hasValidSavedGame() async {
    _callCount++;
    if (_callCount == 1) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      return const Result.success(true);
    }

    return const Result.success(false);
  }

  @override
  Future<Result<Game?>> loadSavedGame() async {
    return const Result.success(null);
  }

  @override
  Future<Result<void>> saveGame({required Game game}) async {
    return const Result.success(null);
  }

  @override
  Future<Result<void>> clearSavedGame() async {
    return const Result.success(null);
  }
}

void main() {
  late FakeGameRepository repository;
  late MockHomeNavigation mockNavigation;

  setUp(() {
    repository = FakeGameRepository();
    mockNavigation = MockHomeNavigation();
  });

  ProviderContainer createContainer() {
    return ProviderContainer.test(
      overrides: [
        hasSavedGameUseCaseProvider.overrideWithValue(
          HasSavedGameUseCase(repository: repository),
        ),
        homeNavigationProvider.overrideWithValue(mockNavigation),
      ],
    );
  }

  test('starts with resume disabled before saved game check completes', () {
    repository.hasSavedGame = true;

    final container = createContainer();
    addTearDown(container.dispose);

    expect(container.read(homeNotifierProvider).isResumeEnabled, isFalse);
  });

  test('enables resume after saved game check when save exists', () async {
    repository.hasSavedGame = true;

    final container = createContainer();
    addTearDown(container.dispose);

    container.listen(homeNotifierProvider, (_, _) {}, fireImmediately: true);
    await pumpEventQueue();

    expect(container.read(homeNotifierProvider).isResumeEnabled, isTrue);
  });

  test('keeps resume disabled after check when no saved game exists', () async {
    repository.hasSavedGame = false;

    final container = createContainer();
    addTearDown(container.dispose);

    container.listen(homeNotifierProvider, (_, _) {}, fireImmediately: true);
    await pumpEventQueue();

    expect(container.read(homeNotifierProvider).isResumeEnabled, isFalse);
  });

  test('openNewGame delegates to navigation immediately', () {
    repository.hasSavedGame = false;

    final container = createContainer();
    addTearDown(container.dispose);

    container
        .read(homeNotifierProvider.notifier)
        .openNewGame(difficulty: Difficulty.hard);

    verify(mockNavigation.openNewGame(difficulty: Difficulty.hard)).called(1);
  });

  test(
    'openResumeGame delegates to navigation when resume is enabled',
    () async {
      repository.hasSavedGame = true;

      final container = createContainer();
      addTearDown(container.dispose);

      container.listen(homeNotifierProvider, (_, _) {}, fireImmediately: true);
      await pumpEventQueue();
      container.read(homeNotifierProvider.notifier).openResumeGame();

      verify(mockNavigation.openResumeGame()).called(1);
    },
  );

  test('refreshResumeAvailability disables resume after save is cleared', () async {
    repository.hasSavedGame = true;

    final container = createContainer();
    addTearDown(container.dispose);

    container.listen(homeNotifierProvider, (_, _) {}, fireImmediately: true);
    await pumpEventQueue();

    expect(container.read(homeNotifierProvider).isResumeEnabled, isTrue);

    repository.hasSavedGame = false;
    container.read(homeNotifierProvider.notifier).refreshResumeAvailability();
    await pumpEventQueue();

    expect(container.read(homeNotifierProvider).isResumeEnabled, isFalse);
  });

  test('ignores stale resume availability when a newer refresh completes first', () async {
    final delayedRepository = _DelayedGameRepository();

    final container = ProviderContainer.test(
      overrides: [
        hasSavedGameUseCaseProvider.overrideWithValue(
          HasSavedGameUseCase(repository: delayedRepository),
        ),
        homeNavigationProvider.overrideWithValue(mockNavigation),
      ],
    );
    addTearDown(container.dispose);

    container.listen(homeNotifierProvider, (_, _) {}, fireImmediately: true);
    container.read(homeNotifierProvider.notifier).refreshResumeAvailability();
    await pumpEventQueue();
    await Future<void>.delayed(const Duration(milliseconds: 150));
    await pumpEventQueue();

    expect(container.read(homeNotifierProvider).isResumeEnabled, isFalse);
  });

  test('openResumeGame does nothing when resume is disabled', () {
    repository.hasSavedGame = false;

    final container = createContainer();
    addTearDown(container.dispose);

    container.read(homeNotifierProvider.notifier).openResumeGame();

    verifyNever(mockNavigation.openResumeGame());
  });
}
