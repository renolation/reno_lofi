// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_library_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listLibraryProviderHash() =>
    r'8b1128163176d28f1e83b53d7712618cfbdefd22';

/// See also [ListLibraryProvider].
@ProviderFor(ListLibraryProvider)
final listLibraryProviderProvider = AutoDisposeAsyncNotifierProvider<
    ListLibraryProvider, List<LibraryEntity>>.internal(
  ListLibraryProvider.new,
  name: r'listLibraryProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$listLibraryProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ListLibraryProvider = AutoDisposeAsyncNotifier<List<LibraryEntity>>;
String _$selectingLibraryControllerHash() =>
    r'a60de686234956573964eddd6a80cb642014aa7e';

/// See also [SelectingLibraryController].
@ProviderFor(SelectingLibraryController)
final selectingLibraryControllerProvider =
    NotifierProvider<SelectingLibraryController, LibraryEntity?>.internal(
  SelectingLibraryController.new,
  name: r'selectingLibraryControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectingLibraryControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectingLibraryController = Notifier<LibraryEntity?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
