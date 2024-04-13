// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_screen_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameScreenControllerHash() =>
    r'a71b4570f53cea977ded80551717161916b2ccad';

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

abstract class _$GameScreenController
    extends BuildlessAutoDisposeNotifier<GameState> {
  late final GameStartData gameStartData;

  GameState build(
    GameStartData gameStartData,
  );
}

/// See also [GameScreenController].
@ProviderFor(GameScreenController)
const gameScreenControllerProvider = GameScreenControllerFamily();

/// See also [GameScreenController].
class GameScreenControllerFamily extends Family<GameState> {
  /// See also [GameScreenController].
  const GameScreenControllerFamily();

  /// See also [GameScreenController].
  GameScreenControllerProvider call(
    GameStartData gameStartData,
  ) {
    return GameScreenControllerProvider(
      gameStartData,
    );
  }

  @override
  GameScreenControllerProvider getProviderOverride(
    covariant GameScreenControllerProvider provider,
  ) {
    return call(
      provider.gameStartData,
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
  String? get name => r'gameScreenControllerProvider';
}

/// See also [GameScreenController].
class GameScreenControllerProvider
    extends AutoDisposeNotifierProviderImpl<GameScreenController, GameState> {
  /// See also [GameScreenController].
  GameScreenControllerProvider(
    GameStartData gameStartData,
  ) : this._internal(
          () => GameScreenController()..gameStartData = gameStartData,
          from: gameScreenControllerProvider,
          name: r'gameScreenControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$gameScreenControllerHash,
          dependencies: GameScreenControllerFamily._dependencies,
          allTransitiveDependencies:
              GameScreenControllerFamily._allTransitiveDependencies,
          gameStartData: gameStartData,
        );

  GameScreenControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.gameStartData,
  }) : super.internal();

  final GameStartData gameStartData;

  @override
  GameState runNotifierBuild(
    covariant GameScreenController notifier,
  ) {
    return notifier.build(
      gameStartData,
    );
  }

  @override
  Override overrideWith(GameScreenController Function() create) {
    return ProviderOverride(
      origin: this,
      override: GameScreenControllerProvider._internal(
        () => create()..gameStartData = gameStartData,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        gameStartData: gameStartData,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<GameScreenController, GameState>
      createElement() {
    return _GameScreenControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GameScreenControllerProvider &&
        other.gameStartData == gameStartData;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, gameStartData.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GameScreenControllerRef on AutoDisposeNotifierProviderRef<GameState> {
  /// The parameter `gameStartData` of this provider.
  GameStartData get gameStartData;
}

class _GameScreenControllerProviderElement
    extends AutoDisposeNotifierProviderElement<GameScreenController, GameState>
    with GameScreenControllerRef {
  _GameScreenControllerProviderElement(super.provider);

  @override
  GameStartData get gameStartData =>
      (origin as GameScreenControllerProvider).gameStartData;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
