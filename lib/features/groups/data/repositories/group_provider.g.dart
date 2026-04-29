// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$groupRepositoryHash() => r'bf89d04afc9d50fcdfdf3038118e1133413496eb';

/// See also [groupRepository].
@ProviderFor(groupRepository)
final groupRepositoryProvider = AutoDisposeProvider<GroupRepository>.internal(
  groupRepository,
  name: r'groupRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$groupRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GroupRepositoryRef = AutoDisposeProviderRef<GroupRepository>;
String _$userGroupsHash() => r'5a0282f34b9bf3c5aeec3b1b4c1a4ce8181ca607';

/// See also [userGroups].
@ProviderFor(userGroups)
final userGroupsProvider =
    AutoDisposeStreamProvider<List<Map<String, dynamic>>>.internal(
      userGroups,
      name: r'userGroupsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$userGroupsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserGroupsRef =
    AutoDisposeStreamProviderRef<List<Map<String, dynamic>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
