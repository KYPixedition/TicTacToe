import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../fakes/fake_game_repository.dart';
import 'package:tictactoe/features/home/di/has_saved_game_use_case_provider.dart';
import 'package:tictactoe/features/home/di/home_navigation_provider.dart';
import 'package:tictactoe/features/home/domain/usecases/has_saved_game_use_case.dart';
import 'package:tictactoe/features/home/navigation/home_navigation.dart';
import 'package:tictactoe/features/home/presentation/notifiers/home_notifier.dart';

class MockHomeNavigation extends Mock implements HomeNavigation {}

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

    container.read(homeNotifierProvider.notifier).openNewGame();

    verify(mockNavigation.openNewGame()).called(1);
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

  test('openResumeGame does nothing when resume is disabled', () {
    repository.hasSavedGame = false;

    final container = createContainer();
    addTearDown(container.dispose);

    container.read(homeNotifierProvider.notifier).openResumeGame();

    verifyNever(mockNavigation.openResumeGame());
  });
}
