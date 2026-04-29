// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BudgetModel _$BudgetModelFromJson(Map<String, dynamic> json) => _BudgetModel(
  id: json['id'] as String,
  userId: json['userId'] as String,
  categoryId: json['categoryId'] as String,
  limitAmount: (json['limitAmount'] as num).toDouble(),
  periodMonth: json['periodMonth'] as String,
  alertThreshold: (json['alertThreshold'] as num?)?.toDouble() ?? 0.8,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$BudgetModelToJson(_BudgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'categoryId': instance.categoryId,
      'limitAmount': instance.limitAmount,
      'periodMonth': instance.periodMonth,
      'alertThreshold': instance.alertThreshold,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
