import 'package:balance_tracker/features/transactions/domain/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference _collection(String userId) => _firestore
      .collection('users')
      .doc(userId)
      .collection('transactions');

  Stream<List<TransactionModel>> watchTransactions(String userId) {
    return _collection(userId)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => TransactionModel.fromFirestore(doc))
            .toList());
  }

  Future<List<TransactionModel>> getTransactionsByMonth(
      String userId, int year, int month) async {
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 1);
    final snap = await _collection(userId)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('date', isLessThan: Timestamp.fromDate(end))
        .orderBy('date', descending: true)
        .get();
    return snap.docs
        .map((doc) => TransactionModel.fromFirestore(doc))
        .toList();
  }

  Future<void> addTransaction(
      String userId, TransactionModel transaction) async {
    await _collection(userId).doc(transaction.id).set({
      'userId': transaction.userId,
      'amount': transaction.amount,
      'type': transaction.type.name,
      'categoryId': transaction.categoryId,
      'date': Timestamp.fromDate(transaction.date),
      'createdAt': Timestamp.fromDate(transaction.createdAt),
      'accountId': transaction.accountId,
      'subcategory': transaction.subcategory,
      'note': transaction.note,
      'isFromSubscription': transaction.isFromSubscription,
      'isFromDebt': transaction.isFromDebt,
    });
  }

  Future<void> deleteTransaction(String userId, String transactionId) async {
    await _collection(userId).doc(transactionId).delete();
  }

  Future<void> updateTransaction(
      String userId, TransactionModel transaction) async {
    await _collection(userId).doc(transaction.id).update({
      'amount': transaction.amount,
      'type': transaction.type.name,
      'categoryId': transaction.categoryId,
      'date': Timestamp.fromDate(transaction.date),
      'subcategory': transaction.subcategory,
      'note': transaction.note,
    });
  }
}