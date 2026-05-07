import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
Stream<User?> authState(AuthStateRef ref) {
  return FirebaseAuth.instance.authStateChanges();
}

@riverpod
User? currentUser(CurrentUserRef ref) {
  // Escucha cambios de auth
  ref.watch(authStateProvider);
  // Devuelve siempre el usuario actual "fresco" de Firebase
  return FirebaseAuth.instance.currentUser;
}
