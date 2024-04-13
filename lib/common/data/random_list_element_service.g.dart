// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'random_list_element_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getRandomElementFromListHash() =>
    r'1841fb40fc91a517022d9f53e4a7eb9e4da3cb57';

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

/// See also [getRandomElementFromList].
@ProviderFor(getRandomElementFromList)
const getRandomElementFromListProvider = GetRandomElementFromListFamily();

/// See also [getRandomElementFromList].
class GetRandomElementFromListFamily extends Family<String> {
  /// See also [getRandomElementFromList].
  const GetRandomElementFromListFamily();

  /// See also [getRandomElementFromList].
  GetRandomElementFromListProvider call(
    List<String> list,
  ) {
    return GetRandomElementFromListProvider(
      list,
    );
  }

  @override
  GetRandomElementFromListProvider getProviderOverride(
    covariant GetRandomElementFromListProvider provider,
  ) {
    return call(
      provider.list,
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
  String? get name => r'getRandomElementFromListProvider';
}

/// See also [getRandomElementFromList].
class GetRandomElementFromListProvider extends AutoDisposeProvider<String> {
  /// See also [getRandomElementFromList].
  GetRandomElementFromListProvider(
    List<String> list,
  ) : this._internal(
          (ref) => getRandomElementFromList(
            ref as GetRandomElementFromListRef,
            list,
          ),
          from: getRandomElementFromListProvider,
          name: r'getRandomElementFromListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getRandomElementFromListHash,
          dependencies: GetRandomElementFromListFamily._dependencies,
          allTransitiveDependencies:
              GetRandomElementFromListFamily._allTransitiveDependencies,
          list: list,
        );

  GetRandomElementFromListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.list,
  }) : super.internal();

  final List<String> list;

  @override
  Override overrideWith(
    String Function(GetRandomElementFromListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetRandomElementFromListProvider._internal(
        (ref) => create(ref as GetRandomElementFromListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        list: list,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String> createElement() {
    return _GetRandomElementFromListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetRandomElementFromListProvider && other.list == list;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, list.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetRandomElementFromListRef on AutoDisposeProviderRef<String> {
  /// The parameter `list` of this provider.
  List<String> get list;
}

class _GetRandomElementFromListProviderElement
    extends AutoDisposeProviderElement<String>
    with GetRandomElementFromListRef {
  _GetRandomElementFromListProviderElement(super.provider);

  @override
  List<String> get list => (origin as GetRandomElementFromListProvider).list;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
