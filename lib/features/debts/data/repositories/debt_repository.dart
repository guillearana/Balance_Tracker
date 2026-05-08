import 'package:balance_tracker/features/debts/domain/models/debt_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Repositorio que gestiona el acceso a datos de deudas en Firestore.
///
/// Colección Firestore: `users/{userId}/debts`
class DebtRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Devuelve la referencia a la subcolección de deudas del usuario.
  CollectionReference _collection(String userId) => _firestore
      .collection('users')
      .doc(userId)
      .collection('debts');

  /// Devuelve un stream con la lista de deudas del usuario [userId].
  ///
  /// El stream emite un nuevo valor ante cualquier cambio en la colección.
  Stream<List<DebtModel>> watchDebts(String userId) {
    return _collection(userId)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => DebtModel.fromFirestore(doc))
            .toList());
  }

  /// Guarda una nueva [debt] en Firestore para el usuario [userId].
  ///
  /// Los campos `createdAt` y `updatedAt` se asignan con marca de tiempo
  /// del servidor. El campo `dueDate` se convierte a [Timestamp].
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

  /// Actualiza los campos `pendingAmount`, `status` y `updatedAt`
  /// de la deuda identificada por [debt.id] del usuario [userId].
  Future<void> updateDebt(String userId, DebtModel debt) async {
    await _collection(userId).doc(debt.id).update({
      'pendingAmount': debt.pendingAmount,
      'status': debt.status.name,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Elimina la deuda con [debtId] del usuario [userId].
  Future<void> deleteDebt(String userId, String debtId) async {
    await _collection(userId).doc(debtId).delete();
  }
}
