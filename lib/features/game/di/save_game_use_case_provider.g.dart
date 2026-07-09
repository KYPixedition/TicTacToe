// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_game_use_case_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveGameUseCase)
final saveGameUseCaseProvider = SaveGameUseCaseProvider._();

final class SaveGameUseCaseProvider
    extends
        $FunctionalProvider<SaveGameUseCase, SaveGameUseCase, SaveGameUseCase>
    with $Provider<SaveGameUseCase> {
  SaveGameUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveGameUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveGameUseCaseHash();

  @$internal
  @override
  $ProviderElement<SaveGameUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SaveGameUseCase create(Ref ref) {
    return saveGameUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveGameUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveGameUseCase>(value),
    );
  }
}

String _$saveGameUseCaseHash() => r'448e51a63f321650ff926d2007bdfd98e826b579';
