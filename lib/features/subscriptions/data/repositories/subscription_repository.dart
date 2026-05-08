import 'package:balance_tracker/features/subscriptions/domain/models/subscription_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Repositorio que gestiona el acceso a datos de suscripciones en Firestore.
///
/// Colección Firestore: `users/{userId}/subscriptions`
class SubscriptionRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Devuelve la referencia a la subcolección de suscripciones del usuario.
  CollectionReference _collection(String userId) => _firestore
      .collection('users')
      .doc(userId)
      .collection('subscriptions');

  /// Devuelve un stream con las suscripciones activas (`isActive == true`)
  /// del usuario [userId].
  Stream<List<SubscriptionModel>> watchActiveSubscriptions(String userId) {
    return _collection(userId)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => SubscriptionModel.fromFirestore(doc))
            .toList());
  }

  /// Guarda una nueva [subscription] en Firestore para el usuario [userId].
  ///
  /// Los campos de fecha (`startDate`, `nextPayment`) se convierten a
  /// [Timestamp]. El campo `createdAt` se asigna con marca de tiempo del servidor.
  Future<void> addSubscription(
      String userId, SubscriptionModel subscription) async {
    await _collection(userId).doc(subscription.id).set({
      'userId': subscription.userId,
      'name': subscription.name,
      'amount': subscription.amount,
      'frequency': subscription.frequency.name,
      'startDate': Timestamp.fromDate(subscription.startDate),
      'nextPayment': Timestamp.fromDate(subscription.nextPayment),
      'paymentMode': subscription.paymentMode.name,
      'isActive': subscription.isActive,
      'categoryId': subscription.categoryId,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Marca la suscripción [subscriptionId] del usuario [userId] como cancelada.
  ///
  /// Establece `isActive` a `false` y registra la fecha de cancelación.
  Future<void> cancelSubscription(String userId, String subscriptionId) async {
    await _collection(userId).doc(subscriptionId).update({
      'isActive': false,
      'cancelledAt': FieldValue.serverTimestamp(),
    });
  }

  /// Actualiza el campo `nextPayment` de la suscripción [subscriptionId]
  /// del usuario [userId] con la nueva fecha [nextPayment].
  Future<void> updateNextPayment(
      String userId, String subscriptionId, DateTime nextPayment) async {
    await _collection(userId).doc(subscriptionId).update({
      'nextPayment': Timestamp.fromDate(nextPayment),
    });
  }
}
