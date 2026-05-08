import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'debt_model.freezed.dart';
part 'debt_model.g.dart';

/// Estado en que puede encontrarse una deuda.
enum DebtStatus {
  /// Deuda pendiente de pago.
  active,

  /// Deuda completamente pagada.
  paid,

  /// Deuda cuyo vencimiento ha sido superado sin pago completo.
  overdue,
}

/// Modelo inmutable que representa una deuda del usuario.
@freezed
abstract class DebtModel with _$DebtModel {
  const DebtModel._();

  /// Crea una instancia de [DebtModel].
  ///
  /// - [id]: Identificador único de la deuda.
  /// - [userId]: Identificador del usuario propietario.
  /// - [name]: Nombre descriptivo de la deuda.
  /// - [totalAmount]: Monto total original de la deuda.
  /// - [pendingAmount]: Monto aún pendiente de pago.
  /// - [monthlyPayment]: Cuota mensual acordada.
  /// - [dueDate]: Fecha de vencimiento de la deuda.
  /// - [status]: Estado actual de la deuda. Por defecto [DebtStatus.active].
  /// - [note]: Nota opcional con información adicional.
  /// - [createdAt]: Fecha de creación del registro.
  /// - [updatedAt]: Fecha de la última actualización del registro.
  const factory DebtModel({
    required String id,
    required String userId,
    required String name,
    required double totalAmount,
    required double pendingAmount,
    required double monthlyPayment,
    required DateTime dueDate,
    @Default(DebtStatus.active) DebtStatus status,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DebtModel;

  /// Crea un [DebtModel] a partir de un mapa JSON.
  factory DebtModel.fromJson(Map<String, dynamic> json) =>
      _$DebtModelFromJson(json);

  /// Crea un [DebtModel] a partir de un [DocumentSnapshot] de Firestore.
  ///
  /// Convierte los campos [Timestamp] de Firestore (`dueDate`, `createdAt`,
  /// `updatedAt`) a cadenas ISO 8601 antes de delegar en [fromJson].
  static DebtModel fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DebtModel.fromJson({
      'id': doc.id,
      ...data,
      'dueDate': (data['dueDate'] as Timestamp).toDate().toIso8601String(),
      'createdAt': (data['createdAt'] as Timestamp?)?.toDate().toIso8601String(),
      'updatedAt': (data['updatedAt'] as Timestamp?)?.toDate().toIso8601String(),
    });
  }
}
