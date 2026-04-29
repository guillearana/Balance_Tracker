// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transactionRepositoryHash() =>
    r'c2847b825170bbc3b692461530c126430d879de0';

/// See also [transactionRepository].
@ProviderFor(transactionRepository)
final transactionRepositoryProvider =
    AutoDisposeProvider<TransactionRepository>.internal(
      transactionRepository,
      name: r'transactionRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$transactionRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TransactionRepositoryRef =
    AutoDisposeProviderRef<TransactionRepository>;
String _$transactionsHash() => r'2d7a637f7395499b1b3bfd5bf6613c371c208f31';

/// See also [transactions].
@ProviderFor(transactions)
final transactionsProvider =
    AutoDisposeStreamProvider<List<TransactionModel>>.internal(
      transactions,
      name: r'transactionsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$transactionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TransactionsRef = AutoDisposeStreamProviderRef<List<TransactionModel>>;
String _$transactionsByMonthHash() =>
    r'0d0da6658292b1bba3855ed612a6a3de6be28745';

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

/// See also [transactionsByMonth].
@ProviderFor(transactionsByMonth)
const transactionsByMonthProvider = TransactionsByMonthFamily();

/// See also [transactionsByMonth].
class TransactionsByMonthFamily
    extends Family<AsyncValue<List<TransactionModel>>> {
  /// See also [transactionsByMonth].
  const TransactionsByMonthFamily();

  /// See also [transactionsByMonth].
  TransactionsByMonthProvider call(int year, int month) {
    return TransactionsByMonthProvider(year, month);
  }

  @override
  TransactionsByMonthProvider getProviderOverride(
    covariant TransactionsByMonthProvider provider,
  ) {
    return call(provider.year, provider.month);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'transactionsByMonthProvider';
}

/// See also [transactionsByMonth].
class TransactionsByMonthProvider
    extends AutoDisposeFutureProvider<List<TransactionModel>> {
  /// See also [transactionsByMonth].
  TransactionsByMonthProvider(int year, int month)
    : this._internal(
        (ref) =>
            transactionsByMonth(ref as TransactionsByMonthRef, year, month),
        from: transactionsByMonthProvider,
        name: r'transactionsByMonthProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$transactionsByMonthHash,
        dependencies: TransactionsByMonthFamily._dependencies,
        allTransitiveDependencies:
            TransactionsByMonthFamily._allTransitiveDependencies,
        year: year,
        month: month,
      );

  TransactionsByMonthProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.year,
    required this.month,
  }) : super.internal();

  final int year;
  final int month;

  @override
  Override overrideWith(
    FutureOr<List<TransactionModel>> Function(TransactionsByMonthRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TransactionsByMonthProvider._internal(
        (ref) => create(ref as TransactionsByMonthRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        year: year,
        month: month,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<TransactionModel>> createElement() {
    return _TransactionsByMonthProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TransactionsByMonthProvider &&
        other.year == year &&
        other.month == month;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TransactionsByMonthRef
    on AutoDisposeFutureProviderRef<List<TransactionModel>> {
  /// The parameter `year` of this provider.
  int get year;

  /// The parameter `month` of this provider.
  int get month;
}

class _TransactionsByMonthProviderElement
    extends AutoDisposeFutureProviderElement<List<TransactionModel>>
    with TransactionsByMonthRef {
  _TransactionsByMonthProviderElement(super.provider);

  @override
  int get year => (origin as TransactionsByMonthProvider).year;
  @override
  int get month => (origin as TransactionsByMonthProvider).month;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
