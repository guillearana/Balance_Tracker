import 'package:balance_tracker/features/auth/providers/auth_provider.dart';
import 'package:balance_tracker/features/transactions/data/repositories/transaction_repository.dart';
import 'package:balance_tracker/features/transactions/domain/models/transaction_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_provider.g.dart';

@riverpod
TransactionRepository transactionRepository(TransactionRepositoryRef ref) {
  return TransactionRepository();
}

@riverpod
Stream<List<TransactionModel>> transactions(TransactionsRef ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value([]);
  return ref
      .watch(transactionRepositoryProvider)
      .watchTransactions(user.uid);
}

@riverpod
Future<List<TransactionModel>> transactionsByMonth(
    TransactionsByMonthRef ref, int year, int month) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return [];
  return ref
      .watch(transactionRepositoryProvider)
      .getTransactionsByMonth(user.uid, year, month);
}