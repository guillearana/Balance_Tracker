import 'package:balance_tracker/features/debts/domain/models/debt_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DebtRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference _collection(String userId) => _firestore
      .collection('users')
      .doc(userId)
      .collection('debts');

  Stream<List<DebtModel>> watchDebts(String userId) {
    return _collection(userId)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => DebtModel.fromFirestore(doc))
            .toList());
  }

  Future<void> addDebt(String userId, DebtModel debt) async {
    await _collection(userId).doc(debt.id).set({
      'userId': debt.userId,
      'name': debt.name,
      'totalAmount': debt.totalAmount,
      'pendingAmount': debt.pendingAmount,
      'monthlyPayment': debt.monthlyPayment,
      'dueDate': Timestamp.fromDate(debt.dueDate),
      'status': debt.status.name,
      'note': debt.note,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateDebt(String userId, DebtModel debt) async {
    await _collection(userId).doc(debt.id).update({
      'pendingAmount': debt.pendingAmount,
      'status': debt.status.name,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteDebt(String userId, String debtId) async {
    await _collection(userId).doc(debtId).delete();
  }
}