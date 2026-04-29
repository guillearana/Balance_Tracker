import 'package:balance_tracker/features/auth/providers/auth_provider.dart';
import 'package:balance_tracker/features/groups/data/repositories/group_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_provider.g.dart';

@riverpod
GroupRepository groupRepository(GroupRepositoryRef ref) {
  return GroupRepository();
}

@riverpod
Stream<List<Map<String, dynamic>>> userGroups(UserGroupsRef ref) {
  final user = ref.watch(currentUserProvider);
  print('userGroups LLAMADO - user: ${user?.uid}');
  if (user == null) return Stream.value([]);
  final stream = ref.read(groupRepositoryProvider).watchUserGroups(user.uid);
  print('STREAM CREADO');
  return stream;
}