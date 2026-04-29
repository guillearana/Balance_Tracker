import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'subscription_model.freezed.dart';
part 'subscription_model.g.dart';

enum SubscriptionFrequency { monthly, annual, weekly }
enum PaymentMode { auto, manual }

@freezed
abstract class SubscriptionModel with _$SubscriptionModel {
  const SubscriptionModel._();

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

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);

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