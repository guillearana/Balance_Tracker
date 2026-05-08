import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

/// Repositorio que gestiona el acceso a datos de grupos compartidos en Firestore.
///
/// Colección Firestore principal: `groups`
/// Subcolecciones: `groups/{groupId}/members`, `groups/{groupId}/expenses`
class GroupRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Referencia a la colección raíz de grupos.
  CollectionReference get _groups => _firestore.collection('groups');

  /// Crea un nuevo grupo con el nombre [name], creado por el usuario [createdBy]
  /// con nombre visible [displayName].
  ///
  /// Genera un código de invitación aleatorio de 6 caracteres, añade al creador
  /// como primer miembro y devuelve la [DocumentReference] del grupo creado.
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

  /// Genera un código alfanumérico aleatorio de 6 caracteres en mayúsculas.
  String _generateCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random();
    return List.generate(6, (_) => chars[rand.nextInt(chars.length)]).join();
  }

  /// Elimina el grupo con [groupId] de la colección `groups`.
  Future<void> deleteGroup(String groupId) async {
    await _groups.doc(groupId).delete();
  }

  /// Devuelve un stream con los grupos creados por el usuario [userId].
  ///
  /// Filtra por el campo `createdBy`. Cada elemento del stream es un mapa
  /// que incluye el `id` del documento junto con sus datos.
  Stream<List<Map<String, dynamic>>> watchUserGroups(String userId) {
    return _groups
        .where('createdBy', isEqualTo: userId)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
            .toList());
  }

  /// Devuelve un stream con los grupos en los que el usuario [userId] es miembro.
  ///
  /// Filtra por el array `memberIds` que contenga el [userId].
  Stream<List<Map<String, dynamic>>> watchMemberGroups(String userId) {
    return _groups
        .where('memberIds', arrayContains: userId)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
            .toList());
  }

  /// Añade un gasto [expense] a la subcolección `expenses` del grupo [groupId].
  ///
  /// Incluye el campo `createdAt` con marca de tiempo del servidor y guarda
  /// cada elemento de `expense['splits']` en la subcolección `splits` del gasto.
  Future<void> addExpense(String groupId, Map<String, dynamic> expense) async {
    final ref = await _groups.doc(groupId).collection('expenses').add({
      ...expense,
      'createdAt': FieldValue.serverTimestamp(),
    });
    for (final split in expense['splits'] as List) {
      await ref.collection('splits').add(split);
    }
  }

  /// Devuelve un stream con los gastos del grupo [groupId], ordenados por
  /// `createdAt` de forma descendente.
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

  /// Devuelve los miembros activos del grupo [groupId].
  ///
  /// Excluye los documentos con `active == false`. Destinado a la capa de UI.
  Future<List<Map<String, dynamic>>> getGroupMembers(String groupId) async {
    final snap = await _groups.doc(groupId).collection('members').get();
    return snap.docs
        .map((doc) => {'id': doc.id, ...doc.data()})
        .where((m) => m['active'] != false)
        .toList();
  }

  /// Devuelve todos los miembros del grupo [groupId], incluyendo los inactivos.
  ///
  /// Destinado a cálculos internos donde se necesita el historial completo.
  Future<List<Map<String, dynamic>>> getAllGroupMembers(String groupId) async {
    final snap = await _groups.doc(groupId).collection('members').get();
    return snap.docs
        .map((doc) => {'id': doc.id, ...doc.data()})
        .toList();
  }

  /// Añade el usuario [userId] con nombre [displayName] a la subcolección
  /// `members` del grupo [groupId].
  Future<void> addMember(
      String groupId, String userId, String displayName) async {
    await _groups.doc(groupId).collection('members').doc(userId).set({
      'userId': userId,
      'displayName': displayName,
      'joinedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Intenta unir al usuario [userId] con nombre [displayName] al grupo cuyo
  /// código de invitación coincide con [code].
  ///
  /// Devuelve el [groupId] si la unión es exitosa, `'already_member'` si el
  /// usuario ya pertenece al grupo, o `null` si el código no existe.
  /// Si el usuario estaba marcado como inactivo, se reactiva su membresía.
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

      if (memberDoc.exists) {
        final data = memberDoc.data() as Map<String, dynamic>;
        if (data['active'] == false) {
          // Reactivar miembro
          await _groups.doc(groupId).collection('members').doc(userId).update({
            'active': true,
            'displayName': displayName,
            'joinedAt': FieldValue.serverTimestamp(),
          });
          await _groups.doc(groupId).update({
            'memberIds': FieldValue.arrayUnion([userId]),
          });
          return groupId;
        }
        return 'already_member';
      }

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

  /// Marca al miembro [userId] como inactivo en el grupo [groupId] y lo elimina
  /// del array `memberIds`.
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
