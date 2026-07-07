// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Manages game screen state and user commands.

@ProviderFor(GameNotifier)
final gameNotifierProvider = GameNotifierFamily._();

/// Manages game screen state and user commands.
final class GameNotifierProvider
    extends $NotifierProvider<GameNotifier, GameState> {
  /// Manages game screen state and user commands.
  GameNotifierProvider._({
    required GameNotifierFamily super.from,
    required GameEntryMode super.argument,
  }) : super(
         retry: null,
         name: r'gameNotifierProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$gameNotifierHash();

  @override
  String toString() {
    return r'gameNotifierProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  GameNotifier create() => GameNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GameState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GameState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GameNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$gameNotifierHash() => r'e4e3dd56f7fa6c5fc4c523b6228c312abdb35d8e';

/// Manages game screen state and user commands.

final class GameNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          GameNotifier,
          GameState,
          GameState,
          GameState,
          GameEntryMode
        > {
  GameNotifierFamily._()
    : super(
        retry: null,
        name: r'gameNotifierProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Manages game screen state and user commands.

  GameNotifierProvider call(GameEntryMode entryMode) =>
      GameNotifierProvider._(argument: entryMode, from: this);

  @override
  String toString() => r'gameNotifierProvider';
}

/// Manages game screen state and user commands.

abstract class _$GameNotifier extends $Notifier<GameState> {
  late final _$args = ref.$arg as GameEntryMode;
  GameEntryMode get entryMode => _$args;

  GameState build(GameEntryMode entryMode);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<GameState, GameState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GameState, GameState>,
              GameState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
