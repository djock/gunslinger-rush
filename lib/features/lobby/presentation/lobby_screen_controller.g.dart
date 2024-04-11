// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lobby_screen_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lobbyScreenControllerHash() =>
    r'1a7781c2e20b69baf59b37ef5d181cd62732b934';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$LobbyScreenController
    extends BuildlessAutoDisposeAsyncNotifier<List<Player>> {
  late final Player player;

  FutureOr<List<Player>> build(
    Player player,
  );
}

/// See also [LobbyScreenController].
@ProviderFor(LobbyScreenController)
const lobbyScreenControllerProvider = LobbyScreenControllerFamily();

/// See also [LobbyScreenController].
class LobbyScreenControllerFamily extends Family<AsyncValue<List<Player>>> {
  /// See also [LobbyScreenController].
  const LobbyScreenControllerFamily();

  /// See also [LobbyScreenController].
  LobbyScreenControllerProvider call(
    Player player,
  ) {
    return LobbyScreenControllerProvider(
      player,
    );
  }

  @override
  LobbyScreenControllerProvider getProviderOverride(
    covariant LobbyScreenControllerProvider provider,
  ) {
    return call(
      provider.player,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'lobbyScreenControllerProvider';
}

/// See also [LobbyScreenController].
class LobbyScreenControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<LobbyScreenController,
        List<Player>> {
  /// See also [LobbyScreenController].
  LobbyScreenControllerProvider(
    Player player,
  ) : this._internal(
          () => LobbyScreenController()..player = player,
          from: lobbyScreenControllerProvider,
          name: r'lobbyScreenControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$lobbyScreenControllerHash,
          dependencies: LobbyScreenControllerFamily._dependencies,
          allTransitiveDependencies:
              LobbyScreenControllerFamily._allTransitiveDependencies,
          player: player,
        );

  LobbyScreenControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.player,
  }) : super.internal();

  final Player player;

  @override
  FutureOr<List<Player>> runNotifierBuild(
    covariant LobbyScreenController notifier,
  ) {
    return notifier.build(
      player,
    );
  }

  @override
  Override overrideWith(LobbyScreenController Function() create) {
    return ProviderOverride(
      origin: this,
      override: LobbyScreenControllerProvider._internal(
        () => create()..player = player,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        player: player,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<LobbyScreenController, List<Player>>
      createElement() {
    return _LobbyScreenControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LobbyScreenControllerProvider && other.player == player;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, player.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LobbyScreenControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<Player>> {
  /// The parameter `player` of this provider.
  Player get player;
}

class _LobbyScreenControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<LobbyScreenController,
        List<Player>> with LobbyScreenControllerRef {
  _LobbyScreenControllerProviderElement(super.provider);

  @override
  Player get player => (origin as LobbyScreenControllerProvider).player;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
