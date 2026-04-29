import 'package:cloud_firestore/cloud_firestore.dart';

class CategorySeeder {
  static Future<void> seedDefaultCategories(String userId) async {
    final firestore = FirebaseFirestore.instance;
    final categoriesRef = firestore
        .collection('users')
        .doc(userId)
        .collection('categories');

    final defaultCategories = [
      {'name': 'Comida', 'icon': 'restaurant', 'color': 0xFFFF7675},
      {'name': 'Transporte', 'icon': 'directions_car', 'color': 0xFF74B9FF},
      {'name': 'Ocio', 'icon': 'sports_esports', 'color': 0xFFA29BFE},
      {'name': 'Salud', 'icon': 'favorite', 'color': 0xFF55EFC4},
      {'name': 'Hogar', 'icon': 'home', 'color': 0xFFFDCB6E},
      {'name': 'Ropa', 'icon': 'checkroom', 'color': 0xFFE17055},
      {'name': 'Educacion', 'icon': 'school', 'color': 0xFF00B894},
      {'name': 'Otros', 'icon': 'category', 'color': 0xFFB2BEC3},
    ];

    final batch = firestore.batch();
    for (final category in defaultCategories) {
      final doc = categoriesRef.doc();
      batch.set(doc, {
        ...category,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
    await batch.commit();
  }
}