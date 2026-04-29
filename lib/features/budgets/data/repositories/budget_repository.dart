import 'package:balance_tracker/features/budgets/domain/models/budget_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BudgetRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference _collection(String userId) => _firestore
      .collection('users')
      .doc(userId)
      .collection('budgets');

  Stream<List<BudgetModel>> watchBudgets(String userId) {
    return _collection(userId)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => BudgetModel.fromFirestore(doc))
            .toList());
  }

  Future<void> addBudget(String userId, BudgetModel budget) async {
    await _collection(userId).doc(budget.id).set({
      'userId': budget.userId,
      'categoryId': budget.categoryId,
      'limitAmount': budget.limitAmount,
      'periodMonth': budget.periodMonth,
      'alertThreshold': budget.alertThreshold,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateBudget(String userId, BudgetModel budget) async {
    await _collection(userId).doc(budget.id).update({
      'limitAmount': budget.limitAmount,
      'alertThreshold': budget.alertThreshold,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteBudget(String userId, String budgetId) async {
    await _collection(userId).doc(budgetId).delete();
  }
}