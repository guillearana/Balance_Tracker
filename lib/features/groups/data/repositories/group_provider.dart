import 'package:balance_tracker/features/auth/providers/auth_provider.dart';
import 'package:balance_tracker/features/groups/data/repositories/group_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
part 'group_provider.g.dart';

@riverpod
GroupRepository groupRepository(GroupRepositoryRef ref) {
  return GroupRepository();
}

@riverpod
Stream<List<Map<String, dynamic>>> userGroups(UserGroupsRef ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value([]);
  final repo = ref.read(groupRepositoryProvider);

  // Combina grupos creados por el usuario + grupos donde es miembro
  return Rx.combineLatest2(
    repo.watchUserGroups(user.uid),
    repo.watchMemberGroups(user.uid),
    (List<Map<String, dynamic>> created, List<Map<String, dynamic>> member) {
      // Une ambas listas eliminando duplicados por id
      final Map<String, Map<String, dynamic>> combined = {};
      for (final g in created) combined[g['id'] as String] = g;
      for (final g in member) combined[g['id'] as String] = g;
      return combined.values.toList();
    },
  );
}