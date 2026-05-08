import 'package:balance_tracker/features/transactions/domain/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Repositorio que gestiona el acceso a datos de transacciones en Firestore.
///
/// Colección Firestore: `users/{userId}/transactions`
class TransactionRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Devuelve la referencia a la subcolección de transacciones del usuario.
  CollectionReference _collection(String userId) => _firestore
      .collection('users')
      .doc(userId)
      .collection('transactions');

  /// Devuelve un stream con todas las transacciones del usuario [userId],
  /// ordenadas por fecha descendente.
  Stream<List<TransactionModel>> watchTransactions(String userId) {
    return _collection(userId)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => TransactionModel.fromFirestore(doc))
            .toList());
  }

  /// Devuelve las transacciones del usuario [userId] en el mes indicado por
  /// [year] y [month], ordenadas por fecha descendente.
  ///
  /// Filtra por el rango `[inicio del mes, inicio del mes siguiente)`.
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

  /// Guarda una nueva [transaction] en Firestore para el usuario [userId].
  ///
  /// Los campos de fecha (`date`, `createdAt`) se convierten a [Timestamp].
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

  /// Elimina la transacción [transactionId] del usuario [userId].
  Future<void> deleteTransaction(String userId, String transactionId) async {
    await _collection(userId).doc(transactionId).delete();
  }

  /// Actualiza los campos editables (`amount`, `type`, `categoryId`, `date`,
  /// `subcategory`, `note`) de la transacción [transaction.id] del usuario [userId].
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
