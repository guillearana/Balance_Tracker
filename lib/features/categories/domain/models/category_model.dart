import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

/// Modelo inmutable que representa una categoría de transacción.
@freezed
abstract class CategoryModel with _$CategoryModel {
  const CategoryModel._();

  /// Crea una instancia de [CategoryModel].
  ///
  /// - [id]: Identificador único de la categoría.
  /// - [name]: Nombre visible de la categoría.
  /// - [icon]: Nombre o código del icono que representa la categoría.
  /// - [color]: Color asociado a la categoría en formato string (ej. hex).
  /// - [isDefault]: Indica si la categoría es predeterminada del sistema. Por defecto `false`.
  /// - [type]: Tipo de categoría: `'expense'` o `'income'`. Por defecto `'expense'`.
  /// - [userId]: Identificador del usuario propietario; `null` si es categoría global.
  const factory CategoryModel({
    required String id,
    required String name,
    required String icon,
    required String color,
    @Default(false) bool isDefault,
    @Default('expense') String type,
    String? userId,
  }) = _CategoryModel;

  /// Crea un [CategoryModel] a partir de un mapa JSON.
  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  /// Crea un [CategoryModel] a partir de un [DocumentSnapshot] de Firestore.
  ///
  /// Inyecta el `id` del documento en el mapa de datos antes de delegar en [fromJson].
  static CategoryModel fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CategoryModel.fromJson({'id': doc.id, ...data});
  }
}
