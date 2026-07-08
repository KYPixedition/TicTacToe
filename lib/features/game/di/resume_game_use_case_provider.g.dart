// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_game_use_case_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [ResumeGameUseCase].

@ProviderFor(resumeGameUseCase)
final resumeGameUseCaseProvider = ResumeGameUseCaseProvider._();

/// Provides the [ResumeGameUseCase].

final class ResumeGameUseCaseProvider
    extends
        $FunctionalProvider<
          ResumeGameUseCase,
          ResumeGameUseCase,
          ResumeGameUseCase
        >
    with $Provider<ResumeGameUseCase> {
  /// Provides the [ResumeGameUseCase].
  ResumeGameUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resumeGameUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resumeGameUseCaseHash();

  @$internal
  @override
  $ProviderElement<ResumeGameUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ResumeGameUseCase create(Ref ref) {
    return resumeGameUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResumeGameUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResumeGameUseCase>(value),
    );
  }
}

String _$resumeGameUseCaseHash() => r'd143412145824ad41fdce278a45166a3c534530c';
