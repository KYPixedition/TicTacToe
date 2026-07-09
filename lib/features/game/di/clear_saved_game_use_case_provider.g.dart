// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clear_saved_game_use_case_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(clearSavedGameUseCase)
final clearSavedGameUseCaseProvider = ClearSavedGameUseCaseProvider._();

final class ClearSavedGameUseCaseProvider
    extends
        $FunctionalProvider<
          ClearSavedGameUseCase,
          ClearSavedGameUseCase,
          ClearSavedGameUseCase
        >
    with $Provider<ClearSavedGameUseCase> {
  ClearSavedGameUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clearSavedGameUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clearSavedGameUseCaseHash();

  @$internal
  @override
  $ProviderElement<ClearSavedGameUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ClearSavedGameUseCase create(Ref ref) {
    return clearSavedGameUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClearSavedGameUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClearSavedGameUseCase>(value),
    );
  }
}

String _$clearSavedGameUseCaseHash() =>
    r'9e840c55a9e8cbf9bd28e4cb94f847b07d568cdc';
