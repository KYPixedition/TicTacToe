// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_cpu_move_use_case_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(playCpuMoveUseCase)
final playCpuMoveUseCaseProvider = PlayCpuMoveUseCaseProvider._();

final class PlayCpuMoveUseCaseProvider
    extends
        $FunctionalProvider<
          PlayCpuMoveUseCase,
          PlayCpuMoveUseCase,
          PlayCpuMoveUseCase
        >
    with $Provider<PlayCpuMoveUseCase> {
  PlayCpuMoveUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playCpuMoveUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playCpuMoveUseCaseHash();

  @$internal
  @override
  $ProviderElement<PlayCpuMoveUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PlayCpuMoveUseCase create(Ref ref) {
    return playCpuMoveUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlayCpuMoveUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlayCpuMoveUseCase>(value),
    );
  }
}

String _$playCpuMoveUseCaseHash() =>
    r'4be8ed6c755ee8c8f60105bac180b59ae513971a';
