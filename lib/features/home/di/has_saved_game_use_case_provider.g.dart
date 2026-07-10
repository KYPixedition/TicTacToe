// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'has_saved_game_use_case_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(hasSavedGameUseCase)
final hasSavedGameUseCaseProvider = HasSavedGameUseCaseProvider._();

final class HasSavedGameUseCaseProvider
    extends
        $FunctionalProvider<
          HasSavedGameUseCase,
          HasSavedGameUseCase,
          HasSavedGameUseCase
        >
    with $Provider<HasSavedGameUseCase> {
  HasSavedGameUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hasSavedGameUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hasSavedGameUseCaseHash();

  @$internal
  @override
  $ProviderElement<HasSavedGameUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HasSavedGameUseCase create(Ref ref) {
    return hasSavedGameUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HasSavedGameUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HasSavedGameUseCase>(value),
    );
  }
}

String _$hasSavedGameUseCaseHash() =>
    r'3d77fd5d1bf67f236cf785eca3836bc9f3632652';
