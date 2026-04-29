import 'package:balance_tracker/features/categories/domain/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<CategoryModel>> watchDefaultCategories() {
    return _firestore
        .collection('categories')
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => CategoryModel.fromFirestore(doc))
            .toList());
  }

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

  Future<void> deleteUserCategory(String userId, String categoryId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .doc(categoryId)
        .delete();
  }

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