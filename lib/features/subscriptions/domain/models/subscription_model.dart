import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'subscription_model.freezed.dart';
part 'subscription_model.g.dart';

/// Frecuencia de cobro de una suscripción.
enum SubscriptionFrequency {
  /// Cobro mensual.
  monthly,

  /// Cobro anual.
  annual,

  /// Cobro semanal.
  weekly,
}

/// Modo de pago de una suscripción.
enum PaymentMode {
  /// El pago se procesa automáticamente.
  auto,

  /// El pago requiere acción manual del usuario.
  manual,
}

/// Modelo inmutable que representa una suscripción recurrente del usuario.
@freezed
abstract class SubscriptionModel with _$SubscriptionModel {
  const SubscriptionModel._();

  /// Crea una instancia de [SubscriptionModel].
  ///
  /// - [id]: Identificador único de la suscripción.
  /// - [userId]: Identificador del usuario propietario.
  /// - [name]: Nombre del servicio o suscripción.
  /// - [amount]: Monto cobrado por cada período.
  /// - [frequency]: Frecuencia de cobro ([SubscriptionFrequency]).
  /// - [startDate]: Fecha en que inició la suscripción.
  /// - [nextPayment]: Fecha del próximo cobro programado.
  /// - [paymentMode]: Modo de pago ([PaymentMode]).
  /// - [isActive]: Indica si la suscripción está activa. Por defecto `true`.
  /// - [categoryId]: Identificador de la categoría asociada; puede ser `null`.
  /// - [cancelledAt]: Fecha en que se canceló la suscripción; `null` si sigue activa.
  /// - [createdAt]: Fecha de creación del registro.
  const factory SubscriptionModel({
    required String id,
    required String userId,
    required String name,
    required double amount,
    required SubscriptionFrequency frequency,
    required DateTime startDate,
    required DateTime nextPayment,
    required PaymentMode paymentMode,
    @Default(true) bool isActive,
    String? categoryId,
    DateTime? cancelledAt,
    DateTime? createdAt,
  }) = _SubscriptionModel;

  /// Crea un [SubscriptionModel] a partir de un mapa JSON.
  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);

  /// Crea un [SubscriptionModel] a partir de un [DocumentSnapshot] de Firestore.
  ///
  /// Convierte los campos [Timestamp] de Firestore (`startDate`, `nextPayment`,
  /// `cancelledAt`, `createdAt`) a cadenas ISO 8601 antes de delegar en [fromJson].
  static SubscriptionModel fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SubscriptionModel.fromJson({
      'id': doc.id,
      ...data,
      'startDate': (data['startDate'] as Timestamp).toDate().toIso8601String(),
      'nextPayment': (data['nextPayment'] as Timestamp).toDate().toIso8601String(),
      'cancelledAt': (data['cancelledAt'] as Timestamp?)?.toDate().toIso8601String(),
      'createdAt': (data['createdAt'] as Timestamp?)?.toDate().toIso8601String(),
    });
  }
}
