import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

/// Tipo de movimiento económico.
enum TransactionType {
  /// Entrada de dinero.
  income,

  /// Salida de dinero.
  expense,
}

/// Modelo inmutable que representa una transacción económica del usuario.
@freezed
abstract class TransactionModel with _$TransactionModel {
  const TransactionModel._();

  /// Crea una instancia de [TransactionModel].
  ///
  /// - [id]: Identificador único de la transacción.
  /// - [userId]: Identificador del usuario propietario.
  /// - [amount]: Monto de la transacción.
  /// - [type]: Tipo de transacción ([TransactionType]).
  /// - [categoryId]: Identificador de la categoría asociada.
  /// - [date]: Fecha en que ocurrió la transacción.
  /// - [createdAt]: Fecha de creación del registro en el sistema.
  /// - [accountId]: Identificador de la cuenta asociada; puede ser `null`.
  /// - [subcategory]: Subcategoría opcional para mayor detalle.
  /// - [note]: Nota opcional con información adicional.
  /// - [isFromSubscription]: Indica si la transacción fue generada por una suscripción. Por defecto `false`.
  /// - [isFromDebt]: Indica si la transacción fue generada por el pago de una deuda. Por defecto `false`.
  const factory TransactionModel({
    required String id,
    required String userId,
    required double amount,
    required TransactionType type,
    required String categoryId,
    required DateTime date,
    required DateTime createdAt,
    String? accountId,
    String? subcategory,
    String? note,
    @Default(false) bool isFromSubscription,
    @Default(false) bool isFromDebt,
  }) = _TransactionModel;

  /// Crea un [TransactionModel] a partir de un mapa JSON.
  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  /// Crea un [TransactionModel] a partir de un [DocumentSnapshot] de Firestore.
  ///
  /// Convierte los campos [Timestamp] de Firestore (`date`, `createdAt`)
  /// a cadenas ISO 8601 antes de delegar en [fromJson].
  static TransactionModel fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TransactionModel.fromJson({
      'id': doc.id,
      ...data,
      'date': (data['date'] as Timestamp).toDate().toIso8601String(),
      'createdAt': (data['createdAt'] as Timestamp).toDate().toIso8601String(),
      'type': data['type'],
    });
  }
}
