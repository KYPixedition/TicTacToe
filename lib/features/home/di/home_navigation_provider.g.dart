// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_navigation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeNavigation)
final homeNavigationProvider = HomeNavigationProvider._();

final class HomeNavigationProvider
    extends $FunctionalProvider<HomeNavigation, HomeNavigation, HomeNavigation>
    with $Provider<HomeNavigation> {
  HomeNavigationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeNavigationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeNavigationHash();

  @$internal
  @override
  $ProviderElement<HomeNavigation> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HomeNavigation create(Ref ref) {
    return homeNavigation(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeNavigation value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeNavigation>(value),
    );
  }
}

String _$homeNavigationHash() => r'7f0f57d8b780601ddbc8ddcd211fc39fce9b7b13';
