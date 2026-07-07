// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_move_use_case_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [PlayMoveUseCase].

@ProviderFor(playMoveUseCase)
final playMoveUseCaseProvider = PlayMoveUseCaseProvider._();

/// Provides the [PlayMoveUseCase].

final class PlayMoveUseCaseProvider
    extends
        $FunctionalProvider<PlayMoveUseCase, PlayMoveUseCase, PlayMoveUseCase>
    with $Provider<PlayMoveUseCase> {
  /// Provides the [PlayMoveUseCase].
  PlayMoveUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playMoveUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playMoveUseCaseHash();

  @$internal
  @override
  $ProviderElement<PlayMoveUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PlayMoveUseCase create(Ref ref) {
    return playMoveUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlayMoveUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlayMoveUseCase>(value),
    );
  }
}

String _$playMoveUseCaseHash() => r'd5c8563d02c113866ada93c0bc629a74c08719cc';
