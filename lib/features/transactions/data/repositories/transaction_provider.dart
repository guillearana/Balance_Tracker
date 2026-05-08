import 'package:balance_tracker/features/auth/providers/auth_provider.dart';
import 'package:balance_tracker/features/transactions/data/repositories/transaction_repository.dart';
import 'package:balance_tracker/features/transactions/domain/models/transaction_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_provider.g.dart';

/// Expone una instancia singleton de [TransactionRepository].
@riverpod
TransactionRepository transactionRepository(TransactionRepositoryRef ref) {
  return TransactionRepository();
}

/// Expone un stream con todas las transacciones del usuario autenticado,
/// ordenadas por fecha descendente.
///
/// Devuelve un stream vacío si no hay usuario activo.
/// Utiliza [transactionRepositoryProvider] y [currentUserProvider].
@riverpod
Stream<List<TransactionModel>> transactions(TransactionsRef ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value([]);
  return ref
      .watch(transactionRepositoryProvider)
      .watchTransactions(user.uid);
}

/// Expone un Future con las transacciones del usuario autenticado
/// para el mes indicado por [year] y [month].
///
/// Devuelve una lista vacía si no hay usuario activo.
/// Utiliza [transactionRepositoryProvider] y [currentUserProvider].
@riverpod
Future<List<TransactionModel>> transactionsByMonth(
    TransactionsByMonthRef ref, int year, int month) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return [];
  return ref
      .watch(transactionRepositoryProvider)
      .getTransactionsByMonth(user.uid, year, month);
}
