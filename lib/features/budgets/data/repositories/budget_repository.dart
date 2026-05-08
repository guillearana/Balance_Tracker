import 'package:balance_tracker/features/budgets/domain/models/budget_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Repositorio que gestiona el acceso a datos de presupuestos en Firestore.
///
/// Colección Firestore: `users/{userId}/budgets`
class BudgetRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Devuelve la referencia a la subcolección de presupuestos del usuario.
  CollectionReference _collection(String userId) =>
      _firestore.collection('users').doc(userId).collection('budgets');

  /// Devuelve un stream con la lista de presupuestos del usuario [userId].
  ///
  /// El stream emite un nuevo valor cada vez que cambian los documentos
  /// en la colección `users/{userId}/budgets`.
  Stream<List<BudgetModel>> watchBudgets(String userId) {
    return _collection(userId).snapshots().map(
      (snap) => snap.docs.map((doc) => BudgetModel.fromFirestore(doc)).toList(),
    );
  }

  /// Guarda un nuevo [budget] en Firestore para el usuario [userId].
  ///
  /// Los campos `createdAt` y `updatedAt` se asignan con marca de tiempo
  /// del servidor.
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

  /// Actualiza los campos `limitAmount`, `alertThreshold` y `updatedAt`
  /// del presupuesto identificado por [budget.id] del usuario [userId].
  Future<void> updateBudget(String userId, BudgetModel budget) async {
    await _collection(userId).doc(budget.id).update({
      'limitAmount': budget.limitAmount,
      'alertThreshold': budget.alertThreshold,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Elimina el presupuesto con [budgetId] del usuario [userId].
  Future<void> deleteBudget(String userId, String budgetId) async {
    await _collection(userId).doc(budgetId).delete();
  }
}
