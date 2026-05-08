import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'budget_model.freezed.dart';
part 'budget_model.g.dart';

/// Modelo inmutable que representa un presupuesto mensual por categoría.
@freezed
abstract class BudgetModel with _$BudgetModel {
  const BudgetModel._();

  /// Crea una instancia de [BudgetModel].
  ///
  /// - [id]: Identificador único del presupuesto.
  /// - [userId]: Identificador del usuario propietario.
  /// - [categoryId]: Identificador de la categoría asociada al presupuesto.
  /// - [limitAmount]: Monto máximo permitido para el período.
  /// - [periodMonth]: Período al que aplica el presupuesto (ej. "2024-05").
  /// - [alertThreshold]: Fracción del límite a partir de la cual se genera una alerta. Por defecto 0.8 (80 %).
  /// - [createdAt]: Fecha de creación del registro.
  /// - [updatedAt]: Fecha de la última actualización del registro.
  const factory BudgetModel({
    required String id,
    required String userId,
    required String categoryId,
    required double limitAmount,
    required String periodMonth,
    @Default(0.8) double alertThreshold,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _BudgetModel;

  /// Crea un [BudgetModel] a partir de un mapa JSON.
  factory BudgetModel.fromJson(Map<String, dynamic> json) =>
      _$BudgetModelFromJson(json);

  /// Crea un [BudgetModel] a partir de un [DocumentSnapshot] de Firestore.
  ///
  /// Convierte los campos [Timestamp] de Firestore (`createdAt`, `updatedAt`)
  /// a cadenas ISO 8601 antes de delegar en [fromJson].
  static BudgetModel fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BudgetModel.fromJson({
      'id': doc.id,
      ...data,
      'createdAt': (data['createdAt'] as Timestamp?)?.toDate().toIso8601String(),
      'updatedAt': (data['updatedAt'] as Timestamp?)?.toDate().toIso8601String(),
    });
  }
}
