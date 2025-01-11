import '../../../utils/instances.dart';

Future<void> loginWithEmailAndPassword(String email, String password) {
  return auth.signInWithEmailAndPassword(email: email, password: password);
}

Future<void> signOut() {
  return auth.signOut();
}

Future<void> recoverAccount(String email) {
  return auth.sendPasswordResetEmail(email: email);
}
