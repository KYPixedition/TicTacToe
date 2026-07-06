// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_navigation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [GameNavigation] implementation.

@ProviderFor(gameNavigation)
final gameNavigationProvider = GameNavigationProvider._();

/// Provides the [GameNavigation] implementation.

final class GameNavigationProvider
    extends $FunctionalProvider<GameNavigation, GameNavigation, GameNavigation>
    with $Provider<GameNavigation> {
  /// Provides the [GameNavigation] implementation.
  GameNavigationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gameNavigationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gameNavigationHash();

  @$internal
  @override
  $ProviderElement<GameNavigation> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GameNavigation create(Ref ref) {
    return gameNavigation(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GameNavigation value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GameNavigation>(value),
    );
  }
}

String _$gameNavigationHash() => r'b77887ccac1c457b2de45cd4adce9f8167d291ef';
