import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'debt_model.freezed.dart';
part 'debt_model.g.dart';

enum DebtStatus { active, paid, overdue }

@freezed
abstract class DebtModel with _$DebtModel {
  const DebtModel._();

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

  factory DebtModel.fromJson(Map<String, dynamic> json) =>
      _$DebtModelFromJson(json);

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