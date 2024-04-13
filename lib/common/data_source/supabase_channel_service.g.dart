// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supabase_channel_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$supabaseChannelServiceHash() =>
    r'fe8486bd9247776cfc2ebaeeb94fa49d7930796a';

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

abstract class _$SupabaseChannelService
    extends BuildlessNotifier<RealtimeChannel> {
  late final String channelName;

  RealtimeChannel build(
    String channelName,
  );
}

/// See also [SupabaseChannelService].
@ProviderFor(SupabaseChannelService)
const supabaseChannelServiceProvider = SupabaseChannelServiceFamily();

/// See also [SupabaseChannelService].
class SupabaseChannelServiceFamily extends Family<RealtimeChannel> {
  /// See also [SupabaseChannelService].
  const SupabaseChannelServiceFamily();

  /// See also [SupabaseChannelService].
  SupabaseChannelServiceProvider call(
    String channelName,
  ) {
    return SupabaseChannelServiceProvider(
      channelName,
    );
  }

  @override
  SupabaseChannelServiceProvider getProviderOverride(
    covariant SupabaseChannelServiceProvider provider,
  ) {
    return call(
      provider.channelName,
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
  String? get name => r'supabaseChannelServiceProvider';
}

/// See also [SupabaseChannelService].
class SupabaseChannelServiceProvider
    extends NotifierProviderImpl<SupabaseChannelService, RealtimeChannel> {
  /// See also [SupabaseChannelService].
  SupabaseChannelServiceProvider(
    String channelName,
  ) : this._internal(
          () => SupabaseChannelService()..channelName = channelName,
          from: supabaseChannelServiceProvider,
          name: r'supabaseChannelServiceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$supabaseChannelServiceHash,
          dependencies: SupabaseChannelServiceFamily._dependencies,
          allTransitiveDependencies:
              SupabaseChannelServiceFamily._allTransitiveDependencies,
          channelName: channelName,
        );

  SupabaseChannelServiceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.channelName,
  }) : super.internal();

  final String channelName;

  @override
  RealtimeChannel runNotifierBuild(
    covariant SupabaseChannelService notifier,
  ) {
    return notifier.build(
      channelName,
    );
  }

  @override
  Override overrideWith(SupabaseChannelService Function() create) {
    return ProviderOverride(
      origin: this,
      override: SupabaseChannelServiceProvider._internal(
        () => create()..channelName = channelName,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        channelName: channelName,
      ),
    );
  }

  @override
  NotifierProviderElement<SupabaseChannelService, RealtimeChannel>
      createElement() {
    return _SupabaseChannelServiceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SupabaseChannelServiceProvider &&
        other.channelName == channelName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, channelName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SupabaseChannelServiceRef on NotifierProviderRef<RealtimeChannel> {
  /// The parameter `channelName` of this provider.
  String get channelName;
}

class _SupabaseChannelServiceProviderElement
    extends NotifierProviderElement<SupabaseChannelService, RealtimeChannel>
    with SupabaseChannelServiceRef {
  _SupabaseChannelServiceProviderElement(super.provider);

  @override
  String get channelName =>
      (origin as SupabaseChannelServiceProvider).channelName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
