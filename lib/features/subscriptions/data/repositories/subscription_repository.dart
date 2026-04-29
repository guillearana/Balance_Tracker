import 'package:balance_tracker/features/subscriptions/domain/models/subscription_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference _collection(String userId) => _firestore
      .collection('users')
      .doc(userId)
      .collection('subscriptions');

  Stream<List<SubscriptionModel>> watchActiveSubscriptions(String userId) {
    return _collection(userId)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => SubscriptionModel.fromFirestore(doc))
            .toList());
  }

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

  Future<void> cancelSubscription(String userId, String subscriptionId) async {
    await _collection(userId).doc(subscriptionId).update({
      'isActive': false,
      'cancelledAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateNextPayment(
      String userId, String subscriptionId, DateTime nextPayment) async {
    await _collection(userId).doc(subscriptionId).update({
      'nextPayment': Timestamp.fromDate(nextPayment),
    });
  }
}