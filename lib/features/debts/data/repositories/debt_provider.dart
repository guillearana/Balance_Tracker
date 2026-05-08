import 'package:balance_tracker/features/auth/providers/auth_provider.dart';
import 'package:balance_tracker/features/debts/data/repositories/debt_repository.dart';
import 'package:balance_tracker/features/debts/domain/models/debt_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debt_provider.g.dart';

/// Expone una instancia singleton de [DebtRepository].
@riverpod
DebtRepository debtRepository(DebtRepositoryRef ref) {
  return DebtRepository();
}

/// Expone un stream con la lista de deudas del usuario autenticado.
///
/// Devuelve un stream vacío si no hay usuario activo.
/// Utiliza [debtRepositoryProvider] y [currentUserProvider].
@riverpod
Stream<List<DebtModel>> debts(DebtsRef ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value([]);
  return ref.watch(debtRepositoryProvider).watchDebts(user.uid);
}
