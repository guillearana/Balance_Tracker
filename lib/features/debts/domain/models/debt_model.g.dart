// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DebtModel _$DebtModelFromJson(Map<String, dynamic> json) => _DebtModel(
  id: json['id'] as String,
  userId: json['userId'] as String,
  name: json['name'] as String,
  totalAmount: (json['totalAmount'] as num).toDouble(),
  pendingAmount: (json['pendingAmount'] as num).toDouble(),
  monthlyPayment: (json['monthlyPayment'] as num).toDouble(),
  dueDate: DateTime.parse(json['dueDate'] as String),
  status:
      $enumDecodeNullable(_$DebtStatusEnumMap, json['status']) ??
      DebtStatus.active,
  note: json['note'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$DebtModelToJson(_DebtModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'totalAmount': instance.totalAmount,
      'pendingAmount': instance.pendingAmount,
      'monthlyPayment': instance.monthlyPayment,
      'dueDate': instance.dueDate.toIso8601String(),
      'status': _$DebtStatusEnumMap[instance.status]!,
      'note': instance.note,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$DebtStatusEnumMap = {
  DebtStatus.active: 'active',
  DebtStatus.paid: 'paid',
  DebtStatus.overdue: 'overdue',
};
