import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

enum TransactionType { income, expense }

@freezed
abstract class TransactionModel with _$TransactionModel {
  const TransactionModel._();

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

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

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