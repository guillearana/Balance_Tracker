import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class GroupRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference get _groups => _firestore.collection('groups');

  Future<DocumentReference> createGroup(
    String name,
    String createdBy,
    String displayName,
  ) async {
    final code = _generateCode();
    final ref = await _groups.add({
      'name': name,
      'createdBy': createdBy,
      'inviteCode': code,
      'memberIds': [createdBy],
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    await ref.collection('members').doc(createdBy).set({
      'userId': createdBy,
      'displayName': displayName,
      'joinedAt': FieldValue.serverTimestamp(),
    });
    return ref;
  }

  String _generateCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random();
    return List.generate(6, (_) => chars[rand.nextInt(chars.length)]).join();
  }

  Future<void> deleteGroup(String groupId) async {
    await _groups.doc(groupId).delete();
  }

  Stream<List<Map<String, dynamic>>> watchUserGroups(String userId) {
    return _groups
        .where('createdBy', isEqualTo: userId)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
            .toList());
  }

  Stream<List<Map<String, dynamic>>> watchMemberGroups(String userId) {
    return _groups
        .where('memberIds', arrayContains: userId)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
            .toList());
  }

  Future<void> addExpense(String groupId, Map<String, dynamic> expense) async {
    final ref = await _groups.doc(groupId).collection('expenses').add({
      ...expense,
      'createdAt': FieldValue.serverTimestamp(),
    });
    for (final split in expense['splits'] as List) {
      await ref.collection('splits').add(split);
    }
  }

  Stream<List<Map<String, dynamic>>> watchGroupExpenses(String groupId) {
    return _groups
        .doc(groupId)
        .collection('expenses')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => {'id': doc.id, ...doc.data()})
            .toList());
  }

  // Solo miembros activos — para mostrar en UI
  Future<List<Map<String, dynamic>>> getGroupMembers(String groupId) async {
    final snap = await _groups.doc(groupId).collection('members').get();
    return snap.docs
        .map((doc) => {'id': doc.id, ...doc.data()})
        .where((m) => m['active'] != false)
        .toList();
  }

  // Todos los miembros incluyendo inactivos — para cálculos
  Future<List<Map<String, dynamic>>> getAllGroupMembers(String groupId) async {
    final snap = await _groups.doc(groupId).collection('members').get();
    return snap.docs
        .map((doc) => {'id': doc.id, ...doc.data()})
        .toList();
  }

  Future<void> addMember(
      String groupId, String userId, String displayName) async {
    await _groups.doc(groupId).collection('members').doc(userId).set({
      'userId': userId,
      'displayName': displayName,
      'joinedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<String?> joinGroupByCode(
      String code, String userId, String displayName) async {
    final snap = await _groups
        .where('inviteCode', isEqualTo: code.toUpperCase().trim())
        .limit(1)
        .get();

    if (snap.docs.isEmpty) return null;

    final groupDoc = snap.docs.first;
    final groupId = groupDoc.id;

    final memberDoc = await _groups
        .doc(groupId)
        .collection('members')
        .doc(userId)
        .get();

    if (memberDoc.exists) return 'already_member';

    await _groups.doc(groupId).collection('members').doc(userId).set({
      'userId': userId,
      'displayName': displayName,
      'joinedAt': FieldValue.serverTimestamp(),
    });

    await _groups.doc(groupId).update({
      'memberIds': FieldValue.arrayUnion([userId]),
    });

    return groupId;
  }

  Future<void> removeMember(String groupId, String userId) async {
    await _groups
        .doc(groupId)
        .collection('members')
        .doc(userId)
        .update({'active': false});
    await _groups.doc(groupId).update({
      'memberIds': FieldValue.arrayRemove([userId]),
    });
  }
}