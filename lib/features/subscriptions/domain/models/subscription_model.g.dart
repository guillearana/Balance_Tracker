// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionModel _$SubscriptionModelFromJson(Map<String, dynamic> json) =>
    _SubscriptionModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      frequency: $enumDecode(_$SubscriptionFrequencyEnumMap, json['frequency']),
      startDate: DateTime.parse(json['startDate'] as String),
      nextPayment: DateTime.parse(json['nextPayment'] as String),
      paymentMode: $enumDecode(_$PaymentModeEnumMap, json['paymentMode']),
      isActive: json['isActive'] as bool? ?? true,
      categoryId: json['categoryId'] as String?,
      cancelledAt: json['cancelledAt'] == null
          ? null
          : DateTime.parse(json['cancelledAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$SubscriptionModelToJson(_SubscriptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'amount': instance.amount,
      'frequency': _$SubscriptionFrequencyEnumMap[instance.frequency]!,
      'startDate': instance.startDate.toIso8601String(),
      'nextPayment': instance.nextPayment.toIso8601String(),
      'paymentMode': _$PaymentModeEnumMap[instance.paymentMode]!,
      'isActive': instance.isActive,
      'categoryId': instance.categoryId,
      'cancelledAt': instance.cancelledAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$SubscriptionFrequencyEnumMap = {
  SubscriptionFrequency.monthly: 'monthly',
  SubscriptionFrequency.annual: 'annual',
  SubscriptionFrequency.weekly: 'weekly',
};

const _$PaymentModeEnumMap = {
  PaymentMode.auto: 'auto',
  PaymentMode.manual: 'manual',
};
