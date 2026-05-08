import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

/// Expone un stream con los cambios de estado de autenticación de Firebase.
///
/// Emite `null` cuando no hay sesión activa y un [User] cuando el usuario
/// inicia sesión.
@riverpod
Stream<User?> authState(AuthStateRef ref) {
  return FirebaseAuth.instance.authStateChanges();
}

/// Expone el [User] actualmente autenticado, o `null` si no hay sesión.
///
/// Se suscribe a [authStateProvider] para invalidarse cuando el estado
/// de autenticación cambia.
@riverpod
User? currentUser(CurrentUserRef ref) {
  ref.watch(authStateProvider);
  return FirebaseAuth.instance.currentUser;
}
