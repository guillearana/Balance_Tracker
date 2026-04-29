import 'package:cloud_firestore/cloud_firestore.dart';

class GroupRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference get _groups => _firestore.collection('groups');

  Future<DocumentReference> createGroup(String name, String createdBy) async {
    final ref = await _groups.add({
      'name': name,
      'createdBy': createdBy,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    await ref.collection('members').doc(createdBy).set({
      'userId': createdBy,
      'joinedAt': FieldValue.serverTimestamp(),
    });
    return ref;
  }
  Future<void> deleteGroup(String groupId) async {
    await _groups.doc(groupId).delete();
  }

  Stream<List<Map<String, dynamic>>> watchUserGroups(String userId) {
    return _groups
        .where('createdBy', isEqualTo: userId)
        .snapshots()
        .map((snap) {
          return snap.docs
              .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
              .toList();
        });
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

  Future<List<Map<String, dynamic>>> getGroupMembers(String groupId) async {
    final snap = await _groups.doc(groupId).collection('members').get();
    return snap.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
  }

  Future<void> addMember(String groupId, String userId) async {
    await _groups.doc(groupId).collection('members').doc(userId).set({
      'userId': userId,
      'joinedAt': FieldValue.serverTimestamp(),
    });
  }
}