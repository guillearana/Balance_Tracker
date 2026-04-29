import 'package:balance_tracker/features/auth/providers/auth_provider.dart';
import 'package:balance_tracker/features/categories/data/repositories/category_repository.dart';
import 'package:balance_tracker/features/categories/domain/models/category_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_provider.g.dart';

@riverpod
CategoryRepository categoryRepository(CategoryRepositoryRef ref) {
  return CategoryRepository();
}

@riverpod
Stream<List<CategoryModel>> defaultCategories(DefaultCategoriesRef ref) {
  return ref.watch(categoryRepositoryProvider).watchDefaultCategories();
}

@riverpod
Stream<List<CategoryModel>> userCategories(UserCategoriesRef ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value([]);
  return ref.watch(categoryRepositoryProvider).watchUserCategories(user.uid);
}

@riverpod
Stream<List<CategoryModel>> allCategories(AllCategoriesRef ref) {
  final defaults = ref.watch(defaultCategoriesProvider);
  final userCats = ref.watch(userCategoriesProvider);

  final defaultList = defaults.valueOrNull ?? [];
  final userList = userCats.valueOrNull ?? [];

  return Stream.value([...defaultList, ...userList]);
}