import 'package:balance_tracker/features/categories/domain/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Repositorio que gestiona el acceso a datos de categorías en Firestore.
///
/// Utiliza dos colecciones:
/// - `categories` — categorías globales predeterminadas del sistema.
/// - `users/{userId}/categories` — categorías personalizadas del usuario.
class CategoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Devuelve un stream con las categorías globales predeterminadas del sistema.
  ///
  /// Colección Firestore: `categories`
  Stream<List<CategoryModel>> watchDefaultCategories() {
    return _firestore
        .collection('categories')
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => CategoryModel.fromFirestore(doc))
            .toList());
  }

  /// Devuelve un stream con las categorías personalizadas del usuario [userId].
  ///
  /// Colección Firestore: `users/{userId}/categories`
  Stream<List<CategoryModel>> watchUserCategories(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => CategoryModel.fromFirestore(doc))
            .toList());
  }

  /// Guarda una nueva [category] personalizada para el usuario [userId].
  ///
  /// Fuerza `isDefault` a `false` y asocia el `userId` al documento.
  /// Colección Firestore: `users/{userId}/categories`
  Future<void> addUserCategory(String userId, CategoryModel category) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .doc(category.id)
        .set({
      'name': category.name,
      'icon': category.icon,
      'color': category.color,
      'isDefault': false,
      'type': category.type,
      'userId': userId,
    });
  }

  /// Elimina la categoría [categoryId] del usuario [userId].
  ///
  /// Colección Firestore: `users/{userId}/categories`
  Future<void> deleteUserCategory(String userId, String categoryId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .doc(categoryId)
        .delete();
  }

  /// Inserta el conjunto de categorías predeterminadas del sistema en la
  /// colección global `categories` mediante un batch write.
  ///
  /// Colección Firestore: `categories`
  Future<void> seedDefaultCategories() async {
    final categories = [
      {'name': 'Comida', 'icon': 'restaurant', 'color': '#FF6B6B', 'type': 'expense'},
      {'name': 'Transporte', 'icon': 'directions_car', 'color': '#4ECDC4', 'type': 'expense'},
      {'name': 'Vivienda', 'icon': 'home', 'color': '#45B7D1', 'type': 'expense'},
      {'name': 'Suscripciones', 'icon': 'subscriptions', 'color': '#96CEB4', 'type': 'expense'},
      {'name': 'Ocio', 'icon': 'sports_esports', 'color': '#FFEAA7', 'type': 'expense'},
      {'name': 'Salud', 'icon': 'favorite', 'color': '#DDA0DD', 'type': 'expense'},
      {'name': 'Ropa', 'icon': 'checkroom', 'color': '#F0A500', 'type': 'expense'},
      {'name': 'Educación', 'icon': 'school', 'color': '#74B9FF', 'type': 'expense'},
      {'name': 'Otros', 'icon': 'category', 'color': '#B2BEB5', 'type': 'expense'},
      {'name': 'Sueldo', 'icon': 'work', 'color': '#55EFC4', 'type': 'income'},
      {'name': 'Extra', 'icon': 'star', 'color': '#FDCB6E', 'type': 'income'},
      {'name': 'Regalo', 'icon': 'card_giftcard', 'color': '#FD79A8', 'type': 'income'},
      {'name': 'Otros ingresos', 'icon': 'attach_money', 'color': '#00CEC9', 'type': 'income'},
    ];

    final batch = _firestore.batch();
    for (final cat in categories) {
      final ref = _firestore.collection('categories').doc();
      batch.set(ref, {'isDefault': true, ...cat});
    }
    await batch.commit();
  }
}
