// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albums_libraries_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$albumsLibrariesProviderHash() =>
    r'ff31c8be1547b081db6f6377b883269ce89e6e0d';

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

abstract class _$AlbumsLibrariesProvider
    extends BuildlessAutoDisposeAsyncNotifier<List<ItemEntity>> {
  late final String libraryId;

  FutureOr<List<ItemEntity>> build(
    String libraryId,
  );
}

/// See also [AlbumsLibrariesProvider].
@ProviderFor(AlbumsLibrariesProvider)
const albumsLibrariesProviderProvider = AlbumsLibrariesProviderFamily();

/// See also [AlbumsLibrariesProvider].
class AlbumsLibrariesProviderFamily
    extends Family<AsyncValue<List<ItemEntity>>> {
  /// See also [AlbumsLibrariesProvider].
  const AlbumsLibrariesProviderFamily();

  /// See also [AlbumsLibrariesProvider].
  AlbumsLibrariesProviderProvider call(
    String libraryId,
  ) {
    return AlbumsLibrariesProviderProvider(
      libraryId,
    );
  }

  @override
  AlbumsLibrariesProviderProvider getProviderOverride(
    covariant AlbumsLibrariesProviderProvider provider,
  ) {
    return call(
      provider.libraryId,
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
  String? get name => r'albumsLibrariesProviderProvider';
}

/// See also [AlbumsLibrariesProvider].
class AlbumsLibrariesProviderProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AlbumsLibrariesProvider,
        List<ItemEntity>> {
  /// See also [AlbumsLibrariesProvider].
  AlbumsLibrariesProviderProvider(
    String libraryId,
  ) : this._internal(
          () => AlbumsLibrariesProvider()..libraryId = libraryId,
          from: albumsLibrariesProviderProvider,
          name: r'albumsLibrariesProviderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$albumsLibrariesProviderHash,
          dependencies: AlbumsLibrariesProviderFamily._dependencies,
          allTransitiveDependencies:
              AlbumsLibrariesProviderFamily._allTransitiveDependencies,
          libraryId: libraryId,
        );

  AlbumsLibrariesProviderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.libraryId,
  }) : super.internal();

  final String libraryId;

  @override
  FutureOr<List<ItemEntity>> runNotifierBuild(
    covariant AlbumsLibrariesProvider notifier,
  ) {
    return notifier.build(
      libraryId,
    );
  }

  @override
  Override overrideWith(AlbumsLibrariesProvider Function() create) {
    return ProviderOverride(
      origin: this,
      override: AlbumsLibrariesProviderProvider._internal(
        () => create()..libraryId = libraryId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        libraryId: libraryId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AlbumsLibrariesProvider,
      List<ItemEntity>> createElement() {
    return _AlbumsLibrariesProviderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AlbumsLibrariesProviderProvider &&
        other.libraryId == libraryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, libraryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AlbumsLibrariesProviderRef
    on AutoDisposeAsyncNotifierProviderRef<List<ItemEntity>> {
  /// The parameter `libraryId` of this provider.
  String get libraryId;
}

class _AlbumsLibrariesProviderProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AlbumsLibrariesProvider,
        List<ItemEntity>> with AlbumsLibrariesProviderRef {
  _AlbumsLibrariesProviderProviderElement(super.provider);

  @override
  String get libraryId => (origin as AlbumsLibrariesProviderProvider).libraryId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
