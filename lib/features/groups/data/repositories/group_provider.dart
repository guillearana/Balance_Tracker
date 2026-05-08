import 'package:balance_tracker/features/auth/providers/auth_provider.dart';
import 'package:balance_tracker/features/groups/data/repositories/group_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'group_provider.g.dart';

/// Expone una instancia singleton de [GroupRepository].
@riverpod
GroupRepository groupRepository(GroupRepositoryRef ref) {
  return GroupRepository();
}

/// Expone un stream con todos los grupos relacionados con el usuario autenticado.
///
/// Combina con `Rx.combineLatest2` los grupos creados por el usuario y los
/// grupos en los que es miembro, deduplicando por `id`.
/// Devuelve un stream vacío si no hay usuario activo.
/// Utiliza [groupRepositoryProvider] y [currentUserProvider].
@riverpod
Stream<List<Map<String, dynamic>>> userGroups(UserGroupsRef ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value([]);
  final repo = ref.read(groupRepositoryProvider);
  return Rx.combineLatest2(
    repo.watchUserGroups(user.uid),
    repo.watchMemberGroups(user.uid),
    (List<Map<String, dynamic>> created, List<Map<String, dynamic>> member) {
      final Map<String, Map<String, dynamic>> combined = {};
      for (final g in created) combined[g['id'] as String] = g;
      for (final g in member) combined[g['id'] as String] = g;
      return combined.values.toList();
    },
  );
}
