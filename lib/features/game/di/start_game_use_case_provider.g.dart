// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_game_use_case_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [StartGameUseCase].

@ProviderFor(startGameUseCase)
final startGameUseCaseProvider = StartGameUseCaseProvider._();

/// Provides the [StartGameUseCase].

final class StartGameUseCaseProvider
    extends
        $FunctionalProvider<
          StartGameUseCase,
          StartGameUseCase,
          StartGameUseCase
        >
    with $Provider<StartGameUseCase> {
  /// Provides the [StartGameUseCase].
  StartGameUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'startGameUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$startGameUseCaseHash();

  @$internal
  @override
  $ProviderElement<StartGameUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StartGameUseCase create(Ref ref) {
    return startGameUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StartGameUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StartGameUseCase>(value),
    );
  }
}

String _$startGameUseCaseHash() => r'049e4b75cc325a37cd0e0c2419345d7bdf7b655b';
