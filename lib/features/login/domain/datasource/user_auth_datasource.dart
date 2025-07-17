import 'package:firebase_auth/firebase_auth.dart';

abstract class UserAuthDataSource {
  Future<User> signInWithEmailAndPassword(String username, String password);
  Future<User> createUserWithEmailAndPassword(String email, String password);
  Future<void> logout();
  Future<bool> isAuthenticated();
}
