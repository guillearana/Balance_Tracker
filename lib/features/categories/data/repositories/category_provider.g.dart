// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categoryRepositoryHash() =>
    r'2c639f6980a7270515ebbdc08e1c3a4bf104027f';

/// See also [categoryRepository].
@ProviderFor(categoryRepository)
final categoryRepositoryProvider =
    AutoDisposeProvider<CategoryRepository>.internal(
      categoryRepository,
      name: r'categoryRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$categoryRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategoryRepositoryRef = AutoDisposeProviderRef<CategoryRepository>;
String _$defaultCategoriesHash() => r'c8ca0ef9314a35a48bdc3a48db15ed45e2108e7b';

/// See also [defaultCategories].
@ProviderFor(defaultCategories)
final defaultCategoriesProvider =
    AutoDisposeStreamProvider<List<CategoryModel>>.internal(
      defaultCategories,
      name: r'defaultCategoriesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$defaultCategoriesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DefaultCategoriesRef =
    AutoDisposeStreamProviderRef<List<CategoryModel>>;
String _$userCategoriesHash() => r'c304a73268842a06285a932fc3b205b48225bee6';

/// See also [userCategories].
@ProviderFor(userCategories)
final userCategoriesProvider =
    AutoDisposeStreamProvider<List<CategoryModel>>.internal(
      userCategories,
      name: r'userCategoriesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$userCategoriesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserCategoriesRef = AutoDisposeStreamProviderRef<List<CategoryModel>>;
String _$allCategoriesHash() => r'34c635c789bce0770907d28b4d6afabe3c34253c';

/// See also [allCategories].
@ProviderFor(allCategories)
final allCategoriesProvider =
    AutoDisposeStreamProvider<List<CategoryModel>>.internal(
      allCategories,
      name: r'allCategoriesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allCategoriesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllCategoriesRef = AutoDisposeStreamProviderRef<List<CategoryModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
