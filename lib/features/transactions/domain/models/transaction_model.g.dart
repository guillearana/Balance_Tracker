// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    _TransactionModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      categoryId: json['categoryId'] as String,
      date: DateTime.parse(json['date'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      accountId: json['accountId'] as String?,
      subcategory: json['subcategory'] as String?,
      note: json['note'] as String?,
      isFromSubscription: json['isFromSubscription'] as bool? ?? false,
      isFromDebt: json['isFromDebt'] as bool? ?? false,
    );

Map<String, dynamic> _$TransactionModelToJson(_TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'amount': instance.amount,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'categoryId': instance.categoryId,
      'date': instance.date.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'accountId': instance.accountId,
      'subcategory': instance.subcategory,
      'note': instance.note,
      'isFromSubscription': instance.isFromSubscription,
      'isFromDebt': instance.isFromDebt,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.income: 'income',
  TransactionType.expense: 'expense',
};
