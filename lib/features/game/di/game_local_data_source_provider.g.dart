// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_local_data_source_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the local game data source.

@ProviderFor(gameLocalDataSource)
final gameLocalDataSourceProvider = GameLocalDataSourceProvider._();

/// Provides the local game data source.

final class GameLocalDataSourceProvider
    extends
        $FunctionalProvider<
          GameLocalDataSource,
          GameLocalDataSource,
          GameLocalDataSource
        >
    with $Provider<GameLocalDataSource> {
  /// Provides the local game data source.
  GameLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gameLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gameLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<GameLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GameLocalDataSource create(Ref ref) {
    return gameLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GameLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GameLocalDataSource>(value),
    );
  }
}

String _$gameLocalDataSourceHash() =>
    r'7b375819ca79c2fa73b5930697ba53a0a508f562';
