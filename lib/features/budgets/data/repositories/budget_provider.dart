import 'package:balance_tracker/features/auth/providers/auth_provider.dart';
import 'package:balance_tracker/features/budgets/data/repositories/budget_repository.dart';
import 'package:balance_tracker/features/budgets/domain/models/budget_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'budget_provider.g.dart';

@riverpod
BudgetRepository budgetRepository(BudgetRepositoryRef ref) {
  return BudgetRepository();
}

@riverpod
Stream<List<BudgetModel>> budgets(BudgetsRef ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value([]);
  return ref.watch(budgetRepositoryProvider).watchBudgets(user.uid);
}