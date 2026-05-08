import 'package:balance_tracker/features/auth/providers/auth_provider.dart';
import 'package:balance_tracker/features/categories/data/repositories/category_repository.dart';
import 'package:balance_tracker/features/categories/domain/models/category_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_provider.g.dart';

/// Expone una instancia singleton de [CategoryRepository].
@riverpod
CategoryRepository categoryRepository(CategoryRepositoryRef ref) {
  return CategoryRepository();
}

/// Expone un stream con las categorías predeterminadas del sistema.
///
/// Utiliza [categoryRepositoryProvider].
@riverpod
Stream<List<CategoryModel>> defaultCategories(DefaultCategoriesRef ref) {
  return ref.watch(categoryRepositoryProvider).watchDefaultCategories();
}

/// Expone un stream con las categorías personalizadas del usuario autenticado.
///
/// Devuelve un stream vacío si no hay usuario activo.
/// Utiliza [categoryRepositoryProvider] y [currentUserProvider].
@riverpod
Stream<List<CategoryModel>> userCategories(UserCategoriesRef ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value([]);
  return ref.watch(categoryRepositoryProvider).watchUserCategories(user.uid);
}

/// Expone un stream con la unión de categorías predeterminadas y del usuario.
///
/// Combina los valores actuales de [defaultCategoriesProvider] y
/// [userCategoriesProvider]. Usa listas vacías como fallback si alguno
/// aún no tiene valor.
@riverpod
Stream<List<CategoryModel>> allCategories(AllCategoriesRef ref) {
  final defaults = ref.watch(defaultCategoriesProvider);
  final userCats = ref.watch(userCategoriesProvider);

  final defaultList = defaults.valueOrNull ?? [];
  final userList = userCats.valueOrNull ?? [];

  return Stream.value([...defaultList, ...userList]);
}
