// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$debtRepositoryHash() => r'c8c7c2cbd476bab56f22a72ba1becc4b34e5e645';

/// See also [debtRepository].
@ProviderFor(debtRepository)
final debtRepositoryProvider = AutoDisposeProvider<DebtRepository>.internal(
  debtRepository,
  name: r'debtRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$debtRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DebtRepositoryRef = AutoDisposeProviderRef<DebtRepository>;
String _$debtsHash() => r'abe20cf552fb82052c253fb42e92d3bc1db543c4';

/// See also [debts].
@ProviderFor(debts)
final debtsProvider = AutoDisposeStreamProvider<List<DebtModel>>.internal(
  debts,
  name: r'debtsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$debtsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DebtsRef = AutoDisposeStreamProviderRef<List<DebtModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
